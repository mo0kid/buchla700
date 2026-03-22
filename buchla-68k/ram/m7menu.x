/*
   =============================================================================
	m7menu.c -- external declarations
   =============================================================================
*/

#pragma once

#include "curpak.h"
#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		blakpal[16][3];
extern	struct	curpak	m7_flds;
extern	struct	selbox	mdboxes[];
extern	int16_t		menupal[16][3];
extern	int16_t		mfrc[][2];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		drawm(void);
extern	void		dswap(void);
extern	void		m7menu(void);
extern	int16_t		mdselbx(int16_t n);
extern	void		mlbld(int8_t *where, int8_t *from);
extern	void		mlpoint(int16_t x, int16_t y, int16_t pen);
