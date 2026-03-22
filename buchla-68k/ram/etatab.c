/*
   =============================================================================
	etatab.c -- assignment editor - assignment table number field handlers
	Version 9 -- 1988-08-22 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_atab() -- load the edit buffer
   =============================================================================
*/

int16_t et_atab(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", curasg);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_atab() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_atab(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;
	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GE NASGS)
		return(FAILURE);

	curasg = tmpval;
	asgmod = TRUE;
	adswin(0);

	settc(2, 6);

	return(SUCCESS);
}

/*
   =============================================================================
	rd_atab() -- (re)display the field
   =============================================================================
*/

int16_t rd_atab(int16_t nn)
{
	register int16_t n;

	n = nn & 0xFF;
	sprintf(dspbuf, "%02.2d", curasg);

	point = adpoint;

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(asgob, 64, (asgmod ? AK_MODC : adbox[n][4]), adbox[n][5],
		cfetp->frow, cfetp->flcol, dspbuf, 14);

	lseg(0, 0, 128, 0, AK_BORD);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_atab() -- handle new data entry
   =============================================================================
*/

int16_t nd_atab(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0xFF;
	ec = stccol - cfetp->flcol;	/* setup edit buffer column */

	ebuf[ec] = (int8_t)(k + '0');
	ebuf[2] = '\0';

	dspbuf[0] = (int8_t)(k + '0');
	dspbuf[1] = '\0';

	point = adpoint;

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5],
		stcrow, stccol, dspbuf, 14);

	lseg(0, 0, 128, 0, AK_BORD);

	advacur();
	return(SUCCESS);
}


