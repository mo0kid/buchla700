/*
   =============================================================================
	setwq.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "wordq.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		getwq(struct wordq *qp, uint16_t *p);
extern	int16_t		putwq(struct wordq *qp, uint16_t c);
extern	int16_t		setwq(struct wordq *qp, uint16_t *qadr, int16_t qsiz, int16_t hi, int16_t lo);
