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

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>

#define DISK_FILE_NAME "buchla.disk"
#define MIDAS_FILE_NAME "midas.abs"

#define N_CYL 80
#define N_SID 2
#define N_SEC 9
#define SZ_SEC 512

#define N_SEC_CLU 2
#define SZ_CLU (SZ_SEC * N_SEC_CLU)

#define N_BOOT_SEC 1
#define N_FAT_SEC 3
#define N_ROOT_SEC 7

#define N_FAT 2
#define SZ_DIR_ENT 32

#define ROOT_SEC (N_BOOT_SEC + N_FAT_SEC * N_FAT)
#define N_META_SEC (ROOT_SEC + N_ROOT_SEC)

static uint8_t midas[1024 * 1024];
static int32_t sz_midas;

static uint8_t disk[N_CYL * N_SID * N_SEC][SZ_SEC];

static int32_t put_sec_8(int32_t sec, int32_t off, int32_t val)
{
	disk[sec][off] = (uint8_t)val;
	return off + 1;
}

static int32_t put_sec_16(int32_t sec, int32_t off, int32_t val)
{
	disk[sec][off + 0] = (uint8_t)(val >> 0);
	disk[sec][off + 1] = (uint8_t)(val >> 8);
	return off + 2;
}

static int32_t put_sec_32(int32_t sec, int32_t off, int32_t val)
{
	off = put_sec_16(sec, off, val & 65535);
	off = put_sec_16(sec, off, val >> 16);
	return off;
}

static int32_t put_sec_str(int32_t sec, int32_t off, const char *str, int32_t len)
{
	int32_t i;

	for (i = 0;  str[i] != 0 && i < len; ++i) {
		disk[sec][off + i] = (uint8_t)str[i];
	}

	while (i < len) {
		disk[sec][off + i] = ' ';
		++i;
	}

	return off + i;
}

static int32_t put_fat_12(int32_t sec, int32_t ent, int32_t val)
{
	uint8_t *fat = disk[sec];

	int32_t off = ent / 2 * 3;
	int32_t bit = (ent % 2) * 12;

	int32_t tmp = 0;

	tmp |= fat[off + 0] <<  0;
	tmp |= fat[off + 1] <<  8;
	tmp |= fat[off + 2] << 16;

	tmp = (tmp & ~(0xfff << bit)) | (val << bit);

	fat[off + 0] = (uint8_t)(tmp >>  0);
	fat[off + 1] = (uint8_t)(tmp >>  8);
	fat[off + 2] = (uint8_t)(tmp >> 16);

	return ent + 1;
}

static void init_boot_sector(void)
{
	int32_t off = 0;

	// magic number
	off = put_sec_8(0, off, 0xe9);
	off = put_sec_8(0, off, 0x00);

	// OEM
	off = put_sec_str(0, off, "EMUL", 6);

	// serial number - must equal byte 12 (BPB bytes/sector high byte)
	// to work around a d7-doubling bug in the BIOS rwabs serial check
	off = put_sec_8(0, off, (SZ_SEC >> 8) & 0xff);
	off = put_sec_8(0, off, (SZ_SEC >> 8) & 0xff);
	off = put_sec_8(0, off, (SZ_SEC >> 8) & 0xff);

	// bytes per sector
	off = put_sec_16(0, off, SZ_SEC);

	// sectors per cluster
	off = put_sec_8(0, off, N_SEC_CLU);

	// number of reserved sectors
	off = put_sec_16(0, off, N_BOOT_SEC);

	// number of FATs
	off = put_sec_8(0, off, N_FAT);

	// maximum number of root directory entries
	off = put_sec_16(0, off, N_ROOT_SEC * SZ_SEC / SZ_DIR_ENT);

	// total number of sectors
	off = put_sec_16(0, off, N_CYL * N_SID * N_SEC);

	// media descriptor (floppy disk, 720k)
	off = put_sec_8(0, off, 0xf9);

	// sectors per FAT (9 * 512 / 3 * 2 = 3072)
	off = put_sec_16(0, off, N_FAT_SEC);

	// sectors per track
	off = put_sec_16(0, off, N_SEC);

	// number of sides
	off = put_sec_16(0, off, N_SID);

	// number of hidden sectors
	off = put_sec_16(0, off, 0);

	put_sec_8(0, SZ_SEC - 2, 0x55);
	put_sec_8(0, SZ_SEC - 1, 0xaa);
}

static void init_fat(int32_t sec)
{
	int32_t ent = 0;

	ent = put_fat_12(sec, ent, 0xff9);
	ent = put_fat_12(sec, ent, 0xfff);

	int32_t n_clu = (sz_midas + SZ_CLU - 1) / SZ_CLU;

	for (int32_t i = 0; i < n_clu - 1; ++i) {
		ent = put_fat_12(sec, ent, ent + 1);
	}

	put_fat_12(sec, ent, 0xfff);
}

static void init_midas(void)
{
	int32_t off = 0;

	// file name
	off = put_sec_str(ROOT_SEC, off, "MIDAS", 8);

	// extension
	off = put_sec_str(ROOT_SEC, off, "ABS", 3);

	// file attributes (0x20 = archive)
	off = put_sec_8(ROOT_SEC, off, 0x20);

	// unused
	for (int32_t i = 0; i < 10; ++i) {
		off = put_sec_8(ROOT_SEC, off, 0x00);
	}

	// last modified time (12:34:56)
	off = put_sec_16(ROOT_SEC, off, (12 << 11) | (34 << 5) | (56 / 2));

	// last modified date (1988-06-20)
	off = put_sec_16(ROOT_SEC, off, (8 << 9) | (6 << 5) | 20);

	// start cluster
	off = put_sec_16(ROOT_SEC, off, 2);

	// file size
	off = put_sec_32(ROOT_SEC, off, sz_midas);

	int32_t n_sec = (sz_midas + SZ_SEC - 1) / SZ_SEC;
	memcpy(disk[N_META_SEC], midas, (size_t)n_sec * SZ_SEC);
}

static void write_disk(void)
{
	FILE *fh = fopen(DISK_FILE_NAME, "wb");

	if (fh == NULL || fwrite(disk, sizeof disk, 1, fh) != 1) {
		fprintf(stderr, "error while writing disk file " DISK_FILE_NAME "\n");
		exit(1);
	}

	fclose(fh);
}

static void load_midas(void)
{
	FILE *fh = fopen(MIDAS_FILE_NAME, "rb");

	if (fh == NULL) {
		fprintf(stderr, "error while opening MIDAS file " MIDAS_FILE_NAME "\n");
		exit(1);
	}

	if (fseek(fh, 0, SEEK_END) < 0) {
		fprintf(stderr, "error while seeking in MIDAS file " MIDAS_FILE_NAME "\n");
		exit(1);
	}

	ssize_t len = ftell(fh);

	if (len < 0) {
		fprintf(stderr, "error while determining size of MIDAS file " MIDAS_FILE_NAME "\n");
		exit(1);
	}

	sz_midas = (int32_t)len;
	rewind(fh);

	if (fread(midas, (size_t)sz_midas, 1, fh) != 1) {
		fprintf(stderr, "error while reading MIDAS file " MIDAS_FILE_NAME "\n");
		exit(1);
	}

	fclose(fh);
}

int32_t main(int32_t argc, char *argv[])
{
	(void)argc;
	(void)argv;

	load_midas();
	init_boot_sector();

	for (int32_t i = 0; i < N_FAT; ++i) {
		init_fat(N_BOOT_SEC + i * N_FAT_SEC);
	}

	init_midas();
	write_disk();
	return 0;
}
