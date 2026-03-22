/*
   =============================================================================
	memset.c -- fill memory with short words
	Version 1 -- 1987-03-18 -- D.N. Lynx Crowe

	Set an array of n shorts starting at vp to the short s.
	Return pointer to vp.
   =============================================================================
*/

#include "ram.h"

volatile void *memsetw(volatile void *vp, uint16_t s, int16_t n)
{
	volatile uint16_t *sp = vp;

	while (--n >= 0)
		*sp++ = s;

	return(vp);
}
