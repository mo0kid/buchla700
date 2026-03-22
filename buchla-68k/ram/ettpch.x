/*
   =============================================================================
	ettpch.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		ef_tpch(int16_t nn);
extern	int16_t		et_tpch(int16_t nn);
extern	int16_t		loc2key(int16_t row, int16_t col);
extern	int16_t		nd_tpch(int16_t nn, int16_t k);
extern	int16_t		rd_tpch(int16_t nn);
