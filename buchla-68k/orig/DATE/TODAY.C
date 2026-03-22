/*
   =============================================================================
	today.c -- print the date and time of day
	Version 1 -- 1988-12-05 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "osbind.h"
#include "stddefs.h"

char	*days[] = {

	"Sunday",
	"Monday",
	"Tuesday",
	"Wednesday",
	"Thursday",
	"Friday",
	"Saturday"
};

char	*mons[] = {

	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
};

/* 
*/

/*
   =============================================================================
	wkday() -- determine the day of the week by Zeller's Congruence

	Uses the Gregorian calendar -- accurate from 1752 through 4901 A.D.

	short
	wkday(year, month, day)
	short year, month, day;

		year	1752..4901
		month	1..12		1 = Jan., 2 = Feb., ..., 12 = Dec.
		day	1..31

	Returns:

		0 - Sunday
		1 - Monday
		2 - Tuesday
		3 - Wednesday
		4 - Thursday
		5 - Friday
		6 - Saturday
   =============================================================================
*/

short
wkday(year, month, day)
register short year, month, day;
{
	register short cen, yinc;

	month -= 2;

	if (month < 1) {

		month += 12;
		--year;
	}

	cen = year / 100;
	yinc = year - (cen * 100);

	return(((((26 * month) - 2) / 10) + day + yinc + (yinc / 4)
		+ (cen / 4) - (2 * cen)) % 7);
}

/* 
*/

main()
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

	printf("It is %02d:%02d:%02d on %s,  %s %d, %d.\n",
		hh, mm, ss,
		days[wkday(yr, mn, dy)],
		mons[mn - 1], dy, yr);

	exit(0);
}
