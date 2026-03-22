/*
 *  Copyright (C) 2017 The Contributors
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or (at
 *  your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 *  General Public License for more details.
 *
 *  A copy of the GNU General Public License can be found in the file
 *  "gpl.txt" in the top directory of this repository.
 */

#include <all.h>
#include <dsp.h>

#define ver(...) _ver(fpu_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(fpu_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(fpu_verbose, 2, __VA_ARGS__)

int32_t fpu_verbose = 0;
double fpu_time_scale = 1.0;   /* 0.5 = half duration, 2.0 = double */

/*
 * FPU exec rate: fpu_exec() is called from cpu_loop at PER_SEC rate.
 * Interpolation timing: time_ms = F_MNT / max(F_EXP, 1).
 * Interpolation steps  = time_ms * EXEC_PER_MS.
 * Calibrated so envelope durations match the real hardware.
 */

#define EXEC_PER_MS 421

/* -------------------------------------------------------------------------- */
/* Waveshape table write                                                      */
/* -------------------------------------------------------------------------- */

static void fpu_write_ws(uint32_t off, uint32_t val)
{
	/*
	 * Waveshape tables: byte offsets 0x0000 - 0x3FFF.
	 * Layout per voice (1024 bytes = 512 words):
	 *   WSB: word offsets 1..254 → bytes 2..508
	 *   WSA: word offsets 257..510 → bytes 514..1020
	 */

	uint32_t word_off = off / 2;
	int32_t voice = (int32_t)(word_off / 512);
	int32_t within = (int32_t)(word_off % 512);

	if (voice < 0 || voice >= DSP_VOICES) {
		return;
	}

	int16_t sval = (int16_t)val;

	if (within >= 257 && within <= 510) {
		/* WSA table: entries 1-254 → array indices 0-253 */
		int32_t entry = within - 257;

		if (entry >= 0 && entry < DSP_WS_COUNT) {
			g_dsp.voices[voice].wsa[entry] = sval;
			ver3("fpu ws A v%d [%d] = %d", voice, entry, (int)sval);
		}
	}
	else if (within >= 1 && within <= 254) {
		/* WSB table: entries 1-254 → array indices 0-253 */
		int32_t entry = within - 1;

		if (entry >= 0 && entry < DSP_WS_COUNT) {
			g_dsp.voices[voice].wsb[entry] = sval;
			ver3("fpu ws B v%d [%d] = %d", voice, entry, (int)sval);
		}
	}
}

/* -------------------------------------------------------------------------- */
/* Function register write                                                    */
/* -------------------------------------------------------------------------- */

static void fpu_write_func(uint32_t off, uint32_t val)
{
	/*
	 * Function registers: byte offsets 0x4000 - 0x5FDF.
	 * Each voice has 16 functions × 32 bytes = 512 bytes.
	 * off_from_func_base = off - 0x4000
	 * voice = off_from_func_base / 512
	 * func  = (off_from_func_base % 512) / 32
	 * reg   = (off_from_func_base % 512) % 32
	 */

	uint32_t rel = off - FPU_FUNC;
	int32_t voice = (int32_t)(rel / 512);
	int32_t func = (int32_t)((rel % 512) / 32);
	int32_t reg = (int32_t)((rel % 512) % 32);

	if (voice < 0 || voice >= DSP_VOICES) {
		return;
	}

	if (func < 0 || func >= DSP_FUNCS) {
		return;
	}

	dsp_func_t *fn = &g_dsp.voices[voice].funcs[func];
	int16_t sval = (int16_t)val;
	uint16_t uval = (uint16_t)val;

	switch (reg) {
	case FR_CTL:
		ver2("fpu ctl v%d f%d 0x%04x", voice, func, uval);

		if (uval == FPU_FKILL) {
			/* kill: stop interpolation immediately */
			fn->active = false;
			fn->remaining = 0;
			ver2("fpu kill v%d f%d", voice, func);
			break;
		}

		if (uval & FPU_UPD) {
			/* determine which value register has the new target */
			int16_t new_val;

			if (uval & (1 << FPU_VBIT)) {
				new_val = fn->val01;
			}
			else {
				new_val = fn->val10;
			}

			fn->target = new_val;
			fn->int_enable = (uval & FPU_INT) != 0;

			/* calculate interpolation time */
			uint16_t mnt = fn->mnt;
			uint16_t exp = fn->exp;
			double time_ms;

			if (exp == 0) {
				time_ms = 0.0;
			}
			else {
				time_ms = (double)mnt / (double)exp;
			}

			int32_t steps = (int32_t)(time_ms * EXEC_PER_MS);

			if (steps < 1) {
				/* immediate: jump to target */
				fn->current_d = (double)fn->target;
				fn->current = fn->target;
				fn->active = false;
				fn->remaining = 0;

				/* if interrupt enabled, signal completion */
				if (fn->int_enable) {
					dsp_irq_fifo_t *fifo = &g_dsp.irq_fifo;

					if (fifo->head - fifo->tail < DSP_IRQ_FIFO_SZ) {
						fifo->buf[fifo->head % DSP_IRQ_FIFO_SZ] =
								(uint8_t)(voice * 16 + func);
						fifo->head++;
					}
				}

				ver2("fpu imm v%d f%d val=%d", voice, func,
						(int)fn->current);
			}
			else {
				/* start interpolation */
				fn->increment = ((double)fn->target - fn->current_d) /
						(double)steps;
				fn->remaining = steps;
				fn->active = true;

				ver2("fpu start v%d f%d cur=%d tgt=%d steps=%d",
						voice, func, (int)fn->current,
						(int)fn->target, steps);
			}
		}

		break;

	case FR_VAL10:
		fn->val10 = sval;
		ver3("fpu val10 v%d f%d %d", voice, func, (int)sval);
		break;

	case FR_VAL01:
		fn->val01 = sval;
		ver3("fpu val01 v%d f%d %d", voice, func, (int)sval);
		break;

	case FR_MNT:
		fn->mnt = uval;
		ver3("fpu mnt v%d f%d 0x%04x", voice, func, uval);
		break;

	case FR_EXP:
		fn->exp = uval;
		ver3("fpu exp v%d f%d 0x%04x", voice, func, uval);
		break;

	case FR_CV1:
		fn->cv1 = sval;
		ver2("fpu cv1 v%d f%d %d", voice, func, (int)sval);
		break;

	case FR_SF1:
	case FR_CV2:
	case FR_SF2:
	case FR_CV3:
	case FR_SF3:
		/* CV2/CV3 and scale factors — not yet used */
		break;

	default:
		break;
	}
}

/* -------------------------------------------------------------------------- */
/* Config register write                                                      */
/* -------------------------------------------------------------------------- */

static void fpu_write_cfg(uint32_t off, uint32_t val)
{
	/*
	 * Config registers: byte offsets 0x5FE0 - 0x5FFC.
	 * Each voice has one 16-bit config word at 0x5FE0 + voice*2.
	 * Format: bits 8-11 = FM config number, bit 13 = osc2 sync,
	 *         bit 14 = osc3 sync, bit 15 = osc4 sync.
	 */

	int32_t voice = (int32_t)((off - FPU_CFG) / 2);

	if (voice < 0 || voice >= DSP_VOICES) {
		return;
	}

	uint16_t cfg = (uint16_t)val;
	int32_t fm_config = (cfg >> 8) & 0x0F;
	bool sync2 = (cfg & 0x2000) != 0;
	bool sync3 = (cfg & 0x4000) != 0;
	bool sync4 = (cfg & 0x8000) != 0;

	g_dsp.voices[voice].config = fm_config;
	g_dsp.voices[voice].osc_sync[1] = sync2;
	g_dsp.voices[voice].osc_sync[2] = sync3;
	g_dsp.voices[voice].osc_sync[3] = sync4;

	ver("fpu cfg v%d config=%d sync=%d%d%d", voice, fm_config,
			(int)sync2, (int)sync3, (int)sync4);
}

/* -------------------------------------------------------------------------- */
/* Public interface                                                           */
/* -------------------------------------------------------------------------- */

void fpu_init(void)
{
	ver("fpu init");
	dsp_init();
}

void fpu_quit(void)
{
	ver("fpu quit");
}

bool fpu_exec(void)
{
	dsp_irq_fifo_t *fifo = &g_dsp.irq_fifo;

	/* advance all active function interpolators */

	for (int32_t v = 0; v < DSP_VOICES; ++v) {
		for (int32_t f = 0; f < DSP_FUNCS; ++f) {
			dsp_func_t *fn = &g_dsp.voices[v].funcs[f];

			if (!fn->active) {
				continue;
			}

			fn->remaining--;
			fn->current_d += fn->increment;
			fn->current = (int16_t)fn->current_d;

			if (fn->remaining <= 0) {
				/* interpolation complete: snap to target */
				fn->current_d = (double)fn->target;
				fn->current = fn->target;
				fn->active = false;

				if (fn->int_enable &&
						fifo->head - fifo->tail < DSP_IRQ_FIFO_SZ) {
					fifo->buf[fifo->head % DSP_IRQ_FIFO_SZ] =
							(uint8_t)(v * 16 + f);
					fifo->head++;
				}

				ver2("fpu done v%d f%d val=%d", v, f,
						(int)fn->current);
			}
		}
	}

	/* return true while there are pending interrupts */

	return fifo->head > fifo->tail;
}

uint32_t fpu_read(uint32_t off, int32_t sz)
{
	ver2("fpu rd 0x%04x:%d", off, sz * 8);

	/*
	 * Read at offset 0x4000 returns the interrupt status byte.
	 * FPUINT.S: move.w FPUINT1,d0  then  andi.w #$00FF,d0
	 * The low byte contains the voice/function number.
	 */

	if (off >= FPU_FUNC && off < FPU_ICLR) {
		dsp_irq_fifo_t *fifo = &g_dsp.irq_fifo;

		if (fifo->head > fifo->tail) {
			return (uint32_t)fifo->buf[fifo->tail % DSP_IRQ_FIFO_SZ];
		}

		return 0;
	}

	return 0;
}

void fpu_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("fpu wr 0x%04x:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (off < FPU_FUNC) {
		/* waveshape table region */
		fpu_write_ws(off, val);
	}
	else if (off >= FPU_FUNC && off < FPU_CFG) {
		/* function register region */
		fpu_write_func(off, val);
	}
	else if (off >= FPU_CFG && off < FPU_SYN) {
		/* config register */
		fpu_write_cfg(off, val);
	}
	else if (off == FPU_SYN) {
		/* sync word — not critical for emulation */
		ver2("fpu sync 0x%04x", val);
	}
	else if (off >= FPU_ICLR) {
		/* interrupt clear: advance FIFO to next pending */
		dsp_irq_fifo_t *fifo = &g_dsp.irq_fifo;

		if (fifo->tail < fifo->head) {
			fifo->tail++;

			/* compact FIFO when both pointers are high */
			if (fifo->tail >= DSP_IRQ_FIFO_SZ) {
				fifo->head -= fifo->tail;
				fifo->tail = 0;
			}
		}

		ver2("fpu irq clear (pending %d)", fifo->head - fifo->tail);
	}
}
