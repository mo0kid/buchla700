/*
   =============================================================================
	moontx.c -- Calculate the current phase of the moon.
	Version 2 -- 1989-01-10 -- D.N. Lynx Crowe

	Original code by Keith E. Brandt  VIII 1984

	Based on routines from "Practical Astronomy with Your Calculator",
		by Peter Duffett-Smith.

	Comments give the section of the book that particular piece
	of code was adapted from.
   =============================================================================
*/

#define	MAINPROG	1

#include	"stdio.h"

#ifdef	VAX
#include	"sys/time.h"
#else	VAX
#include	"time.h"
#endif	VAX

#include	"math.h"

#define EPOCH   1985
#define EPSILONg 279.611371     /* solar ecliptic long at EPOCH */
#define RHOg     282.680403     /* solar ecliptic long of perigee at EPOCH */
#define e          0.01671542   /* solar orbit eccentricity */
#define lzero     18.251907     /* lunar mean long at EPOCH */
#define Pzero    192.917585     /* lunar mean long of perigee at EPOCH */
#define Nzero     55.204723     /* lunar mean long of node at EPOCH */

#ifndef PI
#define	PI         3.141592654
#endif

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

	return(50 * (1 - cos(dtor(D))));    /* sec 63 #3 */
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

#if	MAINPROG

char	mstring[128];

main()
{
	long	curtime;

	moontxt(mstring);
	time(&curtime);

	printf("%s", ctime(&curtime));
	printf("%s\n", mstring);
}

#endif
