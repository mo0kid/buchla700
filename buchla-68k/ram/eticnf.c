/*
   =============================================================================
	eticnf.c -- instrument editor - configuration number field handlers
	Version 16 -- 1988-08-23 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	CFG_OFF		10	/* display offset into configuration field */

/*
   =============================================================================
	et_icnf() -- load the edit buffer
   =============================================================================
*/

int16_t et_icnf(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", vbufs[curvce].idhcfg);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_icnf() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_icnf(int16_t n)
{
	register int16_t i, tmpval;

	(void)n;

	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if (tmpval GE NUMCFG)		/* check against limit */
		return(FAILURE);

	vbufs[curvce].idhcfg = (int8_t)tmpval;
	dosync(curvce);
	showcfg(tmpval);
	modinst();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_icnf() -- (re)display the field
   =============================================================================
*/

int16_t rd_icnf(int16_t n)
{
	sprintf(dspbuf, "%02d", vbufs[curvce].idhcfg);	/* convert */

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(instob, 64, idbox[n][4], idbox[n][5],		/* display */
		idbox[n][6], idbox[n][7] + CFG_OFF, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_icnf() -- handle new data entry
   =============================================================================
*/

int16_t nd_icnf(int16_t n, int16_t k)
{
	register int16_t ec;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');	/* enter new data in buffer */
	ebuf[2] = '\0';			/* make sure string is terminated */

	dspbuf[0] = (int8_t)(k + '0');	/* setup for display */
	dspbuf[1] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	/* display the new data */

	vcputsv(instob, 64, ID_ENTRY, idbox[n][5],
		idbox[n][6], stccol, dspbuf, 14);

	advicur();			/* advance cursor */

	return(SUCCESS);
}


