/*
   =============================================================================
	etloc.c -- location field handlers
	Version 11 -- 1988-07-13 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_loc() -- load edit buffer
   =============================================================================
*/

int16_t et_loc(int16_t n)
{
	ebuf[0] = (int8_t)(grploc[n] + 1 + '0');
	ebuf[1] = '\0';
	ebflag = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	setloc() -- set location
   =============================================================================
*/

void setloc(int16_t grp, int16_t loc)
{
	int16_t g, i, val;
	volatile uint16_t *fpu;
	struct idfnhdr *fp;
	uint16_t fpmant, fpexp;
	uint16_t oldsr;
	volatile int16_t nop = 0;

	grploc[grp] = loc;
	val = (loctab[loc] << 1) ^ (int16_t)0x8000;
	g = grp + 1;

	fpmant = (uint16_t)(((uint32_t)(curintp & 0xFFF0) *
		  ((uint32_t)timemlt)) >> 15);

	fpexp = expbit[curintp & 0x000F];


	for (i = 0; i < 12; i++)
		if (g EQ vce2grp[i]) {

			fp = &vbufs[i].idhfnc[4];
			fpu = io_fpu + FPU_OFNC + (i << 8) + 0x0040;

			oldsr = setsr(0x2200);

/* ++++++++++++++++++++++++++++ FPU interrupts disabled +++++++++++++++++++++ */

			fp->idftmd ^= I_NVBITS;

			*(fpu + (int32_t)FPU_TMNT) = fpmant;
			++nop;	++nop;	++nop;
			*(fpu + (int32_t)FPU_TEXP) = fpexp;
			++nop;	++nop;	++nop;

			if (fp->idftmd & I_VNSUBN)
				*(fpu + FPU_TNV1) = (uint16_t)val;
			else
				*(fpu + FPU_TNV0) = (uint16_t)val;

			++nop;	++nop;	++nop;

			*(fpu + FPU_TCTL) = (uint16_t)
				((fp->idftmd & (I_NRATIO | I_NVBITS)) | 0x0001);

			setsr(oldsr);

/* ++++++++++++++++++++++++++++ Interrupts restored +++++++++++++++++++++++++ */

		}
}

/*
   =============================================================================
	ef_loc() -- parse edit buffer
   =============================================================================
*/

int16_t ef_loc(int16_t n)
{
	register int16_t ival;
	register struct s_entry *ep;

	ebuf[1] = '\0';
	ival = ebuf[0] - '0';
	ebflag = FALSE;

	if (ival EQ 0)
		return(FAILURE);

	--ival;

	setloc(n, ival);

	if (recsw AND grpstat[n] AND (2 EQ grpmode[n])) {

		if (E_NULL NE (ep = findev(p_cur, t_cur, EV_LOCN, n, -1))) {

			ep->e_data2 = (int8_t)ival;

		} else if (E_NULL NE (ep = e_alc(E_SIZE2))) {

			ep->e_type  = EV_LOCN;
			ep->e_data1 = (int8_t)n;
			ep->e_data2 = (int8_t)ival;
			ep->e_time  = t_cur;
			p_cur = e_ins(ep, ep_adj(p_cur, 0, t_cur))->e_fwd;
			eh_ins(ep, EH_LOCN);
			ctrsw = TRUE;
			se_disp(ep, D_FWD, gdstbc, 1);
			scupd();
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_loc() -- (re)display the field
   =============================================================================
*/

int16_t rd_loc(int16_t n)
{
	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 4, 8+(n*5), (grploc[n] + 1 + '0'), SDW11ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	ds_loc() -- display all location to group assignments
   =============================================================================
*/

void ds_loc(void)
{
	register int16_t i;

	for (i = 0; i < 12; i++)
		rd_loc(i);
}

/*
   =============================================================================
	nd_loc() -- data entry function
   =============================================================================
*/

int16_t nd_loc(int16_t n, int16_t k)
{
	(void)n;

	ebuf[0]  = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 4, stccol, k + '0', SDW11DEA);
	advscur();

	return(SUCCESS);
}

