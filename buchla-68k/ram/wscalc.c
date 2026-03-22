/*
   =============================================================================
	wscalc.c -- MIDAS-VII waveshape editor harmonic functions
	Version 9 -- 1988-09-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	WAVESMAX	1023
#define	WAVESMIN	1023

#include "knmtab.h"		/* short knmtab[NUMHARM][NUMWPCAL]; */

/*
   =============================================================================
	adj() -- adjust the coefficients in vknm[wshar][] for a new value
   =============================================================================
*/

void adj(int16_t wshar)
{
	register int16_t wspnt;
	register int32_t harval;
	register int16_t *kp;
	register int32_t *vp;

	vp = &vknm[wshar][0];

	harval = vmtab[wshar];

	if (harval) {

		kp = &knmtab[wshar][0];

		for (wspnt = 0; wspnt < NUMWPCAL; wspnt++)
			*vp++ = *kp++ * harval;

	} else {

		for (wspnt = 0; wspnt < NUMWPCAL; wspnt++)
			*vp++ = 0;
	}
}

/*
   =============================================================================
	wadj() -- adjust the coefficients for all harmonics
   =============================================================================
*/

void wadj(void)
{
	register int16_t wshar;

	for (wshar = 0; wshar < NUMHARM; wshar++)
		adj(wshar);
}

/*
   =============================================================================
	clrwsa() -- clear waveshape table harmonic work areas
   =============================================================================
*/

void clrwsa(void)
{
	memsetw(offsets, 0, NUMWPCAL);
	memsetw(vknm,    0, (NUMHARM * NUMWPCAL) << 1);
	memsetw(vmtab,   0, NUMHARM);
}

/*
   =============================================================================
	wscalc() -- calculate a waveshape from its harmonics and offsets
   =============================================================================
*/

void wscalc(void)
{
	register int16_t wspnt, wshar;
	register int32_t hfac, hmax, temp;

	hmax = WAVESMIN;	/* set minimum scaling value */

	for (wspnt = 0; wspnt < NUMWPCAL; wspnt++) {

		temp = 0;	/* sum up the harmonics */

		for (wshar = 0; wshar < NUMHARM; wshar++)
			temp += vknm[wshar][wspnt];

		/* add in the offsets */

		hwave[wspnt] = (temp / 100) + offsets[wspnt];

		/* adjust the maximum value seen */

		if ((temp = abs(hwave[wspnt])) > hmax)
			hmax = temp;
	}

	/* calculate the scale factor */

	hfac = ((int32_t)WAVESMAX << 16) / hmax;

	/* scale the waveshape */

	for (wspnt = 0; wspnt < NUMWPCAL; wspnt++)
		wsbuf[wspnt] = (int16_t)((hwave[wspnt] * hfac) >> 16);
}

