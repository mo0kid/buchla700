/*
   =============================================================================
	vobjfns.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	volatile uint16_t	vi_ctl;
extern	int16_t			vi_dis;
extern	int16_t			wsize;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		CpyObj(volatile uint16_t *from, volatile uint16_t *to, int16_t w, int16_t h, int16_t sw);
extern	void		SelObj(int16_t obj);
extern	void		SetObj(int16_t obj, int16_t type, int16_t bank, volatile uint16_t *base, int16_t xpix, int16_t ypix, int16_t x0, int16_t y0, uint16_t flags, int16_t pri);
extern	void		SetPri(int16_t obj, int16_t pri);
