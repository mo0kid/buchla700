/*
   =============================================================================
	chinayr.c -- return the Chinese Year of the ...
	Version 1 -- 1988-05-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	TESTER		/* define for a test program */

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
		return("?????");
	else
		return(chyrs[year % 12]);
}

/* 
*/

#ifdef	TESTER

#include "stdio.h"

extern	int	atoi();

main(argc, argv)
int argc;
char *argv[];
{
	register int n;

	while (--argc) {

		n = atoi(*++argv);

		if (n < 4)
			printf("%4d is out of range\n", n);
		else
			printf("%4d is the Year of the %s\n", n, chinayr(n));
	}
}

#endif
