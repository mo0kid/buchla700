/*
   ============================================================================	
	transit.c -- calculate sunrise, sunset, and hours of daylight
	Version 2 -- 1989-01-26 -- Robert Bond / D.N. Lynx Crowe
 
	transit <options>

	options:	-d yyyy-mm-dd	first date (default is current system date)
			-e yyyy-mm-dd	last date (default is current system date)
			-a lat		decimal latitude (default = 45.5333)
			-o lon		decimal longitude (default = 122.8333) 
			-y yyyy		year  (calculates for the entire year)
			-z tz		timezone (default = 8, PST)
        
	Calculated output is written to OUTFILE, errors are written to stdout.  

	Define BSD for BSD4.2 systems.  System V assumed otherwise.
	This selects between <sys/time.h> and <time.h> below.

	Note that the latitude, longitude, time zone correction and
	time zone string are all defaulted in the global variable section.
	The default is for Oakland, CA.

	Most of the code in this program is adapted from algorithms
	presented in "Practical Astronomy With Your Calculator" by
	Peter Duffet-Smith.

	The GST and ALT-AZIMUTH algorithms are from Sky and Telescope,
	June, 1984 by Roger W. Sinnott

	Adapted from:  sun.c
	Original author: Robert Bond - Beaverton, Oregon.

	Mods by:  D.N. Lynx Crowe - Oakland, California.
   ============================================================================	
*/

#include "stdio.h"
#include "math.h"
#include "types.h"

#ifdef BSD
#include <sys/time.h>
#else
#include "time.h"
#endif

#include "stddefs.h"

#define	OUTFILE		"daylight.dat"		/* output file name */

#ifndef	PI
#define PI       3.141592654
#endif

#define EPOCH	 1980
#define JDE	 2444238.5	/* Julian date of EPOCH */

FILE	*outfp;			/* output file pointer */

double dtor();
double adj360();
double adj24();
double julian_date();
double hms_to_dh();
double solar_lon();
double acos_deg();
double asin_deg();
double atan_q_deg();
double atan_deg();
double sin_deg();
double cos_deg();
double tan_deg();
double gmst();

int mo;
int day;
int yr;

int endmo;
int endday;
int endyr;

int popt = 0;			/* position option flag */

int tz=8;			/* Default time zone */
char *tzs  = "PST";		/* Default time zone string */
char *dtzs = "PDT";		/* Default daylight savings time string */

/* double lat = 45.5333;		/* Default latitude (Beaverton Ore.) */
/* double lon = 122.8333;		/* Default Longitude (Degrees west) */ 

double lat = 37.75;		/* Default latitude (Oakland, CA) */
double lon = 122.25;		/* Default longitude (degrees west) */

char mdays[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

char *
lite(hrz, mrz, hst, mst, nite, day, rise, set)
int hrz, mrz, hst, mst;
char nite, day, rise, set;
{
	register int i, h, m;
	static char niteday[49];

	if (mrz < 30)		/* quantize rise time */
		mrz = 0;
	else
		mrz = 30;

	if (mst < 30)		/* quantize set time */
		mst = 0;
	else
		mst = 30;

	for (i = 0; i < 48; i++) {

		h = i >> 1;
		m = (i & 1) ? 30 : 0;

		if ( (h < hrz) OR ((h EQ hrz) AND (m < mrz)) OR
		     (h > hst) OR ((h EQ hst) AND (m > mst)) )
			niteday[i] = nite;
		else if ((h EQ hrz) AND (m EQ mrz))
			niteday[i] = rise;
		else if ((h EQ hst) AND (m EQ mst))
			niteday[i] = set;
		else
			niteday[i] = day;
	}

	niteday[48] = '\0';
	return(&niteday[0]);
}

int
days(y)
register int y;
{
	if (y < 1970)
		y += 1900;

	if ( ((y % 4) EQ 0) AND ((y % 100) OR ((y % 400) EQ 0)) )
		y = 366;
	else
		y = 365;

	return(y);
}

/* 
*/

main(argc,argv)
int argc;
char *argv[];
{
	time_t sec_1970;
	int modays;
	struct tm *pt;

	sec_1970 = time((time_t *)0);  
	pt = localtime(&sec_1970);  

	yr  = pt->tm_year + 1900;
	mo  = pt->tm_mon + 1;
	day = pt->tm_mday;

	endyr = yr;
	endmo = mo;
	endday = day;

	if (pt->tm_isdst) {		/* convert tz to daylight savings time */

		tz--;
		tzs = dtzs;	
	}

	initopts(argc, argv);

	if ((FILE *)NULL EQ (outfp = fopen(OUTFILE, "w"))) {

		printf("ERROR:  Unable to open \"%s\" for output\n", OUTFILE);
		exit(1);
	}

	fprintf(outfp, 
		"Sunrise, Sunset (%s) and Hours of Daylight at Latitude %lf, Longitude %lf\n\n",
		tzs, lat, lon);

	while (TRUE) {

		dosun();

		if ((endyr EQ yr) AND (endmo EQ mo) AND (endday EQ day))
			exit(0);

		modays = mdays[mo - 1];

		if ((days(yr) EQ 366) AND (mo EQ 2))
			++modays;

		if (++day > modays) {

			day = 1;

			if (++mo > 12) {

				mo = 1;
				++yr;
			}
		}
	}
}

dosun()
{
	double ed, jd;
	double alpha1, delta1, alpha2, delta2, st1r, st1s, st2r, st2s;
	double a1r, a1s, a2r, a2s, dt, x, y;
	double trise, tset, ar, as, delta, tri, da;
	double lambda1, lambda2;
	double m1;
	double hsm, ratio;
	int h, m, hrz, mrz, hdl, mdl;

	jd = julian_date(mo,day,yr);
	ed = jd - JDE;

	lambda1 = solar_lon(ed);
	lambda2 = solar_lon(ed + 1.0);

	lon_to_eq(lambda1, &alpha1, &delta1);
	lon_to_eq(lambda2, &alpha2, &delta2);

	rise_set(alpha1, delta1, &st1r, &st1s, &a1r, &a1s);
	rise_set(alpha2, delta2, &st2r, &st2s, &a2r, &a2s);

	m1 = adj24(gmst(jd - 0.5, 0.5 + tz / 24.0) - lon / 15); /* lst midnight */
	hsm = adj24(st1r - m1);
	ratio = hsm / 24.07;

	if (fabs(st2r - st1r) > 1.0)
		st2r += 24.0;

	trise = adj24((1.0 - ratio) * st1r + ratio * st2r);

	hsm = adj24(st1s - m1);
	ratio = hsm / 24.07;

	if (fabs(st2s - st1s) > 1.0)
		st2s += 24.0;

	tset = adj24((1.0 - ratio) * st1s + ratio * st2s);

	ar = a1r * 360.0 / (360.0 + a1r - a2r);
	as = a1s * 360.0 / (360.0 + a1s - a2s);

	delta = (delta1 + delta2) / 2.0;
	tri = acos_deg(sin_deg(lat)/cos_deg(delta));

	x = 0.835608;	/* correction for refraction, parallax, size of sun */
	y = asin_deg(sin_deg(x)/sin_deg(tri));
	da = asin_deg(tan_deg(x)/tan_deg(tri));
	dt = 240.0 * y / cos_deg(delta) / 3600;

	fprintf(outfp, "%04d-%02d-%02d  ", yr, mo, day);

	lst_to_hm(trise - dt, jd, &hrz, &mrz);
	fprintf(outfp, "%02d:%02d  ", hrz, mrz);

	lst_to_hm(tset + dt, jd, &h, &m);
	fprintf(outfp, "%02d:%02d  ", h, m);

	mdl = m - mrz;

	if (mdl < 0) {

		mdl += 60;

		h--;
	}

	hdl = h - hrz;

	fprintf(outfp, "%2d:%02d  ", hdl, mdl);

	fprintf(outfp, "%s\n", lite(hrz, mrz, h, m, '*', ' ', 'R', 'S'));
}

/* 
*/

double
dtor(deg)
double deg;
{
	return (deg * PI / 180.0);
}

double
rtod(deg)
double deg;
{
	return (deg * 180.0 / PI);
}


double
adj360(deg)
double deg;
{
	while (deg < 0.0) 
		deg += 360.0;

	while (deg > 360.0)
		deg -= 360.0;

	return(deg);
}

double
adj24(hrs)
double hrs;
{
	while (hrs < 0.0) 
		hrs += 24.0;

	while (hrs > 24.0)
		hrs -= 24.0;

	return(hrs);
}

/* 
*/

initopts(argc,argv)
int argc;
char *argv[];
{
	int ai;
	char *ca;
	char *str;

	while (--argc) {

		if ((*++argv)[0] == '-') {

			ca = *argv;

			for(ai = 1; ca[ai] != '\0'; ai++)
				switch (ca[ai]) {

				case 'a':
					str = *++argv;
		
					if (sscanf(str, "%lf", &lat) != 1)
						usage();

					argc--;
					break;

				case 'o':
					str = *++argv;

					if (sscanf(str, "%lf", &lon) != 1)
						usage();

					argc--;
					break;

				case 'z':
					str = *++argv;

					if (sscanf(str, "%d", &tz) != 1)
						usage();

					tzs = "   ";
					argc--;
					break;

				case 'y':
					str = *++argv;

					if (sscanf(str, "%d", &yr) != 1)
						usage();

					mo = 1;
					day = 1;
					endmo = 12;
					endday = 31;
					argc--;
					break;

				case 'd':
					str = *++argv;

					if (sscanf(str, "%d-%d-%d", &yr, &mo, &day) != 3)
						usage();

					argc--;
					break;

				case 'e':
					str = *++argv;

					if (sscanf(str, "%d-%d-%d", &endyr, &endmo, &endday) != 3)
						usage();

					argc--;
					break;

				default:
					usage();
				}

		} else
			usage();
	}
}

/* 
*/

usage()
{
	printf("Usage: sun [-p] [-t h:m:s] [-d m/d/y] [-a lat] [-o lon] [-z tz]\n");

	printf("-t hh:mm:ss\ttime (default is current system time)\n");
	printf("-d yyyy-mm-dd\tfirst date (default is current system date)\n");
	printf("-e yyyy-mm-dd\tlast date (default is current system date)\n");
	printf("-a lat\t\tdecimal latitude (default = 37.75)\n");
	printf("-o lon\t\tdecimal longitude (default = 122.25) \n");
	printf("-z tz\t\ttimezone (default = 8, PST)\n");
	printf("\nDefaults are for Oakland, CA\n");
	exit(1);
}

/* 
*/

double
julian_date(m, d, y)
{
	int a, b;
	double jd;

	if (m == 1 || m == 2) {

		--y;
		m += 12;
	}

	if (y < 1583) {

		printf("ERROR:  Can't handle dates before 1583 \n");
		exit(1);
	}

	a = y/100;
	b = 2 - a + a/4;
	b += (int)((double)y * 365.25);
	b += (int)(30.6001 * ((double)m + 1.0));
	jd = (double)d + (double)b + 1720994.5;
	return(jd);
}

double
hms_to_dh(h, m, s)
{
	double rv;

	rv = h + m / 60.0 + s / 3600.0;
	return rv;
}

/* 
*/

double
solar_lon(ed)
double ed;
{
	double n, m, e, ect, errt, v;

	n = 360.0 * ed / 365.2422;
	n = adj360(n);
	m = n + 278.83354 - 282.596403;
	m = adj360(m);
	m = dtor(m);
	e = m; ect = 0.016718;

	while ((errt = e - ect * sin(e) - m) > 0.0000001) 
		e = e - errt / (1 - ect * cos(e));

	v = 2 * atan(1.0168601 * tan(e/2));
	v = adj360(v * 180.0 / PI + 282.596403);
	return(v);
}

/* 
*/

double
acos_deg(x)
double x;
{
	return rtod(acos(x));
}

double
asin_deg(x)
double x;
{
	return rtod(asin(x));
}

double
atan_q_deg(y,x)
double y,x;
{
	double rv;

	if (y == 0)
		rv = 0;
	else if (x == 0)
		rv = y>0 ? 90.0 : -90.0;
	else
		rv = atan_deg(y/x);

	if (x<0)
		return rv+180.0;

	if (y<0)
		return rv+360.0;

	return(rv);
}

/* 
*/

double
atan_deg(x)
double x;
{
	return rtod(atan(x));
}

double
sin_deg(x)
double x;
{
	return sin(dtor(x));
}

double
cos_deg(x)
double x;
{
	return cos(dtor(x));
}

double
tan_deg(x)
double x;
{
	return tan(dtor(x));
}

/* 
*/

lon_to_eq(lambda, alpha, delta)
double lambda;
double *alpha;
double *delta;
{
	double tlam,epsilon;

	tlam = dtor(lambda);
	epsilon = dtor((double)23.441884);
	*alpha = atan_q_deg((sin(tlam))*cos(epsilon),cos(tlam)) / 15.0;
	*delta = asin_deg(sin(epsilon)*sin(tlam));
}

rise_set(alpha, delta, lstr, lsts, ar, as)
double alpha, delta, *lstr, *lsts, *ar, *as;
{
	double tar;
	double h;

	tar = sin_deg(delta)/cos_deg(lat);

	if (tar < -1.0 || tar > 1.0) {

		printf("ERROR:  The object is circumpolar \n");
		exit (1);
	}

	*ar = acos_deg(tar);
	*as = 360.0 - *ar;

	h = acos_deg(-tan_deg(lat) * tan_deg(delta)) / 15.0;
	*lstr = 24.0 + alpha - h;

	if (*lstr > 24.0)
		*lstr -= 24.0;

	*lsts = alpha + h;

	if (*lsts > 24.0)
		*lsts -= 24.0;
}

/* 
*/

lst_to_hm(lst, jd, h, m)
double lst, jd;
int *h, *m;
{
	double ed, gst, jzjd, t, r, b, t0, gmt;

	gst = lst + lon / 15.0;

	if (gst > 24.0)
		gst -= 24.0;

	jzjd = julian_date(1,0,yr);
	ed = jd-jzjd;
	t = (jzjd -2415020.0)/36525.0;
	r = 6.6460656+2400.05126*t+2.58E-05*t*t;
	b = 24-(r-24*(yr-1900));
	t0 = ed * 0.0657098 - b;

	if (t0 < 0.0)
		t0 += 24;

	gmt = gst-t0;

	if (gmt<0) 
		gmt += 24.0;

	gmt = gmt * 0.99727 - tz;;

	if (gmt < 0)
		gmt +=24.0;

	dh_to_hm(gmt, h, m);
}

/* 
*/

dh_to_hm(dh, h, m)
double dh;
int *h, *m;
{
	double tempsec;

	*h = dh;
	*m = (dh - *h) * 60;
	tempsec = (dh - *h) * 60 - *m;
	tempsec = tempsec * 60 + 0.5;

	if (tempsec > 30)
		(*m)++;

	if (*m == 60) {

		*m = 0;
		(*h)++;
	}
}

/* 
*/

eq_to_altaz(r, d, t, alt, az)
double r, d, t;
double *alt, *az;
{
	double p = 3.14159265;
	double r1 = p / 180.0;
	double b = lat * r1;
	double l = (360 - lon) * r1;
	double t5, s1, c1, c2, s2, a, h;

	r = r * 15.0 * r1;
	d = d * r1;
	t = t * 15.0 * r1;
	t5 = t - r + l;
	s1 = sin(b) * sin(d) + cos(b) * cos(d) * cos(t5);
	c1 = 1 - s1 * s1;

	if (c1 > 0) {

		c1 = sqrt(c1);
		h = atan(s1 / c1);

	} else {

		h = (s1 / fabs(s1)) * (p / 2.0);
	}

	c2 = cos(b) * sin(d) - sin(b) * cos(d) * cos(t5);
	s2 = -cos(d) * sin(t5);

	if (c2 == 0) 
		a = (s2/fabs(s2)) * (p/2);
	else {

	a = atan(s2/c2);

		if (c2 < 0)
			a=a+p;
	}

	if (a<0)
		a=a+2*p;

	*alt = h / r1;
	*az = a / r1;
}

/* 
*/

double
gmst(j, f)
double j,f;
{
	double d, j0, t, t1, t2, s;

	d = j - 2451545.0;
	t = d / 36525.0;
	t1 = floor(t);
	j0 = t1 * 36525.0 + 2451545.0;
	t2 = (j - j0 + 0.5)/36525.0;
	s = 24110.54841 + 184.812866 * t1; 
	s += 8640184.812866 * t2;
	s += 0.093104 * t * t;
	s -= 0.0000062 * t * t * t;
	s /= 86400.0;
	s -= floor(s);
	s = 24 * (s + (f - 0.5) * 1.002737909);

	if (s < 0)
		s += 24.0;

	if (s > 24.0)
		s -= 24.0;

	return(s);
}
