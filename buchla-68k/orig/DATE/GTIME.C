/*
   =============================================================================
	gtime.c -- get the time from a string
	Version 1 -- 1988-01-14
   =============================================================================
*/

#include "stddefs.h"
#include "time.h"

#define	dysize(A)	(((A) % 4) ? 365 : 366)

extern	long	timbuf;

static	char	*cbp;
static	int	dmsize[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

/*
   =============================================================================
	gpair() -- get 2 digits
   =============================================================================
*/

static
int
gpair()
{
	register int c, d;
	register char *cp;

	cp = cbp;

	if(*cp EQ 0)
		return(-1);

	c = (*cp++ - '0') * 10;

	if (c < 0 OR c > 100)
		return(-1);

	if (*cp EQ 0)
		return(-1);

	if ((d = *cp++ - '0') < 0 OR d > 9)
		return(-1);

	cbp = cp;

	return (c + d);
}

/*  */

/*
   =============================================================================
	gtime() -- get time
   =============================================================================
*/

int
gtime(cp)
char *cp;
{
	register int i;
	register int y, t;
	int d, h, m;
	long nt;
	struct tm ntm;

	tzset();

	cbp = cp;

	t = gpair();

	if (t < 1 OR t > 12)
		return(1);

	d = gpair();

	if(d < 1 OR d > 31)
		return(1);

	h = gpair();

	if (h EQ 24) {

		h = 0;
		d++;
	}

	m = gpair();

	if (m < 0 OR m > 59)
		return(1);

	y = gpair();

	if (y < 0) {

		time(&nt);
		y = lcltime(&nt, &ntm)->tm_year;
	}

	if (*cbp EQ 'p')
		h += 12;

	if (h < 0 OR h > 23)
		return(1);

	timbuf = 0;
	y += 1900;

	for(i = 1970; i < y; i++)
		timbuf += dysize(i);

	/* Leap year */

	if (dysize(y) EQ 366 AND t GE 3)
		timbuf += 1;

	while (--t)
		timbuf += dmsize[t - 1];

	timbuf += (d - 1);
	timbuf *= 24;
	timbuf += h;
	timbuf *= 60;
	timbuf += m;
	timbuf *= 60;

	return(0);
}
