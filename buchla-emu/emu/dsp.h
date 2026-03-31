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

#pragma once

#include <stdbool.h>
#include <stdint.h>
#include <math.h>

/* Precision selection: single-precision float on RPi (ARM Cortex-A53),
 * double-precision on macOS/desktop.  All DSP computation uses dsp_real
 * and the dsp_xxx math wrappers so a single code path serves both. */

#if defined(EMU_RPI)
typedef float dsp_real;
#define dsp_sin   sinf
#define dsp_cos   cosf
#define dsp_fmax  fmaxf
#define dsp_fmin  fminf
#define dsp_fabs  fabsf
#define dsp_pow   powf
#define dsp_exp   expf
#define dsp_log   logf
#define dsp_tan   tanf
#define dsp_sqrt  sqrtf
#define dsp_asin  asinf
#define dsp_tanh  tanhf
#define DSP_PI    3.14159265f
#define DSP_TWO_PI 6.28318530f
#else
typedef double dsp_real;
#define dsp_sin   sin
#define dsp_cos   cos
#define dsp_fmax  fmax
#define dsp_fmin  fmin
#define dsp_fabs  fabs
#define dsp_pow   pow
#define dsp_exp   exp
#define dsp_log   log
#define dsp_tan   tan
#define dsp_sqrt  sqrt
#define dsp_asin  asin
#define dsp_tanh  tanh
#define DSP_PI    M_PI
#define DSP_TWO_PI (2.0 * M_PI)
#endif

#define DSP_VOICES      12
#define DSP_FUNCS       16
#define DSP_OSCS        4
#define DSP_WS_COUNT    254
#define DSP_SAMPLE_RATE 48000

/* FPU function indices within a voice */

#define FN_SPARE   0
#define FN_FREQ1   1
#define FN_LEVEL   2
#define FN_FREQ2   3
#define FN_LOCN    4
#define FN_FREQ3   5
#define FN_FILTRQ  6
#define FN_FREQ4   7
#define FN_DYNAM   8
#define FN_INDEX1  9
#define FN_FILTER  10
#define FN_INDEX2  11
#define FN_INDEX3  12
#define FN_INDEX4  13
#define FN_INDEX5  14
#define FN_INDEX6  15

/* FPU control word bits */

#define FPU_UPD    0x0001   /* update bit (start interpolation) */
#define FPU_INT    0x0002   /* interrupt enable */
#define FPU_RAT    0x0004   /* ratio bit */
#define FPU_VSEL   0x0018   /* new value select bits */
#define FPU_VBIT   3        /* bit number for value select */

/* FPU special control words */

#define FPU_FKILL  0x0014   /* kill function */
#define FPU_FSEND  0x0015   /* send value immediately (no interrupt) */

/* FPU register byte offsets within a function (32 bytes per function) */

#define FR_CTL     0x00
#define FR_VAL10   0x02
#define FR_CV1     0x08
#define FR_SF1     0x0A
#define FR_CV2     0x0C
#define FR_SF2     0x0E
#define FR_CV3     0x10
#define FR_SF3     0x12
#define FR_MNT     0x14
#define FR_EXP     0x16
#define FR_VAL01   0x1C

/* FPU address region byte offsets from base (0x180000) */

#define FPU_WST    0x0000   /* waveshape tables: 0x0000 - 0x3FFF */
#define FPU_FUNC   0x4000   /* function registers: 0x4000 - 0x5FDF */
#define FPU_CFG    0x5FE0   /* config registers: 0x5FE0 - 0x5FFC */
#define FPU_SYN    0x5FFE   /* sync word */
#define FPU_ICLR   0x6000   /* interrupt clear */

/* Per-function interpolator state */

typedef struct {
	dsp_real current_d;     /* accumulated value */
	int16_t  current;       /* quantized current value */
	int16_t  target;        /* interpolation target */
	dsp_real increment;     /* per-step increment */
	int32_t  remaining;     /* interpolation steps remaining */
	bool     active;        /* interpolation in progress */
	bool     int_enable;    /* generate interrupt on completion */

	/* shadow register state */

	int16_t  val10;
	int16_t  val01;
	uint16_t mnt;
	uint16_t exp;

	/* control voltage modulation (written by patch system via FPU CV1) */

	int16_t  cv1;
	int16_t  cv2;

	/* DSP-side smoothed values (updated at audio rate) */

	dsp_real cv2_smooth;
	dsp_real dsp_smooth;
} dsp_func_t;

/* Per-oscillator state */

typedef struct {
	dsp_real phase;
	dsp_real phase_inc;
} dsp_osc_t;

/* 4-pole OTA ladder filter (analog-modeled) */

typedef struct {
	dsp_real s[4];       /* integrator states */
	dsp_real feedback;   /* delayed feedback sample */
} dsp_filter_t;

/* DC blocking high-pass filter */

typedef struct {
	dsp_real prev_in;
	dsp_real prev_out;
} dsp_dcblock_t;

/* Biquad filter (used for all-pass and high-pass) */

typedef struct {
	dsp_real b0, b1, b2;
	dsp_real a1, a2;
	dsp_real z1, z2;          /* state (direct form II transposed) */
} dsp_biquad_t;

/* Phase shifter (global stereo effect) */

#define PS_ALLPASS_STAGES 8

typedef struct {
	dsp_biquad_t ap_l[PS_ALLPASS_STAGES];  /* left all-pass chain */
	dsp_biquad_t ap_r[PS_ALLPASS_STAGES];  /* right all-pass chain */
	dsp_biquad_t hp_l;                      /* left high-pass (200 Hz) */
	dsp_biquad_t hp_r;                      /* right high-pass (200 Hz) */
	dsp_real     lfo_phase;
	dsp_real     lfo_inc;
	int32_t      update_counter;            /* coefficient update decimation */
} dsp_pshift_t;

/* 7-band stereo graphic EQ (LMC835 emulation) */

#define EQ_BANDS    7
#define EQ_CHANNELS 2

typedef struct {
	dsp_biquad_t filters[EQ_BANDS][EQ_CHANNELS];
	dsp_real     gain_db[EQ_BANDS][EQ_CHANNELS];  /* ±12 dB per band */
	bool         dirty;                             /* coefficients need update */
} dsp_eq_t;

/* Aural exciter (always-on harmonic enhancer) */

typedef struct {
	dsp_biquad_t hp_l, hp_r;       /* high-pass 1 kHz */
	dsp_biquad_t lp_l, lp_r;       /* low-pass 12 kHz */
	dsp_biquad_t ap_l, ap_r;       /* all-pass for stereo width */
} dsp_exciter_t;

/* Per-voice state */

#define DSP_RAMP_SAMPLES 64    /* ~1.3ms anti-click ramp at 48kHz */

typedef struct {
	dsp_func_t   funcs[DSP_FUNCS];
	dsp_osc_t    oscs[DSP_OSCS];
	dsp_filter_t filter;
	dsp_dcblock_t dcblock;
	int16_t      wsa[DSP_WS_COUNT];    /* waveshape A (signed 16-bit) */
	int16_t      wsb[DSP_WS_COUNT];    /* waveshape B */
	int32_t      config;               /* FM routing config 0-11 */
	bool         osc_sync[DSP_OSCS];   /* oscillator sync flags */
	dsp_real     ramp;                 /* anti-click ramp 0..1 */
	bool         was_active;           /* was producing sound last sample */
} dsp_voice_t;

/* IRQ FIFO queue for completed functions */

#define DSP_IRQ_FIFO_SZ 256

typedef struct {
	uint8_t  buf[DSP_IRQ_FIFO_SZ];
	int32_t  head;             /* write position */
	int32_t  tail;             /* read position */
} dsp_irq_fifo_t;

/* Global DSP state */

typedef struct {
	dsp_voice_t    voices[DSP_VOICES];
	dsp_pshift_t   pshift;
	dsp_eq_t       eq;
	dsp_exciter_t  exciter;
	dsp_real       sample_rate;
	dsp_real       ht_value;       /* horizontal touch: -1..+1 pitch bend */
	dsp_real       vt_value;       /* vertical touch: 0..1 mod depth */
	dsp_irq_fifo_t irq_fifo;
} dsp_state_t;

extern dsp_state_t g_dsp;
