/*
   =============================================================================
	time.c -- get the time of day in seconds since Jan 1, 1970
	Version 1 -- 1987-03-23
   =============================================================================
*/

long	_time;		/* system time of day */

long
time(tloc)
long *tloc; {

	if (tloc)
		*tloc = _time;

	return (_time);
}
