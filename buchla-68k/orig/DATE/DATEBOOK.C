/*
   =============================================================================
	datebook.c -- F A S T    C A L E N D A R
	Version 11 -- 1989-02-06 -- D.N. Lynx Crowe

	Adapted from public domain source code retrieved from Usenet.

	This C program is a faster,  more general version of the
	standard UNIX utility CALENDAR(1), only modified for GEMDOS
	and with a few kinks added...

	It recognizes the following formats for dates:

        numeric/numeric                     As in:  1/12, 01/12, 12/1, ...
											month/day format

        3-charmonth[any chars] numeric      As in:  January 12, Jan. 12,
                                            jan. 12, JAN. 12, ...

        3-charweekday[any chars]            As in:  Friday, Monday, MON.,
                                            mon., tue, wed, ...

        numeric month                       A month from 1 to 12 as in:
                                            1, 2, 04, 12, ...

    Any lines, following a line that is matched, that have "whitespace"
    in the first column will be printed along with the matched line.
   =============================================================================
*/

#define	HASARGS		0		/* define non-zero to allow file arg */

#include "stdio.h"
#include "ctype.h"

#include "types.h"
#include "time.h"
#include "math.h"

#include "stddefs.h"

#define	CALFILE	"c:\\datebook.dat"	/* default name for datebook file */

#define	DAY	(24*3600)		/*  Number of seconds in a day.  */

#define EPOCH   1985
#define EPSILONg 279.611371     /* solar ecliptic long at EPOCH */
#define RHOg     282.680403     /* solar ecliptic long of perigee at EPOCH */
#define e          0.01671542   /* solar orbit eccentricity */
#define lzero     18.251907     /* lunar mean long at EPOCH */
#define Pzero    192.917585     /* lunar mean long of perigee at EPOCH */
#define Nzero     55.204723     /* lunar mean long of node at EPOCH */

/*  Remove this for SYS5 machines, or others with strchr instead of index.  */
/*  #define     strchr  index   */

/* 
*/

char mstring[128];

char datebuf[300];		/*  Global input line.  */

char *months[] = {		/*  Month definitions.  */

	"JAN", "FEB", "MAR",
	"APR", "MAY", "JUN",
	"JUL", "AUG", "SEP",
	"OCT", "NOV", "DEC"
};

char	*nm_mon[] = {

	"January", "February", "March",
	"April", "May", "June",
	"July", "August", "September",
	"October", "November", "December"
};

char *weekdays[] = {		/*  Weekday definitions.  */

	"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"
};

char	*nm_day[] = {

	"Sunday" , "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
	"Saturday"
};

short	tisnow;
short	seen;

FILE	*outfp = stdout;

int
ly(yr)
int yr;
{
	/* returns 1 if leapyear, 0 otherwise */

	return (yr % 4 == 0 && yr % 100 != 0 || yr % 400 == 0);
}

double
dtor(deg)
double deg;
{
	/* convert degrees to radians */

	return (deg * PI / 180);
}

double
adj360(deg)
double *deg;
{
	/* adjust value so 0 <= deg <= 360 */

	do {

		if (*deg < 0)
			*deg += 360;
		else if (*deg > 360)
			*deg -= 360;

	} while (*deg < 0 || *deg > 360);
}

double
potm(days)
double days;
{
	double N;
	double Msol;
	double Ec;
	double LambdaSol;
	double l;
	double Mm;
	double Ev;
	double Ac;
	double A3;
	double Mmprime;
	double A4;
	double lprime;
	double V;
	double ldprime;
	double D;
	double Nm;

	N = 360 * days / 365.2422;  /* sec 42 #3 */
	adj360(&N);

	Msol = N + EPSILONg - RHOg; /* sec 42 #4 */
	adj360(&Msol);

	Ec = 360 / PI * e * sin(dtor(Msol)); /* sec 42 #5 */

	LambdaSol = N + Ec + EPSILONg;       /* sec 42 #6 */
	adj360(&LambdaSol);

	l = 13.1763966 * days + lzero;       /* sec 61 #4 */
	adj360(&l);

	Mm = l - (0.1114041 * days) - Pzero; /* sec 61 #5 */
	adj360(&Mm);

	Nm = Nzero - (0.0529539 * days);     /* sec 61 #6 */
	adj360(&Nm);

	Ev = 1.2739 * sin(dtor(2*(l - LambdaSol) - Mm)); /* sec 61 #7 */

	Ac = 0.1858 * sin(dtor(Msol));       /* sec 61 #8 */
	A3 = 0.37 * sin(dtor(Msol));

	Mmprime = Mm + Ev - Ac - A3;         /* sec 61 #9 */

	Ec = 6.2886 * sin(dtor(Mmprime));    /* sec 61 #10 */

	A4 = 0.214 * sin(dtor(2 * Mmprime)); /* sec 61 #11 */

	lprime = l + Ev + Ec - Ac + A4;      /* sec 61 #12 */

	V = 0.6583 * sin(dtor(2 * (lprime - LambdaSol))); /* sec 61 #13 */

	ldprime = lprime + V;                /* sec 61 #14 */

	D = ldprime - LambdaSol;             /* sec 63 #2 */

	return((double)(50 * (1 - cos(dtor(D)))));    /* sec 63 #3 */
}

moontxt(buf)
char buf[];
{
	char *cp = buf;
	long *lo;	/* used by time calls */
	long curtime;
	double days;   /* days since EPOCH */
	double phase;  /* percent of lunar surface illuminated */
	double phase2; /* percent of lunar surface illuminated one day later */
	int i = EPOCH;
	struct tm *pt; /* ptr to time structure */

	lo = &curtime;
	time(lo);		/* get system time */
	pt = gmtime(lo);	/* get ptr to gmt time struct */

	/* calculate days since EPOCH */

	days = (pt->tm_yday +1) + ((pt->tm_hour + (pt->tm_min / 60.0)
		+ (pt->tm_sec / 3600.0)) / 24.0);

	while (i < pt->tm_year + 1900)
		days = days + 365 + ly(i++);

	phase = potm(days);
	sprintf(cp,"The Moon is ");
	cp += strlen(buf);

	if ((int)(phase + .5) == 100)
		sprintf(cp,"Full");
	else if ((int)(phase + 0.5) == 0) 
		sprintf(cp,"New");
	else if ((int)(phase + 0.5) == 50)  {

		phase2 = potm(++days);

		if (phase2 > phase)
			sprintf(cp,"at the First Quarter");
		else 
			sprintf(cp,"at the Last Quarter");

	} else if ((int)(phase + 0.5) > 50) {

		phase2 = potm(++days);

		if (phase2 > phase)
			sprintf(cp,"Waxing ");
		else 
			sprintf(cp,"Waning ");

		cp = buf + strlen(buf);
		sprintf(cp,"Gibbous (%1.0f%% of Full)", phase);

	} else if ((int)(phase + 0.5) < 50) {

		phase2 = potm(++days);

		if (phase2 > phase)
			sprintf(cp,"Waxing ");
		else
			sprintf(cp,"Waning ");

		cp = buf + strlen(buf);
		sprintf(cp,"Crescent (%1.0f%% of Full)", phase);
	}
}

/* 
*/

/* 
   =============================================================================
	chinayr() -- returns a pointer to a static string for the Chinese year
   =============================================================================
*/

char *
chinayr(year)
register int year;
{
	static	char	*chyrs[] = {	/* Chinese Year cycle */

		"Rat",		/* 0 */
		"Ox",		/* 1 */
		"Tiger",	/* 2 */
		"Rabbit",	/* 3 */
		"Dragon",	/* 4 */
		"Snake",	/* 5 */
		"Horse",	/* 6 */
		"Ram",		/* 7 */
		"Monkey",	/* 8 */
		"Cock",		/* 9 */
		"Dog",		/* 10 */
		"Boar"		/* 11 */
	};

	year -= 4;

	if (year < 0)
		return((char *)"?????");
	else
		return(chyrs[year % 12]);
}

/* 
*/

/*
   =============================================================================
	getdate() -- Check the input line, and get only the lines without
	leading "whitespace".  Conditionally print those lines with leading
	blanks, based on the "success" flag.
   =============================================================================
*/

char *
getdate(fp, success)
char *success;
register FILE *fp;
{
	register int c;
	static char inbuf[300];
	register char *t, *s;

	t = inbuf;
	s = datebuf;

	while ((c = getc(fp)) LE ' ' AND c NE EOF) {	/*  Skip leading space.  */

		ungetc(c, fp);
		fgets(inbuf, 300, fp);

		/*  Print the line if we previously printed a match.  */

		if (*success)
			fprintf(outfp,"%s\t%s", (tisnow ? ">" : " "), inbuf);
	}

	*success = 1;			/*  Assume success for now.  */

	if (c EQ EOF)			/*  Return EOF if we are there.  */
		return((char *)0);

	ungetc(c, fp);			/*  Unget the character.  */
	fgets(t, 300, fp);		/*  Get the input line.  */
	strcpy(s, t);			/*  Make a copy of it.  */

	return(inbuf);
}

/* 
*/

/*
   =============================================================================
	isnow() -- See if the passed string has a "NOW" date in it.
   =============================================================================
*/

int
isnow(datebuf)
char *datebuf;
{
	char *s, *t;
	long l;
	register int before, after, offset, month, day;
	register struct tm *tmptr;
	long timenow;

	time(&timenow);		/*  Get the current time.  */
	tmptr = localtime(&timenow);

	before = 0;
	after  = 0;

	t = datebuf;

/* 
*/
	/*  Is the first character a digit in a Month?  */

	if (isdigit(*t) AND (month = getnum(&t) - 1) GE 0 AND month < 12) {

		tisnow = (tmptr->tm_mon EQ month);

		/*  Find the separating slash.  */

		if (s = (char *)strchr(t, '/'))
			t = s + 1;
		else if (tmptr->tm_mon EQ month)
			return(1);
		else
			return(0);

	/*  Is the string a month name?  */

	} else if ((month = ischmonth(t)) GE 0) {

		/*  Skip till while space.  */

		while (!isspace(*t) AND *t)
			++t;

		/*  Skip to first NON-white space.  */

		while (isspace(*t) AND *t)
			++t;

	/*  Not a month, so try a DAY as in Friday, Saturday, etc...  */

	} else if ((day = ischday(datebuf)) GE 0) {

		tisnow = (day EQ tmptr->tm_wday);

		/*  Is this today?  */

		if (day EQ tmptr->tm_wday OR ((day + 6)%7) EQ tmptr->tm_wday)
			return(1);
		else
			return(0);

	} else {

		/*  Fail to recognize any other data as a valid date.  */

		return(0);
	}
/* 
*/
	/*  Is there only what looks to be a month?  If so, then OK.  */

	if (! *t OR ! isdigit(*t)) {

		/*  Is it this month?  */

		if (tmptr->tm_mon EQ month)
			return(1);

		return(0);
	}

	/*  Calculate the value of the day.  */

	day = getnum(&t);

	/*  Check for *w or *W extended week specifiers.  */

	if (*t EQ '*') {

		if (t[1] EQ 'w')
			++before;

		if (t[1] EQ 'W')
			++after;

		if (t[2] EQ 'W')
			++after;

		if (t[2] EQ 'w')
			++before;
	}

/* 
*/            
	offset = 1;			/*  Set weekend offset.  */

	switch (tmptr->tm_wday) {	/*  Get offset based on the weekend.  */

	case 5:		++offset;

	case 6:		++offset;

	default:	++offset;

	}

	tisnow = istoday(timenow, month, day);
		
	/*  Step through all dates by DAY.  */

	l = timenow - (after * 7 * DAY);

	while (l < timenow + (before * 7 * DAY) + (offset * DAY)) {

		if (istoday(l, month, day))
			return(1);

		l += DAY;
	}

	return(0);		/*  Return failure.  */
}

/* 
*/

/*
   =============================================================================
	ischday() -- Check if the string s is a DAY of the week as in monday,
	tues, wed, THU., or any derivative thereof.
   =============================================================================
*/

int
ischday(s)
register char *s;
{
	register char *tt;
	register int i, found = 0, c;
	register char t[30];

	/*  Copy the input, and capitalize it.  */

	for (tt = t, i=0; isalpha(*s) AND i < 28; ++i)
		*tt++ = islower(c = *s++) ? toupper(c) : c;

	*tt = '\0';

	/*  Search the list of valid day names for the string.  */

	for (i = 0; i < 7; ++i) {

		if (strncmp(t, weekdays[i], 3) EQ 0) {

			found++;
			break;
		}
	}

	/*  Return the numeric equivalent if we found it.  */

	if (found)
		return(i);

	/*  Return invalid day name.  */

	return(-1);
}

/* 
*/

/*
   =============================================================================
	ischmonth() -- Check if the string s is a valid derivative of the name
	of a month as in JUNE, jun, August, etc...
   =============================================================================
*/

int
ischmonth(s)
register char *s;
{
	register char *tt;
	register int i, found = 0, c;
	register char t[30];

	/*  Copy and capitalize.  */

	for (tt = t, i=0; isalpha(*s) AND i < 28; ++i)
		*tt++ = islower(c = *s++) ? toupper(c) : c;

	*tt = '\0';

	/*  Look through the list for a match.  */

	for (i = 0; i < 12; ++i) {

		if (strncmp(t, months[i], 3) EQ 0) {

			found++;
			break;
		}
	}

	/*  Return the numeric equivalent if we found it.  */

	if (found)
		return(i);

	/*  Return faliure.  */

	return(-1);
}

/* 
*/

/*
   =============================================================================
	getnum() -- Scan the string *t, and evaluate any integer contained
	there.  It is assumed that at least 1 digit exists (**t).
   =============================================================================
*/

int
getnum(t)
char **t;
{
	register int i, c;
	register char *s;

	i = 0;

	/*  Get the starting address.  */
	s = *t;

	/*  Get the starting value from the first digit.  */
	i = (c = *s++) - '0';

	/*  Evaluate the rest of the digits (if any).  */

	while (isdigit(c = *s++))
		i = i * 10 + (c - '0');

	/*  Set the new address.  */
	*t = --s;

	/*  Return the value.  */
	return(i);
}

/* 
*/

/*
   =============================================================================
	istoday() -- Return whether or not the time t corresponds to
	the month and day.
   =============================================================================
*/

int
istoday(t, month, day)
long t;
register int month, day;
{
	register struct tm *tm;

	tm = localtime(&t);

	return(tm->tm_mon EQ month AND tm->tm_mday EQ day);
}

/* 
*/

/*
   =============================================================================
	main function for datebook.c
   =============================================================================
*/

main(argc, argv)
int argc;
char **argv;
{
	register char *s;
	char success;
	register char file[200];
	register FILE *fp;
	long intime;
	long *timeloc;
	int year;
	struct tm *intmp;

	/* Use file passed as an argument if it is there,
		otherwise use default file. */

#if	HASARGS
	if (argc LE 1)
#endif
		strcpy(file, CALFILE);
#if	HASARGS
	else
		strcpy(file, argv[1]);
#endif

	if ((fp = fopen(file, "r")) EQ NULL) {	/*  Open the input file.  */

		perror(file);
		exit(1);
	}

	time(timeloc = &intime);    
	intmp = localtime(timeloc);
	year = intmp->tm_year+1900;

	fprintf(outfp,"\nThe time is %02d:%02d and ",
		intmp->tm_hour, intmp->tm_min);

	fprintf(outfp,"today is %s,\n%s %d, %d - the year of the %s.\n\n",
		nm_day[intmp->tm_wday], nm_mon[intmp->tm_mon],
		intmp->tm_mday, year, chinayr(year));

	moontxt(mstring);
	fprintf(outfp, "%s\n\n", mstring);

	if ((intmp->tm_wday EQ 5) AND (intmp->tm_mday EQ 13))
		fprintf(outfp,"!\tWatch out -- It's Friday the Thirteenth!\n\n");

	success = 0;	/*  Initially, no success.  */
	seen = FALSE;

	while (s = getdate(fp, &success)) {	/*  Loop till EOF is encountered.  */

		if (isnow(datebuf)) {	/*  Check date for "NOW"  */

			/*  Print it, it is valid.  */

			fprintf(outfp,"%s\t%s", (tisnow ? ">" : " "), s);
			seen = TRUE;

		} else {

			/* Reset the "print lines with leading blanks" flag. */
			
			success = 0;
		}
	}

	if (NOT seen)
		fprintf(outfp, "No reminders for today.\n");

	fclose(fp);	/*  Close up and exit.  */
	exit(0);
}
