/*
   =============================================================================
	strccpy.c -- copy string up to specified character
	Version 1 -- 1987-04-03 -- D.N. Lynx Crowe
   =============================================================================
*/

/*
   =============================================================================
	strccpy(s1, s2, c) -- copy string up to specified character

	Copy string s2 to s1 up to but not including the first occurrence of c.
	s1 must be large enough to contain the copied bytes.
	No checking is done. Character c is not copied.  Returns s1.
   =============================================================================
 */

#include "ram.h"

int8_t *strccpy(int8_t *s1, int8_t *s2, int8_t c)
{
	register int8_t *os1;
	register int8_t x;

	os1 = s1;

	while(c != (x = *s1++))
		*s2++ = x;

	return(os1);
}
