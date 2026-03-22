/*
   =============================================================================
	atol.c -- ascii to long conversion
	Version 3 -- 1987-06-29 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

int32_t atol(int8_t *cp)
{
	register int32_t n;
	register int16_t sign;

	sign = 0;

	if (*cp EQ '-') {

		++cp;
		sign = 1;

	} else {

		if (*cp EQ '+')
		++cp;
	}

	for (n = 0; isdigit(*cp); )
		n = n * 10 + *cp++ - '0';

	return(sign ? -n : n);
}

