/*
   =============================================================================
	moon.c -- calculate the phase of the moon
	Version 3 -- 1988-12-05 -- D.N. Lynx Crowe

	Modified version of the public domain code "mphase.c" from Usenet.
	Original author unknown.

	Modified to run under GEMDOS.
   =============================================================================
*/

#define	MAIN		1

#include "stddefs.h"

/*
   =============================================================================
	mphase() -- return the phase of the moon

	returns 0..7  where:  0 = new, 4 = full
   =============================================================================
*/

int
mphase(year, diy)
register int year, diy;
{
	/* moon period: 29.5306 days */
	/* year: 365.2422 days */

	register int epact, golden;

	golden = (year % 19) + 1;

	epact = (11 * golden + 18) % 30;

	if (((epact EQ 25) AND (golden > 11)) OR (epact EQ 24))
		epact++;

	return( (((((diy + epact) * 6) + 11) % 177) / 22) & 7);
}

/* 
*/

#if	MAIN

#include "stdio.h"

char	*mph[] = {

	"new",
	"waxing, in its first quarter",
	"in its first quarter",
	"waxing full",
	"full",
	"waning full",
	"in its last quarter",
	"waning, in its last quarter" };

main()
{
	register int year;		/* year */
	register int diy;		/* day in year */

	if (argc NE 3) {

		printf("usage:  moon year day-in-year\n");
		exit(1);
	}

	year = atoi(argv[1]);
	diy  = atoi(argv[2]);

	printf("The moon is %s.\n", mph[mphase(year, diy)]);
}

#endif

