/*
   =============================================================================
	etagpt.c -- assignment editor - group to input port field handlers
	Version 5 -- 198-10-04 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_agpt() -- load the edit buffer
   =============================================================================
*/

int16_t et_agpt(int16_t n)
{
	register int16_t grp;

	grp = 0x00FF & (n >> 8);

	ebuf[0] = (int8_t)grp2prt[grp][0];
	ebuf[1] = '\0';

	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_agpt() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_agpt(int16_t n)
{
	register int16_t grp, i;

	grp = 0x00FF & (n >> 8);

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	grp2prt[grp][0] = ebuf[0];

	if (grp2prt[grp][0] NE 1)
		for (i = 0; i < 88; i++)
			key2grp[i] &= ~(0x0001 << grp);

	drawk2g(grp);

	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_agpt() -- (re)display the field
   =============================================================================
*/

int16_t rd_agpt(int16_t nn)
{
	register int16_t n, grp;

	n   = 0x00FF & nn;
	grp = 0x00FF & (nn >> 8);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		cfetp->frow, cfetp->flcol, gprep[grp2prt[grp][0]], 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_agpt() -- handle new data entry
   =============================================================================
*/

int16_t nd_agpt(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0x00FF;

	if (k EQ 8) {		/* '-' */

		if (--ebuf[0] LT 0)
			ebuf[0] = 3;

	} else if (k EQ 9) {	/* '+' */

		if (++ebuf[0] GT 3)
			ebuf[0] = 0;

	} else {

		return(FAILURE);
	}

	dspbuf[0] = *gprep[(int16_t)ebuf[0]];
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5], stcrow, stccol, dspbuf, 14);

	return(SUCCESS);
}


