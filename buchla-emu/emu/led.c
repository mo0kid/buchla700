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

#define ver(...) _ver(led_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(led_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(led_verbose, 2, __VA_ARGS__)

int32_t led_verbose = 0;

void led_init(void)
{
	ver("led init");
}

void led_quit(void)
{
	ver("led quit");
}

bool led_exec(void)
{
	ver3("led exec");
	return false;
}

uint32_t led_read(uint32_t off, int32_t sz)
{
	ver2("led rd %u:%d", off, sz * 8);
	return 0;
}

void led_write(uint32_t off, int32_t sz, uint32_t val)
{
	ver2("led wr %u:%d 0x%0*x", off, sz * 8, sz * 2, val);
}
