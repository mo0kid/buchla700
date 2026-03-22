/*
   =============================================================================
	vmput.c -- video menu put functions
	Version 3 -- 1987-03-30 -- D.N. Lynx Crowe
	(c) Copyright 1987 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	vmput(obase, row, col, ms, ma) -- put a menu item in a screen image.
	Copies lines from ms, with attribute ma, to obase at (row,col).
   =============================================================================
*/

void vmput(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *ms[], uint16_t ma)
{
	register int16_t c, tc, tr;
	int8_t *cp;

	tr = row;

	while ((cp = *ms++)) {

		tc = col;

		while ((c = *cp++))
			vputc(obase, tr, tc++, c, ma);

		tr++;
	}
}

/*
   =============================================================================
	vmputa(obase, row, col, ms, ma) -- put a menu item in a screen image.
	Copies lines from ms, with attributes from ma, to obase at (row,col).
   =============================================================================
*/

void vmputa(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *ms[], uint16_t *ma[])
{
	register int16_t c, tc, tr;
	uint16_t *tm;
	int8_t *cp;

	tr = row;

	while ((cp = *ms++)) {

		tc = col;
		tm = *ma++;

		while ((c = *cp++))
			vputc(obase, tr, tc++, c, *tm++);

		tr++;
	}
}
