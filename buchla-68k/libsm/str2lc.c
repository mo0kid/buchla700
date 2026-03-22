/*
   ============================================================================
	str2lc(s) -- convert string s to lower case ASCII
	Version 2 -- 1987-06-12 -- Copyright 1987 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int8_t *str2lc(int8_t *s)
{
	register int8_t c;
	register int8_t *r = s;

	while ((c = *s))
		*s++ = (int8_t)tolower(c);

	return(r);
}

