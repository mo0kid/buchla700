/*
   =============================================================================
	memset.c -- fill memory
	Version 1 -- 1987-06-12

	Set an array of n chars starting at vp to the character c.
	Return vp.
   =============================================================================
*/

#include "ram.h"

void *memset(void *vp, uint8_t c, int16_t n)
{
	uint8_t *cp = vp;

	while (--n >= 0)
		*cp++ = c;
		
	return(vp);
}
