/*
   ============================================================================
	rindex.c -- BSD style rindex function
	Version 2 -- 1987-06-12 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int8_t *rindex(int8_t *str, int8_t c)
{
	register int8_t *cp;

	for (cp = str ;*cp++ ; )
		;

	while (cp > str)
		if (*--cp == c)
			return(cp);

	return((int8_t *)0);
}

