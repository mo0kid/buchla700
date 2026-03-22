/*
   =============================================================================
	strrchr.c -- find last occurrence of a character in a string
	Version 1 -- 1987-06-12

	Return the ptr in sp at which the character c last
	appears; NULL if not found.
   =============================================================================
*/

#include "ram.h"

int8_t *strrchr(int8_t *sp, int8_t c)
{
	register int8_t *r;

	r = NULL;

	do {

	if (*sp == c)
		r = sp;

	} while(*sp++);

	return(r);
}
