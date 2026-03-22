/*
   ============================================================================
	memcmpu -- compare two memory areas while ignoring case
	Version 4 -- 1987-06-15 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int16_t memcmpu(void *vp1, void *vp2, int16_t n)
{
	int8_t *cp1 = vp1;
	int8_t *cp2 = vp2;
	register int8_t c1, c2;

	while (n) {

		c1 = *cp1++;
		c2 = *cp2++;

		if (isascii(c1) && islower(c1))
			c1 = (int8_t)_toupper(c1);

		if (isascii(c2) && islower(c2))
			c2 = (int8_t)_toupper(c2);

		if (c1 < c2)
			return(-1);

		if (c1 > c2)
			return(1);

		n--;
	}

	return(0);
}

