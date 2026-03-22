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

int32_t sdl_verbose = 0;

#define ver(...) _ver(sdl_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(sdl_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(sdl_verbose, 2, __VA_ARGS__)

typedef void (*sdl_func_t)(void);

static sdl_func_t sdl_funcs[] = {
	lcd_sdl, ser_sdl, vid_sdl
};

void sdl_init(void)
{
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_TIMER | SDL_INIT_AUDIO) < 0) {
		fprintf(stderr, "SDL_Init() failed: %s\n", SDL_GetError());
		exit(1);
	}

	SDL_LogSetPriority(SDL_LOG_CATEGORY_APPLICATION, SDL_LOG_PRIORITY_VERBOSE);

	if (SDLNet_Init() < 0) {
		fail("SDLNet_Init() failed: %s", SDLNet_GetError());
	}

	if (TTF_Init() < 0) {
		fail("TTF_Init() failed: %s", TTF_GetError());
	}

	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");
	SDL_StartTextInput();
}

void sdl_quit(void)
{
	TTF_Quit();
	SDLNet_Quit();
	SDL_Quit();
}

void sdl_loop(void)
{
	inf("entering SDL loop");

#if defined EMU_LINUX
	SDL_Scancode down = SDL_SCANCODE_UNKNOWN;
#endif

	bool rel_mod = false;
	uint32_t win = 0;
	int32_t boot_tick = autoboot ? 0 : -1;

	while (SDL_AtomicGet(&run) != 0) {
		for (int32_t i = 0; i < ARRAY_COUNT(sdl_funcs); ++i) {
			sdl_funcs[i]();
		}

		SDL_Event ev;

		while (SDL_PollEvent(&ev) > 0) {
			ver2("sdl ev %d", ev.type);

#if defined EMU_LINUX
			// Work around duplicate key-down events on Linux.

			if (ev.type == SDL_KEYDOWN) {
				if (down == ev.key.keysym.scancode) {
					ver2("sdl dedup: skip %d", (int32_t)down);
					continue;
				}

				down = ev.key.keysym.scancode;
				ver2("sdl dedup: %d", (int32_t)down);
			}
			else if (ev.type == SDL_KEYUP) {
				down = SDL_SCANCODE_UNKNOWN;
				ver2("sdl dedup: reset");
			}
#endif

			if (ev.type == SDL_QUIT ||
					(ev.type == SDL_KEYDOWN && ev.key.keysym.sym == SDLK_ESCAPE)) {
				inf("quit event");
				SDL_AtomicSet(&run, 0);
				continue;
			}

			if (ev.type == SDL_KEYDOWN && ev.key.keysym.sym == SDLK_f &&
					(ev.key.keysym.mod & KMOD_GUI) != 0) {
				SDL_Window *vw = SDL_GetWindowFromID(vid_win);

				if (vw != NULL) {
					uint32_t flags = SDL_GetWindowFlags(vw);

					if (flags & SDL_WINDOW_FULLSCREEN_DESKTOP) {
						SDL_SetWindowFullscreen(vw, 0);
						inf("fullscreen off");
					}
					else {
						SDL_SetWindowFullscreen(vw, SDL_WINDOW_FULLSCREEN_DESKTOP);
						inf("fullscreen on");
					}
				}

				continue;
			}

			if (ev.type == SDL_DROPFILE) {
				char *path = ev.drop.file;
				inf("drop file: %s", path);

				if (SDL_LockMutex(cpu_mutex) < 0) {
					fail("SDL_LockMutex() failed: %s", SDL_GetError());
				}

				if (fdd_swap(path)) {
					inf("DISK SWAPPED: %s", path);
				}
				else {
					err("DISK SWAP FAILED: %s", path);
				}

				if (SDL_UnlockMutex(cpu_mutex) < 0) {
					fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
				}

				SDL_free(path);
				continue;
			}

			if (ev.type == SDL_KEYDOWN && ev.key.keysym.sym == SDLK_F5) {
#if defined EMU_OS_X
				char *path = dlg_open_disk();

				if (path != NULL) {
					if (SDL_LockMutex(cpu_mutex) < 0) {
						fail("SDL_LockMutex() failed: %s", SDL_GetError());
					}

					if (fdd_swap(path)) {
						inf("DISK SWAPPED: %s", path);
					}
					else {
						err("DISK SWAP FAILED: %s", path);
					}

					if (SDL_UnlockMutex(cpu_mutex) < 0) {
						fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
					}

					free(path);
				}
#else
				inf("file dialog not available on this platform");
#endif
				continue;
			}

			if (ev.type == SDL_WINDOWEVENT) {
				if (ev.window.event == SDL_WINDOWEVENT_FOCUS_GAINED) {
					ver("sdl ev win %u", ev.window.windowID);
					win = ev.window.windowID;
				}
			}

			if (ev.type == SDL_KEYDOWN && ev.key.keysym.sym == SDLK_DOWN) {
				ver("sdl ev down-arrow");
				rel_mod = true;
				ser_mou_res();
				continue;
			}

			if (ev.type == SDL_KEYDOWN && ev.key.keysym.sym == SDLK_UP) {
				ver("sdl ev up-arrow");
				rel_mod = false;
				continue;
			}

			if (rel_mod) {
				if (ev.type == SDL_MOUSEMOTION) {
					ver("sdl ev mousemotion (%d, %d)", ev.motion.xrel, ev.motion.yrel);
					ser_mou_mov(&ev.motion);
					continue;
				}

				if (ev.type == SDL_MOUSEBUTTONDOWN) {
					ver("sdl ev mousebuttondown %d", ev.button.button);
					ser_mou_dn(&ev.button);
					continue;
				}

				if (ev.type == SDL_MOUSEBUTTONUP) {
					ver("sdl ev mousebuttonup %d", ev.button.button);
					ser_mou_up(&ev.button);
					continue;
				}
			}

			if (ev.type == SDL_TEXTINPUT) {
				ver("sdl ev text input %d", ev.text.text[0]);

				if (win == ser_win) {
					ser_text(&ev.text);
				}

				continue;
			}

			if (ev.type == SDL_KEYDOWN) {
				ver("sdl ev key down %d", (int32_t)ev.key.keysym.sym);

				if (win == ser_win) {
					ser_key(&ev.key);
				}
				else if (win == vid_win) {
					kbd_key(&ev.key, true, true);
				}
				else if (win == lcd_win) {
					kbd_key(&ev.key, false, true);
				}

				continue;
			}

			if (ev.type == SDL_KEYUP) {
				ver("sdl ev key up %d", (int32_t)ev.key.keysym.sym);

				if (win == vid_win) {
					kbd_key(&ev.key, true, false);
				}
				else if (win == lcd_win) {
					kbd_key(&ev.key, false, false);
				}

				continue;
			}
		}

		if (boot_tick >= 0) {
			++boot_tick;

			if (boot_tick == 30) {
				// Force nflops = 1 in BIOS RAM in case flopini
				// failed during boot.  Address from rwabs7's
				// tst.w instruction in the BIOS binary.
				cpu_poke(0x0e06, 0);
				cpu_poke(0x0e07, 1);

				// Disable verify-after-write (fverify = 0).
				// The emulated FDD always writes correctly so
				// verification is unnecessary and slows writes
				// significantly due to retry overhead.
				cpu_poke(0x0e18, 0);
				cpu_poke(0x0e19, 0);

				inf("patched BIOS RAM: nflops=1, fverify=0");

				/* Install analog FIFO handler at 0x9000.
				 *
				 * FIFO buffer: 0x9080 (16 words)
				 * Head (read):  0x90A0 (word, 0-15)
				 * Tail (write): 0x90A2 (word, 0-15)
				 *
				 * Handler checks trap 14 func 8.  If FIFO has
				 * data (head != tail), pops next value into D0
				 * and RTEs.  Otherwise falls to original handler.
				 */
				uint32_t orig = ((uint32_t)cpu_peek(0xB8) << 24) |
						((uint32_t)cpu_peek(0xB9) << 16) |
						((uint32_t)cpu_peek(0xBA) << 8) |
						((uint32_t)cpu_peek(0xBB));

				uint16_t code[] = {
				/* 0x9000 */ 0x0C6F, 0x0008, 0x0006, /* cmpi.w #8,6(sp)    */
				/* 0x9006 */ 0x6634,                 /* bne.s  .orig        */
				/* 0x9008 */ 0x2F01,                 /* move.l d1,-(sp)     */
				/* 0x900A */ 0x3039, 0x0000, 0x90A0, /* move.w ($90A0).l,d0 */
				/* 0x9010 */ 0x3239, 0x0000, 0x90A2, /* move.w ($90A2).l,d1 */
				/* 0x9016 */ 0xB041,                 /* cmp.w  d1,d0        */
				/* 0x9018 */ 0x6720,                 /* beq.s  .empty       */
				/* 0x901A */ 0xD040,                 /* add.w  d0,d0        */
				/* 0x901C */ 0x41F9, 0x0000, 0x9080, /* lea ($9080).l,a0   */
				/* 0x9022 */ 0x3230, 0x0000,         /* move.w (a0,d0.w),d1*/
				/* 0x9026 */ 0xE248,                 /* lsr.w  #1,d0        */
				/* 0x9028 */ 0x5240,                 /* addq.w #1,d0        */
				/* 0x902A */ 0x0240, 0x000F,         /* andi.w #15,d0       */
				/* 0x902E */ 0x33C0, 0x0000, 0x90A0, /* move.w d0,($90A0).l*/
				/* 0x9034 */ 0x3001,                 /* move.w d1,d0        */
				/* 0x9036 */ 0x221F,                 /* move.l (sp)+,d1     */
				/* 0x9038 */ 0x4E73,                 /* rte                 */
				/* .empty: */
				/* 0x903A */ 0x221F,                 /* move.l (sp)+,d1     */
				/* .orig:  */
				/* 0x903C */ 0x4EF9,                 /* jmp    xxxx.l       */
				/* 0x903E */ (uint16_t)(orig >> 16),
				/* 0x9040 */ (uint16_t)(orig & 0xFFFF)
				};

				for (int i = 0; i < (int)(sizeof code / sizeof code[0]); ++i) {
					cpu_poke(0x9000 + i * 2, (uint8_t)(code[i] >> 8));
					cpu_poke(0x9000 + i * 2 + 1, (uint8_t)(code[i] & 0xFF));
				}

				/* clear FIFO */
				cpu_poke(0x90A0, 0); cpu_poke(0x90A1, 0);
				cpu_poke(0x90A2, 0); cpu_poke(0x90A3, 0);

				/* patch trap 14 vector */
				cpu_poke(0xB8, 0x00);
				cpu_poke(0xB9, 0x00);
				cpu_poke(0xBA, 0x90);
				cpu_poke(0xBB, 0x00);

				inf("installed analog FIFO handler at 0x9000, orig=0x%08x", orig);
			}
			else if (boot_tick == 40) {
				inf("autoboot: sending 'r'");
				ser_type("r\r");
			}
			else if (boot_tick == 80) {
				inf("autoboot: sending 'go $10000'");
				ser_type("go $10000\r");
			}
			else if (boot_tick == 200) {
				/* Scan BSS for valents[] after MIDAS init */
				uint32_t found = 0;

				for (uint32_t a = 0x5F6A0; a < 0xF0000; a += 2) {
					uint32_t v0 =
						((uint32_t)cpu_peek(a) << 24) |
						((uint32_t)cpu_peek(a + 1) << 16) |
						((uint32_t)cpu_peek(a + 2) << 8) |
						((uint32_t)cpu_peek(a + 3));

					if (v0 == a) {
						uint32_t v1 =
							((uint32_t)cpu_peek(a + 10) << 24) |
							((uint32_t)cpu_peek(a + 11) << 16) |
							((uint32_t)cpu_peek(a + 12) << 8) |
							((uint32_t)cpu_peek(a + 13));

						if (v1 == a + 10) {
							uint32_t v2 =
								((uint32_t)cpu_peek(a + 20) << 24) |
								((uint32_t)cpu_peek(a + 21) << 16) |
								((uint32_t)cpu_peek(a + 22) << 8) |
								((uint32_t)cpu_peek(a + 23));

							if (v2 == a + 20) {
								found = a;
								break;
							}
						}
					}
				}

				if (found) {
					inf("valents[] at 0x%08x", found);
				}
				else {
					inf("valents[] NOT found");
				}

				boot_tick = -1;
			}
		}

		SDL_Delay(50);

		if (SDL_GetRelativeMouseMode() != rel_mod) {
			SDL_SetRelativeMouseMode(rel_mod);

			if (rel_mod) {
				inf("MOUSE CAPTURED - press UP-ARROW KEY to release");
			}
			else {
				inf("mouse released");
			}
		}
	}

	inf("leaving SDL loop");
}
