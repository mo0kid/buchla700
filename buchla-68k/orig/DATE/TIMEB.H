/* timeb.h -- Version 1.0 -- ala' BSD4.2 */

struct timeb {
	time_t	time;
	unsigned short	millitm;
	short	timezone;
	short	dstflag;
};

#define	LOCALTZ		-480
#define	LOCALDF		1
