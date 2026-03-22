/*
   =============================================================================
	mphase.c -- calculate the phase of the moon
	Version 1 -- 1988-01-14 -- D.N. Lynx Crowe

	Modified version of the public domain code from Usenet.
	Original author unknown.
   =============================================================================
*/

#define	MAIN		1

#include "stddefs.h"
#include "time.h"

struct	tm	*lcltime();

/*
   =============================================================================
	mphase() -- return the phase of the moon

	returns 0..7  where:  0 = new, 4 = full
   =============================================================================
*/

int
mphase(lt)
register struct tm *lt;
{
	/* moon period: 29.5306 days */
	/* year: 365.2422 days */

	register int epact, diy, golden;

	diy = lt->tm_yday;

	golden = (lt->tm_year % 19) + 1;

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

long	lcldate;
struct	tm	lcltm;

struct tm *
getlt()
{
	time(&lcldate);
	return(lcltime(&lcldate, &lcltm));
}

main()
{
	printf("The moon is %s.\n", mph[mphase(getlt())]);
}

#endif

