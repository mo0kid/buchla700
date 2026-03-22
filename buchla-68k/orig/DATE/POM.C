/* pom.c -- The phase of the moon, for your safety and convenience.
**
**  Stolen from ArchMach & converted from PL/I by Brian Hess.
**  Extensively cleaned up by Rich Salz.
**
**  Minor bug fixes by D.N. Lynx Crowe	1985-06-05
**
**  If you can figure out how this program works, then YOU deserve
**  to be working on it, sucker!  Here's a hint:  The epoch is 13:23,
**  10/1/78.
*/

#ifdef	UNIX
#include <math.h>
#include <sys/types.h>
#include <time.h>
#else
#include "math.h"
#include "types.h"
#include "time.h"
#endif

/* Globals. */

long		 Day;
long		 Hour;
long		 Minute;
double		 Fraction;

char		*Moon[] = {

    "new",
    "first quarter of the",
    "full",
    "last quarter of the"
};


/* Linked in later. */

time_t		 time();
struct tm	*localtime();


#define LINES		24
#define WIDTH		80
#define CENTER		((WIDTH - 2 * LINES) / 2)
#define BRIGHT		'@'
#define LEDGE		'('
#define REDGE		')'
#define FULL		0.5
#define TwoPi		(2 * 3.1415927)
#define ZERO		0.03

#define Plural(X)	if (X != 1) printf("s");

/*
   -----------------------------------------------------------------------
	Calculate() -- calculate the phase of the moon
   -----------------------------------------------------------------------
*/

long
Calculate()
{
    register struct tm	*tm;
    register long	 Length;
    register long	 Phase;
    register long	 DeltaH;
    register long	 Delta;
    register long	 offset;
    time_t		 tick;
    long		 julian;
    long		 year;
    long		 hour;
    long		 minute;

    tick	= time((time_t *)0);
    tm		= localtime(&tick);
    julian	= tm->tm_yday + 1;
    year	= tm->tm_year - 78;
    hour	= tm->tm_hour;
    minute	= tm->tm_min;

    Length	= (double)2551 / 60 * 1000 + (double)443 / 60;
    offset	= ((year * 365L + julian) * 24L + hour) * 60L + minute;
    Delta	= offset - (273L * 24L + 13L) * 60L + 23L;
    Phase	= Delta - (Delta / Length) * Length;

    Fraction	= (double)Phase / (double)Length;

    Length	= Length / 4;
    Phase	= Phase / Length;
    Delta	= Delta - (Delta / Length) * Length;
    DeltaH	= Delta / 60;
    Minute	= Delta - DeltaH * 60;
    Day		= DeltaH / 24;
    Hour	= DeltaH - Day * 24;
    return(Phase);
}

/*
   -----------------------------------------------------------------------
	CharPos(x) -- calculate character position for Draw
   -----------------------------------------------------------------------
*/

int
CharPos(x)
    double		x;
{
    register int	i;

    i = x * LINES + 0.5;
    if ((i += LINES + CENTER) < 1)
	i = 1;
    return(i);
}

/*
   -----------------------------------------------------------------------
	Draw() -- draw the moon
   -----------------------------------------------------------------------
*/

void
Draw()
{
    register char	*p;
    register int	 i;
    register int	 end;
    register double	 y;
    register double	 cht;
    register double	 squisher;
    register double	 horizon;
    register double	 terminator;
    char		 Buffer[256];

    /* Clear screen? */

    if (Fraction < FULL)
	squisher = cos(TwoPi * Fraction);
    else
	squisher = cos(TwoPi * (Fraction - FULL));

    cht = (double)2.0 / (LINES - 6.0);
    for (y = 0.93; y > -1.0; y -= cht)
    {
	for (i = sizeof Buffer, p = Buffer; --i >= 0; )
	    *p++ = ' ';
	horizon = sqrt(1.0 - y * y);
	Buffer[    CharPos(-horizon)]	= LEDGE;
	Buffer[i = CharPos( horizon)]	= REDGE;
	Buffer[++i]			= '\0';
	terminator = horizon * squisher;
	if (Fraction > ZERO && Fraction < (1.0 - ZERO))
	{
	    if (Fraction < FULL)
	    {
		i   = CharPos( terminator);
		end = CharPos( horizon);
	    }
	    else
	    {
		i   = CharPos(-horizon);
		end = CharPos( terminator);
	    }
	    while (i <= end)
		Buffer[i++] = BRIGHT;
	}
	printf(" %s\n", Buffer);
    }
}

/*
   -----------------------------------------------------------------------
	main(ac) -- calculate the phase of the moon and optionally draw it
   -----------------------------------------------------------------------
*/

main(ac)
    int			 ac;
{
    register long	 Phase;

    Phase = Calculate();

    if (ac != 1)
	Draw();

    printf("\nIt is ");

    if (Day == 0 && Hour == 0 && Minute == 0)
	printf("exactly");
    else {

	if (Day) {

	    printf("%ld day", Day);
	    Plural(Day);

	    if (Hour | Day)
		printf(", ");
	}

	if (Hour) {

	    printf("%ld hour", Hour);
	    Plural(Hour);

	    if (Minute)
		printf(", ");
	}

	if (Minute) {

	    printf("%ld minute", Minute);
	    Plural(Minute);
	}

	printf(" since");
    }

    printf(" the %s moon.\n", Moon[Phase]);

    exit(0);
}
