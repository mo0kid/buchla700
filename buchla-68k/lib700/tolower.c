/*
   ============================================================================
	tolower.c -- convert character to lower case ASCII
	Version 1 -- 1987-09-11 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

/*
   ============================================================================
	tolower(c) -- convert c to lower case ASCII
   ============================================================================
*/

int16_t tolower(int16_t c)
{
	int16_t	x;

	if (isascii(c)) {

		if (isupper(c))
			x = _tolower(c);
		else
			x = c;

	} else {

		x = c;
	}

	return(x);
}


