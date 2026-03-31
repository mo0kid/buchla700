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

#define ver(...) _ver(ser_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(ser_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(ser_verbose, 2, __VA_ARGS__)

int32_t ser_verbose = 0;

#define WIN_W (1520 / 2)
#define WIN_H (950 / 2)

#define BEL_CYC 10000
#define MOU_CYC 10000

#if defined EMU_WIN
#define MOU_DIV 64
#elif defined EMU_OS_X
#define MOU_DIV 1
#else
#define MOU_DIV 4
#endif

#define CON_W 80
#define CON_H 25

#define CON_BGR 0x00000000
#define CON_BEL 0x00808080
#define CON_CUR 0x00e87000
#define CON_FGR ((SDL_Color){ .r = 255, .b = 255, .g = 255, .a = 255 })

#define BUF_SZ 16

#define REG_IER_ISR 0
#define REG_CFR_SR  1
#define REG_CDR_TBR 2
#define REG_TDR_RDR 3

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

static uint8_t mem[CON_H][CON_W];

static SDL_Window *win;
uint32_t ser_win;

static SDL_Renderer *ren;
static SDL_atomic_t frame;

static TTF_Font *fon;
static int32_t fon_w, fon_h;

static int32_t sur_w, sur_h;
static SDL_Surface *sur;

static int32_t cur_x = 0, cur_y = 0;
static int32_t bel = 0;

static int32_t mou;
static int32_t mou_dx, mou_dy;
static bool mou_l, mou_r;

static void scroll(void)
{
	memmove(mem, mem + 1, (CON_H - 1) * CON_W);
	memset(mem + (CON_H - 1), ' ', CON_W);
}

static void forw(void)
{
	if (cur_x < CON_W - 1) {
		++cur_x;
		return;
	}

	if (cur_y == CON_H - 1) {
		cur_x = 0;
		scroll();
		return;
	}

	cur_x = 0;
	++cur_y;
}

static void back(void)
{
	if (cur_x > 0) {
		--cur_x;
		return;
	}

	if (cur_y == 0) {
		return;
	}

	cur_x = CON_W - 1;
	--cur_y;
}

static void down(void)
{
	if (cur_y < CON_H - 1) {
		++cur_y;
		return;
	}

	scroll();
}

static void echo(uint8_t c)
{
	if (c < 32) {
		switch (c) {
		case '\r':
			cur_x = 0;
			break;

		case '\n':
			down();
			break;

		case '\b':
			back();
			break;

		case '\a':
			bel = BEL_CYC;
			break;

		default:
			echo('^');
			echo((uint8_t)(c + '@'));
			return;
		}
	}
	else {
		mem[cur_y][cur_x] = c;
		forw();
	}

	SDL_AtomicAdd(&frame, 1);
}

static void xmit(int32_t un)
{
	int32_t i = state[un].buf_tl;
	ver2("ser xmit %d %d", i, state[un].buf_hd);

	if (i >= state[un].buf_hd) {
		return;
	}

	uint8_t byte = state[un].buf[i % BUF_SZ];
	ver2("ser xmit 0x%02x", byte);

	state[un].rdr = byte;
	state[un].rdr_ok = true;
	state[un].irq_r = true;

	state[un].buf_tl = i + 1;

	if (state[un].buf_tl >= BUF_SZ) {
		state[un].buf_hd -= BUF_SZ;
		state[un].buf_tl -= BUF_SZ;
		ver2("ser adj %d %d", state[un].buf_tl, state[un].buf_hd);
	}
}

static void out_lk(int32_t un, uint8_t c)
{
	int32_t i = state[un].buf_hd;
	ver2("ser out %d %d 0x%02x", state[un].buf_tl, i, c);

	if (i >= state[un].buf_tl + BUF_SZ) {
		err("serial port %d losing data", un);
		return;
	}

	state[un].buf[i % BUF_SZ] = c;
	state[un].buf_hd = i + 1;

	if (!state[un].irq_r && !state[un].rdr_ok) {
		xmit(un);
	}
}

static void out(int32_t un, uint8_t c)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	out_lk(un, c);

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

static void mouse(uint8_t c)
{
	if (c == 't') {
		ver2("ser mou init");
	}

	out_lk(0, 'V');
	out_lk(0, 'O');
}

void ser_sdl(void)
{
	ver3("ser_sdl()");

	static int32_t last = 0;
	int32_t now = SDL_AtomicGet(&frame);

	if (last == now) {
		ver3("no update");
		return;
	}

	last = now;

	if (SDL_FillRect(sur, NULL, bel == 0 ? CON_BGR : CON_BEL) < 0) {
		fail("SDL_FillRect() failed: %s", SDL_GetError());
	}

	if (SDL_FillRect(sur, &(SDL_Rect){
		.x = cur_x * fon_w,
		.y = cur_y * fon_h,
		.w = fon_w,
		.h = fon_h
	}, CON_CUR) < 0) {
		fail("SDL_FillRect() failed: %s", SDL_GetError());
	}

	for (int32_t y = 0; y < CON_H; ++y) {
		char line[CON_W + 1];
		line[CON_W] = 0;

		if (SDL_LockMutex(cpu_mutex) < 0) {
			fail("SDL_LockMutex() failed: %s", SDL_GetError());
		}

		memcpy(line, mem[y], CON_W);

		if (SDL_UnlockMutex(cpu_mutex) < 0) {
			fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
		}

		SDL_Surface *lin = TTF_RenderText_Blended(fon, line, CON_FGR);

		if (lin == NULL) {
			fail("TTF_RenderText_Blended() failed: %s", TTF_GetError());
		}

		if (SDL_BlitSurface(lin, NULL, sur, &(SDL_Rect){
			.x = 0,
			.y = y * fon_h,
			.w = CON_W * fon_w,
			.h = fon_h
		})) {
			fail("SDL_BlitSurface() failed: %s", SDL_GetError());
		}

		SDL_FreeSurface(lin);
	}

	SDL_Texture *tex = SDL_CreateTextureFromSurface(ren, sur);

	if (tex == NULL) {
		fail("SDL_CreateTextureFromSurface() failed: %s", SDL_GetError());
	}

	if (SDL_RenderCopy(ren, tex, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	SDL_DestroyTexture(tex);
	SDL_RenderPresent(ren);
}

void ser_key(SDL_KeyboardEvent *ev)
{
	switch (ev->keysym.sym) {
	case SDLK_BACKSPACE:
		out(1, '\b');
		break;

	case SDLK_RETURN:
		out(1, '\r');
		break;

	default:
		if ((ev->keysym.mod & KMOD_CTRL) != 0 &&
				ev->keysym.sym >= SDLK_a && ev->keysym.sym <= SDLK_z) {
			out(1, (uint8_t)(ev->keysym.sym - SDLK_a + 1));
		}

		break;
	}
}

void ser_text(SDL_TextInputEvent *ev)
{
	for (int32_t i = 0; ev->text[i] != 0; ++i) {
		out(1, (uint8_t)ev->text[i]);
	}
}

void ser_type(const char *str)
{
	for (int32_t i = 0; str[i] != 0; ++i) {
		out(1, (uint8_t)str[i]);
	}
}

static void mou_ev(void)
{
	ver2("ser mou ev (%d, %d) %c %c",
		mou_dx, mou_dy, mou_l ? 'l' : '-', mou_r ? 'r' : '-');

	int32_t dx = mou_dx / MOU_DIV;
	int32_t dy = mou_dy / MOU_DIV;

	if (dx < -128) {
		dx = -128;
	}
	else if (dx > 127) {
		dx = 127;
	}

	if (dy < -128) {
		dy = -128;
	}
	else if (dy > 127) {
		dy = 127;
	}

	dx = dx & 0xff;
	dy = dy & 0xff;

	int32_t b1 = 0x40;

	if (mou_l) {
		b1 |= 0x20;
	}

	if (mou_r) {
		b1 |= 0x10;
	}

	b1 |= (dy & 0xc0) >> 4;
	b1 |= (dx & 0xc0) >> 6;

	int32_t b2 = dx & 0x3f;
	int32_t b3 = dy & 0x3f;

	out_lk(0, (uint8_t)b1);
	out_lk(0, (uint8_t)b2);
	out_lk(0, (uint8_t)b3);

	mou_dx = mou_dy = 0;
}

static void mou_ev_chk(void)
{
	if (--mou > 0) {
		return;
	}

	mou = MOU_CYC;

	if (mou_dx == 0 && mou_dy == 0) {
		return;
	}

	mou_ev();
}

void ser_mou_res(void)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	mou = MOU_CYC;
	mou_dx = mou_dy = 0;
	mou_l = mou_r = false;

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

void ser_mou_mov(SDL_MouseMotionEvent *ev)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	mou_dx += ev->xrel;
	mou_dy += ev->yrel;

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

void ser_mou_dn(SDL_MouseButtonEvent *ev)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	if (ev->button == SDL_BUTTON_LEFT) {
		mou_l = true;
	}
	else if (ev->button == SDL_BUTTON_RIGHT) {
		mou_r = true;
	}
	else {
		return;
	}

	mou_ev();

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

void ser_mou_up(SDL_MouseButtonEvent *ev)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	if (ev->button == SDL_BUTTON_LEFT) {
		mou_l = false;
	}
	else if (ev->button == SDL_BUTTON_RIGHT) {
		mou_r = false;
	}
	else {
		return;
	}

	mou_ev();

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

/* public entry point for OSC companion XY pad */

void ser_osc_mou(int32_t dx, int32_t dy, bool down)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	mou_dx += dx;
	mou_dy += dy;
	mou_l = down;

	mou_ev();

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

void ser_init(void)
{
	ver("ser init");

#if defined(EMU_RPI)
	/* RPi: skip serial console window — only CRT via KMS/DRM */
	return;
#endif

	win = SDL_CreateWindow("Serial Console", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
			WIN_W, WIN_H, 0);

	if (win == NULL) {
		fail("SDL_CreateWindow() failed: %s", SDL_GetError());
	}

	ser_win = SDL_GetWindowID(win);

	if (ser_win == 0) {
		fail("SDL_GetWindowID() failed: %s", SDL_GetError());
	}

	ren = SDL_CreateRenderer(win, -1, 0);

	if (ren == NULL) {
		fail("SDL_CreateRenderer() failed: %s", SDL_GetError());
	}

	SDL_AtomicSet(&frame, 1);

	SDL_RWops *ops = SDL_RWFromFile(font, "rb");

	if (ops == NULL) {
		fail("error while opening font file %s: %s", font, SDL_GetError());
	}

	fon = TTF_OpenFontRW(ops, 1, 32);

	if (fon == NULL) {
		fail("error while loading font file %s: %s", font, TTF_GetError());
	}

	fon_h = TTF_FontLineSkip(fon);

	if (TTF_GlyphMetrics(fon, 'X', NULL, NULL, NULL, NULL, &fon_w) < 0) {
		fail("error while measuring font width: %s", TTF_GetError());
	}

	sur_w = CON_W * fon_w;
	sur_h = CON_H * fon_h;

	sur = SDL_CreateRGBSurface(0, sur_w, sur_h, 32, 0, 0, 0, 0);

	if (sur == NULL) {
		fail("SDL_CreateRGBSurface() failed: %s", SDL_GetError());
	}

	for (int32_t y = 0; y < CON_H; ++y) {
		for (int32_t x = 0; x < CON_W; ++x) {
			mem[y][x] = ' ';
		}
	}
}

void ser_quit(void)
{
	ver("ser quit");

	SDL_FreeSurface(sur);
	TTF_CloseFont(fon);

	SDL_DestroyRenderer(ren);
	SDL_DestroyWindow(win);
}

bool ser_exec(void)
{
	ver3("ser exec");

	if (bel > 0) {
		--bel;

		if (bel == BEL_CYC - 1 || bel == 0) {
			SDL_AtomicAdd(&frame, 1);
		}
	}

	mou_ev_chk();

	return state[0].irq_r || state[0].irq_t || state[1].irq_r || state[1].irq_t;
}

uint32_t ser_read(uint32_t off, int32_t sz)
{
	ver2("ser rd %u:%d", off, sz * 8);

	if (sz != 1 || off > 7) {
		fail("invalid ser rd %u:%d", off, sz * 8);
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

void ser_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("ser wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (sz != 1 || off > 7) {
		fail("invalid ser wr %u:%d", off, sz * 8);
	}

	int32_t rg = (int32_t)(off % 4);
	int32_t un = (int32_t)(off / 4);

	switch (rg) {
	case REG_TDR_RDR:
		ver2("TDR[%d] 0x%02x", un, val);

		if (un == 1) {
			echo((uint8_t)val);
		}
		else {
			mouse((uint8_t)val);
		}

		state[un].irq_t = true;
		break;

	default:
		break;
	}
}
