/*
   =============================================================================
	vputsv.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		vputsav(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t *attr, int16_t len);
extern	void		vputsv(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t attr, int16_t len);
