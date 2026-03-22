/*
   =============================================================================
	jdate.c -- Julian date converter -- ACM Algorithm 199

	Algorithm 199 from Collected algorithms of the ACM.

	Takes a julian date (the number of days since some distant epoch
	or other), and a pointer to a result array.  Returns a pointer to the
	filled in result array:

		ip[0] = month;

		ip[1] = day of month;

		ip[2] = year (actual year, like 1977,
			not 77 unless it was  77 a.d.);

		ip[3] = day of week (0->Sunday to 6->Saturday)

	The Gregorian calendar is assumed.

	Written by:		Robert G. Tantzen

	Translated to C by:	Nat Howard

	Revisions by:

		D.N. Lynx Crowe		1988-01-14
			optimized for speed and adapted for re-entrancy
   =============================================================================
*/

/* 
*/

int *
jdate(j, ret)
register long j;
register int *ret;
{
	register long d, m, y, k;

	ret[3] = (j + 1L) % 7L;

	j -= 1721119L;

	k = (4L * j) - 1L;
	y = k / 146097L;
	j = k - (146097L * y);
	d = j / 4L;

	k = (4L * d) + 3L;
	j = k / 1461L;
	d = k - (1461L * j);
	d = (d + 4L) / 4L;

	k = (5L * d) - 3L;
	m = k / 153L;
	d = k - (153L * m);
	d = (d + 5L) / 5L;
	y = (100L * y) + j;

	if(m < 10)  {

		m += 3;

	} else {

		m -= 9;
		++y;
	}

	ret[0] = m;
	ret[1] = d;
	ret[2] = y;

	return(ret);
}
