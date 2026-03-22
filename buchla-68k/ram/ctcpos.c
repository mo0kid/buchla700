/*
   =============================================================================
	ctcpos.c -- character text cursor positioning
	Version 12 -- 1989-11-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

int16_t	ctcsw;				/* text cursor status */

int16_t	mtcoldc;			/* previous cursor column location */
int16_t	mtcoldr;			/* previous cursor row location */

/*
   =============================================================================
	ctcpos() -- position the patch text cursor at ('row', 'col')
   =============================================================================
*/

void ctcpos(int16_t row, int16_t col)
{
	register int16_t nrow;

	if (ctcsw) {

		if (v_regs[5] & 0x0180)		/* point at the control bank */
			vbank(0);

		nrow = CurLine + 7;

		if (stcrow EQ DATAROW)		/* turn off old cursor */
			vclrav(obj9, nrow, stccol, C_ULINE, 48);

		if (row EQ DATAROW)		/* turn on new cursor */
			vsetav(obj9, nrow, col, C_ULINE, 48);
	}

	stcrow = row;			/* update cursor position */
	stccol = col;
}

/*
   =============================================================================
	ctcoff() -- turn off the patch text cursor
   =============================================================================
*/

void ctcoff(void)
{
	if (v_regs[5] & 0x0180)		/* point at the control bank */
		vbank(0);

	if (stcrow EQ DATAROW)		/* turn off cursor */
		vclrav(obj9, CurLine + 7, stccol, C_ULINE, 48);

	ctcsw = FALSE;
}

/*
   =============================================================================
	ctcon() -- turn on the patch text cursor
   =============================================================================
*/

void ctcon(void)
{
	if (v_regs[5] & 0x0180)		/* point at the control bank */
		vbank(0);

	if (stcrow EQ DATAROW) {	/* turn on cursor */

		ctcsw = TRUE;
		vsetav(obj9, CurLine + 7, stccol, C_ULINE, 48);
	}
}

/*
   =============================================================================
	mtcpos() -- position the menu text cursor at ('row', 'col')
   =============================================================================
*/

void mtcpos(int16_t row, int16_t col)
{
	if (v_regs[5] & 0x0180)			/* point at the control bank */
		vbank(0);

	if (inrange(mtcoldr, 19, 23)) {		/* turn off old cursor */

		vclrav(obj11, mtcoldr - 18, mtcoldc, C_ULINE, 64);

		mtcoldr = 0;			/* void old cursor location */
		mtcoldc = 0;
	}

	if (inrange(row, 19, 23)) {		/* turn on new cursor */

		vsetav(obj11, row - 18, col, C_ULINE, 64);

		mtcoldr = row;			/* keep track of new cursor */
		mtcoldc = col;
	}

	vtcrow = row;				/* update cursor position */
	vtccol = col;
}

/*
   =============================================================================
	mtcoff() -- turn off the menu text cursor
   =============================================================================
*/

void mtcoff(void)
{
	if (v_regs[5] & 0x0180)		/* point at the control bank */
		vbank(0);

	if (inrange(mtcoldr, 19, 23))		/* turn off cursor */
		vclrav(obj11, mtcoldr - 18, mtcoldc, C_ULINE, 64);
}

