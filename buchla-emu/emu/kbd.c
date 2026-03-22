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

#define ver(...) _ver(kbd_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(kbd_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(kbd_verbose, 2, __VA_ARGS__)

int32_t kbd_verbose = 0;

#define BUF_SZ 128

static int32_t buf_hd = 0;
static int32_t buf_tl = 0;
static uint8_t buf[BUF_SZ];

static uint8_t reg = 0;
static bool irq = false;

static void xmit(void)
{
	ver2("kbd xmit %d %d", buf_tl, buf_hd);

	if (buf_tl >= buf_hd) {
		return;
	}

	reg = buf[buf_tl % BUF_SZ];
	irq = true;
	ver2("kbd xmit 0x%02x", reg);

	++buf_tl;

	if (buf_tl >= BUF_SZ) {
		buf_hd -= BUF_SZ;
		buf_tl -= BUF_SZ;
		ver2("kbd adj %d %d", buf_tl, buf_hd);
	}
}

static void out(uint8_t c)
{
	ver2("kbd out %d %d 0x%02x", buf_tl, buf_hd, c);

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	if (buf_hd >= buf_tl + BUF_SZ) {
		err("keyboard port losing data");
	}
	else {
		buf[buf_hd % BUF_SZ] = c;
		++buf_hd;

		if (!irq) {
			xmit();
		}
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

static void but_on(int32_t sig)
{
	out((uint8_t)(0x80 | sig));
	out(0x01);
}

static void but_off(int32_t sig)
{
	out((uint8_t)(0x80 | sig));
	out(0x00);
}

static void key_touch(int32_t sig, int32_t val)
{
	out((uint8_t)(0x80 | sig));
	out(0x01);
	out((uint8_t)val);
}

static void key_off(int32_t sig)
{
	out((uint8_t)(0x80 | sig));
	out(0x00);
}

static void slid(int32_t sig, bool on, int32_t val)
{
	out((uint8_t)(0x80 | sig));
	out(on ? 0x01 : 0x00);
	out((uint8_t)val);
}

#if defined NOT_YET
static void pot(int32_t sig, int32_t val)
{
	out((uint8_t)(0x80 | sig));
	out((uint8_t)val);
}
#endif

static void vid_key(SDL_KeyboardEvent *ev, bool dn)
{
	if ((ev->keysym.mod & KMOD_SHIFT) != 0 &&
			ev->keysym.sym >= SDLK_a && ev->keysym.sym <= SDLK_x) {
		int32_t i = ev->keysym.sym - SDLK_a;
		ver2("kbd key %d %s", i, dn ? "dn" : "up");

		if (dn) {
			key_touch(1 + i, 0x7f);
		}
		else {
			key_off(1 + i);
		}

		return;
	}

	int32_t sig;

	if (ev->keysym.sym >= SDLK_0 && ev->keysym.sym <= '9') {
		int32_t i = ev->keysym.sym - SDLK_0;
		ver2("kbd dat %d %s", i, dn ? "dn" : "up");
		sig = 60 + i;
	}
	else {
		switch (ev->keysym.sym) {
		case SDLK_x:
			ver2("kbd x %s", dn ? "dn" : "up");
			sig = 70;
			break;

		case SDLK_e:
			ver2("kbd e %s", dn ? "dn" : "up");
			sig = 71;
			break;

		case SDLK_m:
			ver2("kbd m %s", dn ? "dn" : "up");
			sig = 72;
			break;

		default:
			return;
		}
	}

	if (dn) {
		but_on(sig);
	}
	else {
		but_off(sig);
	}
}

static void lcd_key(SDL_KeyboardEvent *ev, bool dn)
{
	if ((ev->keysym.mod & KMOD_CTRL) != 0 &&
			ev->keysym.sym >= SDLK_a && ev->keysym.sym <= SDLK_n) {
		int32_t i = ev->keysym.sym - SDLK_a;
		ver2("kbd lcd %d %s", i, dn ? "dn" : "up");

		if (dn) {
			but_on(39 + i);
		}
		else {
			but_off(39 + i);
		}

		return;
	}

	if (ev->keysym.sym >= SDLK_a && ev->keysym.sym <= SDLK_n) {
		static int32_t lev[14] = {
			64, 0, 0, 0, 0, 64, 64, 64, 64, 0, 0, 0, 64, 0
		};

		int32_t i = ev->keysym.sym - SDLK_a;
		int32_t val = lev[i];

		if (!dn) {
			if ((ev->keysym.mod & KMOD_SHIFT) != 0) {
				val = val > 10 ? val - 10 : 0;
			}
			else {
				val = val < 117 ? val + 10 : 127;
			}
		}

		ver2("kbd sli %d %s %d", i, dn ? "dn" : "up", val);
		slid(25 + i, dn, val);

		lev[i] = val;
		return;
	}
}

/* public entry points for OSC companion */

void kbd_osc_key_touch(int32_t sig, int32_t val) { key_touch(sig, val); }
void kbd_osc_key_off(int32_t sig) { key_off(sig); }
void kbd_osc_but_on(int32_t sig) { but_on(sig); }
void kbd_osc_but_off(int32_t sig) { but_off(sig); }
void kbd_osc_slid(int32_t sig, bool on, int32_t val) { slid(sig, on, val); }

void kbd_key(SDL_KeyboardEvent *ev, bool vid, bool dn)
{
	if (vid) {
		vid_key(ev, dn);
	}
	else {
		lcd_key(ev, dn);
	}
}

void kbd_init(void)
{
	ver("kbd init");
}

void kbd_quit(void)
{
	ver("kbd quit");
}

bool kbd_exec(void)
{
	ver3("kbd exec");
	return irq;
}

uint32_t kbd_read(uint32_t off, int32_t sz)
{
	ver2("kbd rd %u:%d", off, sz * 8);

	if (sz != 1 || off > 0) {
		fail("invalid kbd rd %u:%d", off, sz * 8);
	}

	irq = false;
	uint32_t res = reg;

	xmit();

	return res;
}

void kbd_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("kbd wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);
	fail("invalid kbd wr %u:%d", off, sz * 8);
}
