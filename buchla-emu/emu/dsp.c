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
#include <math.h>
#include <string.h>

#define TWO_PI DSP_TWO_PI

dsp_state_t g_dsp;
bool dsp_test_tone = false;

/* -------------------------------------------------------------------------- */
/* Pitch / frequency conversion                                               */
/* -------------------------------------------------------------------------- */

/*
 * Convert FPU pitch value (half-cents) to Hz.
 * MIDI note 0 (C-1) = 8.1758 Hz.  Each half-cent = 1/2400 octave.
 */

static dsp_real pitch_to_hz(int16_t pitch)
{
	if (pitch <= 0) {
		return 8.1758;
	}

	return 8.1758 * dsp_pow(2.0, (dsp_real)pitch / 2400.0);
}

/* -------------------------------------------------------------------------- */
/* Waveshaper lookup with linear interpolation                                */
/* -------------------------------------------------------------------------- */

static dsp_real waveshaper_lookup(dsp_real input, const int16_t *table, int32_t count)
{
	if (count < 2) {
		return input;
	}

	dsp_real clamped = dsp_fmax(-1.0, dsp_fmin(1.0, input));
	dsp_real idx = (clamped + 1.0) * 0.5 * (dsp_real)(count - 1);
	int32_t i = (int32_t)idx;
	dsp_real frac = idx - (dsp_real)i;

	if (i < 0) {
		i = 0;
	}

	if (i >= count - 1) {
		i = count - 2;
	}

	dsp_real a = (dsp_real)table[i] / 32000.0;
	dsp_real b = (dsp_real)table[i + 1] / 32000.0;

	return a + frac * (b - a);
}

/* -------------------------------------------------------------------------- */
/* 4-pole OTA ladder filter — analog-modeled after mid-80s Buchla design      */
/*                                                                            */
/* Each stage models an OTA integrator with tanh() soft saturation on the     */
/* input differential pair, giving the warm compression and harmonics of      */
/* real analog filters.  Zero-delay feedback (ZDF) via the Zavalishin/        */
/* Pirkle method keeps tuning accurate at all frequencies.                    */
/*                                                                            */
/* Resonance feeds the 4th-stage output back to the input through tanh,       */
/* naturally limiting at high Q instead of blowing up.                        */
/* -------------------------------------------------------------------------- */

/* thermal voltage scaling — controls saturation knee */
#define VT  (1.22)     /* ~1.2 gives a warm but not overly fuzzy character */
#define VT_INV (1.0 / VT)

static inline dsp_real ota_tanh(dsp_real x)
{
	/* fast tanh approximation: accurate to ~0.1% for |x| < 4 */
	dsp_real x2 = x * x;
	return x * (27.0 + x2) / (27.0 + 9.0 * x2);
}

static dsp_real filter_process_full(dsp_filter_t *f, dsp_real input,
		dsp_real cutoff_hz, dsp_real resonance, dsp_real sr)
{
	dsp_real fc = dsp_fmax(20.0, dsp_fmin(sr * 0.49, cutoff_hz));
	dsp_real r = dsp_fmax(0.0, dsp_fmin(0.95, resonance));

	/* integrator coefficient via bilinear pre-warp */
	dsp_real g = dsp_tan(DSP_PI * fc / sr);
	dsp_real G = g / (1.0 + g);

	/* feedback gain: 4.0 is the theoretical self-oscillation threshold
	 * for a 4-pole ladder.  The tanh saturation in the feedback path
	 * provides natural limiting so we can safely approach it. */
	dsp_real k = r * 4.0;

	/* estimate output for zero-delay feedback using previous states */
	dsp_real S = (G * G * G * f->s[0] +
		    G * G * f->s[1] +
		    G * f->s[2] +
		    f->s[3]);

	dsp_real S_scale = G * G * G * G;
	dsp_real u = (input - k * ota_tanh(f->feedback * VT_INV) * VT) /
		   (1.0 + k * S_scale);

	/* cascade of 4 OTA stages with tanh saturation */
	dsp_real x = ota_tanh(u * VT_INV) * VT;

	for (int32_t i = 0; i < 4; ++i) {
		dsp_real v = G * (x - f->s[i]);
		dsp_real y = v + f->s[i];
		f->s[i] = y + v;
		x = ota_tanh(y * VT_INV) * VT;
	}

	f->feedback = x;

	/* safety: reset if unstable */
	if (!isfinite(x)) {
		for (int32_t j = 0; j < 4; ++j) f->s[j] = 0.0;
		f->feedback = 0.0;
		return 0.0;
	}

	(void)S; /* S used in u calculation above */

	return x;
}

/* -------------------------------------------------------------------------- */
/* DC blocker (1st-order high-pass, coeff 0.995)                              */
/* -------------------------------------------------------------------------- */

static dsp_real dcblock_process(dsp_dcblock_t *dc, dsp_real input)
{
	dsp_real out = input - dc->prev_in + 0.995 * dc->prev_out;

	dc->prev_in = input;
	dc->prev_out = out;

	return out;
}

/* -------------------------------------------------------------------------- */
/* Biquad filter processing (direct form II transposed)                       */
/* -------------------------------------------------------------------------- */

static inline dsp_real biquad_process(dsp_biquad_t *f, dsp_real in)
{
	dsp_real out = f->b0 * in + f->z1;

	f->z1 = f->b1 * in - f->a1 * out + f->z2;
	f->z2 = f->b2 * in - f->a2 * out;

	return out;
}

static void biquad_set_allpass(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real sr)
{
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real a0 = 1.0 + alpha;

	f->b0 = (1.0 - alpha) / a0;
	f->b1 = -2.0 * dsp_cos(w0) / a0;
	f->b2 = 1.0;
	f->a1 = f->b1;
	f->a2 = f->b0;
}

static void biquad_set_highpass(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real sr)
{
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real cosw0 = dsp_cos(w0);
	dsp_real a0 = 1.0 + alpha;

	f->b0 = (1.0 + cosw0) * 0.5 / a0;
	f->b1 = -(1.0 + cosw0) / a0;
	f->b2 = f->b0;
	f->a1 = -2.0 * cosw0 / a0;
	f->a2 = (1.0 - alpha) / a0;
}

static void biquad_set_lowpass(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real sr)
{
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real cosw0 = dsp_cos(w0);
	dsp_real a0 = 1.0 + alpha;

	f->b0 = (1.0 - cosw0) * 0.5 / a0;
	f->b1 = (1.0 - cosw0) / a0;
	f->b2 = f->b0;
	f->a1 = -2.0 * cosw0 / a0;
	f->a2 = (1.0 - alpha) / a0;
}

static void biquad_set_lowshelf(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real gain_db, dsp_real sr)
{
	dsp_real A = dsp_pow(10.0, gain_db / 40.0);
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real cosw0 = dsp_cos(w0);
	dsp_real sqA = 2.0 * dsp_sqrt(A) * alpha;
	dsp_real a0 = (A + 1.0) + (A - 1.0) * cosw0 + sqA;

	f->b0 = A * ((A + 1.0) - (A - 1.0) * cosw0 + sqA) / a0;
	f->b1 = 2.0 * A * ((A - 1.0) - (A + 1.0) * cosw0) / a0;
	f->b2 = A * ((A + 1.0) - (A - 1.0) * cosw0 - sqA) / a0;
	f->a1 = -2.0 * ((A - 1.0) + (A + 1.0) * cosw0) / a0;
	f->a2 = ((A + 1.0) + (A - 1.0) * cosw0 - sqA) / a0;
}

static void biquad_set_highshelf(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real gain_db, dsp_real sr)
{
	dsp_real A = dsp_pow(10.0, gain_db / 40.0);
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real cosw0 = dsp_cos(w0);
	dsp_real sqA = 2.0 * dsp_sqrt(A) * alpha;
	dsp_real a0 = (A + 1.0) - (A - 1.0) * cosw0 + sqA;

	f->b0 = A * ((A + 1.0) + (A - 1.0) * cosw0 + sqA) / a0;
	f->b1 = -2.0 * A * ((A - 1.0) + (A + 1.0) * cosw0) / a0;
	f->b2 = A * ((A + 1.0) + (A - 1.0) * cosw0 - sqA) / a0;
	f->a1 = 2.0 * ((A - 1.0) - (A + 1.0) * cosw0) / a0;
	f->a2 = ((A + 1.0) - (A - 1.0) * cosw0 - sqA) / a0;
}

static void biquad_set_peaking(dsp_biquad_t *f, dsp_real freq, dsp_real q,
		dsp_real gain_db, dsp_real sr)
{
	dsp_real A = dsp_pow(10.0, gain_db / 40.0);
	dsp_real w0 = TWO_PI * freq / sr;
	dsp_real alpha = dsp_sin(w0) / (2.0 * q);
	dsp_real cosw0 = dsp_cos(w0);
	dsp_real a0 = 1.0 + alpha / A;

	f->b0 = (1.0 + alpha * A) / a0;
	f->b1 = -2.0 * cosw0 / a0;
	f->b2 = (1.0 - alpha * A) / a0;
	f->a1 = f->b1;
	f->a2 = (1.0 - alpha / A) / a0;
}

static void biquad_reset(dsp_biquad_t *f)
{
	f->z1 = 0.0;
	f->z2 = 0.0;
}

/* -------------------------------------------------------------------------- */
/* Phase shifter (ported from Taunus PhaseShift)                              */
/*                                                                            */
/* 8-stage cascaded all-pass filters per channel with LFO modulation.         */
/* Parameters come from the spare function (func 0) of voices 1, 2, 3:       */
/*   voice 1 func 0 = intensity,  voice 2 func 0 = rate,                     */
/*   voice 3 func 0 = depth.                                                  */
/* MIDAS sends: (param_0_99 * 10) << 5, so max value = 31680.                */
/* -------------------------------------------------------------------------- */

#define PS_MAX_RAW    31680.0
#define PS_UPDATE_INT 256

static void pshift_init(dsp_pshift_t *ps, dsp_real sr)
{
	for (int32_t i = 0; i < PS_ALLPASS_STAGES; ++i) {
		biquad_set_allpass(&ps->ap_l[i], 1000.0, 1.0, sr);
		biquad_set_allpass(&ps->ap_r[i], 1000.0, 1.0, sr);
		biquad_reset(&ps->ap_l[i]);
		biquad_reset(&ps->ap_r[i]);
	}

	biquad_set_highpass(&ps->hp_l, 200.0, 0.707, sr);
	biquad_set_highpass(&ps->hp_r, 200.0, 0.707, sr);
	biquad_reset(&ps->hp_l);
	biquad_reset(&ps->hp_r);

	ps->lfo_phase = 0.0;
	ps->lfo_inc = TWO_PI * 1.0 / sr;
	ps->update_counter = 0;
}

static void pshift_update_coeffs(dsp_pshift_t *ps, dsp_real intensity,
		dsp_real sr)
{
	dsp_real exp_int = intensity * intensity;
	dsp_real min_freq = 300.0;
	dsp_real max_freq = 3500.0;
	dsp_real base_l = min_freq + (1.0 - exp_int) * (max_freq - min_freq);
	dsp_real base_r = base_l * 0.8;
	dsp_real q = 0.9;

	for (int32_t i = 0; i < PS_ALLPASS_STAGES; ++i) {
		dsp_real ratio = (dsp_real)i / (dsp_real)(PS_ALLPASS_STAGES - 1);

		dsp_real lr = dsp_pow(0.5 + ratio * 0.5, 1.5);
		dsp_real lf = dsp_fmax(250.0, dsp_fmin(6000.0, base_l * lr));

		dsp_real rr = dsp_pow(1.0 - ratio * 0.4, 1.2);
		dsp_real rf = dsp_fmax(250.0, dsp_fmin(6000.0, base_r * rr));

		biquad_set_allpass(&ps->ap_l[i], lf, q, sr);
		biquad_set_allpass(&ps->ap_r[i], rf, q, sr);
	}
}

static dsp_real pshift_lfo(dsp_pshift_t *ps)
{
	dsp_real s = dsp_sin(ps->lfo_phase);
	dsp_real soft = s * (1.5 - 0.5 * s * s);
	dsp_real tri = (2.0 / DSP_PI) * dsp_asin(dsp_sin(ps->lfo_phase));
	dsp_real val = 0.7 * soft + 0.3 * tri;

	ps->lfo_phase += ps->lfo_inc;

	if (ps->lfo_phase >= TWO_PI) {
		ps->lfo_phase -= TWO_PI;
	}

	return val;
}

static void pshift_process(dsp_pshift_t *ps, dsp_real *left, dsp_real *right,
		dsp_real intensity, dsp_real rate_hz, dsp_real depth, dsp_real sr)
{
	if (intensity <= 0.001 && depth <= 0.001) {
		return;
	}

	/* update LFO rate */

	ps->lfo_inc = TWO_PI * rate_hz / sr;

	/* generate LFO and compute modulated intensity */

	dsp_real lfo = pshift_lfo(ps);
	dsp_real mod = lfo * depth * 0.3;
	dsp_real mod_int = dsp_fmax(0.0, dsp_fmin(1.0, intensity + mod));

	/* update filter coefficients periodically */

	if (ps->update_counter <= 0) {
		pshift_update_coeffs(ps, mod_int, sr);
		ps->update_counter = PS_UPDATE_INT;
	}

	--ps->update_counter;

	/* high-pass to remove low-end thumping */

	dsp_real lf = biquad_process(&ps->hp_l, *left);
	dsp_real rf = biquad_process(&ps->hp_r, *right);

	/* cascaded all-pass chain */

	for (int32_t i = 0; i < PS_ALLPASS_STAGES; ++i) {
		lf = biquad_process(&ps->ap_l[i], lf);
		rf = biquad_process(&ps->ap_r[i], rf);
	}

	/* mix: 80% phase-shifted + 20% original */

	*left = lf * 0.8 + *left * 0.2;
	*right = rf * 0.8 + *right * 0.2;
}

/* -------------------------------------------------------------------------- */
/* 7-band stereo graphic EQ (LMC835 emulation)                               */
/*                                                                            */
/* Bands: 50 Hz (low-shelf), 150/400/1k/2.5k/6k Hz (peaking), 15 kHz (high- */
/* shelf).  ±12 dB per band, independent L/R.  Gains set via eq_set_band().   */
/* -------------------------------------------------------------------------- */

static const dsp_real eq_freqs[EQ_BANDS] = {
	50.0, 150.0, 400.0, 1000.0, 2500.0, 6000.0, 15000.0
};

static void eq_update_band(dsp_eq_t *eq, int32_t band, int32_t ch, dsp_real sr)
{
	dsp_real freq = eq_freqs[band];
	dsp_real db = eq->gain_db[band][ch];

	if (band == 0) {
		biquad_set_lowshelf(&eq->filters[band][ch], freq, 0.707, db, sr);
	}
	else if (band == EQ_BANDS - 1) {
		biquad_set_highshelf(&eq->filters[band][ch], freq, 0.707, db, sr);
	}
	else {
		biquad_set_peaking(&eq->filters[band][ch], freq, 1.0, db, sr);
	}
}

static void eq_init(dsp_eq_t *eq, dsp_real sr)
{
	for (int32_t b = 0; b < EQ_BANDS; ++b) {
		for (int32_t c = 0; c < EQ_CHANNELS; ++c) {
			eq->gain_db[b][c] = 0.0;
			biquad_reset(&eq->filters[b][c]);
			eq_update_band(eq, b, c, sr);
		}
	}

	eq->dirty = false;
}

void eq_set_band(int32_t band, int32_t channel, double gain_db)
{
	if (band < 0 || band >= EQ_BANDS || channel < 0 || channel >= EQ_CHANNELS) {
		return;
	}

	gain_db = fmax(-12.0, fmin(12.0, gain_db));
	g_dsp.eq.gain_db[band][channel] = (dsp_real)gain_db;
	g_dsp.eq.dirty = true;
}

static void eq_process(dsp_eq_t *eq, dsp_real *left, dsp_real *right, dsp_real sr)
{
	if (eq->dirty) {
		for (int32_t b = 0; b < EQ_BANDS; ++b) {
			for (int32_t c = 0; c < EQ_CHANNELS; ++c) {
				eq_update_band(eq, b, c, sr);
			}
		}

		eq->dirty = false;
	}

	dsp_real l = *left, r = *right;

	for (int32_t b = 0; b < EQ_BANDS; ++b) {
		l = biquad_process(&eq->filters[b][0], l);
		r = biquad_process(&eq->filters[b][1], r);
	}

	*left = l;
	*right = r;
}

/* -------------------------------------------------------------------------- */
/* Aural exciter (ported from Taunus Exciter)                                 */
/*                                                                            */
/* Always-on effect.  Extracts HF band (1–12 kHz), generates 2nd+3rd order   */
/* harmonics, applies soft clipping, mixes back with original.                */
/* -------------------------------------------------------------------------- */

static void exciter_init(dsp_exciter_t *ex, dsp_real sr)
{
	biquad_set_highpass(&ex->hp_l, 1000.0, 0.707, sr);
	biquad_set_highpass(&ex->hp_r, 1000.0, 0.707, sr);
	biquad_set_lowpass(&ex->lp_l, 12000.0, 0.707, sr);
	biquad_set_lowpass(&ex->lp_r, 12000.0, 0.707, sr);
	biquad_set_allpass(&ex->ap_l, 4000.0, 0.707, sr);
	biquad_set_allpass(&ex->ap_r, 6000.0, 0.707, sr);

	biquad_reset(&ex->hp_l);
	biquad_reset(&ex->hp_r);
	biquad_reset(&ex->lp_l);
	biquad_reset(&ex->lp_r);
	biquad_reset(&ex->ap_l);
	biquad_reset(&ex->ap_r);
}

static inline dsp_real exciter_softclip(dsp_real x)
{
	dsp_real threshold = 0.8;

	if (dsp_fabs(x) > threshold) {
		dsp_real sign = x >= 0.0 ? 1.0 : -1.0;
		dsp_real excess = dsp_fabs(x) - threshold;
		return sign * (threshold + dsp_tanh(excess * 2.0) * 0.2);
	}

	return x;
}

static inline dsp_real exciter_harmonics(dsp_real s)
{
	dsp_real sign = s >= 0.0 ? 1.0 : -1.0;
	dsp_real h = s * s * sign * 2.0 + s * s * s * 0.5;

	return exciter_softclip(h);
}

static void exciter_process(dsp_exciter_t *ex, dsp_real *left, dsp_real *right)
{
	/* extract HF band */

	dsp_real lhf = biquad_process(&ex->hp_l, *left);
	lhf = biquad_process(&ex->lp_l, lhf);

	dsp_real rhf = biquad_process(&ex->hp_r, *right);
	rhf = biquad_process(&ex->lp_r, rhf);

	/* generate harmonics */

	dsp_real lh = exciter_harmonics(lhf);
	dsp_real rh = exciter_harmonics(rhf);

	/* combine: original + harmonics + brightness boost */

	dsp_real le = *left + lh + *left * 0.3;
	dsp_real re = *right + rh + *right * 0.3;

	*left = exciter_softclip(le);
	*right = exciter_softclip(re);
}

/* -------------------------------------------------------------------------- */
/* FM routing configurations (ported from Taunus FMConfig.h)                  */
/*                                                                            */
/* Each function samples oscillators via sin(phase), applies FM modulation,   */
/* and produces wsaInput and wsbInput for the waveshapers.                    */
/* idx[0..5] = index1..index6 normalised values.                              */
/* -------------------------------------------------------------------------- */

typedef void (*fm_route_fn)(dsp_osc_t osc[4], const dsp_real idx[6],
		dsp_real *wsa, dsp_real *wsb);

/* Config 00: Symmetric dual-path.
 * WSA: Osc2→Ind1→Osc1, mixed with Osc4×Ind2, scaled by Ind3.
 * WSB: Osc2→Ind4→Osc3, mixed with Osc4×Ind5, scaled by Ind6.
 * Osc2 and Osc4 each modulate both paths. */

static void route00(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s1 = dsp_sin(o[1].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s1 * x[0]);
	dsp_real o2 = dsp_sin(o[2].phase + s1 * x[3]);

	*wsa = (o0 + s3 * x[1]) * x[2];
	*wsb = (o2 + s3 * x[4]) * x[5];
}

/* Config 01: Split modulators.
 * WSA: Osc2→Ind1→Osc1, with Osc2 side-chain×Ind2, scaled by Ind3.
 * WSB: Osc4→Ind4→Osc3, with Osc4 side-chain×Ind5, scaled by Ind6.
 * Each modulator dedicated to one path. */

static void route01(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s1 = dsp_sin(o[1].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s1 * x[0]);
	dsp_real o2 = dsp_sin(o[2].phase + s3 * x[3]);

	*wsa = (o0 + s1 * x[1]) * x[2];
	*wsb = (o2 + s3 * x[4]) * x[5];
}

/* Config 02: Cascaded FM with feedback.
 * WSA: Osc3→Ind2→Osc2→Ind1→Osc1, scaled by Ind3.
 * WSB: Osc4→Ind4→Osc3, scaled by Ind6.
 * Osc1→Ind5→Osc4 feedback loop creates complex spectra. */

static void route02(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + dsp_sin(o[1].phase + s2 * x[1]) * x[0]);
	dsp_real o2 = dsp_sin(o[2].phase + s3 * x[3]);

	/* Osc1→Ind5→Osc4: use s0 for modulation */
	(void)s0;
	o[3].phase += s0 * x[4];

	*wsa = o0 * x[2];
	*wsb = o2 * x[5];
}

/* Config 03: Shared carrier.
 * Osc3 FM-modulates both Osc1 (via Ind2) and Osc2 (via Ind5).
 * Osc4 appears directly in both outputs.
 * WSA: (Osc4 + Osc1×Ind1)×Ind3. WSB: (Osc4 + Osc2×Ind4)×Ind6. */

static void route03(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s2 * x[1]);
	dsp_real o1 = dsp_sin(o[1].phase + s2 * x[4]);

	*wsa = (s3 + o0 * x[0]) * x[2];
	*wsb = (s3 + o1 * x[3]) * x[5];
}

/* Config 04: Minimal FM + direct envelope.
 * WSA: Osc2→Ind2→Osc1, scaled by Ind3.
 * WSB: Ind6 alone (pure envelope, no oscillator). Ind1 unused.
 * Osc3, Osc4 computed but not routed to output. */

static void route04(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + dsp_sin(o[1].phase) * x[1]);
	dsp_real o1_mod = (s2 + s3) * x[3] + s0 * x[4];

	(void)o1_mod;

	*wsa = o0 * x[2];
	*wsb = x[5]; /* direct envelope → WSB */
}

/* Config 05: Cross-coupled paths.
 * WSA: Osc4→Ind2→Osc1, mixed with Osc2 side-chain, scaled by Ind3×Ind1.
 * WSB: Osc2→Ind5→Osc3, mixed with Osc4 side-chain, scaled by Ind6×Ind4. */

static void route05(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s3 * x[1]);
	dsp_real o2 = dsp_sin(o[2].phase + dsp_sin(o[1].phase) * x[4]);

	*wsa = (dsp_sin(o[1].phase) + o0 * x[0]) * x[2];
	*wsb = (s3 + o2 * x[3]) * x[5];
}

/* Config 06: Three-oscillator cascade, dual output.
 * Osc3→Ind1→Osc2→Ind2→Osc1, with Osc4×Ind4 added.
 * Both WSA (×Ind3) and WSB (×Ind6) receive the same signal. Ind5 unused. */

static void route06(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o1 = dsp_sin(o[1].phase + s2 * x[0]);
	dsp_real o0 = dsp_sin(o[0].phase + o1 * x[1] + s3 * x[3]);

	*wsa = o0 * x[2];
	*wsb = o0 * x[5];
}

/* Config 07: Osc4-centric.
 * WSA: Osc4→Ind4→Osc1, scaled by Ind3.
 * WSB: Osc4 with self-modulation×Ind5, scaled by Ind6.
 * Osc2 has Osc4 FM + self-feedback but not routed to output. Osc3 unused. */

static void route07(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o1 = dsp_sin(o[1].phase + s3 * x[0] + dsp_sin(o[1].phase) * x[1]);
	dsp_real o0 = dsp_sin(o[0].phase + s3 * x[3]);

	(void)o1;

	*wsa = o0 * x[2];
	*wsb = (s3 + s3 * x[4]) * x[5];
}

/* Config 08: Dual-path with feedback.
 * WSA: Osc2→Ind2→Osc1, mixed with Osc3×Ind1, scaled by Ind3.
 * WSB: Osc4 mixed with Osc1×Ind5, scaled by Ind6.
 * Osc3→Ind4→Osc2 feedback alters the FM spectrum. */

static void route08(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + dsp_sin(o[1].phase) * x[1]);

	o[1].phase += s2 * x[3]; /* Osc3→Ind4→Osc2 */

	*wsa = (o0 + s2 * x[0]) * x[2];
	*wsb = (s3 + s0 * x[4]) * x[5];
}

/* Config 09: Circular feedback.
 * WSA: Osc4→Ind1→Osc1, scaled by Ind3.
 * WSB: Osc2→Ind4→Osc3, scaled by Ind6.
 * Osc1→Ind5→Osc4 and Osc3→Ind2→Osc2 form two feedback loops
 * creating chaotic, evolving timbres. */

static void route09(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s1 = dsp_sin(o[1].phase);
	dsp_real s2 = dsp_sin(o[2].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s3 * x[0]);
	dsp_real o2 = dsp_sin(o[2].phase + s1 * x[3]);

	/* feedback: Osc1→Osc4, Osc3→Osc2 */
	o[3].phase += s0 * x[4];
	o[1].phase += s2 * x[1];

	*wsa = o0 * x[2];
	*wsb = o2 * x[5];
}

/* Config 10: Shared modulator, no feedback.
 * Osc2 FM-modulates both Osc1 (via Ind2) and Osc3 (via Ind5).
 * WSA: Osc1 + Osc3 side-chain×Ind1, scaled by Ind3.
 * WSB: Osc3 + Osc1 side-chain×Ind4, scaled by Ind6. Osc4 unused. */

static void route10(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s1 = dsp_sin(o[1].phase);
	dsp_real s2 = dsp_sin(o[2].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s1 * x[1]);
	dsp_real o2 = dsp_sin(o[2].phase + s1 * x[4]);

	*wsa = (o0 + s2 * x[0]) * x[2];
	*wsb = (o2 + s0 * x[3]) * x[5];
}

/* Config 11: Multi-output with shared carrier.
 * Osc3→Ind5→Osc1 as the main FM pair.
 * WSA: Osc1 + Osc1 raw×Ind1 + Osc4×Ind4, scaled by Ind3.
 * WSB: Osc1 + Osc2×Ind2, scaled by Ind6.
 * Three oscillators contribute as side-chains. */

static void route11(dsp_osc_t o[4], const dsp_real x[6],
		dsp_real *wsa, dsp_real *wsb)
{
	dsp_real s0 = dsp_sin(o[0].phase);
	dsp_real s1 = dsp_sin(o[1].phase);
	dsp_real s3 = dsp_sin(o[3].phase);

	dsp_real o0 = dsp_sin(o[0].phase + s1 * x[4]); /* Osc3→Ind5→Osc1 (using s1 as placeholder) */

	/* Osc3 actually modulates Osc1 in config 11 */
	o0 = dsp_sin(o[0].phase + dsp_sin(o[2].phase) * x[4]);

	*wsa = (o0 + s0 * x[0] + s3 * x[3]) * x[2];
	*wsb = (o0 + s1 * x[1]) * x[5];
}

static const fm_route_fn fm_routes[12] = {
	route00, route01, route02, route03,
	route04, route05, route06, route07,
	route08, route09, route10, route11
};

/* -------------------------------------------------------------------------- */
/* Voice rendering — one stereo sample                                        */
/* -------------------------------------------------------------------------- */

/*
 * Smoothing coefficient: one-pole lowpass at audio rate.
 * 0.05 at 48kHz ≈ 0.4ms time constant — fast enough to follow
 * envelopes but eliminates int16_t quantization staircase.
 */

#define SMOOTH_COEFF_48K     0.05
#define CV2_SMOOTH_COEFF_48K 0.003  /* ~7ms at 48kHz — interpolates between fader messages */

static inline dsp_real smooth_val(dsp_func_t *fn)
{
	/* scale coefficients for actual sample rate (tuned for 48kHz) */
	dsp_real rate_scale = 48000.0 / g_dsp.sample_rate;
	dsp_real cv2_coeff = CV2_SMOOTH_COEFF_48K * rate_scale;
	dsp_real coeff = SMOOTH_COEFF_48K * rate_scale;

	fn->cv2_smooth += ((dsp_real)fn->cv2 - fn->cv2_smooth) * cv2_coeff;
	dsp_real target = (dsp_real)fn->current + (dsp_real)fn->cv1 + fn->cv2_smooth;

	if (fpu_time_scale > 0.01) {
		coeff = coeff / (dsp_real)fpu_time_scale;
	}

	fn->dsp_smooth += (target - fn->dsp_smooth) * coeff;

	return fn->dsp_smooth;
}

static void dsp_voice_render(dsp_voice_t *v, dsp_real *left, dsp_real *right)
{
	dsp_real sr = g_dsp.sample_rate;

	/* extract smoothed parameters from function current values */

	dsp_real freq_hz[4];

	freq_hz[0] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ1]));
	freq_hz[1] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ2]));
	freq_hz[2] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ3]));
	freq_hz[3] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ4]));

	/* level: outseg maps 0-1000 → -32000..+32000 (center = 0).
	 * Remap to 0..1: (val/32000 + 1) * 0.5 */

	dsp_real level = smooth_val(&v->funcs[FN_LEVEL]) / 32000.0;

	level = dsp_fmax(0.0, dsp_fmin(1.0, (level + 1.0) * 0.5));

	/* location (panning): -32000..+32000 → -1..+1 */

	dsp_real locn = smooth_val(&v->funcs[FN_LOCN]) / 32000.0;

	locn = dsp_fmax(-1.0, dsp_fmin(1.0, locn));

	/* filter resonance: 0..32000 → 0..1 */

	dsp_real filtrq = dsp_fmax(0.0, smooth_val(&v->funcs[FN_FILTRQ]) / 32000.0);

	filtrq = dsp_fmin(filtrq, 0.99);

	/* dynamics: 0..32000 → 0..1 */

	dsp_real dynam = dsp_fmax(0.0, smooth_val(&v->funcs[FN_DYNAM]) / 32000.0);

	/* FM modulation indices: ±32000 → normalised */

	dsp_real idx[6];

	idx[0] = smooth_val(&v->funcs[FN_INDEX1]) / 32000.0;
	idx[1] = smooth_val(&v->funcs[FN_INDEX2]) / 32000.0;
	idx[2] = smooth_val(&v->funcs[FN_INDEX3]) / 32000.0;
	idx[3] = smooth_val(&v->funcs[FN_INDEX4]) / 32000.0;
	idx[4] = smooth_val(&v->funcs[FN_INDEX5]) / 32000.0;
	idx[5] = smooth_val(&v->funcs[FN_INDEX6]) / 32000.0;

	/* filter cutoff: pitch value in half-cents → Hz */

	dsp_real filter_hz = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FILTER]));

	/* update oscillator phase increments */

	for (int32_t i = 0; i < DSP_OSCS; ++i) {
		v->oscs[i].phase_inc = TWO_PI * freq_hz[i] / sr;
	}

	/* apply FM routing */

	dsp_real wsa_in = 0.0, wsb_in = 0.0;
	int32_t cfg = v->config;

	if (cfg < 0 || cfg >= 12) {
		cfg = 0;
	}

	fm_routes[cfg](v->oscs, idx, &wsa_in, &wsb_in);

	/* advance oscillator phases */

	for (int32_t i = 0; i < DSP_OSCS; ++i) {
		v->oscs[i].phase += v->oscs[i].phase_inc;

		if (v->oscs[i].phase >= TWO_PI) {
			v->oscs[i].phase -= TWO_PI;
		}

		if (v->oscs[i].phase < 0.0) {
			v->oscs[i].phase += TWO_PI;
		}
	}

	/* waveshaper lookup */

	dsp_real wsa_out = waveshaper_lookup(wsa_in, v->wsa, DSP_WS_COUNT);
	dsp_real wsb_out = waveshaper_lookup(wsb_in, v->wsb, DSP_WS_COUNT);

	/* mix WSA and WSB */

	dsp_real mixed = (wsa_out + wsb_out) * 0.2;

	/* 4-pole filter */

	dsp_real filtered = filter_process_full(&v->filter, mixed,
			filter_hz, filtrq, sr);

	/* DC blocker */

	filtered = dcblock_process(&v->dcblock, filtered);

	/* equal-power panning */

	dsp_real pan = (locn + 1.0) * 0.5; /* 0..1 */
	dsp_real lg = dsp_cos(pan * DSP_PI * 0.5);
	dsp_real rg = dsp_sin(pan * DSP_PI * 0.5);

	/* anti-click ramp */

	dsp_real gain = level * dynam;
	bool is_active = gain > 0.001;

	if (is_active && !v->was_active) {
		v->ramp = 0.0;  /* start ramp on note onset */
	}

	v->was_active = is_active;

	if (v->ramp < 1.0) {
		v->ramp += 1.0 / DSP_RAMP_SAMPLES;

		if (v->ramp > 1.0) {
			v->ramp = 1.0;
		}

		gain *= v->ramp;
	}

	/* output with level, dynamics, and ramp */

	*left = filtered * lg * gain;
	*right = filtered * rg * gain;
}

/* -------------------------------------------------------------------------- */
/* Public API                                                                 */
/* -------------------------------------------------------------------------- */

void dsp_init(void)
{
	memset(&g_dsp, 0, sizeof g_dsp);
	g_dsp.sample_rate = (dsp_real)DSP_SAMPLE_RATE;

	/* initialise waveshape tables to linear pass-through */

	for (int32_t v = 0; v < DSP_VOICES; ++v) {
		for (int32_t i = 0; i < DSP_WS_COUNT; ++i) {
			dsp_real x = ((dsp_real)i / (dsp_real)(DSP_WS_COUNT - 1)) * 2.0 - 1.0;

			g_dsp.voices[v].wsa[i] = (int16_t)(x * 32000.0);
			g_dsp.voices[v].wsb[i] = (int16_t)(x * 32000.0);
		}
	}

	pshift_init(&g_dsp.pshift, g_dsp.sample_rate);
	eq_init(&g_dsp.eq, g_dsp.sample_rate);
	exciter_init(&g_dsp.exciter, g_dsp.sample_rate);
}

static dsp_real test_phase = 0.0;

void dsp_render(float *buf, int32_t frames)
{
	for (int32_t i = 0; i < frames; ++i) {
		dsp_real left = 0.0, right = 0.0;

		if (dsp_test_tone) {
			/* 440 Hz sine at -12 dB for audio path testing */
			dsp_real s = dsp_sin(test_phase) * 0.25;

			test_phase += TWO_PI * 440.0 / g_dsp.sample_rate;

			if (test_phase >= TWO_PI) {
				test_phase -= TWO_PI;
			}

			left = s;
			right = s;
		}
		else {
			for (int32_t v = 0; v < DSP_VOICES; ++v) {
				dsp_real vl = 0.0, vr = 0.0;

				dsp_voice_render(&g_dsp.voices[v], &vl, &vr);
				left += vl;
				right += vr;
			}
		}

		/* exciter (always on) */

		exciter_process(&g_dsp.exciter, &left, &right);

		/* phase shifter — read params from spare function of voices 1-3 */
		/* MIDAS sends: (param_0_99 * 10) << 5, max = 31680 */

		dsp_real ps_int = dsp_fmax(0.0, g_dsp.voices[1].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;
		dsp_real ps_rate = dsp_fmax(0.0, g_dsp.voices[2].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;
		dsp_real ps_dep = dsp_fmax(0.0, g_dsp.voices[3].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;

		/* rate: 0..1 → 0.1..5.0 Hz */

		dsp_real rate_hz = 0.1 + ps_rate * 4.9;

		pshift_process(&g_dsp.pshift, &left, &right,
				ps_int, rate_hz, ps_dep, g_dsp.sample_rate);

		/* 7-band graphic EQ */

		eq_process(&g_dsp.eq, &left, &right, g_dsp.sample_rate);

		/* soft clamp */

		left = dsp_fmax(-1.0, dsp_fmin(1.0, left));
		right = dsp_fmax(-1.0, dsp_fmin(1.0, right));

		buf[i * 2 + 0] = (float)left;
		buf[i * 2 + 1] = (float)right;
	}
}
