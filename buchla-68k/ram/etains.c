/*
   =============================================================================
	etains.c -- MIDAS assignment editor -- instrument to groups
	Version 10 -- 1988-07-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	modasg() -- indicate that the assignment table was modified
   =============================================================================
*/

void modasg(void)
{
	if (NOT asgmod) {

		asgmod = TRUE;
		adswin(0);
	}
}

/*
   =============================================================================
	et_ains() -- load the edit buffer
   =============================================================================
*/

int16_t et_ains(int16_t n)
{
	register int16_t grp;

	grp = 0x00FF & (n >> 8);

	sprintf(ebuf, "%02.2d", ins2grp[grp] & 0x00FF);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_ains() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_ains(int16_t n)
{
	register int16_t tmpval, grp, i;

	grp = 0x00FF & (n >> 8);
	ebuf[2] = '\0';
	ebflag = FALSE;
	tmpval = 0;

	for (i = 0; i < 2; i++)
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GE NINST )
		return(FAILURE);

	ins2grp[grp] = tmpval | (ins2grp[grp] & (int16_t)0xFF00);
	modasg();
	setv2gi(grp);
	setinst();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_ains() -- (re)display the field
   =============================================================================
*/

int16_t rd_ains(int16_t nn)
{
	register int16_t n, grp;

	n = 0x00FF & nn;
	grp = 0x00FF & (nn >> 8);

	sprintf(dspbuf, "%02.2d", ins2grp[grp] & 0x00FF);

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		cfetp->frow, cfetp->flcol, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_ains() -- handle new data entry
   =============================================================================
*/

int16_t nd_ains(int16_t nn, int16_t k)
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


