/*
   =============================================================================
	ct.c -- print a calendar with the current date and time for GEMDOS
	Version 2 -- 1988-12-05 -- D.N. Lynx Crowe

	Adapted from Public Domain source code from Usenet.
	Original author unknown.

	wkday() function and GEMDOS interface by D.N. Lynx Crowe.

	Compile and link with the Atari Developer's Alcyon C package.
   =============================================================================
*/

#include "osbind.h"
#include "stddefs.h"

char	dayw[] = { " S  M Tu  W Th  F  S" };	/* calendar heading */

char	*sday[] = {	/* days of the week */

	"Sunday", "Monday", "Tuesday", "Wednesday",
	"Thursday", "Friday", "Saturday"
};

char	*smon[]= {	/* months of the year */

	"January", "February", "March", "April",
	"May", "June", "July", "August",
	"September", "October", "November", "December",
};

char	mon[] = {	/* days in a month */

	0,
	31, 29, 31, 30,
	31, 30, 31, 31,
	30, 31, 30, 31,
};

char	string[432];		/* output work area */

/* 
*/

/*
   =============================================================================
	wkday() -- determine the day of the week by Zeller's Congruence

	Uses the Gregorian calendar -- accurate from 1752 through 4901 A.D.

	int
	wkday(year, month, day)
	int year, month, day;

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

int
wkday(year, month, day)
register int year, month, day;
{
	register int cen, yinc;

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

/*
   =============================================================================
	pstr(str, n) - print a string at a fixed length
   =============================================================================
*/

pstr(str, n)
char *str;
int n;
{
	register int i;
	register char *s;

	s = str;
	i = n;

	while (i--)
		if (*s++ EQ '\0')
			s[-1] = ' ';

	i = n + 1;

	while (i--)
		if (*--s NE ' ')
			break;

	s[1] = '\0';
	printf("%s\n", str);
}

/* 
*/

/*
   =============================================================================
	number(str) -- extract an integer from str
   =============================================================================
*/

int
number(str)
char *str;
{
	register int n, c;
	register char *s;

	n = 0;
	s = str;

	while(c = *s++) {

		if (c < '0' OR c > '9')
			return(0);

		n = (n * 10) + (c - '0');
	}

	return(n);
}

/* 
*/

/*
   =============================================================================
	jan1(yr) -- return the day of the week for January 1st of a given year
   =============================================================================
 */

int
jan1(yr)
int yr;
{
	register int y, d;

	/* normal Gregorian calendar -- one extra day per four years */

	y = yr;
	d = 4 + y + (y + 3) / 4;

	/* Julian calendar -- regular Gregorian less three days per 400 */

	if (y > 1800) {

		d -= (y - 1701) / 100;
		d += (y - 1601) / 400;
	}

	/* great calendar changeover instant */

	if (y > 1752)
		d += 3;

	return(d%7);
}

/* 
*/

/*
   =============================================================================
	cal(m, y, p, w) -- calculate a calendar string
   =============================================================================
*/

cal(m, y, p, w)
int m, y;
char *p;
int w;
{
	register d, i;
	register char *s;

	s = p;
	d = jan1(y);
	mon[2] = 29;
	mon[9] = 30;

	switch((jan1(y + 1) + 7 - d) % 7) {

	/*
	 *	non-leap year
	 */
	case 1:
		mon[2] = 28;
		break;

	/*
	 *	1752
	 */
	default:
		mon[9] = 19;
		break;

	/*
	 *	leap year
	 */
	case 2:
		;
	}

	for (i = 1; i < m; i++)
		d += mon[i];

	d %= 7;
	s += 3*d;

	for (i = 1; i LE mon[m]; i++) {

		if (i EQ 3 AND mon[m] EQ 19) {

			i += 11;
			mon[m] += 11;
		}

		if (i > 9)
			*s = (i / 10) + '0';

		s++;
		*s++ = (i % 10) + '0';
		s++;

		if (++d EQ 7) {

			d = 0;
			s = p + w;
			p = s;
		}
	}
}

/* 
*/

/*
   =============================================================================
	main function for ct command
   =============================================================================
*/

main(argc, argv)
char *argv[];
{
	register int yr, i, j;
	int mn, dy, hh, mm;
	register long t;

	t  = Gettime();

	yr = ((int)(t >> 25) & 0x007F) + 1980;	/* year */
	mn =  (int)(t >> 21) & 0x000F;		/* month */
	dy =  (int)(t >> 16) & 0x001F;		/* day */

	hh = (int)(t >> 11) & 0x001F;			/* hour */
	mm = (int)(t >>  5) & 0x003F;			/* minute */

	switch (argc) {

	case 1:
		break;

	case 2:
		goto allyr;

	case 3:
		mn = number(argv[1]);
		yr = number(argv[2]);
		break;

	default:
		printf("ct:  Incorrect number of arguments\n\n");

		printf("usage: ct [ [month] year ]\n\n");

		printf("        month = 1..12   year = 1752..9999\n\n");

		printf("It is %02d:%02d on %s,  %s %d, %d.\n\n",
			hh, mm, sday[wkday(yr, mn, dy)], smon[mn - 1], dy, yr);

		exit(0);
	}

/* 
*/

	/* print out just the current month */

	if (mn < 1 OR mn > 12)
		goto badarg;

	if (yr < 1752 OR yr > 9999)
		goto badarg;

	printf("\n\n   %s %u\n\n", smon[mn - 1], yr);
	printf("%s\n", dayw);

	cal(mn, yr, string, 24);

	for (i = 0; i < 6 * 24; i += 24)
		pstr(string + i, 24);

	printf("It is %02d:%02d on %s,  %s %d, %d.\n\n",
		hh, mm, sday[wkday(yr, mn, dy)], smon[mn - 1], dy, yr);

	exit(0);

/* 
*/

	/* print out complete year */

allyr:
	yr = number(argv[1]);

	if (yr < 1752 OR yr > 9999)
		goto badarg;

	printf("\n				%u\n", yr);
	printf("\n");

	for (i = 0; i < 12; i += 3) {

		for (j = 0; j < 6 * 72; j++)
			string[j] = '\0';

		printf("	 %.3s", smon[i]);
		printf("			%.3s", smon[i + 1]);
		printf("		       %.3s\n", smon[i + 2]);
		printf("%s   %s   %s\n", dayw, dayw, dayw);

		cal(i + 1, yr, string, 72);
		cal(i + 2, yr, string + 23, 72);
		cal(i + 3, yr, string + 46, 72);

		for (j = 0; j < 6 * 72; j += 72)
			pstr(string + j, 72);
	}

	printf("\n");
	exit(0);

/* 
*/

badarg:
	printf("ct:  Bad argument\n\n");

	printf("usage: ct [ [month] year ]\n\n");
	printf("        month = 1..12   year = 1752..9999\n\n");

	printf("It is %02d:%02d on %s,  %s %d, %d.\n\n\n",
		hh, mm, sday[wkday(yr, mn, dy)], smon[mn - 1], dy, yr);

	exit(1);
}
