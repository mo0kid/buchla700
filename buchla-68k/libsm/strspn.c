/*
   ============================================================================
	strspn.c -- string scan function ala' Unix(tm)
	Version 2 -- 1987-06-12 -- D.N. Lynx Crowe

	Return the number of characters in the maximum leading segment
	of 'string' which consists solely of characters from 'charset'.
   ============================================================================
*/

#include "ram.h"

int16_t strspn(int8_t *string, int8_t *charset)
{
	register int8_t *p, *q;
	register int16_t n = 0;

	for (q = string; *q != '\0'; ++q) {

		for (p = charset; *p != '\0' && *p != *q; ++p)
			;

		if(*p == '\0')
			break;

		n++;
	}

	return(n);
}
