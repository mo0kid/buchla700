/*
   =============================================================================
	fopen.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	FILE		*_opener(int8_t *name, int8_t *mode, uint16_t raw);
extern	FILE		*fopen(int8_t *name, int8_t *mode);
extern	FILE		*fopena(int8_t *name, int8_t *mode);
extern	FILE		*fopenb(int8_t *name, int8_t *mode);
