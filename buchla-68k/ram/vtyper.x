/*
   =============================================================================
	vtyper.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

typedef	void		(*vtchar)(volatile uint16_t *obj, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *buf);
typedef	void		(*vtcurs)(void);

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		vtlin1[];
extern	int8_t		vtlin2[];
extern	int8_t		vtlin3[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		vtcxupd(void);
extern	void		vtcyupd(void);
extern	void		vtdisp(volatile uint16_t *obj, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *buf);
extern	void		vtsetup(volatile uint16_t *obj, vtchar dsp, int16_t col, int8_t *ptr, int16_t tr, int16_t tc, vtcurs adv, vtcurs bsp, vtcurs cup, vtcurs cdn, vtcurs stop, int16_t fg, int16_t bg);
extern	int16_t		vtyper(void);
