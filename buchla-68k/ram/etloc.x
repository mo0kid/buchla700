/*
   =============================================================================
	etloc.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		ds_loc(void);
extern	int16_t		ef_loc(int16_t n);
extern	int16_t		et_loc(int16_t n);
extern	int16_t		nd_loc(int16_t n, int16_t k);
extern	int16_t		rd_loc(int16_t n);
extern	void		setloc(int16_t grp, int16_t loc);
