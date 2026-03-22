/*
   =============================================================================
	adselbx.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	selbox	adboxes[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		adfnbox(int16_t n);
extern	void		admenu(int16_t n);
extern	void		admtxt(int16_t row, int16_t col, int8_t *txt, int16_t tag);
extern	void		endatyp(void);
