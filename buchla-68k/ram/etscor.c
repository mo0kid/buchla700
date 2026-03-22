/*
   =============================================================================
	etscor.c -- score field handlers
	Version 7 -- 1988-08-16 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_scor() -- load edit buffer
   =============================================================================
*/

int16_t et_scor(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%02.2d", curscor + 1);
	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_scor() -- parse edit buffer
   =============================================================================
*/

int16_t ef_scor(int16_t n)
{
	register int16_t ival;

	(void)n;

	ebuf[2] = '\0';
	ival = ((ebuf[0] - '0') * 10) + (ebuf[1] - '0');

	ebflag = FALSE;

	if ((ival GT N_SCORES) OR (ival EQ 0))
		return(FAILURE);

	if (insmode) {

		icancel();
		dsimode();
	}

	selscor(ival - 1);
	sdwins();
	return(SUCCESS);
}

/*
   =============================================================================
	rd_scor() -- redisplay field
   =============================================================================
*/

int16_t rd_scor(int16_t n)
{
	(void)n;

	sprintf(dspbuf, "%02.2d", curscor + 1);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 8, 7, dspbuf, SDW13ATR);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_scor() -- data entry
   =============================================================================
*/

int16_t nd_scor(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	ec = stccol - cfetp->flcol;
	ebuf[ec] = (int8_t)(k + '0');

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 8, stccol, k + '0', SDW13DEA);
	advscur();

	return(SUCCESS);
}

