/*
   =============================================================================
	etmcfn.c -- instrument editor - ws/cf menu field handlers
	Version 7 -- 1988-08-26 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_mcfn() -- load the edit buffer
   =============================================================================
*/

int16_t et_mcfn(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02d", vbufs[curvce].idhcfg);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_mcfn() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_mcfn(int16_t n)
{
	register int16_t tmpval;

	(void)n;

	wmctag = FALSE;
	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = ((ebuf[0] - '0') * 10) + (ebuf[1] - '0');

	if (tmpval GE NUMCFG)		/* check against limit */
		return(FAILURE);

	vbufs[curvce].idhcfg = (int8_t)tmpval;
	dosync(curvce);
	wmctag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	rd_mcfn() -- (re)display the field
   =============================================================================
*/

int16_t rd_mcfn(int16_t n)
{
	(void)n;

	sprintf(dspbuf, "%02d", vbufs[curvce].idhcfg);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(instob, 64, CFBX18, CBBX18, 24, 16, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_mcfn() -- handle new data entry
   =============================================================================
*/

int16_t nd_mcfn(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');	/* enter new data in buffer */
	ebuf[2] = '\0';			/* make sure string is terminated */

	dspbuf[0] = (int8_t)(k + '0');	/* setup for display */
	dspbuf[1] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	/* display the new data */

	vcputsv(instob, 64, ID_ENTRY, CBBX18, stcrow, stccol, dspbuf, 14);

	advicur();			/* advance cursor */

	return(SUCCESS);
}

/*
   =============================================================================
	et_mwsn() -- load the edit buffer
   =============================================================================
*/

int16_t et_mwsn(int16_t nn)
{
	wmcsel = (nn & (int16_t)0xFF00) ? 1 : 0;

	sprintf(ebuf, "%02d", 1 + (wmcsel ? vbufs[curvce].idhwsb
		: vbufs[curvce].idhwsa));

	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_mwsn() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_mwsn(int16_t nn)
{
	int16_t tmpval;
	volatile uint16_t *fpuws;

	wmcsel = (nn & (int16_t)0xFF00) ? 1 : 0;

	wmctag = FALSE;
	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	/* convert from ASCII to binary */

	tmpval = ((ebuf[0] -'0') * 10) + (ebuf[1] - '0');

	if ((tmpval < 1) OR (tmpval > NUMWAVS))
		return(FAILURE);

	if (wmcsel) {

		/* slot B */
		vbufs[curvce].idhwsb = (int8_t)(tmpval - 1);

		memcpyw(vbufs[curvce].idhwvbf, &wslib[tmpval - 1],
			NUMHARM + (2 * NUMWPNT));

		fpuws = io_fpu + FPU_OWST + (curvce << 9) + 1;

		memcpyw(fpuws, vbufs[curvce].idhwvbf, NUMWPNT);

		*(fpuws - 1) = (uint16_t)vbufs[curvce].idhwvbf[0];
		*(fpuws + NUMWPNT) = (uint16_t)vbufs[curvce].idhwvbf[NUMWPNT - 1];

	} else {

		/* slot A */

		vbufs[curvce].idhwsa = (int8_t)(tmpval - 1);

		memcpyw(vbufs[curvce].idhwvaf, &wslib[tmpval - 1],
			NUMHARM + (2 * NUMWPNT));

		fpuws = io_fpu + FPU_OWST + (curvce << 9) + 0x100 + 1;

		memcpyw(fpuws, vbufs[curvce].idhwvaf, NUMWPNT);

		*(fpuws - 1) = (uint16_t)vbufs[curvce].idhwvaf[0];
		*(fpuws + NUMWPNT) = (uint16_t)vbufs[curvce].idhwvaf[NUMWPNT - 1];
	}

	wmctag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	rd_mwsn() -- (re)display the field
   =============================================================================
*/

int16_t rd_mwsn(int16_t nn)
{
	wmcsel = (nn & (int16_t)0xFF00) ? 1 : 0;

	sprintf(dspbuf, "%02d", 1 + (wmcsel ? vbufs[curvce].idhwsb
			: vbufs[curvce].idhwsa));

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(instob, 64, CFBX23, CBBX23, 24, wmcsel ? 16 : 12, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_mwsn() -- handle new data entry
   =============================================================================
*/

int16_t nd_mwsn(int16_t nn, int16_t k)
{
	register int16_t ec;

	(void)nn;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');	/* enter new data in buffer */
	ebuf[2]  = '\0';		/* make sure string is terminated */

	dspbuf[0] = (int8_t)(k + '0');	/* setup for display */
	dspbuf[1] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);			/* display the new data */

	vcputsv(instob, 64, ID_ENTRY, CBBX23, stcrow, stccol, dspbuf, 14);

	advicur();			/* advance cursor */

	return(SUCCESS);
}

