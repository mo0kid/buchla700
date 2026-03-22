/*
   ============================================================================
	str2uc(s) -- converts string s to upper case ASCII
	Version 2 -- 1987-06-12 -- (c) Copyright 1987 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int8_t *str2uc(int8_t *s)
{
	register int8_t c;
	register int8_t *r = s;

	while ((c = *s))
		*s++ = (int8_t)toupper(c);

	return(r);
}

