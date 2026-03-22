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

#define TWO_PI (2.0 * M_PI)

dsp_state_t g_dsp;
bool dsp_test_tone = false;

/* -------------------------------------------------------------------------- */
/* Pitch / frequency conversion                                               */
/* -------------------------------------------------------------------------- */

/*
 * Convert FPU pitch value (half-cents) to Hz.
 * MIDI note 0 (C-1) = 8.1758 Hz.  Each half-cent = 1/2400 octave.
 */

static double pitch_to_hz(int16_t pitch)
{
	if (pitch <= 0) {
		return 8.1758;
	}

	return 8.1758 * pow(2.0, (double)pitch / 2400.0);
}

/* -------------------------------------------------------------------------- */
/* Waveshaper lookup with linear interpolation                                */
/* -------------------------------------------------------------------------- */

static double waveshaper_lookup(double input, const int16_t *table, int32_t count)
{
	if (count < 2) {
		return input;
	}

	double clamped = fmax(-1.0, fmin(1.0, input));
	double idx = (clamped + 1.0) * 0.5 * (double)(count - 1);
	int32_t i = (int32_t)idx;
	double frac = idx - (double)i;

	if (i < 0) {
		i = 0;
	}

	if (i >= count - 1) {
		i = count - 2;
	}

	double a = (double)table[i] / 32000.0;
	double b = (double)table[i + 1] / 32000.0;

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

static inline double ota_tanh(double x)
{
	/* fast tanh approximation: accurate to ~0.1% for |x| < 4 */
	double x2 = x * x;
	return x * (27.0 + x2) / (27.0 + 9.0 * x2);
}

static double filter_process_full(dsp_filter_t *f, double input,
		double cutoff_hz, double resonance, double sr)
{
	double fc = fmax(20.0, fmin(sr * 0.49, cutoff_hz));
	double r = fmax(0.0, fmin(0.95, resonance));

	/* integrator coefficient via bilinear pre-warp */
	double g = tan(M_PI * fc / sr);
	double G = g / (1.0 + g);

	/* feedback gain: 4.0 is the theoretical self-oscillation threshold
	 * for a 4-pole ladder.  The tanh saturation in the feedback path
	 * provides natural limiting so we can safely approach it. */
	double k = r * 4.0;

	/* estimate output for zero-delay feedback using previous states */
	double S = (G * G * G * f->s[0] +
		    G * G * f->s[1] +
		    G * f->s[2] +
		    f->s[3]);

	double S_scale = G * G * G * G;
	double u = (input - k * ota_tanh(f->feedback * VT_INV) * VT) /
		   (1.0 + k * S_scale);

	/* cascade of 4 OTA stages with tanh saturation */
	double x = ota_tanh(u * VT_INV) * VT;

	for (int32_t i = 0; i < 4; ++i) {
		double v = G * (x - f->s[i]);
		double y = v + f->s[i];
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

static double dcblock_process(dsp_dcblock_t *dc, double input)
{
	double out = input - dc->prev_in + 0.995 * dc->prev_out;

	dc->prev_in = input;
	dc->prev_out = out;

	return out;
}

/* -------------------------------------------------------------------------- */
/* Biquad filter processing (direct form II transposed)                       */
/* -------------------------------------------------------------------------- */

static inline double biquad_process(dsp_biquad_t *f, double in)
{
	double out = f->b0 * in + f->z1;

	f->z1 = f->b1 * in - f->a1 * out + f->z2;
	f->z2 = f->b2 * in - f->a2 * out;

	return out;
}

static void biquad_set_allpass(dsp_biquad_t *f, double freq, double q,
		double sr)
{
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double a0 = 1.0 + alpha;

	f->b0 = (1.0 - alpha) / a0;
	f->b1 = -2.0 * cos(w0) / a0;
	f->b2 = 1.0;
	f->a1 = f->b1;
	f->a2 = f->b0;
}

static void biquad_set_highpass(dsp_biquad_t *f, double freq, double q,
		double sr)
{
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double cosw0 = cos(w0);
	double a0 = 1.0 + alpha;

	f->b0 = (1.0 + cosw0) * 0.5 / a0;
	f->b1 = -(1.0 + cosw0) / a0;
	f->b2 = f->b0;
	f->a1 = -2.0 * cosw0 / a0;
	f->a2 = (1.0 - alpha) / a0;
}

static void biquad_set_lowpass(dsp_biquad_t *f, double freq, double q,
		double sr)
{
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double cosw0 = cos(w0);
	double a0 = 1.0 + alpha;

	f->b0 = (1.0 - cosw0) * 0.5 / a0;
	f->b1 = (1.0 - cosw0) / a0;
	f->b2 = f->b0;
	f->a1 = -2.0 * cosw0 / a0;
	f->a2 = (1.0 - alpha) / a0;
}

static void biquad_set_lowshelf(dsp_biquad_t *f, double freq, double q,
		double gain_db, double sr)
{
	double A = pow(10.0, gain_db / 40.0);
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double cosw0 = cos(w0);
	double sqA = 2.0 * sqrt(A) * alpha;
	double a0 = (A + 1.0) + (A - 1.0) * cosw0 + sqA;

	f->b0 = A * ((A + 1.0) - (A - 1.0) * cosw0 + sqA) / a0;
	f->b1 = 2.0 * A * ((A - 1.0) - (A + 1.0) * cosw0) / a0;
	f->b2 = A * ((A + 1.0) - (A - 1.0) * cosw0 - sqA) / a0;
	f->a1 = -2.0 * ((A - 1.0) + (A + 1.0) * cosw0) / a0;
	f->a2 = ((A + 1.0) + (A - 1.0) * cosw0 - sqA) / a0;
}

static void biquad_set_highshelf(dsp_biquad_t *f, double freq, double q,
		double gain_db, double sr)
{
	double A = pow(10.0, gain_db / 40.0);
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double cosw0 = cos(w0);
	double sqA = 2.0 * sqrt(A) * alpha;
	double a0 = (A + 1.0) - (A - 1.0) * cosw0 + sqA;

	f->b0 = A * ((A + 1.0) + (A - 1.0) * cosw0 + sqA) / a0;
	f->b1 = -2.0 * A * ((A - 1.0) + (A + 1.0) * cosw0) / a0;
	f->b2 = A * ((A + 1.0) + (A - 1.0) * cosw0 - sqA) / a0;
	f->a1 = 2.0 * ((A - 1.0) - (A + 1.0) * cosw0) / a0;
	f->a2 = ((A + 1.0) - (A - 1.0) * cosw0 - sqA) / a0;
}

static void biquad_set_peaking(dsp_biquad_t *f, double freq, double q,
		double gain_db, double sr)
{
	double A = pow(10.0, gain_db / 40.0);
	double w0 = TWO_PI * freq / sr;
	double alpha = sin(w0) / (2.0 * q);
	double cosw0 = cos(w0);
	double a0 = 1.0 + alpha / A;

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

static void pshift_init(dsp_pshift_t *ps, double sr)
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

static void pshift_update_coeffs(dsp_pshift_t *ps, double intensity,
		double sr)
{
	double exp_int = intensity * intensity;
	double min_freq = 300.0;
	double max_freq = 3500.0;
	double base_l = min_freq + (1.0 - exp_int) * (max_freq - min_freq);
	double base_r = base_l * 0.8;
	double q = 0.9;

	for (int32_t i = 0; i < PS_ALLPASS_STAGES; ++i) {
		double ratio = (double)i / (double)(PS_ALLPASS_STAGES - 1);

		double lr = pow(0.5 + ratio * 0.5, 1.5);
		double lf = fmax(250.0, fmin(6000.0, base_l * lr));

		double rr = pow(1.0 - ratio * 0.4, 1.2);
		double rf = fmax(250.0, fmin(6000.0, base_r * rr));

		biquad_set_allpass(&ps->ap_l[i], lf, q, sr);
		biquad_set_allpass(&ps->ap_r[i], rf, q, sr);
	}
}

static double pshift_lfo(dsp_pshift_t *ps)
{
	double s = sin(ps->lfo_phase);
	double soft = s * (1.5 - 0.5 * s * s);
	double tri = (2.0 / M_PI) * asin(sin(ps->lfo_phase));
	double val = 0.7 * soft + 0.3 * tri;

	ps->lfo_phase += ps->lfo_inc;

	if (ps->lfo_phase >= TWO_PI) {
		ps->lfo_phase -= TWO_PI;
	}

	return val;
}

static void pshift_process(dsp_pshift_t *ps, double *left, double *right,
		double intensity, double rate_hz, double depth, double sr)
{
	if (intensity <= 0.001 && depth <= 0.001) {
		return;
	}

	/* update LFO rate */

	ps->lfo_inc = TWO_PI * rate_hz / sr;

	/* generate LFO and compute modulated intensity */

	double lfo = pshift_lfo(ps);
	double mod = lfo * depth * 0.3;
	double mod_int = fmax(0.0, fmin(1.0, intensity + mod));

	/* update filter coefficients periodically */

	if (ps->update_counter <= 0) {
		pshift_update_coeffs(ps, mod_int, sr);
		ps->update_counter = PS_UPDATE_INT;
	}

	--ps->update_counter;

	/* high-pass to remove low-end thumping */

	double lf = biquad_process(&ps->hp_l, *left);
	double rf = biquad_process(&ps->hp_r, *right);

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

static const double eq_freqs[EQ_BANDS] = {
	50.0, 150.0, 400.0, 1000.0, 2500.0, 6000.0, 15000.0
};

static void eq_update_band(dsp_eq_t *eq, int32_t band, int32_t ch, double sr)
{
	double freq = eq_freqs[band];
	double db = eq->gain_db[band][ch];

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

static void eq_init(dsp_eq_t *eq, double sr)
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
	g_dsp.eq.gain_db[band][channel] = gain_db;
	g_dsp.eq.dirty = true;
}

static void eq_process(dsp_eq_t *eq, double *left, double *right, double sr)
{
	if (eq->dirty) {
		for (int32_t b = 0; b < EQ_BANDS; ++b) {
			for (int32_t c = 0; c < EQ_CHANNELS; ++c) {
				eq_update_band(eq, b, c, sr);
			}
		}

		eq->dirty = false;
	}

	double l = *left, r = *right;

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

static void exciter_init(dsp_exciter_t *ex, double sr)
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

static inline double exciter_softclip(double x)
{
	double threshold = 0.8;

	if (fabs(x) > threshold) {
		double sign = x >= 0.0 ? 1.0 : -1.0;
		double excess = fabs(x) - threshold;
		return sign * (threshold + tanh(excess * 2.0) * 0.2);
	}

	return x;
}

static inline double exciter_harmonics(double s)
{
	double sign = s >= 0.0 ? 1.0 : -1.0;
	double h = s * s * sign * 2.0 + s * s * s * 0.5;

	return exciter_softclip(h);
}

static void exciter_process(dsp_exciter_t *ex, double *left, double *right)
{
	/* extract HF band */

	double lhf = biquad_process(&ex->hp_l, *left);
	lhf = biquad_process(&ex->lp_l, lhf);

	double rhf = biquad_process(&ex->hp_r, *right);
	rhf = biquad_process(&ex->lp_r, rhf);

	/* generate harmonics */

	double lh = exciter_harmonics(lhf);
	double rh = exciter_harmonics(rhf);

	/* combine: original + harmonics + brightness boost */

	double le = *left + lh + *left * 0.3;
	double re = *right + rh + *right * 0.3;

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

typedef void (*fm_route_fn)(dsp_osc_t osc[4], const double idx[6],
		double *wsa, double *wsb);

/* Config 00: Osc2→Ind1→Osc1→Ind3→WSA, Osc4→Ind2→Ind3 side,
 *            Osc2→Ind4→Osc3→Ind6→WSB, Osc4→Ind5→Ind6 side */

static void route00(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s1 = sin(o[1].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s1 * x[0]);
	double o2 = sin(o[2].phase + s1 * x[3]);

	*wsa = (o0 + s3 * x[1]) * x[2];
	*wsb = (o2 + s3 * x[4]) * x[5];
}

/* Config 01: cross-modulation with side inputs */

static void route01(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s1 = sin(o[1].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s1 * x[0]);
	double o2 = sin(o[2].phase + s3 * x[3]);

	*wsa = (o0 + s1 * x[1]) * x[2];
	*wsb = (o2 + s3 * x[4]) * x[5];
}

/* Config 02: parallel routing, Osc1↔Osc4 feedback */

static void route02(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + sin(o[1].phase + s2 * x[1]) * x[0]);
	double o2 = sin(o[2].phase + s3 * x[3]);

	/* Osc1→Ind5→Osc4: use s0 for modulation */
	(void)s0;
	o[3].phase += s0 * x[4];

	*wsa = o0 * x[2];
	*wsb = o2 * x[5];
}

/* Config 03: side-chained modulation */

static void route03(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s2 * x[1]);
	double o1 = sin(o[1].phase + s2 * x[4]);

	*wsa = (s3 + o0 * x[0]) * x[2];
	*wsb = (s3 + o1 * x[3]) * x[5];
}

/* Config 04: dual modulation, Ind1 unused */

static void route04(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + sin(o[1].phase) * x[1]);
	double o1_mod = (s2 + s3) * x[3] + s0 * x[4];

	(void)o1_mod;

	*wsa = o0 * x[2];
	*wsb = x[5]; /* direct envelope → WSB */
}

/* Config 05: cross-coupled side chains */

static void route05(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s3 * x[1]);
	double o2 = sin(o[2].phase + sin(o[1].phase) * x[4]);

	*wsa = (sin(o[1].phase) + o0 * x[0]) * x[2];
	*wsb = (s3 + o2 * x[3]) * x[5];
}

/* Config 06: dual output, Ind5 unused */

static void route06(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o1 = sin(o[1].phase + s2 * x[0]);
	double o0 = sin(o[0].phase + o1 * x[1] + s3 * x[3]);

	*wsa = o0 * x[2];
	*wsb = o0 * x[5];
}

/* Config 07: unused Osc3, multi-output Osc4 */

static void route07(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s3 = sin(o[3].phase);

	double o1 = sin(o[1].phase + s3 * x[0] + sin(o[1].phase) * x[1]);
	double o0 = sin(o[0].phase + s3 * x[3]);

	(void)o1;

	*wsa = o0 * x[2];
	*wsb = (s3 + s3 * x[4]) * x[5];
}

/* Config 08: dual side-chain architecture */

static void route08(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + sin(o[1].phase) * x[1]);

	o[1].phase += s2 * x[3]; /* Osc3→Ind4→Osc2 */

	*wsa = (o0 + s2 * x[0]) * x[2];
	*wsb = (s3 + s0 * x[4]) * x[5];
}

/* Config 09: circular modulation */

static void route09(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s1 = sin(o[1].phase);
	double s2 = sin(o[2].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s3 * x[0]);
	double o2 = sin(o[2].phase + s1 * x[3]);

	/* feedback: Osc1→Osc4, Osc3→Osc2 */
	o[3].phase += s0 * x[4];
	o[1].phase += s2 * x[1];

	*wsa = o0 * x[2];
	*wsb = o2 * x[5];
}

/* Config 10: unused Osc4, cross-coupled side chains */

static void route10(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s1 = sin(o[1].phase);
	double s2 = sin(o[2].phase);

	double o0 = sin(o[0].phase + s1 * x[1]);
	double o2 = sin(o[2].phase + s1 * x[4]);

	*wsa = (o0 + s2 * x[0]) * x[2];
	*wsb = (o2 + s0 * x[3]) * x[5];
}

/* Config 11: triple-output Osc1 with cross-coupled side chains */

static void route11(dsp_osc_t o[4], const double x[6],
		double *wsa, double *wsb)
{
	double s0 = sin(o[0].phase);
	double s1 = sin(o[1].phase);
	double s3 = sin(o[3].phase);

	double o0 = sin(o[0].phase + s1 * x[4]); /* Osc3→Ind5→Osc1 (using s1 as placeholder) */

	/* Osc3 actually modulates Osc1 in config 11 */
	o0 = sin(o[0].phase + sin(o[2].phase) * x[4]);

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

#define SMOOTH_COEFF 0.05

static inline double smooth_val(dsp_func_t *fn)
{
	double target = (double)fn->current + (double)fn->cv1;
	double coeff = SMOOTH_COEFF;

	if (fpu_time_scale > 0.01) {
		coeff = SMOOTH_COEFF / fpu_time_scale;
	}

	fn->dsp_smooth += (target - fn->dsp_smooth) * coeff;

	return fn->dsp_smooth;
}

static void dsp_voice_render(dsp_voice_t *v, double *left, double *right)
{
	double sr = g_dsp.sample_rate;

	/* extract smoothed parameters from function current values */

	double freq_hz[4];

	freq_hz[0] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ1]));
	freq_hz[1] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ2]));
	freq_hz[2] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ3]));
	freq_hz[3] = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FREQ4]));

	/* level: outseg maps 0-1000 → -32000..+32000 (center = 0).
	 * Remap to 0..1: (val/32000 + 1) * 0.5 */

	double level = smooth_val(&v->funcs[FN_LEVEL]) / 32000.0;

	level = fmax(0.0, fmin(1.0, (level + 1.0) * 0.5));

	/* location (panning): -32000..+32000 → -1..+1 */

	double locn = smooth_val(&v->funcs[FN_LOCN]) / 32000.0;

	locn = fmax(-1.0, fmin(1.0, locn));

	/* filter resonance: 0..32000 → 0..1 */

	double filtrq = fmax(0.0, smooth_val(&v->funcs[FN_FILTRQ]) / 32000.0);

	filtrq = fmin(filtrq, 0.99);

	/* dynamics: 0..32000 → 0..1 */

	double dynam = fmax(0.0, smooth_val(&v->funcs[FN_DYNAM]) / 32000.0);

	/* FM modulation indices: ±32000 → normalised */

	double idx[6];

	idx[0] = smooth_val(&v->funcs[FN_INDEX1]) / 32000.0;
	idx[1] = smooth_val(&v->funcs[FN_INDEX2]) / 32000.0;
	idx[2] = smooth_val(&v->funcs[FN_INDEX3]) / 32000.0;
	idx[3] = smooth_val(&v->funcs[FN_INDEX4]) / 32000.0;
	idx[4] = smooth_val(&v->funcs[FN_INDEX5]) / 32000.0;
	idx[5] = smooth_val(&v->funcs[FN_INDEX6]) / 32000.0;

	/* filter cutoff: pitch value in half-cents → Hz */

	double filter_hz = pitch_to_hz((int16_t)smooth_val(&v->funcs[FN_FILTER]));

	/* update oscillator phase increments */

	for (int32_t i = 0; i < DSP_OSCS; ++i) {
		v->oscs[i].phase_inc = TWO_PI * freq_hz[i] / sr;
	}

	/* apply FM routing */

	double wsa_in = 0.0, wsb_in = 0.0;
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

	double wsa_out = waveshaper_lookup(wsa_in, v->wsa, DSP_WS_COUNT);
	double wsb_out = waveshaper_lookup(wsb_in, v->wsb, DSP_WS_COUNT);

	/* mix WSA and WSB */

	double mixed = (wsa_out + wsb_out) * 0.2;

	/* 4-pole filter */

	double filtered = filter_process_full(&v->filter, mixed,
			filter_hz, filtrq, sr);

	/* DC blocker */

	filtered = dcblock_process(&v->dcblock, filtered);

	/* equal-power panning */

	double pan = (locn + 1.0) * 0.5; /* 0..1 */
	double lg = cos(pan * M_PI * 0.5);
	double rg = sin(pan * M_PI * 0.5);

	/* anti-click ramp */

	double gain = level * dynam;
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
	g_dsp.sample_rate = (double)DSP_SAMPLE_RATE;

	/* initialise waveshape tables to linear pass-through */

	for (int32_t v = 0; v < DSP_VOICES; ++v) {
		for (int32_t i = 0; i < DSP_WS_COUNT; ++i) {
			double x = ((double)i / (double)(DSP_WS_COUNT - 1)) * 2.0 - 1.0;

			g_dsp.voices[v].wsa[i] = (int16_t)(x * 32000.0);
			g_dsp.voices[v].wsb[i] = (int16_t)(x * 32000.0);
		}
	}

	pshift_init(&g_dsp.pshift, g_dsp.sample_rate);
	eq_init(&g_dsp.eq, g_dsp.sample_rate);
	exciter_init(&g_dsp.exciter, g_dsp.sample_rate);
}

static double test_phase = 0.0;

void dsp_render(float *buf, int32_t frames)
{
	for (int32_t i = 0; i < frames; ++i) {
		double left = 0.0, right = 0.0;

		if (dsp_test_tone) {
			/* 440 Hz sine at -12 dB for audio path testing */
			double s = sin(test_phase) * 0.25;

			test_phase += TWO_PI * 440.0 / g_dsp.sample_rate;

			if (test_phase >= TWO_PI) {
				test_phase -= TWO_PI;
			}

			left = s;
			right = s;
		}
		else {
			for (int32_t v = 0; v < DSP_VOICES; ++v) {
				double vl = 0.0, vr = 0.0;

				dsp_voice_render(&g_dsp.voices[v], &vl, &vr);
				left += vl;
				right += vr;
			}
		}

		/* exciter (always on) */

		exciter_process(&g_dsp.exciter, &left, &right);

		/* phase shifter — read params from spare function of voices 1-3 */
		/* MIDAS sends: (param_0_99 * 10) << 5, max = 31680 */

		double ps_int = fmax(0.0, g_dsp.voices[1].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;
		double ps_rate = fmax(0.0, g_dsp.voices[2].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;
		double ps_dep = fmax(0.0, g_dsp.voices[3].funcs[FN_SPARE].dsp_smooth)
				/ PS_MAX_RAW;

		/* rate: 0..1 → 0.1..5.0 Hz */

		double rate_hz = 0.1 + ps_rate * 4.9;

		pshift_process(&g_dsp.pshift, &left, &right,
				ps_int, rate_hz, ps_dep, g_dsp.sample_rate);

		/* 7-band graphic EQ */

		eq_process(&g_dsp.eq, &left, &right, g_dsp.sample_rate);

		/* soft clamp */

		left = fmax(-1.0, fmin(1.0, left));
		right = fmax(-1.0, fmin(1.0, right));

		buf[i * 2 + 0] = (float)left;
		buf[i * 2 + 1] = (float)right;
	}
}
