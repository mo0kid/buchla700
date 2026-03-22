/*
   =============================================================================
	time.h -- header for the time package
	Version 2 -- 1989-01-13 -- D.N. Lynx Crowe
   =============================================================================
*/

struct	tm {		/* time structure */

	int	tm_sec;		/*  seconds (0-59) */
	int	tm_min;		/*  minutes (0-59) */
	int	tm_hour;	/*  hours (0-23) */
	int	tm_mday;	/*  day of month (1-31) */
	int	tm_mon;		/*  month (0-11, Jan is 0) */
	int	tm_year;	/*  year-1900 */
	int	tm_wday;	/*  weekday (0-6, Sun is 0) */
	int	tm_yday;	/*  day of the year */
	int	tm_isdst;	/*  daylight savings flag */
};

extern struct tm 	*gmtime();
extern struct tm	*localtime();
extern char		*asctime();
extern char		*ctime();
extern int		tzset();

extern long		timezone;
extern int		daylight;
extern char		*tzname[];
