/*
   =============================================================================
	strrtrm() -- trim trailing blanks from a string, in-place
	Version 1 -- 1988-08-19 -- D.N. Lynx Crowe

	Returns a pointer to the string.
   =============================================================================
*/

#include "ram.h"

int8_t *strrtrm(int8_t *s)
{
	register int8_t *lp, *rp;

	lp = s;
	rp = s;

	while (*rp)
		++rp;

	while ((int32_t)(--rp) GE (int32_t)lp) {

		if (*rp EQ ' ')
			*rp = '\0';
		else
			break;
	}

	return(lp);
}

