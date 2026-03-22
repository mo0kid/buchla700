/*
   =============================================================================
	etatun.c -- MIDAS assignment editor - tuning table field handlers
	Version 1 -- 1987-12-10 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_atun() -- load the edit buffer
   =============================================================================
*/

int16_t et_atun(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%01.1d", curtun);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_atun() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_atun(int16_t n)
{
	register int16_t tmpval;

	(void)n;

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = ebuf[0] - '0';

	gettun(tmpval);

	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_atun() -- (re)display the field
   =============================================================================
*/

int16_t rd_atun(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "Tun %01.1d", curtun);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		adbox[n][6], adbox[n][7], dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_atun() -- handle new data entry
   =============================================================================
*/

int16_t nd_atun(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0xFF;
	ebuf[0] = (int8_t)(k + '0');
	ebuf[1] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5],
		stcrow, stccol, dspbuf, 14);

	return(SUCCESS);
}


