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

#define ver(...) _ver(tim_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(tim_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(tim_verbose, 2, __VA_ARGS__)

int32_t tim_verbose = 0;

#define REG_CRX 0
#define REG_CR2_SR 1
#define REG_T1H	2
#define REG_T1L 3
#define REG_T2H 4
#define REG_T2L 5
#define REG_T3H 6
#define REG_T3L 7

#define COUNT_1 32
#define COUNT_2 3200
#define COUNT_3 801

typedef struct {
	bool irq_e;
	bool irq;
	int32_t latch;
	int32_t count;
} state_timer;

static state_timer timers[] = {
		{ .irq_e = false, .irq = false, .latch = COUNT_1, .count = COUNT_1 },
		{ .irq_e = false, .irq = false, .latch = COUNT_2, .count = COUNT_2 },
		{ .irq_e = false, .irq = false, .latch = COUNT_3, .count = COUNT_3 }
};

static bool wr_cr1 = false;
static bool oper = false;

void tim_init(void)
{
	ver("tim init");
}

void tim_quit(void)
{
	ver("tim quit");
}

bool tim_exec(void)
{
	if (oper) {
		for (int32_t i = 0; i < ARRAY_COUNT(timers); ++i) {
			--timers[i].count;

			if (timers[i].count == 0) {
				ver2("tim %d zero", i + 1);

				timers[i].count = timers[i].latch;

				if (timers[i].irq_e) {
					ver2("tim %d irq", i + 1);
					timers[i].irq = true;
				}
			}
		}
	}

	return timers[0].irq || timers[1].irq || timers[2].irq;
}

uint32_t tim_read(uint32_t off, int32_t sz)
{
	ver2("tim rd %u:%d", off, sz * 8);

	if (sz != 1 || off > 7) {
		fail("invalid tim rd %u:%d", off, sz * 8);
	}

	uint32_t rv = 0x00;

	switch (off) {
	case REG_CR2_SR:
		rv |= (uint32_t)timers[0].irq << 0;
		rv |= (uint32_t)timers[1].irq << 1;
		rv |= (uint32_t)timers[2].irq << 2;

		ver2("tim irqs %u %u %u",
				(uint32_t)timers[0].irq, (uint32_t)timers[1].irq, (uint32_t)timers[2].irq);
		break;

	case REG_T1L:
		if (timers[0].irq) {
			ver2("tim 1 !irq");
			timers[0].irq = false;
		}

		break;

	case REG_T2L:
		if (timers[1].irq) {
			ver2("tim 2 !irq");
			timers[1].irq = false;
		}

		break;

	case REG_T3L:
		if (timers[2].irq) {
			ver2("tim 3 !irq");
			timers[2].irq = false;
		}

		break;

	default:
		break;
	}

	return rv;
}

void tim_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("tim wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);

	if (sz != 1 || off > 7) {
		fail("invalid tim wr %u:%d", off, sz * 8);
	}

	switch (off) {
	case REG_CRX:
		if (wr_cr1) {
			if ((val & 0x01) == 0) {
				ver2("tim start");
				oper = true;
			}

			timers[0].irq_e = (val & 0x40) != 0;
		}
		else {
			timers[2].irq_e = (val & 0x40) != 0;
		}

		break;

	case REG_CR2_SR:
		wr_cr1 = (val & 0x01) != 0;
		timers[1].irq_e = (val & 0x40) != 0;
		break;

	default:
		break;
	}
}
