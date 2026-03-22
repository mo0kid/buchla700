/*
   =============================================================================
	strcpy.c -- copy string
	Version 1 -- 1987-06-12

	Copy string s2 to s1.  s1 must be large enough.
	return s1
   =============================================================================
*/

#include "ram.h"

int8_t *strcpy(int8_t *s1, int8_t *s2)
{
	register int8_t *os1;

	os1 = s1;

	while ((*s1++ = *s2++))
		;

	return(os1);
}
