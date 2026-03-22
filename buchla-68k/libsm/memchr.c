/*
   =============================================================================
	memchr.c -- search a string for a character
	Version 1 -- 1987-06-12

	Return the ptr in vp at which the character c appears;
	NULL if not found in n chars; don't stop at \0.
   =============================================================================
*/

#include "ram.h"

void *memchr(void *vp, int8_t c, int16_t n)
{
	int8_t *cp = vp;

	while (--n >= 0)
		if (*cp++ == c)
			return(--cp);

	return((void *)0);
}
