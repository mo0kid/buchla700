/*
   =============================================================================
	etaccn.c -- assignment editor - source controller number field handlers
	Version 7 -- 1988-03-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_accn() -- load the edit buffer
   =============================================================================
*/

int16_t et_accn(int16_t n)
{
	register int16_t ctl;

	ctl = 0x00FF & (n >> 8);

	numblk(ebuf, (mctlnum[ctl] & 0x00FF));
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_accn() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_accn(int16_t n)
{
	register int16_t tmpval, ctl, i;

	ctl = 0x00FF & (n >> 8);

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;
	tmpval = 0;

	if ((ebuf[0] EQ ' ') AND (ebuf[1] EQ ' ')) {

		tmpval = -1;

	} else {

		for (i = 0; i < 2; i++) {

			if (ebuf[i] EQ ' ')
				ebuf[i] = '0';

			tmpval = (tmpval * 10) + (ebuf[i] - '0');
		}
	}

	if (mctlnum[ctl] EQ -1)
		mctlnum[ctl] = tmpval;
	else
		mctlnum[ctl] = (mctlnum[ctl] & (int16_t)0xFF00) | tmpval;

	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_accn() -- (re)display the field
   =============================================================================
*/

int16_t rd_accn(int16_t nn)
{
	register int16_t n, ctl;
	int8_t buf[4];

	n = 0x00FF & nn;
	ctl = 0x00FF & (nn >> 8);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		cfetp->frow, cfetp->flcol,
		numblk(buf, (mctlnum[ctl] & 0x00FF)), 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_accn() -- handle new data entry
   =============================================================================
*/

int16_t nd_accn(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0xFF;
	ebuf[stccol - cfetp->flcol] = (int8_t)(k + '0');
	ebuf[2] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5],
		stcrow, stccol, dspbuf, 14);

	advacur();
	return(SUCCESS);
}


