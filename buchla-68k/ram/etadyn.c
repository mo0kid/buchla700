/*
   =============================================================================
	etadyn.c -- MIDAS assignment editor -- dynamics to group field handlers
	Version 7 -- 1988-07-13 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_adyn() -- load the edit buffer
   =============================================================================
*/

int16_t et_adyn(int16_t n)
{
	register int16_t grp;

	grp = 0x00FF & (n >> 8);

	ebuf[0] = (int8_t)(grpdyn[grp] + '0');
	ebuf[1] = '\0';

	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	setdyn() -- set dynamics for a group
   =============================================================================
*/

void setdyn(int16_t grp, int16_t dyn)
{
	int16_t g, i, val;
	volatile uint16_t *fpu;
	struct idfnhdr *fp;
	uint16_t fpmant, fpexp;
	uint16_t oldsr;
	volatile int16_t nop = 0;

	grpdyn[grp] = dyn;
	val = dyntab[dyn];
	g = grp + 1;

	fpmant = (uint16_t)(((uint32_t)(curintp & 0xFFF0) *
		  (uint32_t)timemlt) >> 15);

	fpexp = expbit[curintp & 0x000F];


	for (i = 0; i < 12; i++)
		if (g EQ vce2grp[i]) {

			fp = &vbufs[i].idhfnc[8];
			fpu = io_fpu + FPU_OFNC + (i << 8) + 0x0080;

			oldsr = setsr(0x2200);

/* ++++++++++++++++++++++++++++ FPU interrupts disabled +++++++++++++++++++++ */

			fp->idftmd ^= I_NVBITS;
			*(fpu + (int32_t)FPU_TMNT) = fpmant;
			++nop;	++nop;	++nop;
			*(fpu + (int32_t)FPU_TEXP) = fpexp;
			++nop;	++nop;	++nop;

			if (fp->idftmd & I_VNSUBN)
				*(fpu + (int32_t)FPU_TNV1) = (uint16_t)val;
			else
				*(fpu + (int32_t)FPU_TNV0) = (uint16_t)val;

			++nop;	++nop;	++nop;

			*(fpu + (int32_t)FPU_TCTL) =
				(uint16_t)((fp->idftmd & (I_NRATIO | I_NVBITS)) | 0x0001);

			setsr(oldsr);

/* ++++++++++++++++++++++++++++ Interrupts restored +++++++++++++++++++++++++ */

		}
}

/*
   =============================================================================
	ef_adyn() -- parse (unload) the edit buffer
   =============================================================================
*/

int16_t ef_adyn(int16_t n)
{
	register int16_t dyn, grp;

	grp = 0x00FF & (n >> 8);

	ebuf[1] = '\0';			/* terminate the string in ebuf */
	ebflag = FALSE;

	dyn = ebuf[0] - '0';

	setdyn(grp, dyn);
	modasg();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_adyn() -- (re)display the field
   =============================================================================
*/

int16_t rd_adyn(int16_t nn)
{
	register int16_t n, grp;

	n = 0x00FF & nn;
	grp = 0x00FF & (nn >> 8);

	dspbuf[0] = (int8_t)(grpdyn[grp] + '0');
	dspbuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, adbox[n][4], adbox[n][5],
		cfetp->frow, cfetp->flcol, dspbuf, 14);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_adyn() -- handle new data entry
   =============================================================================
*/

int16_t nd_adyn(int16_t nn, int16_t k)
{
	register int16_t n;

	n = nn & 0xFF;

	dspbuf[0] = ebuf[0] = (int8_t)(k + '0');
	dspbuf[1] = ebuf[1] = '\0';

	vbank(0);
	vcputsv(asgob, 64, AK_ENTRY, adbox[n][5], stcrow, stccol, dspbuf, 14);

	return(SUCCESS);
}


