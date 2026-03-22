/*
   =============================================================================
	vtext.c -- output a text string to the VSDD in 1 byte / character mode
	Version 3 -- 1987-06-02 -- D.N. Lynx Crowe

	Assumes VSDD is pointing at bank 0.
   =============================================================================
*/

#include "ram.h"

static uint16_t	msk[] = { 0xFF00, 0x00FF };

void vtext(volatile uint16_t *obj, int16_t nc, int16_t row, int16_t col, int8_t *ip)
{
	volatile uint16_t *op;

	while (*ip) {

		op = obj + ((nc >> 1) * row) + (col >> 1);

		*op = (*op & msk[col & 1]) |
		      ((uint16_t)(*ip++ & 0x00FF) << ((col & 1) ? 8 : 0));

		col++;
	}
}
