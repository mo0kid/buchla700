/*
   =============================================================================
	etwoff.c -- waveshape editor - offset value field handlers
	Version 16 -- 1987-12-22 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_woff() -- load the edit buffer
   =============================================================================
*/

int16_t et_woff(int16_t n)
{
	register int16_t hoff;
	register int8_t hosgn;

	(void)n;

	lstwoff = curwoff;

	if (curwoff LT 0) {

		hosgn = '-';
		hoff = -curwoff;

	} else {

		hosgn = '+';
		hoff = curwoff;
	}

	sprintf(ebuf, "%c%04d", hosgn, hoff);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_woff() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_woff(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[5] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 1; i < 5; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GT 1023)
		return(FAILURE);

	if (ebuf[0] EQ '-')
		curwoff = -tmpval;
	else
		curwoff = tmpval;

	if (curwdth EQ NUMWIDS)
		wdintp();
	else
		pntsup();

	wdswin(0);
	wdswin(2);
	wdswin(4);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_woff() -- (re)display the field
   =============================================================================
*/

int16_t rd_woff(int16_t nn)
{
	register int16_t hoff, n;
	register int8_t hosgn;

	n = nn & 0xFF;
	lstwoff = curwoff;

	if (curwoff LT 0) {

		hosgn = '-';
		hoff = -curwoff;

	} else {

		hosgn = '+';
		hoff = curwoff;
	}

	sprintf(dspbuf, "%c%04d", hosgn, hoff);

	/* display the value */

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6], wdbox[n][7] + WOFF_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_woff() -- handle new data entry
   =============================================================================
*/

int16_t nd_woff(int16_t nn, int16_t k)
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

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(waveob, 64, WS_ENTRY, wdbox[n][5],
		stcrow, stccol, dspbuf, 14);

	advwcur();
	return(SUCCESS);
}

