/*
   =============================================================================
	totime.c -- translate a time.h structure to Unix internal time format
	Version 2 -- 1989-01-09 -- D.N. Lynx Crowe

	Unix(tm) keeps its time in seconds since 1970-01-01 00:00:00 GMT.
   =============================================================================
*/

#include "stddefs.h"
#include "time.h"

static char mdays[] = {	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

static
int
days(y)
register int y;
{
	if (y < 1970)
		y += 1900;

	if (((y % 4) EQ 0) AND ((y % 100) OR ((y % 400) EQ 0)))
		y = 366;
	else
		y = 365;

	return(y);
}

long
totime(tp, timezn) 
register struct tm *tp;		/* pointer to tm structure */
long timezn;			/* minutes local time is offset from GMT */
{
	long ret;
	int i, j;

	ret = 0L;

	if (tp->tm_year < 70)
		return(0L);

	for (i = 1970, j = tp->tm_year + 1900; i < j; i++)
		ret += days(i) ;

	for(i = 1; i < tp->tm_mon; i++)
		ret += mdays[i - 1] ;

	if((days(tp->tm_year) EQ 366) AND (tp->tm_mon > 2))
		++ret ;

	ret += (tp->tm_mday - 1);
	ret *= 24;
	ret += tp->tm_hour;
	ret *= 60;
	ret += (tp->tm_min + timezn);
	ret *= 60;
	ret += tp->tm_sec;

	return(ret);
}
