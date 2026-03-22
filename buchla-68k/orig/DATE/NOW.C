/*
   =============================================================================
	now.c -- return the date and time as a string
	Version 2 -- 1988-10-28 -- D.N. Lynx Crowe
	(c) Copyright 1987, 1988 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	TESTER	0		/* define non-zero to get a test program */

#include "osbind.h"

/*
   =============================================================================
	now(p) -- return the date and time as a string in 'p'

	Returns a pointer to the string provided, which must be at least
	21 bytes long.  The string will be filled with the date and time
	in the format:

		yyyy-mm-dd  hh:mm:ss

	with a trailing zero byte.
   =============================================================================
*/

char *
now(p)
char *p;
{
	register long t;
	short yr, mn, dy, hh, mm, ss;

	t = Gettime();

	yr = ((short)(t >> 25) & 0x007F) + 1980;
	mn =  (short)(t >> 21) & 0x000F;
	dy =  (short)(t >> 16) & 0x001F;

	hh = (short)(t >> 11) & 0x001F;
	mm = (short)(t >>  5) & 0x003F;
	ss = ((short)t & 0x001F) << 1;

	sprintf(p, "%4d-%02d-%02d  %02d:%02d:%02d", yr, mn, dy, hh, mm, ss);

	return(p);
}

/* 
*/

#if	TESTER

char	x[22];		/* buffer for the returned string */

/* simple test program for the now() function */

main()
{
	printf("Date/Time = %s\n", now(x));
	exit(0);
}

#endif
