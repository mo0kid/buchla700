/*
   =============================================================================
	dirfns.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int8_t		*atrstr(int16_t atr, int8_t s[]);
extern	int8_t		*dtunpk(uint16_t din, uint16_t tin, int8_t *s, int16_t fmt);
extern	int8_t		*mname(int16_t n);
