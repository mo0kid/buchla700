/*
   =============================================================================
	etsnbt.c -- beat field handlers
	Version 4 -- 1988-07-28 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_snbt() -- load edit buffer
   =============================================================================
*/

int16_t et_snbt(int16_t n)
{
	register int32_t curfr, beat;

	(void)n;

	if (clkrun) {

		ebflag = FALSE;
		return(FAILURE);
	}

	curfr = t_cur;
	beat  = curfr / 48;

	sprintf(ebuf, "%05ld", beat);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_snbt() -- parse edit buffer
   =============================================================================
*/

int16_t ef_snbt(int16_t n)
{
	register int32_t ival;
	register int16_t i;

	(void)n;

	if (clkrun)
		return(FAILURE);

	ival = 0L;

	for (i = 0; i < 5; i++)
		ival = (ival * 10) + (ebuf[i] - '0');

	ebflag = FALSE;

	if (insmode) {

		icancel();
		dsimode();
	}

	sc_goto(fc_val = ival * 48L);
	return(SUCCESS);
}

/*
   =============================================================================
	rd_snbt() -- (re)display the field
   =============================================================================
*/

int16_t rd_snbt(int16_t n)
{
	register int32_t curfr, beat;
	int8_t	buf[8];

	(void)n;

	curfr = t_cur;
	beat  = curfr / 48;
	sprintf(buf, "%05ld", beat);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 0, 11, buf, SDW00ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_snbt() -- data entry function
   =============================================================================
*/

int16_t nd_snbt(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	if (clkrun)
		return(FAILURE);

	ec = stccol - cfetp->flcol;
	ebuf[ec] = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 0, stccol, k + '0', SDW00DEA);
	advscur();

	return(SUCCESS);
}

