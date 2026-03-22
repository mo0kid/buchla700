/*
   =============================================================================
	setgc.c -- set cursors and keep them in sync
	Version 2 -- 1988-08-19 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	setgc() -- set graphics cursor
   =============================================================================
*/

void setgc(int16_t xv, int16_t yv)
{
	gcurpos(xv, yv);

	cxval  = xv;
	cyval  = yv;

	stcrow = yv / 14;
	stccol = xv >> 3;

	sgcsw  = TRUE;
	cmtype = CT_GRAF;

	if (infield(stcrow, stccol, curfet))
		cfetp = infetp;
	else
		cfetp = (struct fet *)NULL;
}

/*
   =============================================================================
	settc() -- set text cursor
   =============================================================================
*/

void settc(int16_t rv, int16_t cv)
{
	itcpos(rv, cv);

	stcrow = rv;
	stccol = cv;

	cyval  = rv * 14;
	cxval  = cv << 3;

	sgcsw  = FALSE;
	cmtype = CT_TEXT;

	if (infield(stcrow, stccol, curfet))
		cfetp = infetp;
	else
		cfetp = (struct fet *)NULL;
}

