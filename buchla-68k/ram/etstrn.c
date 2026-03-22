/*
   =============================================================================
	etstrn.c -- section edit group transposition field handlers
	Version 3 -- 1989-11-14 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	et_strn() -- load edit buffer
   =============================================================================
*/

int16_t et_strn(int16_t n)
{
	(void)n;

	sprintf(ebuf, "%c%02d", grptran < 0 ? '-' : '+', abs(grptran));

	ebflag = TRUE;

	return(SUCCESS);
}

/*
   =============================================================================
	ef_strn() -- parse edit buffer
   =============================================================================
*/

int16_t ef_strn(int16_t n)
{
	register int16_t ival;

	(void)n;

	ebuf[3] = '\0';
	ival = ((ebuf[1] - '0') * 10) + (ebuf[2] - '0');

	ebflag = FALSE;

	if ((ival NE 0) AND (ebuf[0] EQ '-'))
		ival = -ival;

	grptran = ival;

	return(SUCCESS);
}

/*
   =============================================================================
	rd_strn() -- redisplay field
   =============================================================================
*/

int16_t rd_strn(int16_t n)
{
	(void)n;

	sprintf(dspbuf, "%c%02d", grptran < 0 ? '-' : '+', abs(grptran));

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputs(obj8, 7, 22, dspbuf, SDMENUBG);

	return(SUCCESS);
}

/*
   =============================================================================
	nd_strn() -- data entry
   =============================================================================
*/

int16_t nd_strn(int16_t n, int16_t k)
{
	register int16_t ec;

	(void)n;

	if (sdmctl NE 4)
		return(FAILURE);

	if ((vtccol GE 22) AND (vtccol LE 24))
		ec = vtccol - 22;
	else
		return(FAILURE);

	if (ec EQ 0) {

		if (k EQ 8)
			k = '-';
		else if (k EQ 9)
			k = '+';
		else
			return(FAILURE);
	} else
		k += '0';

	ebuf[ec] = (int8_t)k;

	if (v_regs[5] & 0x0180)
		vbank(0);

	vputc(obj8, 7, vtccol, k, (SDBGMM | (SD_ENTR << 4)));

	if (vtccol < 24) {

		++vtccol;
		vtxval = CTOX(vtccol);
		ttcpos(vtcrow, vtccol);
	}

	return(SUCCESS);
}

