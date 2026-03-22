/*
   =============================================================================
	ptdkey.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		des2fmt[];
extern	int16_t		dsdecol[5][2][2];
extern	int16_t		dtabl7[];
extern	int16_t		dtabl9[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		SnapPTV(int8_t *s);
extern	void		buf2pte(void);
extern	void		ptde_ds(int16_t n, int16_t key);
extern	void		ptdkey(int16_t k);
extern	void		pte2buf(void);
extern	void		setptcv(void);
extern	void		voidpb(void);
