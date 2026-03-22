/*
   =============================================================================
	etaprg.c -- MIDAS assignment editor - program change channel field
	Version 3 -- 1987-12-21 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

/*
   =============================================================================
	et_aprg() -- load the edit buffer
   =============================================================================
*/

int16_t et_aprg(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", prgchan);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_aprg() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_aprg(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;
	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

#if	DEBUGIT
	if (debugsw)
		printf("ef_aprg($%04.4X):  ebuf=[%s], tmpval=%d\n",
			n, ebuf, tmpval);
#endif

	if ((tmpval EQ 0) OR (tmpval GT 16))
		return(FAILURE);

	prgchan = tmpval;
	return(SUCCESS);
}

/*
   =============================================================================
	rd_aprg() -- (re)display the field
   =============================================================================
*/

int16_t rd_aprg(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%02.2d", prgchan);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		adbox[n][6], adbox[n][7] + 8, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_aprg() -- handle new data entry
   =============================================================================
*/

int16_t nd_aprg(int16_t nn, int16_t k)
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


