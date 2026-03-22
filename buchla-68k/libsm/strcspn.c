/*
   ============================================================================
	strcspn.c -- character scan function ala' Unix(tm)
	Version 1 -- 1987-02-11 -- D.N. Lynx Crowe

	Return the number of characters in the maximum leading segment
	of string which consists solely of characters NOT from charset.
   ============================================================================
*/

#include "ram.h"

int16_t strcspn(int8_t *string, int8_t *charset)
{
	register int8_t *p, *q;
	register int16_t n = 0;

	for(q = string; *q != '\0'; ++q , ++n) {

		for(p = charset; *p != '\0' && *p != *q; ++p)
			;

		if(*p != '\0')
			break;
	}

	return(n);
}
