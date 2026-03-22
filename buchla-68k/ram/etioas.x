/*
   =============================================================================
	etioas.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		ef_intp(int16_t n);
extern	int16_t		ef_ioas(int16_t n);
extern	int16_t		ef_tmpo(int16_t n);
extern	int16_t		ef_tune(int16_t n);
extern	int16_t		et_intp(int16_t n);
extern	int16_t		et_ioas(int16_t n);
extern	int16_t		et_tmpo(int16_t n);
extern	int16_t		et_tune(int16_t n);
extern	int16_t		nd_intp(int16_t n, int16_t k);
extern	int16_t		nd_ioas(int16_t n, int16_t k);
extern	int16_t		nd_tmpo(int16_t n, int16_t k);
extern	int16_t		nd_tune(int16_t n, int16_t k);
extern	int16_t		rd_intp(int16_t n);
extern	int16_t		rd_ioas(int16_t n);
extern	int16_t		rd_tmpo(int16_t n);
extern	int16_t		rd_tune(int16_t n);
