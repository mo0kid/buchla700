/*
   =============================================================================
	dopatch.c -- external declarations
   =============================================================================
*/

#pragma once

#include "patch.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		cv2vce[];
extern	int16_t		frq2par[];
extern	int16_t		ind2par[];
extern	int8_t		ledstat[24];
extern	int16_t		lg2base[7];
extern	uint16_t	seqdupd;
extern	uint8_t		vgtype[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		dopatch(struct patch *pp);
extern	void		pdoctl(int16_t voice, int16_t osc, int16_t dat1, int16_t dat2);
extern	void		pdows(int16_t slot, int16_t voice, int16_t wsn);
extern	void		pfpufn(int16_t voice, int16_t par, uint16_t dat1, uint16_t dat2);
