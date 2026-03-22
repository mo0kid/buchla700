/*
   =============================================================================
	putc.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		_ClFlag;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		fclose(FILE *ptr);
extern	int16_t		fflush(FILE *ptr);
extern	int16_t		flush_(FILE *ptr, int16_t data);
extern	int16_t		putc(int16_t c, FILE *ptr);
extern	int16_t		puterr(int16_t c);
