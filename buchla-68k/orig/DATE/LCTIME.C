/*
   =============================================================================
	lctime.c -- a Unix(tm)-like time and date package
	Version 1 -- 1988-01-14 -- D.N. Lynx Crowe

	These are similar in function to the Unix functions, but are
	able to be used in re-entrant code.
   =============================================================================
*/

#include "stddefs.h"
#include "time.h"

#define	void	int			/* define to handle lack of 'void's */

#define	HASENV	0			/* non-zero if getenv() is available */

#if	HASENV
extern	char	*getenv();
#endif

long	timezn		= 8*60*60;		/* PST offset from GMT */
int	daylite		= 1;			/* daylight savings time = ON */
char	*ltzname[]	= {"PST", "PDT"};

/*
   =============================================================================
	These routines convert time as follows:

	The epoch is 0000 Jan 1 1970 GMT.
	The argument time is in seconds since then.

	struct tm *
	lcltime(tim, tmsp)
	long *tim;
	struct tm *tmsp;

		returns a pointer to a filled in structure containing:

			tm_sec		seconds		(0..59)
			tm_min		minutes		(0..59)
			tm_hour		hours		(0..23)
			tm_mday		day of month	(1..31)
			tm_mon		month		(0..11)
			tm_year		year - 1900
			tm_wday		weekday		(0..6, Sun is 0)
			tm_yday		day of the year
			tm_dst		daylight savings time flag

		The routine corrects for daylight savings time and will work in
		any time zone provided "timezn" is adjusted to the difference
		between	Greenwich and local standard time (measured in seconds).

		In places like Michigan "daylite" must be initialized to 0
		to prevent the conversion to daylight time.

		There is a table which accounts for the peculiarities
		undergone by daylight savings time in 1974-1975.

		The routine does not work in Saudi Arabia,
		which runs on Solar time.

	char *
	latime(t, cbuf)
	struct tm *t;
	char *cbuf;

		Where t is produced by lcltime(), and cbuf points to a
		character string of at least 26 bytes.

		Fills in a character string with the ascii time in the form:

			Thu Jan 01 00:00:00 1970\n\0
			012345678901234567890123
			0	  1	    2

		The string is terminated with a new-line and a zero byte.

	struct tm *
	lgmtime(tim, xtime)
	long *tim;
	struct tm *xtime;

		Fills in a tm structure with GMT and returns a pointer to it.

	char *
	lctime(t, tmsp, cbuf)
	long *t;
	struct tm *tmsp;
	char *cbuf;

		Fills in a tm structure and a character string with the
		current local time.

	void
	ltzset()

		Looks for an environment variable named TZ.

		It should be in the form "ESTn" or "ESTnEDT",
		where "n" represents a string of digits with an optional
		negative sign (for locations east of Greenwich, England).

		If the variable is present, it will set the external
		variables "timezn", "daylite", and "ltzname"
		appropriately. It is called by lcltime(), and
		may also be called explicitly by the user.
   =============================================================================
*/

/*  */

#define	dysize(A)	(((A) % 4) ? 365 : 366)

static	int	xdmsize[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

/*
	Daylight savings time change table:

	The following table is used for 1974 and 1975 and gives the day number
	of the first day after the Sunday of the change.
 */

static struct {

	int	daylb;
	int	dayle;

} daytab[] = {

	5,	333,	/* 1974: Jan 6 - last Sun. in Nov */
	58,	303,	/* 1975: Last Sun. in Feb - last Sun in Oct */
};

/*  */

/*
   =============================================================================
	ct_numb(cp, n) -- convert n to a 2 character string at cp  (RJBF)
   =============================================================================
*/

static char *
ct_numb(cp, n)
register char *cp;
int	n;
{
	cp++;

	if (n GE 10)
		*cp++ = (n / 10) % 10 + '0';
	else
		*cp++ = ' ';

	*cp++ = n % 10 + '0';

	return(cp);
}

/*  */

/*
   =============================================================================
	sunday(t, d)

	The argument d is a 0-origin day number.
	The value is the day number of the first Sunday on or after the day.
   =============================================================================
*/

static
int
sunday(t, d)
register struct tm *t;
register int d;
{
	if (d GE 58)
		d += dysize(t->tm_year) - 365;

	return(d - (d - t->tm_yday + t->tm_wday + 700) % 7);
}

/*  */

/*
   =============================================================================
	ltzset() -- set time variables based on TZ environment variable
   =============================================================================
*/

void
ltzset()
{
	register char *p, *q;
	register int n;
	int sign;

#if	HASENV

	if ((p = getenv("TZ")) AND *p) {

		n = 3;
		q = ltzname[0];

		do {

			*q++ = *p ? *p++ : ' ';

		} while (--n);

		if (sign = *p EQ '-')
			p++;

		n = 0;

		while (*p GE '0' AND *p LE '9')
			n = (n * 10) + *p++ - '0';

		if (sign)
			n = -n;

		timezn = ((long)(n * 60)) * 60;

		if (daylite = *p NE '\0') {

			q = ltzname[1];
			n = 3;

			do {

				*q++ = *p ? *p++ : ' ';

			} while (--n);
		}
	}

#endif
}

/*  */

/*
   =============================================================================
	lgmtime(tim, xtime) -- get Greenwich Mean Time from system time
   =============================================================================
*/

struct tm *
lgmtime(tim, xtime)
register long *tim;
register struct tm *xtime;
{
	register int d0, d1, i;
	register long hms, day;
	int dmsize[12];

	/* break initial number into days */

	hms = *tim % 86400L;
	day = *tim / 86400L;

	if (hms < 0) {

		hms += 86400L;
		day -= 1;
	}

	/* generate hours:minutes:seconds */

	xtime->tm_sec = hms % 60;
	d1 = hms / 60;
	xtime->tm_min = d1 % 60;
	d1 /= 60;
	xtime->tm_hour = d1;

	/*
		day is the day number.
		generate day of the week.
		The addend is 4 mod 7 (1/1/1970 was Thursday)
	 */

	xtime->tm_wday = (day + 7340036L) % 7;

	/* year number */

	if (day GE 0)
		for (d1 = 70; day GE dysize(d1); d1++)
			day -= dysize(d1);
	else
		for (d1 = 70; day < 0; d1--)
			day += dysize(d1 - 1);

	xtime->tm_year = d1;
	xtime->tm_yday = d0 = day;

	/* generate month */

	for (i = 0; i < 12; i++)
		xdmsize[i] = dmsize[i];

	if (dysize(d1) EQ 366)
		xdmsize[1] = 29;
	else
		xdmsize[1] = 28;

	for (d1 = 0; d0 GE xdmsize[d1]; d1++)
		d0 -= xdmsize[d1];

	xtime->tm_mday = d0+1;
	xtime->tm_mon = d1;
	xtime->tm_dst = 0;

	return(xtime);
}

/*  */

/*
   =============================================================================
	lcltime(tim, tmsp) -- get local time from system time
   =============================================================================
*/

struct tm *
lcltime(tim, tmsp)
long *tim;
struct tm *tmsp;
{
	register int dayno, daylbgn, daylend;
	int daylbtm, dayletm;
	register struct tm *ct;
	long copyt;

	ltzset();
	copyt = *tim - timezn;
	ct = lgmtime(&copyt, tmsp);

	dayno   = ct->tm_yday;

	daylbgn = 119;		/* Last Sun in Apr */
	daylend = 303;		/* Last Sun in Oct */
	daylbtm = 2;		/* 02:00 */
	dayletm = 1;		/* 01:00 */

	if (ct->tm_year EQ 74 OR ct->tm_year EQ 75) {

		daylbgn = daytab[ct->tm_year-74].daylb;
		daylend = daytab[ct->tm_year-74].dayle;
	}

	if (ct->tm_year EQ 88) {

	/* NOTE:  this will need to accomodate the change
		to the first sunday in Apr in 1988 */

		dayletm = 2;
	}

	daylbgn = sunday(ct, daylbgn);
	daylend = sunday(ct, daylend);

	if (daylite AND
	    (dayno > daylbgn OR (dayno EQ daylbgn AND ct->tm_hour GE daylbtm)) AND
	    (dayno < daylend OR (dayno EQ daylend AND ct->tm_hour < dayletm))) {

		copyt += 1 * 60 * 60;
		ct = lgmtime(&copyt, tmsp);
		ct->tm_dst++;
	}

	return(ct);
}

/*  */

/*
   =============================================================================
	latime(t, cbuf) -- convert a tm structure to an ASCII string
   =============================================================================
*/

char *
latime(t, cbuf)
struct tm *t;
char *cbuf;
{
	register char *cp, *ncp;
	register int *tp;

	cp = cbuf;

	for (ncp = "Day Mon 00 00:00:00 1900\n"; *cp++ = *ncp++; );

	ncp = &"SunMonTueWedThuFriSat"[3 * t->tm_wday];
	cp = cbuf;
	*cp++ = *ncp++;
	*cp++ = *ncp++;
	*cp++ = *ncp++;
	cp++;
	tp = &t->tm_mon;
	ncp = &"JanFebMarAprMayJunJulAugSepOctNovDec"[(*tp) * 3];
	*cp++ = *ncp++;
	*cp++ = *ncp++;
	*cp++ = *ncp++;
	cp = ct_numb(cp, *--tp);
	cp = ct_numb(cp, *--tp + 100);
	cp = ct_numb(cp, *--tp + 100);
	cp = ct_numb(cp, *--tp + 100);

	if (t->tm_year GE 100) {

		cp[1] = '2';
		cp[2] = '0';
	}

	cp += 2;
	cp = ct_numb(cp, t->tm_year + 100);

	return(cbuf);
}

/*  */

/*
   =============================================================================
	lctime() -- get the current time as a tm structure and an ASCII string
   =============================================================================
*/

char *
lctime(t, tmsp, cbuf)
long	*t;
struct tm *tmsp;
char *cbuf;
{
	return(latime(lcltime(t, tmsp), cbuf));
}
