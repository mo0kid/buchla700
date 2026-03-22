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

typedef struct {
	const char *name;
	int32_t *flag;
} verb_flag_t;

static verb_flag_t verb_flags[] = {
	{ "sdl", &sdl_verbose },
	{ "gdb", &gdb_verbose },
	{ "cpu", &cpu_verbose },
	{ "fpu", &fpu_verbose },
	{ "vid", &vid_verbose },
	{ "tim", &tim_verbose },
	{ "lcd", &lcd_verbose },
	{ "ser", &ser_verbose },
	{ "mid", &mid_verbose },
	{ "fdd", &fdd_verbose },
	{ "snd", &snd_verbose },
	{ "led", &led_verbose },
	{ "kbd", &kbd_verbose },
	{ "osc", &osc_verbose }
};

const char *bios = "bios.abs";
const char *disk = "buchla.disk";
const char *font = "vera.ttf";

uint32_t mid_port = 0;
bool autoboot = false;

SDL_atomic_t run;

static void usage(FILE *fh)
{
	fprintf(fh, "usage: buchla [-h] [-a] [-t] [-v comp [-v comp [...]]] [-b bios] [-d disk] [-f font] [-m port]\n");
	fprintf(fh, "with\n");
	fprintf(fh, "  comp - one of: ");

	for (int32_t i = 0; i < ARRAY_COUNT(verb_flags); ++i) {
		fprintf(fh, "%s, ", verb_flags[i].name);
	}

	fprintf(fh, "all\n");
	fprintf(fh, "  bios - BIOS ROM file (default: bios.abs)\n");
	fprintf(fh, "  disk - disk image file (default: buchla.disk)\n");
	fprintf(fh, "  font - console and LCD font (default: vera.ttf)\n");
	fprintf(fh, "  -a   - auto-boot MIDAS VII (sends 'r' then 'go $10000')\n");
	fprintf(fh, "  -t   - play a 440 Hz test tone (verifies audio path)\n");
	fprintf(fh, "  port - number of the desired MIDI port (default: 0)\n");
	fprintf(fh, "         \"list\" instead of a port number lists available ports\n");
}

static void parse_args(int32_t argc, char *argv[])
{
	for (int32_t i = 0; i < argc; ++i) {
		if (strcmp(argv[i], "-h") == 0) {
			usage(stdout);
			exit(0);
		}

		if (strcmp(argv[i], "-a") == 0) {
			autoboot = true;
			continue;
		}

		if (strcmp(argv[i], "-t") == 0) {
			dsp_test_tone = true;
			continue;
		}

		if (strcmp(argv[i], "-b") == 0) {
			if (++i == argc) {
				usage(stderr);
				fprintf(stderr, "missing argument to -b\n");
				exit(1);
			}

			bios = argv[i];
			continue;
		}

		if (strcmp(argv[i], "-d") == 0) {
			if (++i == argc) {
				usage(stderr);
				fprintf(stderr, "missing argument to -d\n");
				exit(1);
			}

			disk = argv[i];
			continue;
		}

		if (strcmp(argv[i], "-f") == 0) {
			if (++i == argc) {
				usage(stderr);
				fprintf(stderr, "missing argument to -f\n");
				exit(1);
			}

			font = argv[i];
			continue;
		}

		if (strcmp(argv[i], "-v") == 0) {
			if (++i == argc) {
				usage(stderr);
				fprintf(stderr, "missing argument to -v\n");
				exit(1);
			}

			int32_t k;

			if (strcmp(argv[i], "all") == 0) {
				for (k = 0; k < ARRAY_COUNT(verb_flags); ++k) {
					++*verb_flags[k].flag;
				}

				continue;
			}

			for (k = 0; k < ARRAY_COUNT(verb_flags); ++k) {
				if (strcmp(argv[i], verb_flags[k].name) == 0) {
					++*verb_flags[k].flag;
					break;
				}
			}

			if (k == ARRAY_COUNT(verb_flags)) {
				usage(stderr);
				fprintf(stderr, "invalid argument to -v: %s\n", argv[i]);
				exit(1);
			}

			continue;
		}

		if (strcmp(argv[i], "-m") == 0) {
			if (++i == argc) {
				usage(stderr);
				fprintf(stderr, "missing argument to -m\n");
				exit(1);
			}

			if (strcmp(argv[i], "list") == 0) {
				mid_list();
				exit(0);
			}

			char *end;
			int64_t tmp = strtol(argv[i], &end, 10);

			if (*end != 0 || tmp < 0 || tmp > 15) {
				usage(stderr);
				fprintf(stderr, "invalid argument to -m: %s\n", argv[i]);
				exit(1);
			}

			mid_port = (uint32_t)tmp;
			continue;
		}
	}
}

static int32_t cpu_thread(void *data)
{
	(void)data;

	cpu_loop();
	return 0;
}

static int32_t gdb_thread(void *data)
{
	(void)data;

	gdb_loop();
	return 0;
}

static int32_t osc_thread(void *data)
{
	(void)data;

	osc_loop();
	return 0;
}

int32_t main(int32_t argc, char *argv[])
{
	parse_args(argc, argv);
	sdl_init();
	gdb_init();
	cpu_init();
	osc_init();

	SDL_AtomicSet(&run, 1);
	SDL_Thread *thr_cpu = SDL_CreateThread(cpu_thread, "cpu", NULL);

	if (thr_cpu == NULL) {
		fail("SDL_CreateThread() failed: %s", SDL_GetError());
	}

	SDL_Thread *thr_gdb = SDL_CreateThread(gdb_thread, "gdb", NULL);

	if (thr_gdb == NULL) {
		fail("SDL_CreateThread() failed: %s", SDL_GetError());
	}

	SDL_Thread *thr_osc = SDL_CreateThread(osc_thread, "osc", NULL);

	if (thr_osc == NULL) {
		fail("SDL_CreateThread() failed: %s", SDL_GetError());
	}

	sdl_loop();

	SDL_WaitThread(thr_cpu, NULL);
	SDL_WaitThread(thr_gdb, NULL);
	SDL_WaitThread(thr_osc, NULL);

	osc_quit();
	cpu_quit();
	gdb_quit();
	sdl_quit();
	return 0;
}
