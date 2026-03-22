/*
   =============================================================================
	strncat.c -- concatenate strings
	Version 1 -- 1987-06-12

	Concatenate s2 on the end of s1.  S1's space must be large enough.
	At most n characters are moved.
	Return s1.
   =============================================================================
*/

#include "ram.h"

int8_t *strncat(int8_t *s1, int8_t *s2, int16_t n)
{
	register int8_t *os1;

	os1 = s1;

	while (*s1++)
		;

	--s1;

	while ((*s1++ = *s2++))
		if(--n < 0) {

			*--s1 = '\0';
			break;
		}

	return(os1);
}
