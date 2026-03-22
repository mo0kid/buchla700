/*
 *  Copyright (C) 2017-2018 The Contributors
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

#define ver(...) _ver(mid_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(mid_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(mid_verbose, 2, __VA_ARGS__)

int32_t mid_verbose = 0;

#define REG_IER_ISR 0
#define REG_CFR_SR  1
#define REG_CDR_TBR 2
#define REG_TDR_RDR 3

#define BUF_SZ 256

typedef struct {
	int32_t buf_hd;
	int32_t buf_tl;
	uint8_t buf[BUF_SZ];
	bool irq_r;
	bool irq_t;
	bool rdr_ok;
	uint8_t rdr;
} state_t;

static state_t state[] = {
	{ .buf_hd = 0, .buf_tl = 0, .irq_r = false, .irq_t = false, .rdr_ok = false, .rdr = 0x00 },
	{ .buf_hd = 0, .buf_tl = 0, .irq_r = false, .irq_t = false, .rdr_ok = false, .rdr = 0x00 }
};

static struct RtMidiWrapper *mid_in = NULL;

static void xmit(int32_t un)
{
	int32_t i = state[un].buf_tl;
	ver2("mid xmit %d %d", i, state[un].buf_hd);

	if (i >= state[un].buf_hd) {
		return;
	}

	uint8_t byte = state[un].buf[i % BUF_SZ];
	ver2("mid xmit 0x%02x", byte);

	state[un].rdr = byte;
	state[un].rdr_ok = true;
	state[un].irq_r = true;

	state[un].buf_tl = i + 1;

	if (state[un].buf_tl >= BUF_SZ) {
		state[un].buf_hd -= BUF_SZ;
		state[un].buf_tl -= BUF_SZ;
		ver2("mid adj %d %d", state[un].buf_tl, state[un].buf_hd);
	}
}

static void out(int32_t un, uint8_t c)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	int32_t i = state[un].buf_hd;
	ver2("mid out %d %d 0x%02x", state[un].buf_tl, i, c);

	if (i >= state[un].buf_tl + BUF_SZ) {
		err("midi port %d losing data", un);
		return;
	}

	state[un].buf[i % BUF_SZ] = c;
	state[un].buf_hd = i + 1;

	if (!state[un].irq_r && !state[un].rdr_ok) {
		xmit(un);
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

static void callback(double time, const uint8_t *midi, size_t midi_sz, void *data)
{
	(void)data;
	(void)midi_sz;

	// XXX - remove length calculation once RtMidi passes the length

	int32_t len;

	switch (midi[0] & 0xf0) {
	case 0x80: // note on
	case 0x90: // note off
	case 0xa0: // polyphonic key pressure
	case 0xb0: // control change
	case 0xe0: // pitch bend change
		len = 3;
		break;

	case 0xc0: // program change
	case 0xd0: // channel pressure
		len = 2;
		break;

	case 0xf0:
		switch (midi[0]) {
		case 0xf0: // system exclusive
		case 0xf4: // undefined
		case 0xf5: // undefined
		case 0xf7: // end of exclusive
		case 0xf9: // undefined
		case 0xfd: // undefined
			len = -1;
			break;

		case 0xf1: // MIDI time code quarter frame
		case 0xf3: // song select
			len = 2;
			break;

		case 0xf2: // song position pointer
			len = 3;
			break;

		case 0xf6: // tune request
		case 0xf8: // timing clock
		case 0xfa: // start
		case 0xfb: // continue
		case 0xfc: // stop
		case 0xfe: // active sensing
		case 0xff: // reset
			len = 1;
			break;
		}

		break;

	default:
		len = 0;
		break;
	}

	ver2("time %f, len %d", time, len);

	for (int32_t i = 0; i < len; ++i) {
		ver2("midi[%d] 0x%02x", i, midi[i]);
		out(0, midi[i]);
	}
}

void mid_init(void)
{
	ver("mid init");

	mid_in = rtmidi_in_create_default();
	mid_in->data = NULL; // XXX - remove initialization once it's added to RtMidi

	if (!mid_in->ok) {
		fail("rtmidi_in_create_default() failed: %s", mid_in->msg);
	}

	uint32_t n_ports = rtmidi_get_port_count(mid_in);

	if (n_ports == 0) {
		inf("no MIDI ports\n");
		rtmidi_in_free(mid_in);
		mid_in = NULL;
		return;
	}

	if (mid_port >= n_ports) {
		fail("invalid MIDI port %u selected (%u available)", mid_port, n_ports);
	}

	char name[256];
	int name_len = (int)sizeof name;

	rtmidi_get_port_name(mid_in, mid_port, name, &name_len);
	rtmidi_open_port(mid_in, mid_port, name);

	if (!mid_in->ok) {
		fail("error while opening MIDI port %u (%s): %s", mid_port, name, mid_in->msg);
	}

	inf("using MIDI port %u (%s)", mid_port, name);

	rtmidi_in_set_callback(mid_in, callback, mid_in->data);

	if (!mid_in->ok) {
		fail("rtmidi_in_set_callback() failed: %s", mid_in->msg);
	}
}

void mid_quit(void)
{
	ver("mid quit");

	if (mid_in == NULL) {
		return;
	}

	rtmidi_close_port(mid_in);
	rtmidi_in_free(mid_in);
}

bool mid_exec(void)
{
	ver3("mid exec");
	return state[0].irq_r || state[0].irq_t || state[1].irq_r || state[1].irq_t;
}

uint32_t mid_read(uint32_t off, int32_t sz)
{
	ver2("mid rd %u:%d", off, sz * 8);

	if (sz != 1 || off > 7) {
		fail("invalid mid rd %u:%d", off, sz * 8);
	}

	int32_t rg = (int32_t)(off % 4);
	int32_t un = (int32_t)(off / 4);

	uint32_t rv;

	switch (rg) {
	case REG_IER_ISR:
		rv = (uint32_t)(0xc0 | (state[un].rdr_ok ? 0x01 : 0x00));
		state[un].irq_r = false;
		state[un].irq_t = false;
		ver2("ISR[%d] 0x%02x", un, rv);
		break;

	case REG_TDR_RDR:
		rv = state[un].rdr;
		state[un].rdr_ok = false;
		ver2("RDR[%d] 0x%02x", un, rv);
		break;

	default:
		rv = 0x00;
		break;
	}

	if (!state[un].irq_r && !state[un].rdr_ok) {
		xmit(un);
	}

	return rv;
}

void mid_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("mid wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (sz != 1 || off > 7) {
		fail("invalid mid wr %u:%d", off, sz * 8);
	}

	int32_t rg = (int32_t)(off % 4);
	int32_t un = (int32_t)(off / 4);

	switch (rg) {
	case REG_CFR_SR:
		ver2("CFR[%d] 0x%02x", un, val);

		if (un == 1) {
			fdd_set_side((int32_t)val & 0x01);
		}
		else {
			fdd_set_sel((int32_t)val & 0x01);
		}

		break;

	default:
		break;
	}
}

void mid_list(void)
{
	mid_in = rtmidi_in_create_default();
	mid_in->data = NULL; // XXX - remove initialization once it's added to RtMidi

	if (!mid_in->ok) {
		fprintf(stderr, "rtmidi_in_create_default() failed: %s\n", mid_in->msg);
		return;
	}

	uint32_t n_ports = rtmidi_get_port_count(mid_in);

	if (n_ports == 0) {
		fprintf(stdout, "no available MIDI ports\n");
	}
	else {
		for (uint32_t i = 0; i < n_ports; i++) {
			char pname[256];
			int pname_len = (int)sizeof pname;

			rtmidi_get_port_name(mid_in, i, pname, &pname_len);
			fprintf(stdout, "port %u: %s\n", i, pname);
		}
	}

	rtmidi_in_free(mid_in);
}
