/*
   =============================================================================
	etagch.c -- assignment editor - group to channel number field handlers
	Version 6 -- 1987-12-10 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_agch() -- load the edit buffer
   =============================================================================
*/

int16_t et_agch(int16_t n)
{
	register int16_t grp;

	grp = 0x00FF & (n >> 8);

	numblk(ebuf, grp2prt[grp][1]);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_agch() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_agch(int16_t n)
{
	register int16_t tmpval, grp, i;

	grp = 0x00FF & (n >> 8);

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

		if ((tmpval EQ 0) OR (tmpval GT 16))
			return(FAILURE);
	}

	grp2prt[grp][1] = tmpval;

	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_agch() -- (re)display the field
   =============================================================================
*/

int16_t rd_agch(int16_t nn)
{
	register int16_t n, grp;
	int8_t buf[4];

	n = 0x00FF & nn;
	grp = 0x00FF & (nn >> 8);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		cfetp->frow, cfetp->flcol, numblk(buf, grp2prt[grp][1]), 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_agch() -- handle new data entry
   =============================================================================
*/

int16_t nd_agch(int16_t nn, int16_t k)
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


