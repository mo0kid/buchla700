/*
   =============================================================================
	enterit.c -- MIDAS data entry and cursor support functions
	Version 40 -- 1989-12-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

#if	DEBUGIT
short	debugen = 1;
#endif

int16_t	syrate = SMYRATE;		/* smooth scroll vertical rate */

int16_t	LastRow = -1;
int16_t	LastCol = -1;

/*
   =============================================================================
	enterit() -- standard data entry (ENTER) function
   =============================================================================
*/

void enterit(void)
{
	if (NOT astat)					/* only on closures */
		return;

#if	DEBUGIT
	if (debugsw AND debugen)
		printf("enterit():  ENTRY  row = %d  col = %d  curfet =$%lX\n",
			stcrow, stccol, curfet);
#endif

	if (infield(stcrow, stccol, curfet)) {		/* in a field ? */

		cfetp = infetp;				/* set fet pointer */

		if ((cfetp) AND (NOT ebflag))
			(*cfetp->ebto)(cfetp->ftags);	/* load ebuf */

		if (cfetp)
			(*cfetp->ebfrom)(cfetp->ftags);	/* process ebuf */

		if (cfetp)
			(*cfetp->redisp)(cfetp->ftags);	/* redisplay */

		ebflag = FALSE;
	}
}

/*
   =============================================================================
	nokey() -- null key function
   =============================================================================
*/

void nokey(void)
{
}

/*
   =============================================================================
	nodkey() -- null d_key function
   =============================================================================
*/

void nodkey(int16_t k)
{
	(void)k;
}

/*
   =============================================================================
	nonf() -- null non_fld function
   =============================================================================
*/

int16_t nonf(int16_t k)
{
	(void)k;

	return(SUCCESS);
}

/*
   =============================================================================
	entbh() -- data entry box-hit function
   =============================================================================
*/

int16_t entbh(int16_t n)
{
	(void)n;

	enterit();
	return(SUCCESS);
}

/*
   =============================================================================
	cmvgen() -- general cursor mover
   =============================================================================
*/

void cmvgen(void)
{
	register int16_t nc, newrow, newcol, newpos;

	(*premove)();				/* handle PRE-MOVE functions */

	nc = (*curtype)();			/* get new CURSOR TYPE wanted */

	newrow = YTOR(cyval);			/* setup new row */
	newcol = XTOC(cxval);			/* setup new column */

	if (cmtype NE nc) {			/* if changed ... */

		nchwait = curhold;			/* set hold time */
		ncvwait = curhold;

		LastRow = -1;				/* reset last position */
		LastCol = -1;
	}

	/* see if we've got a new text cursor position */

	if ((newrow NE LastRow) OR (newcol NE LastCol))
		newpos = TRUE;
	else
		newpos = FALSE;

	/* setup horizontal and vertical timer counts */

	chtime = (nc EQ CT_GRAF) ? hcwval : thcwval;
	cvtime = (nc EQ CT_GRAF) ? vcwval : ((nc EQ CT_SMTH) ? syrate : tvcwval);

	switch (nc) {			/* switch on new cursor type */

	case CT_GRAF:				/* GRAPHIC CURSOR */

		if (cmtype EQ CT_SCOR) {		/* change from score text */

			stcoff();			/* turn off text */
			sgcon();			/* turn on graphics */
		}

		cmtype = nc;				/* set cursor type */
		gcurpos(cxval, cyval);			/* position cursor */
		break;


	case CT_TEXT:				/* TEXT CURSOR */

		cmtype = nc;				/* set cursor type */

		if (newpos)
			itcpos(newrow, newcol);		/* position cursor */

		break;

	case CT_VIRT:				/* VIRTUAL TYPEWRITER CURSOR */

		cmtype = nc;				/* set cursor type */
		ttcpos(vtcrow, vtccol);			/* position cursor */
		break;

	case CT_SCOR:				/* SCORE TEXT CURSOR */

		if (cmtype EQ CT_GRAF)			/* change from graphics */
			sgcoff();			/* turn off graphics */

		cmtype = nc;				/* set cursor type */

		if (newpos)
			stcpos(newrow, newcol);		/* position cursor */

		break;

	case CT_SMTH:				/* SMOOTH SCROLL TEXT CURSOR */

		cmtype = nc;				/* set cursor type */

		if (newpos)
			ctcpos(newrow, newcol);		/* position cursor */

		break;

	case CT_MENU:				/* SUBMENU CURSOR */

		cmtype = nc;				/* set cursor type */
		mtcpos(vtcrow, vtccol);			/* position cursor */
		break;
	}

	LastRow = newrow;
	LastCol = newcol;

	(*pstmove)();				/* handle POST-MOVE functions */
}

/*
   =============================================================================
	crxrate() -- calculate cursor X rate
   =============================================================================
*/

int16_t crxrate(int16_t cv)
{
	register int16_t cs;

	if (cv GE xycntr) {

		cv -= xycntr;
		cs = 1;
		curpos = -cv;

	} else {

		cv = xycntr - cv;
		cs = 0;
		curpos = cv;
	}

	if (cv > 127)
		cv = 127;

	return(cs ? -cratex[cv] : cratex[cv]);
}

/*
   =============================================================================
	cryrate() -- calculate cursor Y rate
   =============================================================================
*/

int16_t cryrate(int16_t cv)
{
	register int16_t cs;

	if (cv GE xycntr) {

		cv -= xycntr;
		cs = 1;
		curpos = -cv;

	} else {

		cv = xycntr - cv;
		cs = 0;
		curpos = cv;
	}

	if (cv > 127)
		cv = 127;

	return(cs ? -cratey[cv] : cratey[cv]);
}

/*
   =============================================================================
	cmfix() -- cursor motion initial movement processing
   =============================================================================
*/

void cmfix(void)
{
	register int16_t acx, acy, scx, scy;

	crxrate(sigtab[55][0]);		/* get cursor x value */
	acx = abs(curpos);

	cryrate(sigtab[56][0]);		/* get cursor y value */
	acy = abs(curpos);

	scx = sign(cxrate, 1);
	scy = sign(cyrate, 1);

	if (cmfirst) {			/* first motion ? */

		if (acx GE acy) {	/* vertical movement */

			cyrate = 0;
			cxrate = scx;
			nchwait = curhold;
			ncvwait = cvtime;

		} else {		/* horizontal movement */

			cxrate = 0;
			cyrate = scy;
			ncvwait = curhold;
			nchwait = chtime;
		}

		cmfirst = FALSE;

	} else {

		/* limit text movement to 1 axis */

		if (cmtype NE CT_GRAF) {
			if (acx GE acy)
				cyrate = 0;
			else
				cxrate = 0;
		}
	}
}

/*
   =============================================================================
	cxkstd() -- standard cursor x rate calculation
   =============================================================================
*/

void cxkstd(void)
{
	trkball = FALSE;
	tkctrl  = FALSE;
	txflag  = FALSE;
	tyflag  = FALSE;

	if (astat) {		/* contact */

		if (xkstat EQ FALSE) {

			if (xkcount) {		/* debounce */

				xkcount--;
				return;
			}

			xkstat  = TRUE;
			chwait  = 1;
			nchwait = curhold;

			if (ykstat)
				(*xy_dn)();
		}

		cxrate = -crxrate(aval);

	} else {		/* release */

		if (xkstat AND ykstat)
			(*xy_up)();

		xkstat  = FALSE;
		xkcount = 1;
		cxrate  = 0;

		if (ykstat EQ FALSE) {

			cyrate  = 0;
			ykcount = 1;
			nchwait = chtime;
			ncvwait = cvtime;
			chwait  = 1;
			cvwait  = 1;
			cmfirst = TRUE;
		}
	}

	return;
}

/*
   =============================================================================
	cykstd() -- standard cursor y rate calculation
   =============================================================================
*/

void cykstd(void)
{
	trkball = FALSE;
	tkctrl  = FALSE;
	txflag  = FALSE;
	tyflag  = FALSE;

	if (astat) {		/* contact */

		if (ykstat EQ FALSE) {

			if (ykcount) {		/* debounce */

				ykcount--;
				return;
			}

			ykstat  = TRUE;
			cvwait  = 1;
			ncvwait = curhold;

			if (xkstat)
				(*xy_dn)();
		}

		cyrate = cryrate(aval);

	} else {		/* release */

		if (xkstat AND ykstat)
			(*xy_up)();

		ykstat  = FALSE;
		ykcount = 1;
		cyrate  = 0;

		if (xkstat EQ FALSE) {

			cxrate  = 0;
			xkcount = 1;
			nchwait = chtime;
			ncvwait = cvtime;
			chwait  = 1;
			cvwait  = 1;
			cmfirst = TRUE;
		}
	}

	return;
}

/*
   =============================================================================
	stdmkey() -- standard M key processing
   =============================================================================
*/

void stdmkey(void)
{
	if (astat) {

		runit = FALSE;
		submenu = FALSE;
	}
}

/*
   =============================================================================
	stddkey() - standard data key processing
   =============================================================================
*/

void stddkey(int16_t k)
{
	(void)k;

	if (infield(stcrow, stccol, curfet)) {

		cfetp = infetp;		/* set field pointer */

		if (astat) {		/* only do action on closures */

			if (!ebflag)
				(*cfetp->ebto)(cfetp->ftags);	/* setup ebuf */

			(*cfetp->datain)(cfetp->ftags, asig - 60);	/* enter */
		}

	} else {

		if (astat)
			(*not_fld)(asig - 60);		/* not in field */
	}
}

/*
   =============================================================================
	cxgen() -- standard cursor x update processing
   =============================================================================
*/

void cxgen(void)
{
	cxval += cxrate;

	if (cxval > CXMAX)
		cxval = CXMAX;
	else if (cxval < 0)
		cxval = 0;

	return;
}

/*
   =============================================================================
	cygen() -- standard cursor y update processing
   =============================================================================
*/

void cygen(void)
{
	cyval += cyrate;

	if (cyval > CYMAX)
		cyval = CYMAX;
	else if (cyval < 0)
		cyval = 0;

	return;
}

