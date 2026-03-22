/* 
   =============================================================================
	time.h -- header for the time package
	Version 1 -- 1988-01-14
   =============================================================================
*/

struct	tm {

	int	tm_sec;
	int	tm_min;
	int	tm_hour;
	int	tm_mday;
	int	tm_mon;
	int	tm_year;
	int	tm_wday;
	int	tm_yday;
	int	tm_dst;
};

extern struct tm *lgmtime(), *lcltime();
extern char *lctime(), *latime();
extern int ltzset();
extern long timezn;
extern int daylite;
extern char *ltzname[];
