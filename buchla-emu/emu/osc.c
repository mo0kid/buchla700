/*
 *  Copyright (C) 2017-2025 The Contributors
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

#define ver(...) _ver(osc_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(osc_verbose, 1, __VA_ARGS__)

/* -------------------------------------------------------------------------- */
/* Emulator-side newsv: update MIDAS source values through the patch system.  */
/*                                                                            */
/* Reads the valents[] linked list from MIDAS RAM and writes modulation       */
/* values directly to FPU CV1 registers, replicating what MIDAS's newsv()     */
/* does for analog source changes.                                            */
/*                                                                            */
/* valents[] base found at runtime: 0x69700 (192 entries × 10 bytes).         */
/* struct valent { sment *nxt(4), *prv(4), int16 val(2) } = 10 bytes.        */
/* struct sment  { sment *nxt(4), *prv(4), int16 vp(2), int16 sm(2) }        */
/* Index: gs = (grp << 4) | src.  Linked sment nodes have vp = voice/param.  */
/* FPU write: byte offset 0x4000 + vp*32 + 8 (FR_CV1).                       */
/* -------------------------------------------------------------------------- */

#define VALENTS_BASE 0x69700
#define VALENT_SIZE  10

static uint32_t ram_read32(uint32_t addr)
{
	return ((uint32_t)cpu_peek((int32_t)addr) << 24) |
		((uint32_t)cpu_peek((int32_t)(addr + 1)) << 16) |
		((uint32_t)cpu_peek((int32_t)(addr + 2)) << 8) |
		((uint32_t)cpu_peek((int32_t)(addr + 3)));
}

static int16_t ram_read16(uint32_t addr)
{
	return (int16_t)(((uint16_t)cpu_peek((int32_t)addr) << 8) |
			cpu_peek((int32_t)(addr + 1)));
}

static void emu_newsv(int32_t grp, int32_t src, int16_t ival)
{
	int32_t gs = (grp << 4) | src;
	uint32_t entry = VALENTS_BASE + (uint32_t)(gs * VALENT_SIZE);

	/* update valents[gs].val */

	cpu_poke((int32_t)(entry + 8), (uint8_t)((uint16_t)ival >> 8));
	cpu_poke((int32_t)(entry + 9), (uint8_t)((uint16_t)ival & 0xFF));

	/* traverse linked list: valent→sment→sment→...→valent */

	uint32_t smf = entry;
	uint32_t smp = smf;

	int32_t count = 0;

	for (int32_t safety = 0; safety < 64; ++safety) {
		smp = ram_read32(smp);  /* follow nxt pointer */

		if (smp == smf || smp == 0) {
			break;
		}

		int16_t vp = ram_read16(smp + 8);  /* sment.vp */
		int16_t val;

		switch (vp & 0x000F) {
		case 1: case 3: case 5: case 7:  /* freq */
			val = ival >> 3;
			break;

		case 10:  /* filter */
			{
				int32_t ltmp = ((int32_t)ival >> 1) +
						((int32_t)ival >> 2);
				if (ltmp > 32767) ltmp = 32767;
				if (ltmp < -32768) ltmp = -32768;
				val = (int16_t)ltmp;
			}
			break;

		default:
			val = ival;
		}

		/* write to FPU CV1 register */

		uint32_t fpu_off = 0x4000 + ((uint32_t)vp << 5) + 0x08;

		fpu_write(fpu_off, 2, (uint32_t)(uint16_t)val);
		++count;
	}
}
#define ver3(...) _ver(osc_verbose, 2, __VA_ARGS__)

int32_t osc_verbose = 0;

#define OSC_RECV_PORT 9001
#define OSC_SEND_PORT 9002
#define OSC_PKT_SZ    1024

static UDPsocket recv_sock = NULL;
static UDPsocket send_sock = NULL;
static UDPpacket *recv_pkt = NULL;
static IPaddress target_addr;
static bool connected = false;

/* LCD change detection (defined here, used by handle_connect and osc_poll_lcd) */
static char prev_row1[96];
static char prev_row7[96];
static float prev_bars[14];
static bool bar_centered[14];
static int32_t fader_index_offset = 0;
static float fader_hold[14] = {
	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
};
static void osc_poll_lcd(void);
static void osc_dump_all_rows(void);
static void fader_write_fpu(int32_t fader_idx, float value);

static bool xy_active = false;

/* -------------------------------------------------------------------------- */
/* Exponential smoothing for continuous controllers (XY, pressure)             */
/* -------------------------------------------------------------------------- */

#define SMOOTH_COEFF 0.15f   /* lower = smoother, 0.1-0.2 is good for touch */

typedef struct {
	float current;
	bool  active;
} smoother_t;

static smoother_t sm_ht  = { 0.0f, false };
static smoother_t sm_vt  = { 0.0f, false };
static smoother_t sm_prs = { 0.0f, false };

static float smooth_update(smoother_t *s, float target)
{
	if (!s->active) {
		s->current = target;
		s->active = true;
	}
	else {
		s->current += SMOOTH_COEFF * (target - s->current);
	}

	return s->current;
}

static void smooth_reset(smoother_t *s)
{
	s->current = 0.0f;
	s->active = false;
}

/*
 * osc_smooth_tick: called from osc_loop at ~500 Hz to push smoothed
 * values into the FPU.  This decouples the OSC message rate from the
 * control rate sent to the DSP.
 */

static float sm_ht_target  = 0.0f;
static float sm_vt_target  = 0.0f;
static float sm_prs_target = 0.0f;
static bool  sm_xy_dirty   = false;
static bool  sm_prs_dirty  = false;

static void osc_smooth_tick(void)
{
	if (sm_xy_dirty || sm_ht.active) {
		float hv = smooth_update(&sm_ht, sm_ht_target);
		float vv = smooth_update(&sm_vt, sm_vt_target);

		int16_t htval = (int16_t)(hv * 64000.0f);
		int16_t vtval = (int16_t)(vv * 32000.0f);

		for (int32_t g = 0; g < 12; ++g) {
			emu_newsv(g, 10, htval);
			emu_newsv(g, 11, vtval);
		}

		sm_xy_dirty = false;
	}

	if (sm_prs_dirty || sm_prs.active) {
		float pv = smooth_update(&sm_prs, sm_prs_target);

		int16_t scaled = (int16_t)(pv * 32000.0f);

		for (int32_t g = 0; g < 12; ++g) {
			emu_newsv(g, 5, scaled);
		}

		sm_prs_dirty = false;
	}

	/* re-apply fader holds so new notes don't revert to envelope values */

	if (fader_index_offset == 0) {
		for (int32_t i = 0; i < 14; ++i) {
			if (fader_hold[i] >= 0.0f) {
				fader_write_fpu(i, fader_hold[i]);
			}
		}
	}
}

/* -------------------------------------------------------------------------- */
/* Minimal OSC parser                                                         */
/* -------------------------------------------------------------------------- */

static int32_t osc_pad(int32_t len)
{
	return (len + 3) & ~3;
}

static int32_t osc_read_str(const uint8_t *data, int32_t len, int32_t pos,
		char *out, int32_t out_sz)
{
	if (pos >= len) {
		return -1;
	}

	int32_t i = 0;

	while (pos + i < len && data[pos + i] != 0 && i < out_sz - 1) {
		out[i] = (char)data[pos + i];
		++i;
	}

	out[i] = 0;
	return osc_pad(i + 1);
}

static int32_t osc_read_int32(const uint8_t *data, int32_t len, int32_t pos,
		int32_t *out)
{
	if (pos + 4 > len) {
		return -1;
	}

	*out = (int32_t)(
		((uint32_t)data[pos + 0] << 24) |
		((uint32_t)data[pos + 1] << 16) |
		((uint32_t)data[pos + 2] <<  8) |
		((uint32_t)data[pos + 3] <<  0));

	return 4;
}

static int32_t osc_read_float(const uint8_t *data, int32_t len, int32_t pos,
		float *out)
{
	if (pos + 4 > len) {
		return -1;
	}

	uint32_t bits =
		((uint32_t)data[pos + 0] << 24) |
		((uint32_t)data[pos + 1] << 16) |
		((uint32_t)data[pos + 2] <<  8) |
		((uint32_t)data[pos + 3] <<  0);

	memcpy(out, &bits, sizeof(float));
	return 4;
}

/* -------------------------------------------------------------------------- */
/* Signal mapping                                                             */
/* -------------------------------------------------------------------------- */

/*
 * Touch keys:  signals 1-24 (kbd.c vid_key: key_touch(1 + i, vel))
 * Sliders:     signals 25-38 (kbd.c lcd_key: slid(25 + i, on, val))
 * LCD buttons: signals 39-52 (kbd.c lcd_key: but_on(39 + i))
 * Data entry:  signals 60-69 (kbd.c vid_key: 0-9)
 * Special:     signals 70-72 (X, E, M)
 */

static int32_t midi_note_to_sig(int32_t note)
{
	/* tauControl sends notes 0-13 for keys 1-14, 114-123 for keys 15-24 */

	if (note >= 0 && note <= 13) {
		return note + 1;
	}

	if (note >= 114 && note <= 123) {
		return note - 114 + 15;
	}

	return -1;
}

/* -------------------------------------------------------------------------- */
/* OSC message handlers                                                       */
/* -------------------------------------------------------------------------- */

static void handle_key_on(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 3 || tags[0] != 'i' || tags[1] != 'f' ||
			tags[2] != 'f') {
		return;
	}

	int32_t note;
	float vel, ypos;
	int32_t n;

	n = osc_read_int32(data, len, pos, &note);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &vel);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &ypos);
	if (n < 0) return;

	int32_t sig = midi_note_to_sig(note);

	if (sig < 0) {
		return;
	}

	int32_t val = (int32_t)(vel * 127.0f);

	if (val < 1) val = 1;
	if (val > 127) val = 127;

	ver("osc key on sig=%d vel=%d", sig, val);
	kbd_osc_key_touch(sig, val);
}

static void handle_key_off(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 1 || tags[0] != 'i') {
		return;
	}

	int32_t note;

	if (osc_read_int32(data, len, pos, &note) < 0) {
		return;
	}

	int32_t sig = midi_note_to_sig(note);

	if (sig < 0) {
		return;
	}

	ver("osc key off sig=%d", sig);
	kbd_osc_key_off(sig);
}

static void handle_aftertouch(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 3 || tags[0] != 'i' || tags[1] != 'f' ||
			tags[2] != 'f') {
		return;
	}

	int32_t note;
	float vel, ypos;
	int32_t n;

	n = osc_read_int32(data, len, pos, &note);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &vel);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &ypos);
	if (n < 0) return;
	(void)vel;

	int32_t sig = midi_note_to_sig(note);

	if (sig < 0) {
		return;
	}

	/* set smoothed pressure target — osc_smooth_tick pushes to FPU */

	sm_prs_target = ypos;
	sm_prs_dirty = true;

	int32_t pres = (int32_t)(ypos * 127.0f);

	if (pres < 0) pres = 0;
	if (pres > 127) pres = 127;

	kbd_osc_key_touch(sig, pres);
	cpu_analog(sig, pres);
}

static void handle_button(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 2 || tags[0] != 'i' || tags[1] != 'f') {
		return;
	}

	int32_t idx;
	float state;
	int32_t n;

	n = osc_read_int32(data, len, pos, &idx);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &state);
	if (n < 0) return;

	/* companion sends buttonIndex + 100, so idx arrives as 100-113 */

	if (idx >= 100) {
		idx -= 100;
	}

	/* button index 0-13 maps to LCD button signals 39-52 */

	int32_t sig = 39 + idx;

	if (sig < 39 || sig > 52) {
		return;
	}

	inf("osc button idx=%d sig=%d %s", idx, sig, state > 0.5f ? "on" : "off");

	if (state > 0.5f) {
		kbd_osc_but_on(sig);
	}
	else {
		kbd_osc_but_off(sig);
		osc_dump_all_rows();
	}
}

/*
 * Fader index → FPU function mapping.
 * Offset faders (Locn, Frq1-4, Filtr): 0.5 = center, range ±32000
 * Gain faders (Level, Reson, Ind1-6): 0.0 = zero, range 0..32000
 */

static const int32_t fader_to_func[14] = {
	FN_LOCN,   FN_LEVEL,  FN_INDEX1, FN_INDEX2, FN_INDEX3,
	FN_FREQ1,  FN_FREQ2,  FN_FREQ3,  FN_FREQ4,
	FN_INDEX4, FN_INDEX5, FN_INDEX6, FN_FILTER, FN_FILTRQ
};

/* true = offset fader (center at 0.5), false = gain fader (zero at 0.0) */

static const bool fader_is_offset[14] = {
	true,  false, false, false, false,
	true,  true,  true,  true,
	false, false, false, true,  false
};

static void fader_write_fpu(int32_t fader_idx, float value)
{
	int32_t func = fader_to_func[fader_idx];
	int16_t ival;

	if (fader_is_offset[fader_idx]) {
		/* offset: 0.5 = 0, range ±32000 */
		ival = (int16_t)((value - 0.5f) * 64000.0f);
	}
	else {
		/* gain: 0.0 = 0, range 0..32000 */
		ival = (int16_t)(value * 32000.0f);
	}

	/* write to all 12 voices via FPU_FSEND (immediate, no interpolation) */

	for (int32_t v = 0; v < DSP_VOICES; ++v) {
		uint32_t base = 0x4000 + (uint32_t)(v * 512 + func * 32);

		fpu_write(base + FR_MNT,   2, 0);  /* force immediate (no interpolation) */
		fpu_write(base + FR_EXP,   2, 0);
		fpu_write(base + FR_VAL10, 2, (uint32_t)(uint16_t)ival);
		fpu_write(base + FR_CTL,   2, FPU_FSEND);
	}
}

static void handle_fader(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 2 || tags[0] != 'i' || tags[1] != 'f') {
		return;
	}

	int32_t idx;
	float value;
	int32_t n;

	n = osc_read_int32(data, len, pos, &idx);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &value);
	if (n < 0) return;

	int32_t base = idx;

	if (base < 0 || base > 13) {
		return;
	}

	/* write directly to FPU only on PRMTR page (offset 0) */

	if (fader_index_offset == 0) {
		fader_write_fpu(base, value);
		fader_hold[base] = value;
	}

	/* throttle kbd scanner updates to avoid buffer clog —
	 * only send when the 7-bit value actually changes */

	static int32_t prev_kbd_val[14] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	};

	int32_t sig = 25 + base;
	int32_t val = (int32_t)(value * 127.0f);

	if (val < 0) val = 0;
	if (val > 127) val = 127;

	if (val != prev_kbd_val[base]) {
		prev_kbd_val[base] = val;
		kbd_osc_slid(sig, true, val);
	}
}

static void handle_xy(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 2 || tags[0] != 'f' || tags[1] != 'f') {
		return;
	}

	float x, y;
	int32_t n;

	n = osc_read_float(data, len, pos, &x);
	if (n < 0) return;
	pos += n;

	n = osc_read_float(data, len, pos, &y);
	if (n < 0) return;

	/* set smoothed XY targets — osc_smooth_tick pushes to FPU */

	sm_ht_target = x - 0.5f;  /* center at 0 */
	sm_vt_target = y;
	sm_xy_dirty = true;

	xy_active = true;
}

/* called when XY pad touch ends (disconnect message or future release msg) */

void osc_xy_release(void)
{
	if (xy_active) {
		xy_active = false;

		sm_ht_target = 0.0f;
		sm_vt_target = 0.0f;
		sm_xy_dirty = true;
		smooth_reset(&sm_ht);
		smooth_reset(&sm_vt);

		for (int32_t g = 0; g < 12; ++g) {
			emu_newsv(g, 10, 0);
			emu_newsv(g, 11, 0);
		}
	}
}

static void handle_tempo(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 1 || tags[0] != 'f') {
		return;
	}

	float value;

	if (osc_read_float(data, len, pos, &value) < 0) {
		return;
	}

	/* signal 73 = tempo multiplier
	 * knob sends 0.5..1.5, map to 0..127
	 * 0.5=0, 1.0=63, 1.5=127 */

	int32_t val = (int32_t)((value - 0.5f) * 127.0f);

	if (val < 0) val = 0;
	if (val > 127) val = 127;

	inf("osc tempo val=%d (%.1f)", val, (double)value);
	cpu_analog(73, val);
}

static void handle_timescale(const uint8_t *data, int32_t len, int32_t pos,
		const char *tags)
{
	if (strlen(tags) < 1 || tags[0] != 'f') {
		return;
	}

	float value;

	if (osc_read_float(data, len, pos, &value) < 0) {
		return;
	}

	/* The firmware reads analog input 74 to scale envelope mnt/exp.
	 * Its internal mapping is: speed = 0.5 + analog/100.
	 * We want duration = value × nominal, so speed = 1/value.
	 * Solving: analog = (1/value - 0.5) × 100. */

	fpu_time_scale = (double)value;

	float clamped = fmaxf(value, 0.5f);
	int32_t analog = (int32_t)((1.0f / clamped - 0.5f) * 100.0f);

	if (analog < 0) analog = 0;
	if (analog > 127) analog = 127;

	inf("osc timescale %.1f analog=%d", (double)value, analog);
	cpu_analog(74, analog);
}

static void handle_connect(const UDPpacket *pkt)
{
	target_addr = pkt->address;

	/* override the send port to the standard receive port */
	SDLNet_Write16(OSC_SEND_PORT, &target_addr.port);

	connected = true;

	uint32_t ip = SDLNet_Read32(&pkt->address.host);
	inf("osc: companion connected from %u.%u.%u.%u",
		(ip >> 24) & 0xff, (ip >> 16) & 0xff,
		(ip >> 8) & 0xff, ip & 0xff);

	/* force-send current LCD content so the companion syncs immediately */
	prev_row1[0] = 0;
	prev_row7[0] = 0;
	osc_poll_lcd();
}

static void handle_disconnect(void)
{
	connected = false;
	xy_active = false;
	inf("osc: companion disconnected");
}

/* -------------------------------------------------------------------------- */
/* OSC message dispatch                                                       */
/* -------------------------------------------------------------------------- */

static void parse_message(const uint8_t *data, int32_t len,
		const UDPpacket *pkt)
{
	char addr[256];
	char tags[64];
	int32_t pos = 0;
	int32_t n;

	/* read address pattern */

	n = osc_read_str(data, len, pos, addr, (int32_t)sizeof addr);

	if (n < 0) {
		return;
	}

	pos += n;

	/* read type tag string */

	n = osc_read_str(data, len, pos, tags, (int32_t)sizeof tags);

	if (n < 0) {
		return;
	}

	pos += n;

	/* skip the leading comma in type tags */

	const char *tp = tags;

	if (*tp == ',') {
		++tp;
	}

	ver2("osc msg: %s [%s]", addr, tp);

	/* learn reply address from any /taucontrol/ message */

	if (strncmp(addr, "/taucontrol/", 12) == 0 &&
			strcmp(addr, "/taucontrol/disconnect") != 0) {
		if (!connected) {
			handle_connect(pkt);
		}
	}

	/* dispatch based on address */

	if (strcmp(addr, "/taucontrol/key/on") == 0) {
		handle_key_on(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/key/off") == 0) {
		handle_key_off(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/key/aftertouch") == 0) {
		handle_aftertouch(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/button") == 0) {
		handle_button(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/fader") == 0) {
		handle_fader(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/xy") == 0) {
		handle_xy(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/connect") == 0) {
		handle_connect(pkt);
	}
	else if (strcmp(addr, "/taucontrol/disconnect") == 0) {
		handle_disconnect();
	}
	else if (strcmp(addr, "/taucontrol/tempo") == 0) {
		handle_tempo(data, len, pos, tp);
	}
	else if (strcmp(addr, "/taucontrol/timescale") == 0) {
		handle_timescale(data, len, pos, tp);
	}
	else {
		ver("osc unknown: %s", addr);
	}
}

/* -------------------------------------------------------------------------- */
/* OSC send helpers                                                           */
/* -------------------------------------------------------------------------- */

static void osc_write_str(uint8_t *buf, int32_t *pos, const char *str)
{
	int32_t len = (int32_t)strlen(str);
	memcpy(buf + *pos, str, (size_t)len);
	*pos += len;

	/* null-terminate and pad to 4-byte boundary */
	int32_t pad = osc_pad(len + 1) - len;

	for (int32_t i = 0; i < pad; ++i) {
		buf[*pos] = 0;
		++*pos;
	}
}

static void osc_write_int32(uint8_t *buf, int32_t *pos, int32_t val)
{
	buf[*pos + 0] = (uint8_t)((uint32_t)val >> 24);
	buf[*pos + 1] = (uint8_t)((uint32_t)val >> 16);
	buf[*pos + 2] = (uint8_t)((uint32_t)val >>  8);
	buf[*pos + 3] = (uint8_t)((uint32_t)val >>  0);
	*pos += 4;
}

static void osc_write_float(uint8_t *buf, int32_t *pos, float val)
{
	uint32_t bits;
	memcpy(&bits, &val, sizeof(float));

	buf[*pos + 0] = (uint8_t)(bits >> 24);
	buf[*pos + 1] = (uint8_t)(bits >> 16);
	buf[*pos + 2] = (uint8_t)(bits >>  8);
	buf[*pos + 3] = (uint8_t)(bits >>  0);
	*pos += 4;
}

void osc_send_status(const char *status)
{
	if (!connected || send_sock == NULL) {
		return;
	}

	UDPpacket *pkt = SDLNet_AllocPacket(OSC_PKT_SZ);

	if (pkt == NULL) {
		return;
	}

	int32_t pos = 0;
	osc_write_str(pkt->data, &pos, "/taunus/status");
	osc_write_str(pkt->data, &pos, ",s");

	int32_t slen = (int32_t)strlen(status);
	memcpy(pkt->data + pos, status, (size_t)slen);
	pos += slen;

	int32_t pad = osc_pad(slen + 1) - slen;
	for (int32_t i = 0; i < pad; ++i) {
		pkt->data[pos++] = 0;
	}

	pkt->len = pos;
	pkt->address = target_addr;

	SDLNet_UDP_Send(send_sock, -1, pkt);
	SDLNet_FreePacket(pkt);
}

void osc_send_fader(int32_t index, float value)
{
	if (!connected || send_sock == NULL) {
		return;
	}

	UDPpacket *pkt = SDLNet_AllocPacket(OSC_PKT_SZ);

	if (pkt == NULL) {
		return;
	}

	int32_t pos = 0;
	osc_write_str(pkt->data, &pos, "/taucontrol/fader");
	osc_write_str(pkt->data, &pos, ",if");
	osc_write_int32(pkt->data, &pos, index);
	osc_write_float(pkt->data, &pos, value);

	pkt->len = pos;
	pkt->address = target_addr;

	SDLNet_UDP_Send(send_sock, -1, pkt);
	SDLNet_FreePacket(pkt);
}

void osc_send_centered(void)
{
	if (!connected || send_sock == NULL) {
		return;
	}

	int32_t mask = 0;

	for (int32_t i = 0; i < 14; ++i) {
		if (bar_centered[i]) {
			mask |= (1 << i);
		}
	}

	UDPpacket *pkt = SDLNet_AllocPacket(OSC_PKT_SZ);

	if (pkt == NULL) {
		return;
	}

	int32_t pos = 0;
	osc_write_str(pkt->data, &pos, "/taunus/fader/centered");
	osc_write_str(pkt->data, &pos, ",i");
	osc_write_int32(pkt->data, &pos, mask);

	pkt->len = pos;
	pkt->address = target_addr;

	SDLNet_UDP_Send(send_sock, -1, pkt);
	SDLNet_FreePacket(pkt);
}

/* -------------------------------------------------------------------------- */
/* LCD text forwarding                                                        */
/* -------------------------------------------------------------------------- */

static void osc_send_lcd_row(int32_t row, const char *text)
{
	if (!connected || send_sock == NULL) {
		return;
	}

	UDPpacket *pkt = SDLNet_AllocPacket(OSC_PKT_SZ);

	if (pkt == NULL) {
		return;
	}

	int32_t pos = 0;
	osc_write_str(pkt->data, &pos, "/taunus/lcd/row");
	osc_write_str(pkt->data, &pos, ",is");
	osc_write_int32(pkt->data, &pos, row);

	/* write string argument */
	int32_t slen = (int32_t)strlen(text);
	memcpy(pkt->data + pos, text, (size_t)slen);
	pos += slen;

	int32_t spad = osc_pad(slen + 1) - slen;
	for (int32_t i = 0; i < spad; ++i) {
		pkt->data[pos++] = 0;
	}

	pkt->len = pos;
	pkt->address = target_addr;

	SDLNet_UDP_Send(send_sock, -1, pkt);
	SDLNet_FreePacket(pkt);
}

static void osc_dump_all_rows(void)
{
	char row[96];

	for (int32_t r = 0; r < 8; ++r) {
		lcd_get_row(r, row, (int32_t)sizeof row);

		/* trim trailing spaces for readability */
		int32_t end = (int32_t)strlen(row);
		while (end > 0 && row[end - 1] == ' ') --end;
		row[end] = 0;

		if (end > 0) {
			inf("osc lcd row%d: [%s]", r, row);
		}
	}
}

static void osc_poll_lcd(void)
{
	char row[96];
	bool text_changed = false;

	/* row 0: button labels */
	lcd_get_row(0, row, (int32_t)sizeof row);

	if (strcmp(row, prev_row1) != 0) {
		inf("osc lcd row0: [%.40s...]", row);
		osc_send_lcd_row(0, row);
		memcpy(prev_row1, row, sizeof prev_row1);

		/* detect page from button labels (buttons show where you CAN go):
		 *   "Prmtr" button visible → we're on EQ page
		 *   " EQ " button visible  → we're on OTHER page
		 *   otherwise              → PRMTR / VOICE / etc */
		if (strstr(row, "Prmtr") != NULL) {
			/* EQ page */
			for (int32_t i = 0; i < 14; ++i)
				bar_centered[i] = true;
			fader_index_offset = 300;
		} else if (strstr(row, " EQ ") != NULL) {
			/* OTHER page */
			for (int32_t i = 0; i < 14; ++i)
				bar_centered[i] = false;
			fader_index_offset = 200;
		} else {
			/* PRMTR / VOICE */
			for (int32_t i = 0; i < 14; ++i)
				bar_centered[i] = fader_is_offset[i];
			fader_index_offset = 0;
		}

		osc_send_centered();

		for (int32_t i = 0; i < 14; ++i) {
			prev_bars[i] = -1.0f;
			fader_hold[i] = -1.0f;
		}
		text_changed = true;
	}

	/* row 7: fader/pot labels */
	lcd_get_row(7, row, (int32_t)sizeof row);

	if (strcmp(row, prev_row7) != 0) {
		inf("osc lcd row7: [%.40s...]", row);
		osc_send_lcd_row(7, row);
		memcpy(prev_row7, row, sizeof prev_row7);
		text_changed = true;
	}

	if (text_changed)
		return; /* let firmware redraw bars before reading */

	/* bar graphs: fader positions from graphics memory */
	float bars[14];
	lcd_get_bars(bars, 14, bar_centered);

	for (int32_t i = 0; i < 14; ++i) {
		float diff = bars[i] - prev_bars[i];

		if (diff > 0.01f || diff < -0.01f) {
			osc_send_fader(i, bars[i]);
			prev_bars[i] = bars[i];
		}
	}
}

/* -------------------------------------------------------------------------- */
/* Public interface                                                           */
/* -------------------------------------------------------------------------- */

void osc_init(void)
{
	ver("osc init");

	recv_sock = SDLNet_UDP_Open(OSC_RECV_PORT);

	if (recv_sock == NULL) {
		err("osc: could not open UDP port %d: %s", OSC_RECV_PORT,
				SDLNet_GetError());
		return;
	}

	send_sock = SDLNet_UDP_Open(0);

	if (send_sock == NULL) {
		err("osc: could not open UDP send socket: %s", SDLNet_GetError());
	}

	recv_pkt = SDLNet_AllocPacket(OSC_PKT_SZ);

	if (recv_pkt == NULL) {
		err("osc: could not allocate packet: %s", SDLNet_GetError());
		SDLNet_UDP_Close(recv_sock);
		recv_sock = NULL;
		return;
	}

	inf("osc: listening on UDP port %d", OSC_RECV_PORT);
}

void osc_quit(void)
{
	ver("osc quit");

	if (connected) {
		osc_send_status("disconnected");
	}

	if (recv_pkt != NULL) {
		SDLNet_FreePacket(recv_pkt);
		recv_pkt = NULL;
	}

	if (recv_sock != NULL) {
		SDLNet_UDP_Close(recv_sock);
		recv_sock = NULL;
	}

	if (send_sock != NULL) {
		SDLNet_UDP_Close(send_sock);
		send_sock = NULL;
	}
}

void osc_loop(void)
{
	ver("osc loop start");

	int32_t lcd_count = 0;

	while (SDL_AtomicGet(&run) != 0) {
		if (recv_sock == NULL) {
			SDL_Delay(100);
			continue;
		}

		while (SDLNet_UDP_Recv(recv_sock, recv_pkt) == 1) {
			parse_message(recv_pkt->data, recv_pkt->len, recv_pkt);
		}

		/* run smoothing filter at ~500 Hz */
		osc_smooth_tick();

		/* poll LCD text every ~100ms (every 50 iterations at 2ms) */
		if (connected && ++lcd_count >= 50) {
			lcd_count = 0;
			osc_poll_lcd();
		}

		SDL_Delay(2); /* ~500 Hz poll rate, low latency */
	}

	ver("osc loop end");
}
