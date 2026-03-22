/*
   =============================================================================
	memcpyw.c -- copy words
	Version 2 -- 1987-06-15 -- D.N. Lynx Crowe

	Copy vp2 to vp1, always copy n words.
	Return pointer to vp1.
   =============================================================================
*/

#include "ram.h"

volatile void *memcpyw(volatile void *vp1, volatile void *vp2, int16_t n)
{
	volatile int16_t *sp1 = vp1;
	volatile int16_t *sp2 = vp2;

	while (--n >= 0)
		*sp1++ = *sp2++;

	return(vp1);
}
