/*
   =============================================================================
	vputs.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		vputs(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t attr);
extern	void		vputsa(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t *attr);
