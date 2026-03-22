/*
   =============================================================================
	strchr.c -- find a character in a string

	Return the ptr in sp at which the character c appears;
	NULL if not found
   =============================================================================
*/

#include "ram.h"

int8_t *strchr(int8_t *sp, int8_t c)
{
	do {
		if(*sp == c)
			return(sp);
	} while(*sp++);

	return((int8_t *)NULL);
}

