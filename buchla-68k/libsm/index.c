/*
   ============================================================================
	index.c -- BSD style index function
	Version 1 -- 1987-02-11 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int8_t *index(int8_t *str, int8_t c)
{
	while (*str) {

		if (*str == c)
			return(str);

		++str;
	}

	return((int8_t *)0);
}

