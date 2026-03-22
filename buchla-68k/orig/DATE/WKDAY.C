/*
   =============================================================================
	wkday.c -- determine the day of the week by Zeller's Congruence
	Version 1 -- 1988-01-20 -- D.N. Lynx Crowe

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
