/*
   =============================================================================
	etarat.c -- MIDAS assignment editor - phase shifter rate field
	Version 4 -- 1987-12-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_arat() -- load the edit buffer
   =============================================================================
*/

int16_t et_arat(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", ps_rate);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_arat() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_arat(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;
	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	ps_rate = tmpval;
	sendval(2, 0, ((ps_rate * 10) << 5));
	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_arat() -- (re)display the field
   =============================================================================
*/

int16_t rd_arat(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%02.2d", ps_rate);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		adbox[n][6] + 2, adbox[n][7] + 8, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_arat() -- handle new data entry
   =============================================================================
*/

int16_t nd_arat(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0xFF;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */

	ebuf[ec] = (int8_t)(k + '0');
	ebuf[2] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5], stcrow, stccol, dspbuf, 14);

	advacur();
	return(SUCCESS);
}


