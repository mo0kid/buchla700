/*
   =============================================================================
	atoi.c -- ascii to integer conversion
	Version 4 -- 1987-07-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

int16_t atoi(int8_t *cp)
{
	register int16_t i;
	register int16_t sign;

	sign = 0;

	if ( *cp EQ '-' ) {

		++cp;
		sign = 1;

	} else {

		if (*cp EQ '+')
			++cp;
	}

	for (i = 0; isdigit(*cp); )
		i = i * 10 + (0x7F & *cp++) - '0';

	return(sign ? -i : i);
}


