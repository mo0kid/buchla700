/*
   =============================================================================
	ctcpos.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		ctcsw;
extern	int16_t		mtcoldc;
extern	int16_t		mtcoldr;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		ctcoff(void);
extern	void		ctcon(void);
extern	void		ctcpos(int16_t row, int16_t col);
extern	void		mtcoff(void);
extern	void		mtcpos(int16_t row, int16_t col);
