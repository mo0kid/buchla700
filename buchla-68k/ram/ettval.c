/*
   =============================================================================
	ettval.c -- MIDAS tuning editor -- value field handlers
	Version 2 -- 1987-12-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	modtun() -- indicate that the tuning table was modified
   =============================================================================
*/

void modtun(void)
{
	if (NOT tunmod) {

		tunmod = TRUE;
		tdswin(6);
	}
}

/*
   =============================================================================
	et_tval() -- load the edit buffer
   =============================================================================
*/

int16_t et_tval(int16_t n)
{
	register int16_t tv;
	register int8_t ts;

	(void)n;

	tv = (tunval < 0 ? -tunval : tunval) >> 1;
	ts = tunval < 0 ? '-' : '+';

	sprintf(ebuf, "%c%04d", ts, tv);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_tval() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_tval(int16_t n)
{
	register int16_t i, tmpval, tv;
	register int8_t ts;

	ebuf[5] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 1; i < 5; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (ebuf[0] EQ '-')
		tunval = -tmpval << 1;
	else
		tunval = tmpval << 1;

	tv = (tunval < 0 ? -tunval : tunval) >> 1;
	ts = tunval < 0 ? '-' : '+';
	sprintf(dspbuf, "Val %c%04d", ts, tv);

	vbank(0);
	vcputsv(tunob, 64, tdbox[n][4], tdbox[n][5], 18, 54, dspbuf, 14);

	modtun();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_tval() -- (re)display the field
   =============================================================================
*/

int16_t rd_tval(int16_t nn)
{
	register int16_t tv, n;
	register int8_t ts;

	n = nn & 0xFF;

	tv = (tunval < 0 ? -tunval : tunval) >> 1;
	ts = tunval < 0 ? '-' : '+';

	sprintf(dspbuf, "Val %c%04d", ts, tv);

	vbank(0);
	vcputsv(tunob, 64, tdbox[n][4], tdbox[n][5], 18, 54, dspbuf, 14);
	return(SUCCESS);
}

/*
   =============================================================================
	nd_tval() -- handle new data entry
   =============================================================================
*/

int16_t nd_tval(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0xFF;
	ec = stccol - cfetp->flcol;	/* setup edit buffer column */

	if (ec EQ 0) {

		if (k EQ 8) {

			ebuf[0] = '-';
			ebuf[5] = '\0';

			dspbuf[0] = '-';
			dspbuf[1] = '\0';

		} else if (k EQ 9) {

			ebuf[0] = '+';
			ebuf[5] = '\0';

			dspbuf[0] = '+';
			dspbuf[1] = '\0';

		} else {

			return(FAILURE);
		}

	} else {

		ebuf[ec] = (int8_t)(k + '0');
		ebuf[5] = '\0';

		dspbuf[0] = (int8_t)(k + '0');
		dspbuf[1] = '\0';
	}

	vbank(0);
	vcputsv(tunob, 64, TDENTRY, tdbox[n][5], stcrow, stccol, dspbuf, 14);

	advtcur();
	return(SUCCESS);
}


