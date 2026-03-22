/*
   ============================================================================
	toupper.c -- convert character to upper case ASCII
	Version 1 -- 1987-06-11 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

/*
   ============================================================================
	toupper(c) -- convert c to upper case ASCII
   ============================================================================
*/

int16_t toupper(int16_t c)
{
	int16_t	x;

	if (isascii(c)) {

		if (islower(c))
			x = _toupper(c);
		else
			x = c;
	} else {

		x = c;
	}

	return(x);
}

