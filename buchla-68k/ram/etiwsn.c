/*
   =============================================================================
	etiwsn.c -- MIDAS instrument editor - waveshape number handlers
	Version 6 -- 1988-04-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_iwsn() -- load the edit buffer
   =============================================================================
*/

int16_t et_iwsn(int16_t nn)
{
	register int16_t m;

	m = nn >> 8;

	sprintf(ebuf, "%02d", m ? vbufs[curvce].idhwsb + 1
		: vbufs[curvce].idhwsa + 1);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_iwsn() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_iwsn(int16_t nn)
{
	int16_t i, tmpval, m;
	volatile uint16_t *fpuws;

	m = nn >> 8;
	ebuf[2] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	tmpval = 0;

	for (i = 0; i < 2; i++)		/* convert from ASCII to binary */
		tmpval = (tmpval * 10) + (ebuf[i] - '0');

	if ((tmpval EQ 0) OR (tmpval GT NUMWAVS))
		return(FAILURE);

	if (m) {

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

		*(fpuws - 1) = (uint8_t)vbufs[curvce].idhwvaf[0];
		*(fpuws + NUMWPNT) = (uint8_t)vbufs[curvce].idhwvaf[NUMWPNT - 1];
	}

	dswin(21);
	modinst();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_iwsn() -- (re)display the field
   =============================================================================
*/

int16_t rd_iwsn(int16_t nn)
{
	register int16_t m, n;

	m = (nn >> 8) & 0x00FF;
	n = nn & 0x00FF;

	sprintf(dspbuf, "%02d", m ? vbufs[curvce].idhwsb + 1
			: vbufs[curvce].idhwsa + 1);

	vbank(0);

	vcputsv(instob, 64, (m ? WSBFC : WSAFC), idbox[n][5],
		cfetp->frow, cfetp->flcol, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_iwsn() -- handle new data entry
   =============================================================================
*/

int16_t nd_iwsn(int16_t nn, int16_t k)
{
	register int16_t ec, n;

	n = nn & 0x00FF;

	ec = stccol - cfetp->flcol;	/* setup edit buffer column */
	ebuf[ec] = (int8_t)(k + '0');	/* enter new data in buffer */
	ebuf[2] = '\0';			/* make sure string is terminated */

	dspbuf[0] = (int8_t)(k + '0');	/* setup for display */
	dspbuf[1] = '\0';

	vbank(0);			/* display the new data */
	vcputsv(instob, 64, ID_ENTRY, idbox[n][5], stcrow, stccol, dspbuf, 14);

	advicur();			/* advance cursor */

	return(SUCCESS);
}


