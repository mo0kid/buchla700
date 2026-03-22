/*
   =============================================================================
	weekof.c -- return the Monday of the week a given Julian day is in
	Version 1 -- 1988-01-20 -- D.N. Lynx Crowe

	Accepts and returns Julian day numbers as used with jdate() or jday().
   =============================================================================
*/

#include "stddefs.h"

long
weekof(jd)
long jd;
{
	short  wd;

	wd = (jd + 1L) % 7;

	if (wd EQ 1)
		return(jd);
	else if (wd)
		return(jd - (long)(wd - 1));
	else
		return(jd - 6L);
}
