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

#define ver(...) _ver(vid_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(vid_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(vid_verbose, 2, __VA_ARGS__)

int32_t vid_verbose = 0;

#define SCR_W 512
#define SCR_H 350
#define VBL_H 50

#define REG_VCR0 0
#define REG_VCR1 1
#define REG_RWBA 2
#define REG_DSBA 5
#define REG_ODTBA 7
#define REG_ATBA 8
#define REG_CGBA 10
#define REG_ATBAC 11

#define VCR0_UCF 0x0001
#define VCR0_DEN 0x0008

#define DSBA_BS1 0x0080
#define DSBA_BS0 0x0100

#define REG_OFF 0x200
#define PAL_OFF 0x40000

#define OD0_TDE 0x0004
#define OD0_BLA 0x0010
#define OD0_CB 0x0800

#define AT_UND 0x0100
#define AT_CG 0x8000

#define WIN_SZ_W 0x10000
#define MEM_SZ_W 0x20000

#define N_BANKS 2

#define SCALE(_x) (_x * 2)

#define WIN_W SCALE(SCR_W)
#define WIN_H SCALE(SCR_H)

typedef struct {
	int32_t y, h;
} ver_t;

typedef struct {
	int32_t x, w;
	int32_t n_vers;
	ver_t vers[SCR_H / 2];
	uint16_t *mem;
	bool tran;
	int32_t fon_h;
} obj_t;

static int32_t reg_off = REG_OFF;

static uint16_t mem[MEM_SZ_W];
static int32_t bank = 0;

static uint32_t pal[16];

static obj_t objs[16];
static int32_t n_objs = 0;

static SDL_Window *win;
uint32_t vid_win;

static SDL_Renderer *ren;
static SDL_Texture *tex;
static SDL_Texture *crt_tex;
static SDL_Texture *scene_rt;
static SDL_Texture *glow_rt;
static SDL_atomic_t frame;

static uint16_t *rend_bm(uint16_t *vid, int32_t w, int32_t h, uint32_t *pix, int32_t pitch)
{
	for (int32_t y = 0; y < h; ++y) {
		for (int32_t x = 0; x < w / 4; ++x) {
			uint16_t v4 = *vid++;

			*pix++ = pal[(v4 & 0x000f) >>  0];
			*pix++ = pal[(v4 & 0x00f0) >>  4];
			*pix++ = pal[(v4 & 0x0f00) >>  8];
			*pix++ = pal[(v4 & 0xf000) >> 12];
		}

		pix += pitch / 4 - w;
	}

	return vid;
}

static uint16_t *rend_tx(uint16_t *vid, int32_t w, int32_t h, int32_t fon_h,
		uint32_t *pix, int32_t pitch)
{
	int32_t cgba = mem[REG_CGBA];

	uint16_t *cg0 = mem + ((cgba & 0x00f0) <<  8);
	uint16_t *cg1 = mem + ((cgba & 0x000f) << 12);

	int32_t line = fon_h - 1;

	for (int32_t y = 0; y < h; ++y) {
		uint16_t *walk = vid;

		for (int32_t col2 = 0; col2 < w / 16; ++col2) {
			uint16_t ch2 = *walk++;

			for (int32_t i = 0; i < 2; ++i) {
				int32_t ch = (uint8_t)ch2;
				int32_t at = *walk++;

				int32_t bg = at & 0x000f;
				int32_t fg = (at & 0x00f0) >> 4;

				int32_t bits;

				if ((at & AT_UND) != 0 && line == 1) {
					bits = 0xff;
				}
				else {
					uint16_t *cg = (at & AT_CG) != 0 ? cg0 : cg1;
					bits = cg[256 * line + ch];
				}

				int32_t mask = 0x01;

				for (int32_t k = 0; k < 8; ++k) {
					*pix++ = (bits & mask) != 0 ? pal[fg] : pal[bg];
					mask <<= 1;
				}

				ch2 >>= 8;
			}
		}

		if (--line < 0) {
			line = fon_h - 1;
			vid = walk;
		}

		pix += pitch / 4 - w;
	}

	return vid;
}

void vid_sdl(void)
{
	ver3("vid_sdl()");

	static int32_t last = 0;
	int32_t now = SDL_AtomicGet(&frame);

	if (last == now) {
		ver3("no update");
		return;
	}

	last = now;

#if defined(EMU_RPI)
	/* RPi: render directly to screen (no render targets — VC4 GLES
	   doesn't support glFramebufferTexture2D) */

	if (SDL_RenderClear(ren) < 0) {
		fail("SDL_RenderClear() failed: %s", SDL_GetError());
	}

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < n_objs; ++i) {
		obj_t *obj = objs + i;

		pal[0] = obj->tran ? pal[0] & 0xffffff00 : pal[0] | 0x000000ff;
		uint16_t *m = obj->mem;

		for (int32_t k = 0; k < obj->n_vers; ++k) {
			SDL_Rect src = {
				.x = 0, .y = 0, .w = obj->w, .h = obj->vers[k].h
			};

			void *buf;
			int32_t pitch;

			if (SDL_LockTexture(tex, &src, &buf, &pitch) < 0) {
				fail("SDL_LockTexture() failed: %s", SDL_GetError());
			}

			if (obj->fon_h < 0) {
				m = rend_bm(m, obj->w, obj->vers[k].h, buf, pitch);
			}
			else {
				m = rend_tx(m, obj->w, obj->vers[k].h, obj->fon_h, buf, pitch);
			}

			SDL_UnlockTexture(tex);

			SDL_Rect dst = {
				.x = SCALE(obj->x), .y = SCALE(obj->vers[k].y),
				.w = SCALE(obj->w), .h = SCALE(obj->vers[k].h)
			};

			if (SDL_RenderCopy(ren, tex, &src, &dst) < 0) {
				fail("SDL_RenderCopy() failed: %s", SDL_GetError());
			}
		}
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	SDL_RenderPresent(ren);

#else
	/* Desktop: render to texture targets for CRT glow effect */

	if (SDL_SetRenderTarget(ren, scene_rt) < 0) {
		fail("SDL_SetRenderTarget() failed: %s", SDL_GetError());
	}

	if (SDL_RenderClear(ren) < 0) {
		fail("SDL_RenderClear() failed: %s", SDL_GetError());
	}

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < n_objs; ++i) {
		obj_t *obj = objs + i;

		pal[0] = obj->tran ? pal[0] & 0xffffff00 : pal[0] | 0x000000ff;
		uint16_t *m = obj->mem;

		for (int32_t k = 0; k < obj->n_vers; ++k) {
			SDL_Rect src = {
				.x = 0, .y = 0, .w = obj->w, .h = obj->vers[k].h
			};

			void *buf;
			int32_t pitch;

			if (SDL_LockTexture(tex, &src, &buf, &pitch) < 0) {
				fail("SDL_LockTexture() failed: %s", SDL_GetError());
			}

			if (obj->fon_h < 0) {
				m = rend_bm(m, obj->w, obj->vers[k].h, buf, pitch);
			}
			else {
				m = rend_tx(m, obj->w, obj->vers[k].h, obj->fon_h, buf, pitch);
			}

			SDL_UnlockTexture(tex);

			SDL_Rect dst = {
				.x = SCALE(obj->x), .y = SCALE(obj->vers[k].y),
				.w = SCALE(obj->w), .h = SCALE(obj->vers[k].h)
			};

			ver2("vid rend %d %d %dx%d -> (%d, %d) (%d, %d) %dx%d",
					i, k,
					obj->w, obj->vers[k].h,
					obj->x, obj->vers[k].y,
					SCALE(obj->x), SCALE(obj->vers[k].y),
					SCALE(obj->w), SCALE(obj->vers[k].h));

			if (SDL_RenderCopy(ren, tex, &src, &dst) < 0) {
				fail("SDL_RenderCopy() failed: %s", SDL_GetError());
			}
		}
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	/* downscale scene to glow target (linear filtering blurs) */

	if (SDL_SetRenderTarget(ren, glow_rt) < 0) {
		fail("SDL_SetRenderTarget() failed: %s", SDL_GetError());
	}

	SDL_SetTextureBlendMode(scene_rt, SDL_BLENDMODE_NONE);

	if (SDL_RenderCopy(ren, scene_rt, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	/* composite to screen */

	if (SDL_SetRenderTarget(ren, NULL) < 0) {
		fail("SDL_SetRenderTarget() failed: %s", SDL_GetError());
	}

	if (SDL_RenderClear(ren) < 0) {
		fail("SDL_RenderClear() failed: %s", SDL_GetError());
	}

	/* sharp base image */

	SDL_SetTextureBlendMode(scene_rt, SDL_BLENDMODE_BLEND);

	if (SDL_RenderCopy(ren, scene_rt, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	/* phosphor glow (blurred scene, additive) */

	SDL_SetTextureBlendMode(glow_rt, SDL_BLENDMODE_ADD);
	SDL_SetTextureAlphaMod(glow_rt, 0x28);

	if (SDL_RenderCopy(ren, glow_rt, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() failed: %s", SDL_GetError());
	}

	/* scanlines */

	if (SDL_RenderCopy(ren, crt_tex, NULL, NULL) < 0) {
		fail("SDL_RenderCopy() crt failed: %s", SDL_GetError());
	}

	SDL_RenderPresent(ren);
#endif
}

void vid_init(void)
{
	ver("vid init");

#if defined(EMU_RPI)
	win = SDL_CreateWindow("Screen", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
			0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP);
#else
	win = SDL_CreateWindow("Screen", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
			WIN_W, WIN_H, 0);
#endif

	if (win == NULL) {
		fail("SDL_CreateWindow() failed: %s", SDL_GetError());
	}

	vid_win = SDL_GetWindowID(win);

	if (vid_win == 0) {
		fail("SDL_GetWindowID() failed: %s", SDL_GetError());
	}

#if defined(EMU_RPI)
	SDL_ShowCursor(SDL_DISABLE);
	ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_PRESENTVSYNC);
#else
	ren = SDL_CreateRenderer(win, -1, 0);
#endif

	if (ren == NULL) {
		fail("SDL_CreateRenderer() failed: %s", SDL_GetError());
	}

	if (SDL_RenderSetLogicalSize(ren, WIN_W, WIN_H) < 0) {
		fail("SDL_RenderSetLogicalSize() failed: %s", SDL_GetError());
	}

	if (SDL_SetRenderDrawColor(ren, 0x00, 0x00, 0x00, 0xff) < 0) {
		fail("SDL_SetRenderDrawColor() failed: %s", SDL_GetError());
	}

	tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STREAMING,
			SCR_W, SCR_H);

	if (tex == NULL) {
		fail("SDL_CreateTexture() failed: %s", SDL_GetError());
	}

	if (SDL_SetTextureBlendMode(tex, SDL_BLENDMODE_BLEND) < 0) {
		fail("SDL_SetTextureBlendMode() failed: %s", SDL_GetError());
	}

#if !defined(EMU_RPI)
	/* render targets with linear filtering for phosphor glow */

	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");

	scene_rt = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET,
			WIN_W, WIN_H);

	if (scene_rt == NULL) {
		fail("SDL_CreateTexture() scene failed: %s", SDL_GetError());
	}

	glow_rt = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET,
			SCR_W, SCR_H);

	if (glow_rt == NULL) {
		fail("SDL_CreateTexture() glow failed: %s", SDL_GetError());
	}

	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");
#endif

#if !defined(EMU_RPI)
	crt_tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STATIC,
			WIN_W, WIN_H);

	if (crt_tex == NULL) {
		fail("SDL_CreateTexture() crt failed: %s", SDL_GetError());
	}

	if (SDL_SetTextureBlendMode(crt_tex, SDL_BLENDMODE_BLEND) < 0) {
		fail("SDL_SetTextureBlendMode() crt failed: %s", SDL_GetError());
	}

	uint32_t *crt_pix = malloc(WIN_W * WIN_H * sizeof (uint32_t));

	for (int32_t y = 0; y < WIN_H; ++y) {
		uint32_t v = (y & 1) ? 0x00000028 : 0x00000000;

		for (int32_t x = 0; x < WIN_W; ++x) {
			crt_pix[y * WIN_W + x] = v;
		}
	}

	SDL_UpdateTexture(crt_tex, NULL, crt_pix, WIN_W * (int32_t)sizeof (uint32_t));
	free(crt_pix);
#endif

	SDL_AtomicSet(&frame, 1);
}

void vid_quit(void)
{
	ver("vid quit");

	SDL_DestroyTexture(glow_rt);
	SDL_DestroyTexture(scene_rt);
	SDL_DestroyTexture(crt_tex);
	SDL_DestroyTexture(tex);
	SDL_DestroyRenderer(ren);
	SDL_DestroyWindow(win);
}

bool vid_exec(void)
{
	ver3("vid exec");

	static int32_t skip = 99999;
	static int32_t line = 99999;

	if (++skip < 10) {
		ver3("vid skip %d", skip);
		return false;
	}

	skip = 0;
	int32_t vcr0 = mem[REG_VCR0];

	if ((vcr0 & VCR0_DEN) == 0) {
		ver3("vid dis");
		return false;
	}

	if (++line < SCR_H + VBL_H) {
		ver3("vid line %d", line);

		if (line < SCR_H) {
			++mem[REG_ATBAC];
		}

		return line == SCR_H;
	}

	// We get here every 4,000 invocations -> 25 fps.

	ver2("vid frame");
	line = 0;

	int32_t dsba = mem[REG_DSBA];
	bank = ((dsba & DSBA_BS0) != 0 ? 1 : 0) + ((dsba & DSBA_BS1) != 0 ? 2 : 0);

	int32_t rwba = mem[REG_RWBA];
	reg_off = (rwba & 0xfff0) << 1;

	int32_t atba = mem[REG_ATBA];
	mem[REG_ATBAC] = (uint16_t)atba;

	int32_t odtba = mem[REG_ODTBA] & 0xffc0;

	n_objs = 0;

	for (int32_t i = 0; i < 16; ++i) {
		int32_t flips[SCR_H];
		int32_t n_flips = 0;

		uint16_t *od = mem + odtba + 4 * i;

		if ((od[0] & OD0_BLA) != 0) {
			ver3("vid obj %d blanked", i);
			continue;
		}

		int32_t w64 = (od[1] & 0xfc00) >> 10;

		if (w64 == 0) {
			ver3("vid obj %d empty", i);
			continue;
		}

		int32_t mask = 1 << i;

		for (int32_t k = 0; k < SCR_H; ++k) {
			if ((mem[atba + k] & mask) == 0) {
				flips[n_flips] = k;
				++n_flips;
			}
		}

		if (n_flips == 0) {
			ver3("vid obj %d unused", i);
			continue;
		}

		if (n_flips % 2 != 0) {
			flips[n_flips] = SCR_H;
			++n_flips;
		}

		bool cb = (od[0] & OD0_CB) != 0;
		bool tde = (od[0] & OD0_TDE) != 0;

		int32_t x = (od[1] & 0x03ff) * 2;
		int32_t off, fon_h, w;

		if (cb) {
			off = od[2];
			int32_t vcr1 = mem[REG_VCR1];
			fon_h = (vcr1 & 0xf000) >> 12;
			w = w64 * 4 / 3 * 2 * 8;
		}
		else {
			off = ((od[0] & 0x00c0) << 10) | od[2];
			fon_h = -1;
			w = w64 * 16;
		}

		obj_t *obj = objs + n_objs;

		obj->x = x;
		obj->w = w;
		obj->n_vers = n_flips / 2;

		for (int32_t k = 0; k < obj->n_vers; ++k) {
			obj->vers[k].y = flips[2 * k];
			obj->vers[k].h = flips[2 * k + 1] - flips[2 * k];
		}

		obj->mem = mem + off;
		obj->tran = tde;
		obj->fon_h = fon_h;

		ver2("vid obj %d %c %c %d:%d %d+%d %d 0x%05x",
				i, cb ? 'c' : 'b', tde ? 't' : '-', flips[0], flips[1], x, w, fon_h, off);

		++n_objs;
	}

	SDL_AtomicAdd(&frame, 1);
	return false;
}

uint32_t vid_read(uint32_t off, int32_t sz)
{
	ver2("vid rd %d 0x%05x:%d", bank, off, sz * 8);

	int32_t off16 = (int32_t)(off / 2);

	if (sz != 2 || bank >= N_BANKS || off % 2 != 0 || off16 >= WIN_SZ_W) {
		fail("invalid vid rd %d %u:%d", bank, off, sz * 8);
	}

	if (off16 >= reg_off && off16 < reg_off + 16) {
		return mem[off16 - reg_off];
	}

	return mem[bank * WIN_SZ_W + off16];
}

void vid_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("vid wr %d 0x%05x:%d 0x%0*x", bank, off, sz * 8, sz * 2, val);

	int32_t off16 = (int32_t)(off / 2);

	if (sz != 2 || bank >= N_BANKS || off % 2 != 0 || (off16 >= WIN_SZ_W && off16 != PAL_OFF)) {
		fail("invalid vid wr %d %u:%d", bank, off, sz * 8);
	}

	if (off16 == PAL_OFF) {
		int32_t i_pal = ((int32_t)val & 0x03c0) >> 6;

		uint32_t r = ((val & 0x0004) >> 1) | ((val & 0x0020) >> 5);
		uint32_t g = ((val & 0x0002) >> 0) | ((val & 0x0010) >> 4);
		uint32_t b = ((val & 0x0001) << 1) | ((val & 0x0008) >> 3);

		r = (r ^ 3) * 85;
		g = (g ^ 3) * 85;
		b = (b ^ 3) * 85;

		pal[i_pal] = (r << 24) | (g << 16) | (b << 8) | 0xff;
		return;
	}

	if (off16 >= reg_off && off16 < reg_off + 16) {
		mem[off16 - reg_off] = (uint16_t)val;
		return;
	}

	mem[bank * WIN_SZ_W + off16] = (uint16_t)val;
}
