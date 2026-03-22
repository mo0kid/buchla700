/*
   =============================================================================
	etwpnt.c -- waveshape editor - point number field handlers
	Version 8 -- 1987-12-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_wpnt() -- load the edit buffer
   =============================================================================
*/

int16_t et_wpnt(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%03d", curwpnt);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_wpnt() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_wpnt(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[3] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 0; i < 3; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GE NUMWPNT)
		return(FAILURE);

	curwpnt = tmpval;
	newws();
	wdswin(4);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_wpnt() -- (re)display the field
   =============================================================================
*/

int16_t rd_wpnt(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%03d", curwpnt);

	vbank(0);
	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6], wdbox[n][7] + WPNT_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_wpnt() -- handle new data entry
   =============================================================================
*/

int16_t nd_wpnt(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0xFF;
	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');
	ebuf[3] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);

	vcputsv(waveob, 64, WS_ENTRY, wdbox[n][5],
		wdbox[n][6], stccol, dspbuf, 14);

	advwcur();

	return(SUCCESS);
}

