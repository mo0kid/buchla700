/*
   =============================================================================
	strcat.c -- concatenate strings
	Version 1 -- 1987-06-12

	Concatenate s2 onto the end of s1.  S1's space must be large enough.
	Return s1.
   =============================================================================
*/

#include "ram.h"

int8_t *strcat(int8_t *s1, int8_t *s2)
{
	register int8_t *os1;

	os1 = s1;

	while (*s1++)
		;

	--s1;

	while ((*s1++ = *s2++))
		;

	return(os1);
}
