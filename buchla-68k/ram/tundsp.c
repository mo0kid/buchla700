/*
   =============================================================================
	tundsp.c -- MIDAS tuning table editor
	Version 23 -- 1988-11-28 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	TUN_VAL	100		/* default value for tunval in cents */

int16_t	tunpal[16][3] = {	/* color palette */

	{0, 0, 0},	/* 0 */
	{3, 3, 3},	/* 1 */
	{0, 0, 0},	/* 2 */
	{3, 3, 3},	/* 3 */
	{1, 1, 0},	/* 4 */
	{1, 0, 1},	/* 5 */
	{0, 1, 1},	/* 6 (was 0, 1, 0) */
	{0, 1, 1},	/* 7 (was 0, 1, 0) */
	{0, 0, 1},	/* 8 (was 0, 0, 2) */
	{0, 2, 3},	/* 9 (was 0, 3, 0) */
	{2, 2, 2},	/* 10 */
	{2, 3, 3},	/* 11 */
	{3, 3, 0},	/* 12 */
	{3, 3, 0},	/* 13 */
	{3, 0, 0},	/* 14 */
	{0, 0, 3}	/* 15 */
};

			/*   12345678901234567890123456789012	*/
static	int8_t	dfltnam[] = "Local 3rds + MIDI 12 tone scale ";

int8_t	*tdlabl[] = {

	"C", "#", "D", "#", "E", "F", "#", "G",
	"#", "A", "#", "B", "C", "#", "D", "#",
	"E", "F", "#", "G", "#", "A", "#", "B"
};

/*
   =============================================================================
	gettun() -- retrieve a tuning table from the tuning table library
   =============================================================================
*/

void gettun(int16_t n)
{
	memcpyw(tuntab, tunlib[n], 128);
	memcpy(tuncurn, tunname[n], 32);
	curtun = n;
	tunmod = FALSE;
}

/*
   =============================================================================
	puttun() -- store a tuning table in the tuning table library
   =============================================================================
*/

void puttun(int16_t n)
{
	memcpyw(tunlib[n], tuntab, 128);
	memcpy(tunname[n], tuncurn, 32);
	tunmod = FALSE;
}

/*
   =============================================================================
	inittt() -- initialize tuning table to equal tempered 12 tone scale
   =============================================================================
*/

void inittt(int16_t n)
{
	register int16_t i;

	for (i = 0; i < 128; i++)
		tunlib[n][i] = ((i < 21) ? 160 : (i > 108) ? 10960 :
			(160 + ((i - 12) * 100))) << 1;

	for (i = 0; i < 24; i++)
		tunlib[n][lclkmap[i]] = panlkey[i] << 1;

	strcpy(tunname[n], dfltnam);
}


/*
   =============================================================================
	inittl() -- initialize tuning table library
   =============================================================================
*/

void inittl(void)
{
	register int16_t i;

	for (i = 0; i < NTUNS; i++)
		inittt(i);

	tunval = TUN_VAL << 1;
	gettun(0);
	memcpyw(oldtun, tuntab, 128);
}

/*
   =============================================================================
	tt_trcp() -- transpose and copy tuning table values
   =============================================================================
*/

void tt_trcp(int16_t start, int16_t finish, int16_t dest)
{
	register int16_t i;
	register int32_t v;

	memcpyw(oldtun, tuntab, 128);	/* preserve old table for undo */

	if (start > finish) {

		for (i = finish; ((i LE start) AND (dest < 128)); i++) {

			/* reverse copy */

			v = oldtun[i] + (int32_t)tunval;	/* transpose */

			if (v GT (int32_t)PITCHMAX)	/* limit */
				v = (int32_t)PITCHMAX;
			else if (v LT (int32_t)PITCHMIN)
				v = (int32_t)PITCHMIN;

			tuntab[dest++] = (int16_t)v;	/* store the value */
		}

	} else {

		for (i = start; ((i LE finish) AND (dest < 128)); i++) {

			/* forward copy */

			v = oldtun[i] + (int32_t)tunval;	/* transpose */

			if (v GT (int32_t)PITCHMAX)	/* limit */
				v = (int32_t)PITCHMAX;
			else if (v LT (int32_t)PITCHMIN)
				v = (int32_t)PITCHMIN;

			tuntab[dest++] = (int16_t)v;	/* store the value */
		}
	}

	tunmod = TRUE;
}

/*
   =============================================================================
	tt_intp() -- interpolate tuning table values
   =============================================================================
*/

int16_t tt_intp(int16_t from, int16_t to)
{
	register int16_t i, j, k, n;
	register int32_t t;

	memcpyw(oldtun, tuntab, 128);	/* preserve old table for undo */

	if (from > to) {	/* adjust to and from for forward scan */

		i = from;
		from = to;
		to = i;
	}

	n = to - from;			/* get interval size */

	if (n < 2)
		return(FAILURE);

	k = tuntab[from];
	t = (((int32_t)tuntab[to] - (int32_t)k) << 16) / n;
	j = 1 + from;
	n--;

	for (i = 0; i < n ; i++)
		tuntab[j++] = (int16_t)((t * (1 + i)) >> 16) + k;

	tunmod = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	tt_incr() -- increment tuning table values
   =============================================================================
*/

int16_t tt_incr(int16_t from, int16_t to)
{
	register int16_t i;
	register int32_t v;

	memcpyw(oldtun, tuntab, 128);	/* preserve old table for undo */

	if (from > to) {	/* adjust to and from for forward scan */

		i = from;
		from = to;
		to = i;

	}

	v = (int32_t)oldtun[from];		/* initial value */

	if (from++ EQ to)		/* interval has to be at least 1 */
		return(FAILURE);

	for (i = from; i LE to; i++) {

		v += (int32_t)tunval;		/* increment */

		if (v GT (int32_t)PITCHMAX)	/* limit */
			v = (int32_t)PITCHMAX;
		else if (v LT (int32_t)PITCHMIN)
			v = (int32_t)PITCHMIN;

		tuntab[i] = (int16_t)v;		/* store the value */
	}

	tunmod = TRUE;
	return(SUCCESS);
}

/*
   =============================================================================
	td_trcp() -- display transpose select label
   =============================================================================
*/

void td_trcp(int16_t mode)
{
	register int16_t cx;

	cx = mode ? TDSELD : tdbox[6][4];
	vbank(0);
	vcputsv(tunob, 64, cx, tdbox[6][5],  9, 54, "Transpose", 14);
	vcputsv(tunob, 64, cx, tdbox[6][5], 10, 54, "and Copy", 14);
}

/*
   =============================================================================
	td_incr() -- display increment select label
   =============================================================================
*/

void td_incr(int16_t mode)
{
	register int16_t cx;

	cx = mode ? TDSELD : tdbox[6][4];
	vbank(0);
	vcputsv(tunob, 64, cx, tdbox[6][5],  12, 54, "Increment", 14);
}

/*
   =============================================================================
	td_intp() -- display interpolate select label
   =============================================================================
*/

void td_intp(int16_t mode)
{
	register int16_t cx;

	cx = mode ? TDSELD : tdbox[6][4];
	vbank(0);
	vcputsv(tunob, 64, cx, tdbox[6][5],  14, 54, "Intrpolat", 14);
}

/*
   =============================================================================
	advtcur() -- advance the tuning display text cursor
   =============================================================================
*/

void advtcur(void)
{
	register int16_t newcol;

	if (infield(stcrow, stccol, curfet))
		cfetp = infetp;
	else
		return;

	newcol = stccol + 1;

	if (newcol LE cfetp->frcol)
		itcpos(stcrow, newcol);

	cxval = stccol * 8;
	cyval = stcrow * 14;
}

/*
   =============================================================================
	bsptcur() -- backspace the tuning display text cursor
   =============================================================================
*/

void bsptcur(void)
{
	register int16_t newcol;

	if (infield(stcrow, stccol, curfet))
		cfetp = infetp;
	else
		return;

	newcol = stccol - 1;

	if (newcol GE cfetp->flcol)
		itcpos(stcrow, newcol);

	cxval = stccol * 8;
	cyval = stcrow * 14;
}

/*
   =============================================================================
	dsttval() -- display a tuning table value
   =============================================================================
*/

void dsttval(int16_t row, int16_t col, int16_t val, int16_t fg, int16_t bg)
{
	cnvc2p(bfs, (val >> 1));

	bfs[0] = (int8_t)(bfs[0] + '0');
	bfs[1] = (int8_t)(bfs[1] + 'A');
	bfs[2] = sfdsp[bfs[2] - 7];
	bfs[3] = (int8_t)(bfs[3] + '0');
	bfs[4] = (int8_t)(bfs[4] + '0');
	bfs[5] = '\0';

	vbank(0);
	vcputsv(tunob, 64, fg, bg, row, col, bfs, 14);
}

/*
   =============================================================================
	tdswin() -- display a window
   =============================================================================
*/

void tdswin(int16_t n)
{
	uint16_t cx;
	int16_t i, tv;
	int8_t ts;

	cx = exp_c(tdbox[n][5]);

	/* first, fill the box with the background color */

	vbank(0);
	vbfill4(tunob, 128, tdbox[n][0], tdbox[n][1], tdbox[n][2],
		tdbox[n][3], cx);

	/* put in the box label */

	tsplot4(tunob, 64, tdbox[n][4], tdbox[n][6], tdbox[n][7],
		tdbxlb[n], 14);


	switch (n) {	/* final text - overlays above stuff */

	case 0:		/* keys 0..23 */

		for (i = 0; i < 24; i++) {

			tsplot4(tunob, 64, TDLABEL, i, 1, tdlabl[i], 14);
			sprintf(bfs, "%2d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i, 3, bfs, 14);
			dsttval(i, 6, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 1:		/* keys 24..47 */

		for (i = 24; i < 48; i++) {

			sprintf(bfs, "%2d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i - 24, 13, bfs, 14);
			dsttval(i - 24, 16, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 2:		/* keys 48..71 */

		for (i = 48; i < 72; i++) {

			sprintf(bfs, "%2d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i - 48, 23, bfs, 14);
			dsttval(i - 48, 26, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 3:		/* keys 72..95 */

		for (i = 72; i < 96; i++) {

			sprintf(bfs, "%2d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i - 72, 33, bfs, 14);
			dsttval(i - 72, 36, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 4:		/* keys 96..119 */

		for (i = 96; i < 120; i++) {

			sprintf(bfs, "%3d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i - 96, 43, bfs, 14);
			dsttval(i - 96, 47, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 5:		/* keys 120..127 */

		for (i = 120; i < 128; i++) {

			sprintf(bfs, "%3d", 1 + i);
			tsplot4(tunob, 64, TDMKEYC, i - 120, 54, bfs, 14);
			dsttval(i - 120, 58, tuntab[i],
				((tuntab[i] EQ 320) OR (tuntab[i] EQ 21920))
				? TDMKEYC : tdbox[n][4], tdbox[n][5]);
		}

		return;

	case 6:

		td_trcp(0);
		td_incr(0);
		td_intp(0);
		tsplot4(tunob, 64, tdbox[n][4], 16, 54, "Undo", 14);

		tv = (tunval GE 0 ? tunval : -tunval) >> 1;
		ts = tunval GE 0 ? '+' : '-';
		sprintf(bfs, "Val %c%04d", ts, tv);
		tsplot4(tunob, 64, tdbox[n][4], 18, 54, bfs, 14);

		tsplot4(tunob, 64, tdbox[n][4], 20, 54, "Store", 14);
		tsplot4(tunob, 64, tdbox[n][4], 22, 54, "Retrieve", 14);

		tsplot4(tunob, 64, tdbox[n][4], 24, 54, "Table #", 14);
		bfs[0] = (int8_t)(curtun + '0');
		bfs[1] = '\0';
		tsplot4(tunob, 64, tunmod ? TDCHGD : tdbox[n][4],
			24, 61, bfs, 14);

		return;

	case 7:		/* tuning table name */

		tsplot4(tunob, 64, tdbox[n][4], 24, 7, tuncurn, 14);
		return;
	}
}

/*
   =============================================================================
	twins() -- display all tuning editor windows
   =============================================================================
*/

void twins(void)
{
	register int16_t i;

	for (i = 0; i < 8; i++)
		tdswin(i);
}

/*
   =============================================================================
	tundsp() -- put up the tuning display
   =============================================================================
*/

void tundsp(void)
{
	tunob = &v_score[0];		/* setup object pointer */
	obj0  = &v_curs0[0];		/* setup cursor object pointer */
	obj2  = &v_tcur[0];		/* setup typewriter object pointer */
	tdoct = &v_obtab[TUNOBJ];	/* setup object control table pointer */

	ttcmdsv = 0;			/* nothing selected */
	tdnamsw = FALSE;
	submenu = FALSE;

	dswap();			/* initialize display */

	if (v_regs[5] & 0x0180)
		vbank(0);

	memsetw(tunob, 0, 32767);	/* clear the display */
	memsetw(tunob+32767L, 0, 12033);

	SetObj(TUNOBJ, 0, 0, tunob, 512, 350,      0,      0,   TUNFL, -1);
	SetObj(     0, 0, 1,  obj0,  16,  16, TDCURX, TDCURY, OBFL_00, -1);
	SetObj(TTCURS, 0, 1,  obj2,  16,  16,      0,      0,  TTCCFL, -1);

	arcurs(TDCURSR);	/* setup arrow cursor object */
	itcini(TDCURSR);	/* setup text cursor object */
	ttcini(TDTCURC);	/* setup typewriter cursor object */

	twins();

	SetPri(TUNOBJ, TUNPRI);

	settc(YTOR(TDCURY), XTOC(TDCURX));	/* display the text cursor */

	vsndpal(tunpal);
}

