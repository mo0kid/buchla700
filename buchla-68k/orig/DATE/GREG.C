/************************************************************************/
/* Program:     greg                                                    */
/* Purpose:     compute and verify information for Gregorian calendar   */
/* Copyright:   W. M. McKeeman 1986.  This program may be used or 	*/
/*		modified for any purpose so long as this copyright	*/
/*		notice is incorporated in the resulting source code.	*/
/* Compile:	Use cc -Os -DMAIN -o greg greg.c to compile with main   */
/*		delete the -DMAIN to compile as a function only.	*/
/* Input:       year, month, day                                        */
/*              day of month week & year, week of month, julian day.    */
/*              input values are zero (meaning "to be computed") or     */
/*              positive integers (meaning "to be checked and used")    */
/* Output:      consistent positive values for input:                   */
/*              return 0 if all output is valid,                        */
/*              return 1 if input is inconsistent,                      */
/*              return 2 if input is incomplete,                        */
/*              return 3 if int or long int is too short.               */
/* Example:                                                             */
/*   y = 1985; m = 12; d = 10; wd = 0; wk = 0; yd = 0;   jd = 0;        */
/*   greg(&y, &m, &d, &wd, &wk, &yd, &jd) returns 0 and leaves:    */
/*   y = 1985; m = 12; d = 10; wd = 3; wk = 2; yd = 344; jd = 2446410;  */
/* Method:        tableless.  see man page                              */
/************************************************************************/

#include "stdio.h"

#define	SUCCESS	0
#define	INCONS	1
#define	INCOMP	2
#define	SYSFAIL	3

#define Defined(e) ((e) != 0)

#define MakeCon(v1, v2) \
    {if (Defined(v1) && (v1) != (v2)) return(INCONS); else (v1) = (v2);}

#define LeapsB4(y) (((y)-1)/4 - ((y)-1)/100 + ((y)-1)/400)

#define AD0001Jan00        1721425L
#define AD1582Oct15        2299161L
#define AD14699Nov15       7090078L

int
greg(year, month, day0month, day0week, week0month, day0year, julianDay)
int *year, *month, *day0month, *day0week, *week0month, *day0year;
long int *julianDay;                            /* 7 significant digits */
{
    int d, w, m, y, ly, leaps;
    long int td, jd;

	if Defined(*julianDay) {

		jd = *julianDay;

	if (jd <= AD0001Jan00)
		return(INCONS);

        td = jd - AD0001Jan00 - 1;
        y = 1 + (td -= (td+1)/146097, td += (td+1)/36524, td-(td+1)/1461)/365;
        MakeCon(*year, y);
        d = jd - ((y-1)*365 + LeapsB4(y) + AD0001Jan00);
        MakeCon(*day0year, d);
    }

	if (!Defined(*year))
		return(INCOMP);
	else
		y = *year;

	leaps = LeapsB4(y);
	ly = y%400 == 0 || (y%100 != 0 && y%4 == 0);

    if (!Defined(*day0year)) {
        if (!Defined(*month)) return(INCOMP);
        if (!Defined(*day0month)) {
            if (!Defined(*day0week)||!Defined(*week0month))return(INCOMP);
            *day0month = 7*(*week0month-1) + *day0week - 
                (y+leaps+3055L*(*month+2)/100-84-(*month>2)*(2-ly))%7;
        }
        *day0year = 3055L*(*month+2)/100 - 91 + *day0month - (*month>2)*(2-ly);
    }

    td = (*day0year + (*day0year>59+ly)*(2-ly) + 91)*100L;
    m = td/3055 - 2;
    MakeCon(*month, m);
    d = td%3055/100 + 1;
    MakeCon(*day0month, d);

    jd = AD0001Jan00 + (y-1)*365 + LeapsB4(y) + *day0year;
    MakeCon(*julianDay, jd);
    w = (jd+1)%7 + 1;
    MakeCon(*day0week, w);
    w = (13 + *day0month - *day0week)/7;
    MakeCon(*week0month, w);

    return(*month) > 12 || *julianDay < AD1582Oct15 || *day0month >
        (*month == 2 ? 28+ly : 30+(*month == 1 || *month%5%3 != 1));
}

#ifdef	MAIN

main(argc, argv)                                /* driver for greg */
int argc; char *argv[];
{
    int r, i, p[7];
    long int jd;                                /* 7 significant digits */

    if (sizeof (long int) < 4 || sizeof (int) < 2) r = SYSFAIL;
    else if (argc > 8) r = INCONS;        /* too many inputs      */
    else if (argc < 4) r = INCOMP;          /* need y m d at least  */
    else {
        r = SUCCESS;
        for (i=1;i<=6;i++) {
            p[i] = i < argc ? atoi(argv[i]) : 0;
            if (p[i] < 0) r = INCONS;     /* no negative input    */
        }
        jd = argc == 8 ? atol(argv[7]) : 0L;    /* julian day is (long) */
        if (r != INCONS)
            r = greg(&p[1], &p[2], &p[3], &p[4], &p[5], &p[6], &jd);
    }

    switch (r) {

    case INCONS:
        puts("greg: input does not describe a valid gregorian date");

    case SUCCESS:
        printf("%d %d %d %d %d %d %ld\n", p[1],p[2],p[3],p[4],p[5],p[6],jd);
        break;

    case INCOMP:
        puts("greg: insufficient information");
        puts("usage: greg year month day [day0week week0month day0year jd]");
        break;

    case SYSFAIL:
        puts("greg: insufficient precision in either (int) or (long int)");
        break;
    }
    exit(r);
}

#endif
