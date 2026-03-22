/*
   =============================================================================
	etires.c -- instrument editor - resonance field handlers
	Version 2 -- 1988-05-11 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

int16_t	rsntab[] = {		/* resonance table */

	0,		/* 0 =  0.00 */
	(110 << 5),	/* 1 =  1.10 */
	(220 << 5),	/* 2 =  2.20 */
	(330 << 5),	/* 3 =  3.30 */
	(440 << 5),	/* 4 =  4.40 */
	(550 << 5),	/* 5 =  5.50 */
	(660 << 5),	/* 6 =  6.60 */
	(770 << 5),	/* 7 =  7.70 */
	(880 << 5),	/* 8 =  8.80 */
	(1000 << 5)	/* 9 = 10.00 */
};

/*
   =============================================================================
	et_ires() -- load the edit buffer
   =============================================================================
*/

int16_t et_ires(int16_t n)
{
	(void)n;

	if (curfunc NE 4)
		return(FAILURE);

	ebuf[0] = (int8_t)('0' + vbufs[curvce].idhfnc[4].idfprm);
	ebuf[1] = '\0';
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	ef_ires() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_ires(int16_t n)
{
	register int16_t tmpval;

	(void)n;

	if (curfunc NE 4)
		return(FAILURE);

	ebuf[1] = '\0';
	ebflag = FALSE;
	tmpval = ebuf[0] - '0';
	vbufs[curvce].idhfnc[4].idfprm = (int8_t)tmpval;
	sendval(curvce, 6, rsntab[tmpval]);
	modinst();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_ires() -- (re)display the point number
   =============================================================================
*/

int16_t rd_ires(int16_t n)
{
	register struct idfnhdr *fp;

	fp = &vbufs[curvce].idhfnc[4];

	if (curfunc NE 4)
		return(FAILURE);

	dspbuf[0] = (int8_t)('0' + fp->idfprm);
	dspbuf[1] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(instob, 64, ((fp->idftmd & I_TM_KEY) ? idbox[n][4] : ID_INST),
		idbox[n][5], idbox[n][6] + 1, idbox[n][7] + 8, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_ires() -- handle new data entry
   =============================================================================
*/

int16_t nd_ires(int16_t n, int16_t k)
{
	if (curfunc NE 4)
		return(FAILURE);

	dspbuf[0] = ebuf[0] = (int8_t)(k + '0');
	dspbuf[1] = ebuf[1] = '\0';

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(instob, 64, ID_ENTRY, idbox[n][5], stcrow, stccol, dspbuf, 14);
	return(SUCCESS);
}

