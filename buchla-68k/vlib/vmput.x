/*
   =============================================================================
	vmput.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		vmput(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *ms[], uint16_t ma);
extern	void		vmputa(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *ms[], uint16_t *ma[]);
