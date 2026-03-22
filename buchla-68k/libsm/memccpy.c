/*
   =============================================================================
	memccpy.c -- copy bytes until character seen
	Version 1 -- 1987-06-12

	Copy vp2 to vp1, stopping if character c is copied.
	Copy no more than n bytes.
	Return a pointer to the byte after character c in the copy,
	or NULL if c is not found in the first n bytes.
   =============================================================================
*/

#include "ram.h"

void *memccpy(void *vp1, void *vp2, int8_t c, int16_t n)
{
	int8_t *cp1 = vp1;
	int8_t *cp2 = vp2;

	while (--n >= 0)
		if ((*cp1++ = *cp2++) == c)
			return(cp1);

	return((void *)0);
}
