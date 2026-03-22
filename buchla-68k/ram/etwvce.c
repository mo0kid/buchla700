/*
   =============================================================================
	etwvce.c -- waveshape editor - voice field handlers
	Version 8 -- 1987-12-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_wvce() -- load the edit buffer
   =============================================================================
*/

int16_t et_wvce(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", curvce + 1);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_wvce() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_wvce(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;
	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if ((tmpval EQ 0) OR (tmpval GT 12))
		return(FAILURE);

	newvce(tmpval - 1);
	wwins();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_wvce() -- (re)display the field
   =============================================================================
*/

int16_t rd_wvce(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%02d", curvce + 1);

	vbank(0);
	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6], wdbox[n][7] + WVCE_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_wvce() -- handle new data entry
   =============================================================================
*/

int16_t nd_wvce(int16_t nn, int16_t k)
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
		stcrow, stccol, dspbuf, 14);

	advwcur();
	return(SUCCESS);
}

