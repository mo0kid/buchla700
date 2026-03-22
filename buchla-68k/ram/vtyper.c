/*
   =============================================================================
	vtyper.c -- virtual typewriter support functions
	Version 8 -- 1989-11-14 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/* virtual typewriter display line constants */

/*			"123456789012345678901234567890"  */
int8_t	vtlin1[] =	"ABCDEFGHIJKLMNOPQRSTUVWXYZ  | ";	/* top */
int8_t	vtlin2[] =	"abcdefghijklmnopqrstuvwxyz -*-";	/* center */
int8_t	vtlin3[] =	" 0123456789+-/#().,:;!?&<>  | ";	/* bottom */

/*
   =============================================================================
	vtsetup() -- setup the virtual typewriter for data entry

	This sets up the parameters for the virtual typewriter:

		obj	VSDD display object pointer
		dsp	character display function
		col	data entry area -- leftmost column on the screen
		ptr	data string base pointer
		tr	typewriter window topmost row
		tc	typewriter window leftmost column
		adv	data entry cursor advance function
		bsp	data entry cursor backspace function
		cup	data entry cursor up function
		cdn	data entry cursor down function
		stop	virtual typewriter end function
		fg	data entry text foreground color
		bg	data entry text background color
   =============================================================================
*/

void vtsetup(volatile uint16_t *obj, vtchar dsp, int16_t col, int8_t *ptr, int16_t tr, int16_t tc, vtcurs adv, vtcurs bsp, vtcurs cup, vtcurs cdn, vtcurs stop, int16_t fg, int16_t bg)
{
	vtobj   = obj;		/* setup object pointer */
	vt_adv  = adv;		/* setup cursor advance function pointer */
	vt_bsp  = bsp;		/* setup cursor backspace function pointer */
	vt_cup  = cup;		/* setup cursor up function pointer */
	vt_cdn  = cdn;		/* setup cursor down function pointer */
	vt_dsp  = dsp;		/* setup display function pointer */
	vt_stop = stop;		/* setup exit typewriter function pointer */
	vtwrow  = tr;		/* setup typewriter window row */
	vtwcol  = tc;		/* setup typewriter window column */
	vtdecol = col;		/* setup data entry base column */
	vtdeptr = ptr;		/* setup data entry area base address */
	vtfgval = fg;		/* setup foreground color value */
	vtbgval = bg;		/* setup background color value */
	SetPri(TTCURS, TTCPRI);	/* turn on the typewriter cursor */
	vtxval = CTOX(tc);	/* setup vt x value */
	vtyval = YTOR(tr);	/* setup vt y value */
	ttcpos(tr, tc);		/* position the typewriter cusor */
}

/*
   =============================================================================
	vtcxupd() -- update virtual typewriter cursor x value

	Standard cursor x update for use when the typewriter is displayed.

	Reference this in the cursor x update for the particular display
	when the virtual typewriter is displayed.
   =============================================================================
*/

void vtcxupd(void)
{
	vtccol = XTOC(vtxval += cxrate);

	if (vtccol > (vtwcol + 29))
		vtxval = CTOX(vtccol = vtwcol + 29);
	else if (vtccol < vtwcol)
		vtxval = CTOX(vtccol = vtwcol);
}

/*
   =============================================================================
	vtcyupd() -- update virtual typewriter cursor y value

	Standard cursor y update for use when the typewriter is displayed.

	Reference this in the cursor y update for the particular display
	when the virtual typewriter is displayed.
   =============================================================================
*/

void vtcyupd(void)
{
	vtcrow = YTOR(vtyval += cyrate);

	if (vtcrow > (vtwrow + 2))
		vtyval = RTOY(vtcrow = vtwrow + 2);
	else if (vtcrow < vtwrow)
		vtyval = RTOY(vtcrow = vtwrow);
}

/*
   =============================================================================
	vtdisp() -- virtual typewriter data entry display   (4 bit graphics)

	Standard function for virtual typewriter output to a graphic screen.
	Assumes that the graphic object is a 4 bit per pixel object in bank 0.
   =============================================================================
*/

void vtdisp(volatile uint16_t *obj, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *buf)
{

	if (v_regs[5] & 0x0180)
		vbank(0);

	vcputsv(obj, 64, fg, bg, row, col, buf, 14);
}

/*
   =============================================================================
	vtyper() -- do data entry with the virtual typewriter

	Called when enter is hit to do data entry from the select function
	for the display.  Returns TRUE if data entry occurred, FALSE otherwise.
   =============================================================================
*/

int16_t vtyper(void)
{
	/* check for data entry */

	if (vtccol < (vtwcol + 26)) {			/* enter data */

		/* convert (vtcrow, vtccol) to data entry character */

		if (vtcrow EQ vtwrow)
			vtdechr = vtlin1[vtccol - vtwcol];
		else if (vtcrow EQ (vtwrow + 1))
			vtdechr = vtlin2[vtccol - vtwcol];
		else if (vtcrow EQ (vtwrow + 2))
			vtdechr = vtlin3[vtccol - vtwcol];
		else {

			vtdechr = '*';			/* error -- bad row */
			return(FALSE);
		}

		vtdeptr[stccol - vtdecol] = vtdechr;	/* update data area */

		/* update the screen */

		bfs[0] = vtdechr;
		bfs[1] = '\0';

		(*vt_dsp)(vtobj, vtfgval, vtbgval, stcrow, stccol, bfs);

		(*vt_adv)();				/* advance cursor */
		return(TRUE);

	/* check for exit or cursor controls */

	} else if ((vtcrow EQ (vtwrow + 1))
		AND (vtccol EQ (vtwcol + 28))) {	/* exit */

		objclr(TTCPRI);		/* turn off typewriter cursor */
		(*vt_stop)();		/* refresh typewriter window */
		return(FALSE);

	} else if ((vtcrow EQ vtwrow)
		AND (vtccol EQ (vtwcol + 28))) {	/* cursor up */

		(*vt_cup)();		/* move cursor up a row */
		return(FALSE);

	} else if ((vtcrow EQ (vtwrow + 2))
		AND (vtccol EQ (vtwcol + 28))) {	/* cursor down */

		(*vt_cdn)();		/* move cursor down a row */
		return(FALSE);

	} else if ((vtcrow EQ (vtwrow + 1))
		AND (vtccol EQ (vtwcol + 27))) {	/* cursor lft */

		(*vt_bsp)();		/* move cursor left a column */
		return(FALSE);

	} else if ((vtcrow EQ (vtwrow + 1))
		AND (vtccol EQ (vtwcol + 29))) {	/* cursor rgt */

		(*vt_adv)();		/* move cursor right a column */
		return(FALSE);
	} else
		return(FALSE);
}


