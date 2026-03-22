/*
   =============================================================================
	dirfns.c -- miscellaneous directory functions
	Version 4 -- 1987-06-04 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

static int8_t atrcons[] = "ADVSHR";

/*
   =============================================================================
	atrstr(atr, s) -- convert attributes to character string
   =============================================================================
*/

int8_t *atrstr(int16_t atr, int8_t s[])
{
	register int16_t	i, j;

	i = 0x20;

	for (j = 0; j < 6; j++) {

		if (atr & i)
			s[j] = atrcons[j];
		else
			s[j] = '-';

		i >>= 1;
	}

	s[j] = '\0';
	return(s);
}

static int8_t *mnames[] = {

	"???",
	"Jan",
	"Feb",
	"Mar",
	"Apr",
	"May",
	"Jun",
	"Jul",
	"Aug",
	"Sep",
	"Oct",
	"Nov",
	"Dec"
	};

/*
   =============================================================================
	mname - convert month number to month name
   =============================================================================
*/

int8_t *mname(int16_t n)
{
	return((n < 1 || n > 12) ? mnames[0] : mnames[n]);
}

/*
   =============================================================================
	dtunpk(din, tin, s, fmt) -- unpack the date and time from DOS format
	into "yyyy-mm-dd hh:mm", "yyyy mmm dd hh:mm", or "mmm dd yyyy hh:mm"
	format.
   =============================================================================
*/

int8_t *dtunpk(uint16_t din, uint16_t tin, int8_t *s, int16_t fmt)
{
	register uint16_t	ftm, fdt;

	ftm = micon16(tin);
	fdt = micon16(din);

	switch (fmt) {

	case 0:		/* yyyy-mm-dd hh:mm format */

		sprintf(s, "%04d-%02d-%02d %02d:%02d",
			1980 + ((fdt >> 9) & 0x7F),
			(fdt >> 5) & 0xF,
			fdt & 0x1F,
			(ftm >> 11) & 0x1F,
			(ftm >> 5) & 0x3F
			);

		s[16] = '\0';
		break;

	case 1:		/* yyyy mmm dd hh:mm format */
	default:

		sprintf(s, "%04d %s %-2d %02d:%02d",
			1980 + ((fdt >> 9) & 0x7F),
			mname((fdt >> 5) & 0xF),
			fdt & 0x1F,
			(ftm >> 11) & 0x1F,
			(ftm >> 5) & 0x3F
			);

		s[17] = '\0';
		break;

	case 2:		/* mmm dd yyyy hh:mm format */

		sprintf(s, "%s %2d %04d %02d:%02d",
			mname((fdt >> 5) & 0xF),
			fdt & 0x1F,
			1980 + ((fdt >> 9) & 0x7F),
			(ftm >> 11) & 0x1F,
			(ftm >> 5) & 0x3F
			);

		s[17] = '\0';
		break;
	}

	return(s);
}

