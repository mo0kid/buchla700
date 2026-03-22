/*
   =============================================================================
	etadyn.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		ef_adyn(int16_t n);
extern	int16_t		et_adyn(int16_t n);
extern	int16_t		nd_adyn(int16_t nn, int16_t k);
extern	int16_t		rd_adyn(int16_t nn);
extern	void		setdyn(int16_t grp, int16_t dyn);
