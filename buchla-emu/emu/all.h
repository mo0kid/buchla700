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
 *  "gpl-v3.txt" in the top directory of this repository.
 */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#if defined(__x86_64__) || defined(__i386__)
#include <xmmintrin.h>
#else
static inline void _mm_pause(void) {
#if defined(__aarch64__)
	__asm__ volatile("yield");
#endif
}
#endif

#include <m68k.h>

#include <SDL2/SDL.h>
#include <SDL2/SDL_net.h>
#include <SDL2/SDL_ttf.h>

// XXX - work around RtMidi's C++-isms; remove when fixed in RtMidi

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wstrict-prototypes"

typedef struct RtMidiWrapper RtMidiWrapper;

#include <rtmidi/rtmidi_c.h>

#pragma GCC diagnostic pop

#define inf(...) SDL_LogInfo(SDL_LOG_CATEGORY_APPLICATION, __VA_ARGS__);
#define err(...) SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, __VA_ARGS__);

#define _ver(_v, _t, ...) { \
	if (_v > _t) { \
		SDL_LogVerbose(SDL_LOG_CATEGORY_APPLICATION, __VA_ARGS__); \
	} \
}

#define fail(...) { \
	SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, __VA_ARGS__); \
	exit(1); \
}

#define ARRAY_COUNT(_a) (int32_t)(sizeof (_a) / sizeof (_a)[0])

extern int32_t sdl_verbose;
extern int32_t gdb_verbose;
extern int32_t cpu_verbose;
extern int32_t fpu_verbose;
extern int32_t vid_verbose;
extern int32_t tim_verbose;
extern int32_t lcd_verbose;
extern int32_t ser_verbose;
extern int32_t mid_verbose;
extern int32_t fdd_verbose;
extern int32_t snd_verbose;
extern int32_t led_verbose;
extern int32_t kbd_verbose;
extern int32_t osc_verbose;

extern const char *bios;
extern const char *disk;
extern const char *font;

extern uint32_t mid_port;
extern bool dsp_test_tone;
extern bool autoboot;

extern SDL_atomic_t run;

extern uint32_t vid_win;
extern uint32_t ser_win;
extern uint32_t lcd_win;

extern void sdl_init(void);
extern void sdl_quit(void);
extern void sdl_loop(void);

extern void gdb_init(void);
extern void gdb_quit(void);
extern void gdb_loop(void);
extern void gdb_inst(bool bp);

extern SDL_mutex *cpu_mutex;

extern void cpu_init(void);
extern void cpu_quit(void);
extern void cpu_loop(void);

extern uint8_t cpu_peek(int32_t addr);
extern void cpu_poke(int32_t addr, uint8_t val);
extern void cpu_analog(int32_t sig, int32_t val);
extern double fpu_time_scale;

extern void fpu_init(void);
extern void fpu_quit(void);
extern bool fpu_exec(void);
extern uint32_t fpu_read(uint32_t off, int32_t sz);
extern void fpu_write(uint32_t off, int32_t sz, uint32_t val);

extern void vid_init(void);
extern void vid_quit(void);
extern bool vid_exec(void);
extern uint32_t vid_read(uint32_t off, int32_t sz);
extern void vid_write(uint32_t off, int32_t sz, uint32_t val);

extern void vid_sdl(void);

extern void tim_init(void);
extern void tim_quit(void);
extern bool tim_exec(void);
extern uint32_t tim_read(uint32_t off, int32_t sz);
extern void tim_write(uint32_t off, int32_t sz, uint32_t val);

extern void lcd_init(void);
extern void lcd_quit(void);
extern bool lcd_exec(void);
extern uint32_t lcd_read(uint32_t off, int32_t sz);
extern void lcd_write(uint32_t off, int32_t sz, uint32_t val);

extern void lcd_sdl(void);
extern void lcd_get_row(int32_t row, char *buf, int32_t buf_sz);
extern void lcd_get_bars(float *bars, int32_t n_bars);

extern void ser_init(void);
extern void ser_quit(void);
extern bool ser_exec(void);
extern uint32_t ser_read(uint32_t off, int32_t sz);
extern void ser_write(uint32_t off, int32_t sz, uint32_t val);

extern void ser_sdl(void);
extern void ser_text(SDL_TextInputEvent *ev);
extern void ser_key(SDL_KeyboardEvent *ev);

extern void ser_mou_res(void);
extern void ser_mou_mov(SDL_MouseMotionEvent *ev);
extern void ser_mou_dn(SDL_MouseButtonEvent *ev);
extern void ser_mou_up(SDL_MouseButtonEvent *ev);
extern void ser_type(const char *str);

extern void mid_init(void);
extern void mid_quit(void);
extern bool mid_exec(void);
extern uint32_t mid_read(uint32_t off, int32_t sz);
extern void mid_write(uint32_t off, int32_t sz, uint32_t val);
extern void mid_list(void);

extern void fdd_init(void);
extern void fdd_quit(void);
extern bool fdd_exec(void);
extern uint32_t fdd_read(uint32_t off, int32_t sz);
extern void fdd_write(uint32_t off, int32_t sz, uint32_t val);

extern void fdd_set_side(int32_t sid);
extern void fdd_set_sel(int32_t sel);
extern bool fdd_swap(const char *path);
extern void fdd_eject(void);

#if defined EMU_OS_X
extern char *dlg_open_disk(void);
#endif

extern void snd_init(void);
extern void snd_quit(void);
extern bool snd_exec(void);
extern uint32_t snd_read(uint32_t off, int32_t sz);
extern void snd_write(uint32_t off, int32_t sz, uint32_t val);

extern void dsp_init(void);
extern void dsp_render(float *buf, int32_t frames);
extern void eq_set_band(int32_t band, int32_t channel, double gain_db);

extern void led_init(void);
extern void led_quit(void);
extern bool led_exec(void);
extern uint32_t led_read(uint32_t off, int32_t sz);
extern void led_write(uint32_t off, int32_t sz, uint32_t val);

extern void kbd_init(void);
extern void kbd_quit(void);
extern bool kbd_exec(void);
extern uint32_t kbd_read(uint32_t off, int32_t sz);
extern void kbd_write(uint32_t off, int32_t sz, uint32_t val);

extern void kbd_key(SDL_KeyboardEvent *ev, bool vid, bool dn);

extern void kbd_osc_key_touch(int32_t sig, int32_t val);
extern void kbd_osc_key_off(int32_t sig);
extern void kbd_osc_but_on(int32_t sig);
extern void kbd_osc_but_off(int32_t sig);
extern void kbd_osc_slid(int32_t sig, bool on, int32_t val);

extern void ser_osc_mou(int32_t dx, int32_t dy, bool down);

extern void osc_init(void);
extern void osc_quit(void);
extern void osc_loop(void);
extern void osc_send_status(const char *status);
extern void osc_send_fader(int32_t index, float value);
