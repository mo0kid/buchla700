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

#define ver(...) _ver(snd_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(snd_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(snd_verbose, 2, __VA_ARGS__)

int32_t snd_verbose = 0;

/* -------------------------------------------------------------------------- */
/* PSG / LMC835 EQ serial protocol decode                                     */
/*                                                                            */
/* MIDAS controls the graphic EQ by bit-banging serial data on PSG port B     */
/* (register 15).  Each byte is clocked in LSB-first on CLK rising edge,      */
/* then latched on STB rising edge.  Two bytes form a command: band + gain.   */
/* -------------------------------------------------------------------------- */

#define PSG_PRTB  15
#define EQ_STB    0x04
#define EQ_DAT    0x08
#define EQ_CLK    0x10
#define EQ_ADD    0x40

static int32_t  psg_reg  = 0;     /* currently selected PSG register */
static uint8_t  eq_prev  = 0;     /* previous port B value */
static uint8_t  eq_byte  = 0;     /* byte being assembled */
static int32_t  eq_bit   = 0;     /* bit position (0-7) */
static int32_t  eq_band  = -1;    /* received band (-1 = waiting) */

/* LMC835 gain code → dB reverse lookup (max code = 0x2F = 47) */

static const int8_t eqgaint[] = {
	0x00, 0x20, 0x10, 0x08, 0x04, 0x02, 0x12, 0x2A,
	0x16, 0x01, 0x29, 0x2D, 0x2F
};

static int8_t eq_rev[48];   /* code → dB magnitude */

static void eq_init_rev(void)
{
	memset(eq_rev, 0, sizeof eq_rev);

	for (int32_t i = 0; i <= 12; ++i) {
		eq_rev[eqgaint[i] & 0x3F] = (int8_t)i;
	}
}

static void eq_decode_byte(uint8_t byte)
{
	if (eq_band < 0) {
		/* first byte: band number (0-13) */
		eq_band = byte & 0x0F;
		ver("eq serial: band=%d", eq_band);
	}
	else {
		/* second byte: gain code */
		int32_t add = (byte & EQ_ADD) != 0;
		int32_t code = byte & 0x3F;
		int32_t db_mag = (code < 48) ? eq_rev[code] : 0;
		double gain_db = add ? (double)db_mag : -(double)db_mag;

		/* bands 0-6 = left, 7-13 = right */
		int32_t channel = eq_band / 7;
		int32_t band_idx = eq_band % 7;

		ver("eq serial: band=%d ch=%d gain=%.0f dB (code=0x%02x)",
				eq_band, channel, gain_db, byte);

		eq_set_band(band_idx, channel, gain_db);
		eq_band = -1;
	}
}

static void eq_psg_write(uint8_t val)
{
	/* detect CLK rising edge: sample DAT bit */

	if (!(eq_prev & EQ_CLK) && (val & EQ_CLK)) {
		if (eq_bit < 8) {
			if (val & EQ_DAT) {
				eq_byte |= (uint8_t)(1 << eq_bit);
			}

			++eq_bit;
		}
	}

	/* detect STB rising edge: latch byte */

	if (!(eq_prev & EQ_STB) && (val & EQ_STB)) {
		if (eq_bit >= 8) {
			eq_decode_byte(eq_byte);
		}

		eq_byte = 0;
		eq_bit = 0;
	}

	eq_prev = val;
}

static SDL_AudioDeviceID audio_dev;

static int audio_is_s16 = 0;
static float *render_buf = NULL;
static int render_buf_frames = 0;

static void audio_callback(void *userdata, Uint8 *stream, int len)
{
	(void)userdata;

	if (audio_is_s16) {
		int16_t *out = (int16_t *)stream;
		int32_t frames = len / (int)(sizeof(int16_t) * 2); /* stereo */

		/* grow temp buffer if needed */
		if (frames > render_buf_frames) {
			free(render_buf);
			render_buf = (float *)malloc((size_t)frames * sizeof(float) * 2);
			render_buf_frames = frames;
		}

		dsp_render(render_buf, frames);

		/* float [-1,1] → S16 */
		for (int32_t i = 0; i < frames * 2; i++) {
			float s = render_buf[i];
			if (s > 1.0f) s = 1.0f;
			if (s < -1.0f) s = -1.0f;
			out[i] = (int16_t)(s * 32767.0f);
		}
	}
	else {
		float *buf = (float *)stream;
		int32_t frames = len / (int)(sizeof(float) * 2); /* stereo */
		dsp_render(buf, frames);
	}

}

void snd_init(void)
{
	ver("snd init");
	eq_init_rev();

	SDL_AudioSpec want, have;

	SDL_memset(&want, 0, sizeof want);
	want.freq = DSP_SAMPLE_RATE;
	want.channels = 2;
	want.callback = audio_callback;

#if defined(EMU_RPI)
	want.samples = 1024;
	want.format = AUDIO_S16SYS;
#else
	want.samples = 512;
	want.format = AUDIO_F32SYS;
#endif

	audio_dev = SDL_OpenAudioDevice(NULL, 0, &want, &have,
			SDL_AUDIO_ALLOW_FORMAT_CHANGE);

	if (audio_dev == 0) {
		err("SDL_OpenAudioDevice() failed: %s", SDL_GetError());
		return;
	}

	audio_is_s16 = (have.format == AUDIO_S16SYS || have.format == AUDIO_S16LSB
			|| have.format == AUDIO_S16MSB);

	inf("audio: %d Hz, %d ch, %d samples, fmt 0x%04x%s",
			have.freq, have.channels, have.samples, have.format,
			audio_is_s16 ? " (S16)" : " (F32)");

	g_dsp.sample_rate = (double)have.freq;

	/* start audio playback */
	SDL_PauseAudioDevice(audio_dev, 0);
}

void snd_quit(void)
{
	ver("snd quit");

	if (audio_dev != 0) {
		SDL_CloseAudioDevice(audio_dev);
		audio_dev = 0;
	}
}

bool snd_exec(void)
{
	ver3("snd exec");
	return false;
}

uint32_t snd_read(uint32_t off, int32_t sz)
{
	ver2("snd rd %u:%d", off, sz * 8);
	return 0;
}

void snd_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("snd wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (off == 0 && sz == 1) {
		/* PSG register select */
		psg_reg = (int32_t)(val & 0xFF);
	}
	else if (off == 1 && sz == 1 && psg_reg == PSG_PRTB) {
		/* PSG port B write — decode EQ serial data */
		eq_psg_write((uint8_t)(val & 0xFF));
	}
}
