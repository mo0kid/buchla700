/*
   =============================================================================
	librw.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		get_asg(void);
extern	int16_t		get_orc(int16_t lorh, int16_t kind);
extern	int16_t		get_pat(void);
extern	int16_t		get_scr(void);
extern	int16_t		get_seq(void);
extern	int16_t		get_tun(void);
extern	int16_t		get_wav(void);
extern	int16_t		wrt_asg(int16_t slot);
extern	int16_t		wrt_orc(int16_t slot, int16_t lorh);
extern	int16_t		wrt_pat(int16_t slot);
extern	int16_t		wrt_scr(int16_t slot);
extern	int16_t		wrt_seq(int16_t slot);
extern	int16_t		wrt_tun(int16_t slot);
extern	int16_t		wrt_wav(int16_t slot);
