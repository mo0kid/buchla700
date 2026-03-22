/*
   =============================================================================
	rawio.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		getln(int16_t unit, int16_t nb, int8_t *buf);
extern	int16_t		getrln(int16_t unit, int16_t nb, int8_t *buf);
extern	int16_t		readln(int16_t unit, int16_t nc, int8_t *ctl, int16_t nb, int8_t *buf);
extern	void		writeln(int16_t unit, int8_t *buf);
