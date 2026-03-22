/*
   =============================================================================
	vclrs.c -- clear a VSDD text line to a specified value
	Version 2 -- 1987-04-15 -- D.N. Lynx Crowe
	(c) Copyright 1987 -- D.N. Lynx Crowe

	vclrs(obase, row, col, nc, ch, atr)

		Clear 'nc' characters in the text object 'obase' to 'ch',
		using atrributes 'atr', starting at ('row','col');

		No error checking is done, so beware.
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	vclrs(obase, row, col, nc, ch, atr) -- clear a line on the VSDD
   =============================================================================
*/

void vclrs(volatile uint16_t *obase, int16_t row, int16_t col, int16_t nc, int16_t ch, uint16_t attr)
{
	while (nc--)
		vputc(obase, row, col++, ch, attr);
}
