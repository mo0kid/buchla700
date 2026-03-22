/*
   =============================================================================
	etaopt.c -- assignment editor - MIDI output port number field handlers
	Version 4 -- 1987-12-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_aopt() -- load the edit buffer
   =============================================================================
*/

int16_t et_aopt(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%01.1d", curmop);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_aopt() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_aopt(int16_t n)
{
	register int16_t tmpval;

	(void)n;

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = ebuf[0] - '0';

	if (tmpval GT 3)
		return(FAILURE);

	curmop = tmpval;
	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_aopt() -- (re)display the field
   =============================================================================
*/

int16_t rd_aopt(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		adbox[n][6], adbox[n][7] + 9, gprep[curmop], 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_aopt() -- handle new data entry
   =============================================================================
*/

int16_t nd_aopt(int16_t nn, int16_t k)
{
	register int16_t n;

	if ((k < 1) OR (k > 2))
		return(FAILURE);

	n = nn & 0xFF;
	ebuf[0] = (int8_t)(k + '0');
	ebuf[1] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5], stcrow, stccol, dspbuf, 14);

	return(SUCCESS);
}


