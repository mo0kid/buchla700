/*
   =============================================================================
	barbadj.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		BBase;
extern	int16_t		BCenter;
extern	int16_t		BOffset;
extern	int16_t		BTop;
extern	int16_t		BarBLn[128];
extern	int16_t		BarCLn[256];
extern	int16_t		BarCols[14];
extern	uint8_t		BarDots[3];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		BarBadj(int16_t bar, int16_t val);
extern	void		BarBset(int16_t bar, int16_t val);
extern	void		BarCadj(int16_t bar, int16_t val);
extern	void		BarCset(int16_t bar, int16_t val);
