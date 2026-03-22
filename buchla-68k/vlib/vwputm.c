/*
   =============================================================================
	vwputm.c -- put a menu in a 2-bit per pixel graphics window
	Version 1 -- 1987-04-13 -- D.N. Lynx Crowe

	vwputm(obase, nw, fg, bg, row, col, ml)
	unsigned int *obase;
	int nw, fg, bg;
	char *ml[];

		Writes the menu described by the list 'ml' in the
		'nw' character wide bitmap 'obase', using 'fg' for
		the foreground color and 'bg' for the background.
		The menu is at ('row','col') in the bitmap.
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	vwputm(obase, nw, fg, bg, row, col, ml) -- output a menu in a bitmap
   =============================================================================
*/

void vwputm(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *ml[])
{
	while (*ml) {

		vwputs(obase, nw, fg, bg, row++, col, *ml++);
	}
}
	

