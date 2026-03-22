/*
   =============================================================================
	booter.c -- external declarations
   =============================================================================
*/

#pragma once

#include "objdefs.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int32_t		B_bss_l;
extern	int32_t		B_bss_o;
extern	int32_t		B_buf_a;
extern	int32_t		B_chk;
extern	int32_t		B_dat_l;
extern	int32_t		B_dat_o;
extern	int16_t		B_dbg_s;
extern	int32_t		B_end;
extern	struct	EXFILE	B_fhdr;
extern	int32_t		B_lod_l;
extern	int16_t		B_log_s;
extern	int32_t		B_txt_l;
extern	int32_t		B_txt_o;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		booter(int8_t *fn, int32_t textadr);
