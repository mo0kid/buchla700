/*
   =============================================================================
	time.c -- translate GEMDOS time format to Unix internal time format
	Version 2 -- 1989-01-10 -- D.N. Lynx Crowe

	Unix(tm) keeps its time in seconds since 1970-01-01 00:00:00 GMT.
   =============================================================================
*/

#define	TIMEZONE	8		/* PST */

#include "osbind.h"
#include "stddefs.h"

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
time(tloc)
long *tloc;
{
	long _time;
	int i, j, year, month, day, hour, minute, second, t;

	t = Gettime();

	year   = ((short)(t >> 25) & 0x007F) + 1980;
	month  =  (short)(t >> 21) & 0x000F;
	day    =  (short)(t >> 16) & 0x001F;

	hour   =  (short)(t >> 11) & 0x001F;
	minute =  (short)(t >>  5) & 0x003F;
	second =  ((short)t & 0x001F) << 1;

	_time = 0L;

	for (i = 1970, j = year; i < j; i++)
		_time += days(i) ;

	for(i = 1; i < month; i++)
		_time += mdays[i - 1] ;

	if((days(year) EQ 366) AND (month > 2))
		++_time ;

	_time += (day - 1);
	_time *= 24;
	_time += hour + TIMEZONE;
	_time *= 60;
	_time += minute;
	_time *= 60;
	_time += second;

	if (tloc)
		*tloc = _time;

	return(_time);
}
