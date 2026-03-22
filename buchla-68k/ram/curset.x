/*
   =============================================================================
	curset.c -- external declarations
   =============================================================================
*/

#pragma once

#include "curpak.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		trkonly;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		curset(struct curpak *s);
extern	int16_t		stdctp0(void);
extern	int16_t		stdctp1(void);
extern	int16_t		stdctp2(void);
extern	int16_t		stdctp3(void);
extern	int16_t		stdctp4(void);
extern	int16_t		stdctp5(void);
