/*
   =============================================================================
	etwhar.c -- waveshape editor - harmonic number field handlers
	Version 5 -- 1987-12-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_whar() -- load the edit buffer
   =============================================================================
*/

int16_t et_whar(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", curwhrm + 1);
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_whar() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_whar(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if ((tmpval GT NUMHARM) OR (tmpval EQ 0))
		return(FAILURE);

	curwhrm = tmpval - 1;
	newws();
	wdswin(5);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_whar() -- (re)display the field
   =============================================================================
*/

int16_t rd_whar(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%02d", curwhrm + 1);

	vbank(0);			/* display the value */
	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6], wdbox[n][7] + WHRM_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_whar() -- handle new data entry
   =============================================================================
*/

int16_t nd_whar(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0xFF;
	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');
	ebuf[2] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(waveob, 64, WS_ENTRY, wdbox[n][5],
		wdbox[n][6], stccol, dspbuf, 14);

	advwcur();
	return(SUCCESS);
}

