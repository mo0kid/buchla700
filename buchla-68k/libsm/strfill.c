/*
   =============================================================================
	strfill() -- fill a string with a constant byte and zero terminate it
	Version 1 -- 1988-08-19 -- D.N. Lynx Crowe

	Where:
		s = string pointer
		c = constant byte
		n = string length (not including the trailing zero)

	Returns a pointer to the string.
   =============================================================================
*/

#include "ram.h"

int8_t *strfill(int8_t *s, int8_t c, int16_t n)
{
	register int16_t i;
	int8_t *p;

	p = s;

	for (i = n; i--; )
		*s++ = c;

	*s = '\0';
	return(p);
}

