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

#define ver(...) _ver(fdd_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(fdd_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(fdd_verbose, 2, __VA_ARGS__)

int32_t fdd_verbose = 0;

#define N_CYL 80
#define N_SID 2
#define N_SEC 9
#define SZ_SEC 512

#define SZ_DISK (N_CYL * N_SID * N_SEC * SZ_SEC)

#define REG_COM_STAT 0
#define REG_TRA 1
#define REG_SEC 2
#define REG_DAT 3

#define COM_REST 0x00
#define COM_SEEK 0x10
#define COM_SEEK_VER 0x14
#define COM_RD_SEC 0x80
#define COM_RD_SEC_MUL 0x90
#define COM_WR_SEC_WP 0xa0
#define COM_WR_SEC 0xa2
#define COM_INT 0xd0
#define COM_WR_TRA_WP 0xf0
#define COM_WR_TRA 0xf2

#define COM_LAT_CYC 5
#define COM_EXE_CYC 5

typedef enum {
	STEP_IDLE,
	STEP_PREP,
	STEP_EXEC
} step_t;

typedef struct {
	int32_t reg_tra;
	int32_t reg_sec;
	int32_t reg_dat;
	int32_t sid;
	step_t step;
	int32_t com;
	int32_t cyc;
	uint8_t *dat;
	bool tra_0;
} state_t;

static state_t state = {
		.reg_tra = 0, .reg_sec = 0, .reg_dat = 0, .sid = 0,
		.step = STEP_IDLE, .com = -1, .cyc = 0, .dat = NULL, .tra_0 = false
};

static uint8_t image[SZ_DISK];
static char *cur_disk = NULL;

#define SZ_TRACK (N_SEC * SZ_SEC)
#define FMT_TRACK_BYTES 8000

typedef enum {
	FMT_SCAN,
	FMT_ID,
	FMT_DATA
} fmt_state_t;

static fmt_state_t fmt_st;
static int32_t fmt_marks;
static int32_t fmt_pos;
static int32_t fmt_count;
static int32_t fmt_sec;
static uint8_t *fmt_dat;

static const char *com_string(int32_t com)
{
	switch (com & 0xf0) {
	case 0x00:
		return "RESTORE";
	case 0x10:
		return "SEEK";
	case 0x80:
		return "RD_SEC";
	case 0x90:
		return "RD_SEC_MUL";
	case 0xa0:
	case 0xb0:
		return "WR_SEC";
	case 0xd0:
		return "INT";
	case 0xe0:
	case 0xf0:
		return "WR_TRA";
	default:
		return "???";
	}
}

static void stat_string(int32_t stat, char *buff) {
	buff[0] = 0;

	if ((stat & 0x80) != 0) {
		strcat(buff, " mot_on");
	}

	if ((stat & 0x04) != 0) {
		strcat(buff, " zero");
	}

	if ((stat & 0x02) != 0) {
		strcat(buff, " dat_req");
	}

	if ((stat & 0x01) != 0) {
		strcat(buff, " busy");
	}
}

void fdd_set_side(int32_t sid)
{
	ver2("sid <- %d", sid);
	state.sid = sid;
}

void fdd_set_sel(int32_t sel)
{
	ver2("sel <- %d", sel);
}

static void fix_serial(void)
{
	// The BIOS rwabs serial-number check has a d7-doubling bug in its
	// indexed addressing: it compares boot-sector bytes at offsets
	// 8, 10, 12 against BPB[28..30], but getbpb stores from offsets
	// 8, 9, 10.  To make both paths consistent, set the serial bytes
	// (offsets 8, 9, 10) equal to the value at offset 12 (the high
	// byte of BPB bytes_per_sector, normally 0x02).  This way every
	// comparison sees the same value regardless of offset mismatch.
	uint8_t v = image[12];
	image[8] = v;
	image[9] = v;
	image[10] = v;
}

static bool fdd_load(const char *path)
{
	inf("reading disk image file %s", path);

	SDL_RWops *ops = SDL_RWFromFile(path, "rb");

	if (ops == NULL) {
		err("error while opening disk image file %s for reading", path);
		return false;
	}

	Sint64 sz = SDL_RWsize(ops);

	if (sz != SZ_DISK) {
		err("invalid disk image size %lld (expected %d) in %s", (long long)sz, SZ_DISK, path);
		SDL_RWclose(ops);
		return false;
	}

	size_t loaded = 0;

	while (loaded < SZ_DISK) {
		size_t n_rd = SDL_RWread(ops, image + loaded, 1, SZ_DISK - loaded);

		if (n_rd == 0) {
			err("error while reading disk image file %s", path);
			SDL_RWclose(ops);
			return false;
		}

		loaded += n_rd;
	}

	SDL_RWclose(ops);
	return true;
}

void fdd_init(void)
{
	ver("fdd init");

	if (!fdd_load(disk)) {
		fail("cannot load disk image file %s", disk);
	}

	fix_serial();
	cur_disk = SDL_strdup(disk);
}

static void fdd_save(void)
{
	if (cur_disk == NULL) {
		return;
	}

	inf("writing disk image file %s", cur_disk);

	SDL_RWops *ops = SDL_RWFromFile(cur_disk, "wb");

	if (ops == NULL) {
		err("error while opening disk image file %s for writing", cur_disk);
		return;
	}

	size_t stored = 0;

	while (stored < SZ_DISK) {
		size_t n_wr = SDL_RWwrite(ops, image + stored, 1, SZ_DISK - stored);

		if (n_wr == 0) {
			err("error while writing disk image file %s", cur_disk);
			SDL_RWclose(ops);
			return;
		}

		stored += n_wr;
	}

	SDL_RWclose(ops);
}

void fdd_quit(void)
{
	ver("fdd quit");
	fdd_save();
	SDL_free(cur_disk);
	cur_disk = NULL;
}

bool fdd_swap(const char *path)
{
	fdd_save();

	if (!fdd_load(path)) {
		return false;
	}

	fix_serial();
	SDL_free(cur_disk);
	cur_disk = SDL_strdup(path);

	state.reg_tra = 0;
	state.reg_sec = 0;
	state.reg_dat = 0;
	state.sid = 0;
	state.step = STEP_IDLE;
	state.com = -1;
	state.cyc = 0;
	state.dat = NULL;
	state.tra_0 = true;

	inf("disk swapped to %s", cur_disk);
	return true;
}

void fdd_eject(void)
{
	fdd_save();
	memset(image, 0, SZ_DISK);

	state.reg_tra = 0;
	state.reg_sec = 0;
	state.reg_dat = 0;
	state.sid = 0;
	state.step = STEP_IDLE;
	state.com = -1;
	state.cyc = 0;
	state.dat = NULL;
	state.tra_0 = true;

	inf("disk ejected (%s saved)", cur_disk != NULL ? cur_disk : "none");
}

bool fdd_exec(void)
{
	ver3("fdd exec");

	switch (state.step) {
	case STEP_IDLE:
		break;

	case STEP_PREP:
		ver3("prep %d", state.cyc);
		--state.cyc;

		if (state.cyc == 0) {
			ver2("exec %s", com_string(state.com));
			state.step = STEP_EXEC;
			state.cyc = COM_EXE_CYC;
		}

		break;

	case STEP_EXEC:
		ver3("exec %d", state.cyc);
		--state.cyc;

		if (state.cyc == 0) {
			ver2("idle %s", com_string(state.com));
			state.step = STEP_IDLE;
		}

		break;
	}

	return false;
}

uint32_t fdd_read(uint32_t off, int32_t sz)
{
	ver3("fdd rd %u:%d", off, sz * 8);

	if (sz != 1 || off > 3) {
		fail("invalid fdd rd %u:%d", off, sz * 8);
	}

	uint32_t rv;

	switch (off) {
	case REG_COM_STAT:
		rv = 0x80; // motor on

		if (state.step == STEP_EXEC) {
			rv |= 0x01; // busy

			if (state.com >= 0x80) {
				rv |= 0x02; // data request (Type II/III commands)
			}
		}

		if (state.tra_0 && state.com < 0x80) {
			rv |= 0x04; // track zero (Type I commands only)
		}

		char stat[100];
		stat_string((int32_t)rv, stat);
		ver3("stat -> 0x%02x%s", rv, stat);

		if (state.step == STEP_IDLE && state.com >= 0x80 && (rv & 0x5c) != 0) {
			inf("status error: com=0x%02x stat=0x%02x%s", state.com, rv, stat);
		}

		break;

	case REG_TRA:
		rv = (uint32_t)state.reg_tra;
		ver2("tra -> %u", rv);
		break;

	case REG_SEC:
		rv = (uint32_t)state.reg_sec;
		ver2("sec -> %u", rv);
		break;

	case REG_DAT:
		if (state.step != STEP_EXEC ||
				((state.com & 0xe0) != 0x80)) {
			fail("unexpected data register read (com=0x%02x step=%d)", state.com, state.step);
		}

		rv = *state.dat;
		int32_t addr = (int32_t)(state.dat - image);

		if ((addr & (SZ_SEC - 1)) == 0) {
			ver2("addr 0x%06x -> 0x%02x", addr, rv);
		}
		else {
			ver3("addr 0x%06x -> 0x%02x", addr, rv);
		}

		++state.dat;
		++addr;

		if ((addr & (SZ_SEC - 1)) == 0 && (state.com & 0xf0) == 0x80) {
			state.step = STEP_IDLE;
			state.cyc = 0;
		}
		else {
			state.cyc = COM_EXE_CYC;
		}

		break;

	default:
		rv = 0;
		break;
	}

	return rv;
}

void fdd_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver3("fdd wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (sz != 1 || off > 3) {
		fail("invalid fdd wr %u:%d", off, sz * 8);
	}

	switch (off) {
	case REG_COM_STAT:
		ver2("com <- 0x%02x, tra %d, sid %d, sec %d",
				val, state.reg_tra, state.sid, state.reg_sec);

		state.com = (int32_t)val;
		int32_t com_type = (int32_t)val & 0xf0;

		ver2("cmd 0x%02x %s tra %d sid %d sec %d dat %d",
				val, com_string(state.com),
				state.reg_tra, state.sid, state.reg_sec, state.reg_dat);
		state.step = STEP_PREP;
		state.cyc = COM_LAT_CYC;

		if (com_type == 0x00) {
			// Restore
			state.reg_tra = 0;
			state.tra_0 = true;
			state.dat = NULL;
		}
		else if (com_type == 0x10) {
			// Seek (with or without verify)
			state.reg_tra = state.reg_dat;
			state.tra_0 = state.reg_tra == 0;
			state.dat = NULL;
		}
		else if (com_type == 0x80 || com_type == 0x90 ||
				com_type == 0xa0 || com_type == 0xb0) {
			// Read/Write Sector
			if (state.reg_tra == 0 && state.sid == 0 && state.reg_sec == 1) {
				fix_serial();
			}

			size_t sec_off = (size_t)(((state.reg_tra * N_SID + state.sid) * N_SEC +
					state.reg_sec - 1) * SZ_SEC);
			state.dat = image + sec_off;
			state.tra_0 = false;

			static int32_t io_count = 0;
			++io_count;
			if ((io_count % 100) == 0) {
				inf("fdd i/o #%d: %s tra %d sid %d sec %d",
						io_count,
						com_type >= 0xa0 ? "WR" : "RD",
						state.reg_tra, state.sid, state.reg_sec);
			}
		}
		else if (com_type == 0xd0) {
			// Force Interrupt
			state.step = STEP_IDLE;
			state.cyc = 0;
			state.dat = NULL;
			state.tra_0 = false;
		}
		else if (com_type == 0xf0 || com_type == 0xe0) {
			// Write Track (format)
			state.tra_0 = false;
			fmt_st = FMT_SCAN;
			fmt_marks = 0;
			fmt_pos = 0;
			fmt_count = FMT_TRACK_BYTES;
			fmt_sec = 0;
			fmt_dat = NULL;
			ver("format tra %d sid %d", state.reg_tra, state.sid);
		}

		break;

	case REG_TRA:
		state.reg_tra = (int32_t)val;
		ver2("tra <- %u", val);
		break;

	case REG_SEC:
		state.reg_sec = (int32_t)val;
		ver2("sec <- %u", val);
		break;

	case REG_DAT:
		if (state.step == STEP_EXEC &&
				((state.com & 0xe0) == 0xa0)) {
			*state.dat = (uint8_t)val;
			int32_t addr = (int32_t)(state.dat - image);

			if ((addr & (SZ_SEC - 1)) == 0) {
				ver2("addr 0x%06x <- 0x%02x", addr, val);
			}
			else {
				ver3("addr 0x%06x <- 0x%02x", addr, val);
			}

			++state.dat;
			++addr;

			if ((addr & (SZ_SEC - 1)) == 0) {
				if (addr == SZ_SEC) {
					fix_serial();
				}

				state.step = STEP_IDLE;
				state.cyc = 0;
			}
			else {
				state.cyc = COM_EXE_CYC;
			}
		}
		else if (state.step == STEP_EXEC &&
				((state.com & 0xf0) == 0xf0 || (state.com & 0xf0) == 0xe0)) {
			--fmt_count;

			switch (fmt_st) {
			case FMT_SCAN:
				if (val == 0xf5) {
					++fmt_marks;
				}
				else {
					if (fmt_marks >= 3 && val == 0xfe) {
						fmt_st = FMT_ID;
						fmt_pos = 0;
						ver2("fmt id mark tra %d sid %d", state.reg_tra, state.sid);
					}
					else if (fmt_marks >= 3 && val == 0xfb) {
						fmt_st = FMT_DATA;
						fmt_pos = 0;

						if (fmt_sec >= 1 && fmt_sec <= N_SEC) {
							size_t sec_off = (size_t)(((state.reg_tra * N_SID + state.sid) *
									N_SEC + fmt_sec - 1) * SZ_SEC);
							fmt_dat = image + sec_off;
							ver2("fmt data sec %d off 0x%06x", fmt_sec, (int32_t)sec_off);
						}
						else {
							fmt_dat = NULL;
							ver("fmt data sec %d out of range", fmt_sec);
						}
					}

					fmt_marks = 0;
				}

				break;

			case FMT_ID:
				if (fmt_pos == 2) {
					fmt_sec = (int32_t)val;
					ver2("fmt id sec %d", fmt_sec);
				}

				if (++fmt_pos >= 4) {
					fmt_st = FMT_SCAN;
				}

				break;

			case FMT_DATA:
				if (fmt_dat != NULL && fmt_pos < SZ_SEC) {
					fmt_dat[fmt_pos] = (uint8_t)val;
				}

				if (++fmt_pos >= SZ_SEC) {
					ver2("fmt data done sec %d", fmt_sec);
					fmt_st = FMT_SCAN;
					fmt_dat = NULL;
				}

				break;
			}

			if (fmt_count <= 0) {
				ver("format done tra %d sid %d", state.reg_tra, state.sid);
				state.step = STEP_IDLE;
				state.cyc = 0;
			}
			else {
				state.cyc = COM_EXE_CYC;
			}
		}
		else {
			state.reg_dat = (int32_t)val;
			ver2("dat <- 0x%02x", val);
		}

		break;

	default:
		break;
	}
}
