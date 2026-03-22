/*
   =============================================================================
	memcpy.c -- copy memory
	Version 1 -- 1987-06-12

	Copy vp2 to vp1, always copy n bytes.
	Return vp1.
   =============================================================================
 */

#include "ram.h"

void *memcpy(void *vp1, void *vp2, int16_t n)
{
	int8_t *cp1 = vp1;
	int8_t *cp2 = vp2;

	while (--n >= 0)
		*cp1++ = *cp2++;

	return(vp1);
}
