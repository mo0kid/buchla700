/*
   =============================================================================
	etwslt.c -- waveshape editor - waveshape slot field handlers
	Version 8 -- 1987-12-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

/*
   =============================================================================
	et_wslt() -- load the edit buffer
   =============================================================================
*/

int16_t et_wslt(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%c", curwslt + 'A');
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_wslt() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_wslt(int16_t n)
{
	(void)n;

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	curwslt = ebuf[0] - 'A';

#if DEBUGIT
	printf("ef_wslt($%04X):  ebuf[%s], curwslt=%d\r\n", n, ebuf, curwslt);
#endif

	newws();
	dsnewws();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_wslt() -- (re)display the field
   =============================================================================
*/

int16_t rd_wslt(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%c", curwslt + 'A');

	vbank(0);
	vcputsv(waveob, 64, wdbox[n][4], wdbox[n][5],
		wdbox[n][6] + 1, wdbox[n][7] + WSLT_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_wslt() -- handle new data entry
   =============================================================================
*/

int16_t nd_wslt(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0xFF;

#if DEBUGIT
	printf("nd_wslt($%04X, %d)\r\n", nn, k);
#endif

	if (k GT 1)
		return(FAILURE);

	ebuf[0] = (int8_t)(k + 'A');
	ebuf[1] = '\0';

	dspbuf[0] = (int8_t)(k + 'A');
	dspbuf[1] = '\0';

#if DEBUGIT
	printf("nd_wslt($%04X, %d):  ebuf[%s]\r\n", nn, k, ebuf);
#endif

	vbank(0);
	vcputsv(waveob, 64, WS_ENTRY, wdbox[n][5],
		stcrow, stccol, dspbuf, 14);

	advwcur();
	return(SUCCESS);
}

