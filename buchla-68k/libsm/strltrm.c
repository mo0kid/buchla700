/*
   =============================================================================
	strltrm() -- trim leading blanks from a string, in-place
	Version 1 -- 1988-08-19 -- D.N. Lynx Crowe

	Returns a pointer to the string.
   =============================================================================
*/

#include "ram.h"

int8_t *strltrm(int8_t *s)
{
	register int8_t c;
	register int8_t *lp, *rp;

	if (*s NE ' ')
		return(s);

	lp = s;
	rp = s;

	while (*rp EQ ' ')
		++rp;

	while ((c = *rp++))
		*lp++ = c;

	*lp = '\0';

	return(s);
}

