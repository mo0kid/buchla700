/*
   =============================================================================
	jday.c --  convert date to Julian day. -- ACM algorithm 199

	A Julian day is the number of days since some base date
	in the very distant past.

	Handy for getting date of x number of days after a given Julian date
	Use jdate() to get that from the Gregorian date.

	Written by:		Robert G. Tantzen

	Translated to C by:	Nat Howard

	Revised by:		D.N. Lynx Crowe
		1998-01-14 -- optimized for speed

	Translated from the algol original in Collected Algorithms of the <ACM
	This and jdate() are algorithm 199.
   =============================================================================
*/

long
jday(mon, day, year)
int mon, day, year;
{
	register long y = year;
	register long m = mon;
	register long j;
	register long ya;
	register long c;
	long d = day;

	if(m > 2) {

		m -= 3L;

	} else {

		m += 9L;
		--y;
	}

	c = y / 100L;
	ya = y - (100L * c);

	j = (146097L * c) / 4L
		+ (1461L * ya) / 4L
		+ (153L * m + 2L) / 5L
		+ d + 1721119L;

	return(j);
}
