/*
   =============================================================================
	etwhrv.c -- waveshape editor - harmonic value field handlers
	Version 12 -- 1988-09-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_whrv() -- load the edit buffer
   =============================================================================
*/

int16_t et_whrv(int16_t n)
{
	register int16_t harv;
	register int8_t hvsgn;

	(void)n;

	if (curwhrv LT 0) {

		hvsgn = '-';
		harv = -curwhrv;

	} else {

		hvsgn = '+';
		harv = curwhrv;
	}

	sprintf(ebuf, "%c%03d", hvsgn, harv);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_whrv() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_whrv(int16_t n)
{
	register int16_t *hv;
	register int16_t i, tmpval;

	(void)n;

	ebuf[4] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 1; i < 4; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GT 100)
		return(FAILURE);

	if (ebuf[0] EQ '-')
		curwhrv = -tmpval;
	else
		curwhrv = tmpval;

	hv = curwslt ? vbufs[curvce].idhwvbh : vbufs[curvce].idhwvah;
	hv[curwhrm] = curwhrv;
	vmtab[curwhrm] = curwhrv;
	adj(curwhrm);
	wscalc();
	whupd();
	wsnmod[curvce][curwslt] = TRUE;
	wdswin(0);
	wdswin(2);
	wdswin(4);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_whrv() -- (re)display the field
   =============================================================================
*/

int16_t rd_whrv(int16_t nn)
{
	register int16_t harv, n;
	register int8_t hvsgn;

	n = nn & 0x00FF;

	if (curwhrv LT 0) {

		hvsgn = '-';
		harv = -curwhrv;

	} else {

		hvsgn = '+';
		harv = curwhrv;
	}

	sprintf(dspbuf, "%c%03d", hvsgn, harv);

	vbank(0);			/* display the value */
	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6] + 1, wdbox[n][7] + WHRV_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_whrv() -- handle new data entry
   =============================================================================
*/

int16_t nd_whrv(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n  = nn & 0x00FF;
	ec = stccol - cfetp->flcol;	/* setup edit buffer column */

	if (ec EQ 0) {

		if (k EQ 8) {

			ebuf[0] = dspbuf[0] = '-';
			ebuf[4] = dspbuf[1] = '\0';

		} else if (k EQ 9) {

			ebuf[0] = dspbuf[0] = '+';
			ebuf[4] = dspbuf[1] = '\0';

		} else {

			return(FAILURE);
		}

	} else {

		ebuf[ec] = dspbuf[0] = (int8_t)(k + '0');
		ebuf[4]  = dspbuf[1] = '\0';
	}

	vbank(0);
	vcputsv(waveob, 64, WS_ENTRY, wdbox[n][5],
		stcrow, stccol, dspbuf, 14);

	advwcur();
	return(SUCCESS);
}

