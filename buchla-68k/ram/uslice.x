/*
   =============================================================================
	uslice.c -- external declarations
   =============================================================================
*/

#pragma once

#include "slice.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	uint16_t	epxtbl[][16];
extern	int16_t		lintab1[];
extern	int16_t		lintab2[];
extern	int16_t		nttab1[];
extern	int16_t		nttab2[];
extern	uint16_t	pxtbl[][4];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		clrsctl(void);
extern	int16_t		cslice(volatile uint16_t *slice, uint16_t mask1, uint16_t mask2, struct gdsel *gdstb[]);
extern	void		rslice(struct gdsel *gdstb[]);
extern	int16_t		uslice(volatile uint16_t *slice, uint16_t mask1, uint16_t mask2, struct gdsel *gdstb[]);
