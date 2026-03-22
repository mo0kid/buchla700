/*
   =============================================================================
	strncmp.c -- compare strings
	Version 2 -- 1987-06-15

	Compare strings (at most n bytes)
	Returns: s1>s2; >0  s1==s2; 0  s1<s2; <0
   =============================================================================
*/

#include "ram.h"

int16_t strncmp(int8_t *s1, int8_t *s2, int16_t n)
{
	if (s1 == s2)
		return(0);

	while ((--n >= 0) && (*s1 == *s2++))
		if(*s1++ == '\0')
			return(0);

	return((n < 0) ? 0 : (int16_t)(*s1 - *--s2));
}

