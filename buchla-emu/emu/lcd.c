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

#define ver(...) _ver(lcd_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(lcd_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(lcd_verbose, 2, __VA_ARGS__)

int32_t lcd_verbose = 0;

#define WIN_W (1615 / 2)
#define WIN_H (304 / 2)

#define GFX_BGR 0x00000000
#define GFX_FGR 0xFFFFFFFF

#define TXT_BGR 0x000000FF
#define TXT_FGR ((SDL_Color){ .r = 255, .b = 255, .g = 255, .a = 255 })

#define REG_ARG 0
#define REG_COM 1

#define COM_NONE	0x00
#define	COM_MWRITE	0x42
#define	COM_MREAD	0x43
#define	COM_CRSWR	0x46
#define	COM_CRSMRT	0x4C
#define	COM_CRSMUP	0x4E
#define	COM_CRSMDN	0x4F
#define	COM_DSPOFF	0x58
#define	COM_DSPON	0x59

#define TXT_W 85
#define TXT_H 8

#define GFX_W 85
#define GFX_H 64
#define GFX_PIX 6

#define BASE_TXT 0x0000
#define BASE_GFX 0x2000

#define DIR_UP -85
#define DIR_DOWN 85
#define DIR_RIGHT 1

static uint8_t mem_txt[TXT_H * TXT_W];
static uint8_t mem_gfx[GFX_H * GFX_W];

void lcd_get_row(int32_t row, char *buf, int32_t buf_sz)
{
	if (row < 0 || row >= TXT_H || buf_sz < 1) {
		if (buf_sz > 0) buf[0] = 0;
		return;
	}

	int32_t len = buf_sz - 1 < TXT_W ? buf_sz - 1 : TXT_W;

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < len; ++i) {
		uint8_t c = mem_txt[row * TXT_W + i];
		buf[i] = (c == 0 || c < 0x20) ? ' ' : (char)c;
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	buf[len] = 0;
}

#define BAR_ROW_BOT  54   /* mem_gfx row for BBase (9)   */
#define BAR_ROW_MID  31   /* mem_gfx row for BCenter (32) */
#define BAR_ROW_TOP  10   /* mem_gfx row for BTop (53)   */
#define BAR_ROWS     45   /* total bar area rows */

void lcd_get_bars(float *bars, int32_t n_bars, const bool *centered)
{
	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < n_bars && i < 14; ++i) {
		int32_t px = 18 + i * 36;
		int32_t byte_x = px / GFX_PIX;
		int32_t bit_pos = 7 - (px % GFX_PIX);

		if (centered != NULL && centered[i]) {
			/* center-based: scan from center row outward */
			int32_t above = 0;

			for (int32_t y = BAR_ROW_MID - 1; y >= BAR_ROW_TOP; --y) {
				if ((mem_gfx[y * GFX_W + byte_x] >> bit_pos) & 1)
					++above;
				else
					break;
			}

			int32_t below = 0;

			for (int32_t y = BAR_ROW_MID + 1; y <= BAR_ROW_BOT; ++y) {
				if ((mem_gfx[y * GFX_W + byte_x] >> bit_pos) & 1)
					++below;
				else
					break;
			}

			if (above > 0)
				bars[i] = 0.5f + ((float)above / 21.0f) * 0.5f;
			else if (below > 0)
				bars[i] = 0.5f - ((float)below / 23.0f) * 0.5f;
			else
				bars[i] = 0.5f;
		}
		else {
			/* bottom-based: scan above BBase baseline marker */
			int32_t height = 0;

			for (int32_t y = BAR_ROW_BOT - 1; y >= BAR_ROW_TOP; --y) {
				if ((mem_gfx[y * GFX_W + byte_x] >> bit_pos) & 1)
					++height;
				else
					break;
			}

			bars[i] = (float)height / (float)(BAR_ROWS - 1);
		}
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

static SDL_Window *win;
uint32_t lcd_win;

static SDL_Renderer *ren;
static SDL_atomic_t frame;
static SDL_atomic_t ena;

static TTF_Font *fon;
static int32_t fon_w, fon_h;

static int32_t txt_w, txt_h;
static SDL_Surface *txt;
static SDL_Texture *gfx;

static int32_t com;
static int32_t n_arg;
static int32_t cur = BASE_TXT;
static int32_t dir = DIR_RIGHT;

void lcd_sdl(void)
{
	ver3("lcd_sdl()");

	static int32_t last = 0;
	int32_t now = SDL_AtomicGet(&frame);

	if (last == now) {
		ver3("no update");
		return;
	}

	last = now;

	if (SDL_FillRect(txt, NULL, TXT_BGR) < 0) {
		fail("SDL_FillRect() failed: %s", SDL_GetError());
	}

	if (SDL_AtomicGet(&ena) == 0) {
		SDL_Texture *tex = SDL_CreateTextureFromSurface(ren, txt);

		if (tex == NULL) {
			fail("SDL_CreateTextureFromSurface() failed: %s", SDL_GetError());
		}

		if (SDL_RenderCopy(ren, tex, NULL, NULL) < 0) {
			fail("SDL_RenderCopy() failed: %s", SDL_GetError());
		}

		SDL_DestroyTexture(tex);
		SDL_RenderPresent(ren);
		return;
	}

	for (int32_t y = 0; y < TXT_H; ++y) {
		char line[TXT_W + 1];
		line[TXT_W] = 0;

		if (SDL_LockMutex(cpu_mutex) < 0) {
			fail("SDL_LockMutex() failed: %s", SDL_GetError());
		}

		memcpy(line, mem_txt + y * TXT_W, TXT_W);

		if (SDL_UnlockMutex(cpu_mutex) < 0) {
			fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
		}

		for (int32_t x = 0; x < TXT_W; ++x) {
			if (line[x] == 0x00) {
				line[x] = ' ';
			}
			else if (line[x] == 0x7e) {
				line[x] = (char) 0xbb;
			}
			else if (line[x] == 0x7f) {
				line[x] = (char) 0xab;
			}
		}

		SDL_Surface *lin = TTF_RenderText_Blended(fon, line, TXT_FGR);

		if (lin == NULL) {
			fail("TTF_RenderText_Blended() failed: %s", TTF_GetError());
		}

		if (SDL_BlitSurface(lin, NULL, txt, &(SDL_Rect){
			.x = 0,
			.y = y * fon_h,
			.w = TXT_W * fon_w,
			.h = fon_h
		})) {
			fail("SDL_BlitSurface() failed: %s", SDL_GetError());
		}

		SDL_FreeSurface(lin);
	}

	SDL_Texture *tex = SDL_CreateTextureFromSurface(ren, txt);

	if (tex == NULL) {
		fail("SDL_CreateTextureFromSurface() failed: %s", SDL_GetError());
	}

	if (SDL_RenderCopy(ren, tex, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	SDL_DestroyTexture(tex);

	void *buf;
	int32_t pitch;

	if (SDL_LockTexture(gfx, NULL, &buf, &pitch) < 0) {
		fail("SDL_LockTexture() failed: %s", SDL_GetError());
	}

	uint32_t *pix = buf;

	for (int32_t y = 0; y < GFX_H; ++y) {
		for (int32_t x = 0; x < GFX_W; ++x) {
			uint8_t b = mem_gfx[y * GFX_W + x];

			for (int32_t p = 0; p < GFX_PIX; ++p) {
				bool set = (b & (1 << (7 - p))) != 0;
				*pix++ = set ? GFX_FGR : GFX_BGR;
			}
		}

		pix += pitch / 4 - GFX_W * GFX_PIX;
	}

	SDL_UnlockTexture(gfx);

	if (SDL_RenderCopy(ren, gfx, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	SDL_RenderPresent(ren);
}

void lcd_init(void)
{
	ver("lcd init");

#if defined(EMU_RPI)
	/* RPi: skip LCD window — only one fullscreen display via KMS/DRM */
	for (int32_t i = 0; i < TXT_W * TXT_H; ++i) {
		mem_txt[i] = ' ';
	}
	return;
#endif

	win = SDL_CreateWindow("LCD", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
			WIN_W, WIN_H, 0);

	if (win == NULL) {
		fail("SDL_CreateWindow() failed: %s", SDL_GetError());
	}

	lcd_win = SDL_GetWindowID(win);

	if (lcd_win == 0) {
		fail("SDL_GetWindowID() failed: %s", SDL_GetError());
	}

	ren = SDL_CreateRenderer(win, -1, 0);

	if (ren == NULL) {
		fail("SDL_CreateRenderer() failed: %s", SDL_GetError());
	}

	gfx = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STREAMING,
			GFX_W * GFX_PIX, GFX_H);

	if (gfx == NULL) {
		fail("SDL_CreateTexture() failed: %s", SDL_GetError());
	}

	if (SDL_SetTextureBlendMode(gfx, SDL_BLENDMODE_BLEND) < 0) {
		fail("SDL_SetTextureBlendMode() failed: %s", SDL_GetError());
	}

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

	txt_w = TXT_W * fon_w;
	txt_h = TXT_H * fon_h;

	txt = SDL_CreateRGBSurfaceWithFormat(0, txt_w, txt_h, 32, SDL_PIXELFORMAT_RGBA8888);

	if (txt == NULL) {
		fail("SDL_CreateRGBSurface() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < TXT_W * TXT_H; ++i) {
		mem_txt[i] = ' ';
	}
}

void lcd_quit(void)
{
	ver("lcd quit");

	SDL_FreeSurface(txt);
	TTF_CloseFont(fon);

	SDL_DestroyTexture(gfx);

	SDL_DestroyRenderer(ren);
	SDL_DestroyWindow(win);
}

bool lcd_exec(void)
{
	ver3("lcd exec");
	return false;
}

uint32_t lcd_read(uint32_t off, int32_t sz)
{
	ver2("lcd rd %u:%d", off, sz * 8);

	if (sz != 1 || off != 1) {
		fail("invalid lcd rd %u:%d", off, sz * 8);
	}

	switch (com) {
	case COM_MREAD:
		if (cur >= BASE_TXT && cur < BASE_TXT + TXT_W * TXT_H) {
			return mem_txt[cur - BASE_TXT];
		}

		if (cur >= BASE_GFX && cur < BASE_GFX + GFX_W * GFX_H) {
			return mem_gfx[cur - BASE_GFX];
		}

		return 0x00;

	default:
		return 0x00;
	}
}

static void proc_arg(int32_t val)
{
	switch (com) {
	case COM_MWRITE:
		if (cur >= BASE_TXT && cur < BASE_TXT + TXT_W * TXT_H) {
			mem_txt[cur - BASE_TXT] = (uint8_t)val;
		}
		else if (cur >= BASE_GFX && cur < BASE_GFX + GFX_W * GFX_H) {
			mem_gfx[cur - BASE_GFX] = (uint8_t)val;
		}

		cur += dir;
		SDL_AtomicAdd(&frame, 1);
		break;

	case COM_CRSWR:
		if (n_arg == 0) {
			cur = val;
		}
		else if (n_arg == 1) {
			cur |= val << 8;

			if (cur < BASE_TXT ||
					(cur >= BASE_TXT + TXT_W * TXT_H && cur < BASE_GFX) ||
					cur >= BASE_GFX + GFX_W * GFX_H) {
				fail("invalid address 0x%04x", cur);
			}
		}

		break;

	default:
		break;
	}
}

static void proc_com(int32_t val)
{
	switch (val) {
	case COM_CRSWR:
	case COM_MREAD:
	case COM_MWRITE:
		com = val;
		break;

	case COM_CRSMRT:
		dir = DIR_RIGHT;
		com = COM_NONE;
		break;

	case COM_CRSMUP:
		dir = DIR_UP;
		com = COM_NONE;
		break;

	case COM_CRSMDN:
		dir = DIR_DOWN;
		com = COM_NONE;
		break;

	case COM_DSPOFF:
		SDL_AtomicSet(&ena, 0);
		com = COM_NONE;
		break;

	case COM_DSPON:
		SDL_AtomicSet(&ena, 1);
		com = COM_NONE;
		break;

	default:
		com = COM_NONE;
		break;
	}
}

void lcd_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("lcd wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (sz != 1 || off > 1) {
		fail("invalid lcd wr %u:%d", off, sz * 8);
	}

	switch (off) {
	case REG_ARG:
		proc_arg((int32_t)val);
		++n_arg;
		break;

	case REG_COM:
		proc_com((int32_t)val);
		n_arg = 0;
		break;

	default:
		break;
	}
}
