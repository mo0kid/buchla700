/*
   ============================================================================
	strlcmp(s,l) -- compare string s to list l
	Version 1 -- 1987-03-03 -- D.N. Lynx Crowe

	Compares string s to each entry in the list l of strings
	until a match is found or until list l is exhausted.
	List l consists of a zero-entry terminated array of
	pointers to zero terminated strings.
	String s must be zero terminated.

	Returns 0 if no match was found, or the 1-origin index
	of the string in the list l.
   ============================================================================
*/

#include "ram.h"

int16_t strlcmp(int8_t *s, int8_t *l[])
{
	int16_t	rc;

	rc = 0;

	while (l[rc]) {

		if (0 == strcmp(s, l[rc]))
			return(++rc);

		rc++;
	}

	return(0);
}

