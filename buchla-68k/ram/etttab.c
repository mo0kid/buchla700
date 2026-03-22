/*
   =============================================================================
	etttab.c -- MIDAS tuning editor - tuning table number field handlers
	Version 3 -- 1988-08-22 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_ttab() -- load the edit buffer
   =============================================================================
*/

int16_t et_ttab(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%d", curtun);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_ttab() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_ttab(int16_t n)
{
	(void)n;

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	curtun = ebuf[0] - '0';
	modtun();
	settc(22, 54);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_ttab() -- (re)display the field
   =============================================================================
*/

int16_t rd_ttab(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%d", curtun);

	vbank(0);
	vcputsv(tunob, 64, (tunmod ? TDCHGD : tdbox[n][4]), tdbox[n][5],
		24, 61, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_ttab() -- handle new data entry
   =============================================================================
*/

int16_t nd_ttab(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0xFF;

	ebuf[0] = (int8_t)(k + '0');
	ebuf[1] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(tunob, 64, TDENTRY, tdbox[n][5], stcrow, stccol, dspbuf, 14);

	return(SUCCESS);
}

