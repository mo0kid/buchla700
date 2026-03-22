/*
   =============================================================================
	glcinit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	uint8_t		glc_is1[];
extern	uint8_t		glc_is2[];
extern	int16_t		lcdbase;
extern	int16_t		lcdbit;
extern	int16_t		lcdcol;
extern	int16_t		lcdctl1;
extern	int16_t		lcdctl2;
extern	int16_t		lcdcurs;
extern	int16_t		lcdrow;
extern	int16_t		lcdx;
extern	int16_t		lcdy;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		GLCcrc(int16_t row, int16_t col);
extern	void		GLCcurs(int16_t crs);
extern	int16_t		GLCcxy(int16_t x, int16_t y);
extern	void		GLCdisp(int16_t dsp, int16_t crs, int16_t blk1, int16_t blk2, int16_t blk3);
extern	void		GLCinit(void);
extern	void		GLCtext(int16_t row, int16_t col, int8_t *s);
extern	void		GLCwrts(int8_t *s);
