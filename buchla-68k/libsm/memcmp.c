/*
   =============================================================================
	memcmp.c -- compare memory areas
	Version 2 -- 1987-06-15

	Compare n bytes:  vp1>vp2: >0  vp1==vp2: 0  vp1<vp2: <0
   =============================================================================
*/

#include "ram.h"

int16_t memcmp(void *vp1, void *vp2, int16_t n)
{
	int8_t *cp1 = vp1;
	int8_t *cp2 = vp2;
	register int16_t	diff;

	if (cp1 != cp2)
		while (--n >= 0)
			if ((diff = *cp1++ - *cp2++))
				return(diff);

	return(0);
}
