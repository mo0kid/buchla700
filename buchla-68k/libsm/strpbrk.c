/*
   =============================================================================
	strpbrk.c -- find a 'break' character in a string
	Version 1 -- 1987-06-12

	Return ptr to first occurance of any character from `brkset'
	in the character string `string'; NULL if none exists.
   =============================================================================
*/

#include "ram.h"

int8_t *strpbrk(int8_t *string, int8_t *brkset)
{
	register int8_t *p;

	do {

	for (p = brkset; *p != '\0' && *p != *string; ++p)
		;

	if (*p != '\0')
		return(string);
	}

	while(*string++)
		;

	return((int8_t *)0);
}

