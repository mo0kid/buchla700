/*
   =============================================================================
	strcmp.c -- compare strings
	Version 2 -- 1987-06-15

	Compare strings:  s1>s2: >0  s1==s2: 0  s1<s2: <0
   =============================================================================
*/

#include "ram.h"

int16_t strcmp(int8_t *s1, int8_t *s2)
{
	if(s1 == s2)
		return(0);

	while(*s1 == *s2++)
		if(*s1++ == '\0')
			 return(0);

	return((int16_t)*s1 - (int16_t)*--s2);
}

