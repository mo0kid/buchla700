/*
   =============================================================================
	fgets.c -- external declarations
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

extern	int16_t		agetc(FILE *ptr);
extern	int8_t		*fgets(int8_t *s, int16_t n, FILE *fp);
extern	int8_t		*gets(int8_t *line);
