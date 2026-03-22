/*
   =============================================================================
	wdfield.c -- waveshape display field processing and cursor motion
	Version 46 -- 1989-11-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DOUBLED		1		/* non-zero for doubled WS outputs */

#include "ram.h"

#define	WCSCALE		32768L
#define	WCROUND		16384L

#include "wdcurtb.h"		/* int16_t wdcurtb[];  int16_t wdcurct[8][2]; */

int16_t	wxrate = 1;		/* WS interpolate X movement increment */

struct	fet	wd_fet1[] = {

	{23, 10, 11, 0x0002, et_wavs, ef_wavs, rd_wavs, nd_wavs},
	{23, 19, 20, 0x0102, et_wvce, ef_wvce, rd_wvce, nd_wvce},
	{23, 34, 36, 0x0004, et_wpnt, ef_wpnt, rd_wpnt, nd_wpnt},
	{23, 44, 48, 0x0104, et_woff, ef_woff, rd_woff, nd_woff},
	{23, 61, 62, 0x0005, et_whar, ef_whar, rd_whar, nd_whar},

	{24, 20, 20, 0x0302, et_wslt, ef_wslt, rd_wslt, nd_wslt},
	{24, 57, 60, 0x0105, et_whrv, ef_whrv, rd_whrv, nd_whrv},

	{ 0,  0,  0, 0x0000, FN_NULL, FN_NULL, FN_NULL, FN_NULL}
};

int16_t	wdbox[][8] = {	/* display box parameters */

	{  1,   1, 510, 307, WCFBX00, WCBBX00,  0,  1},	/*  0 */
	{  1, 309, 510, 320, WCFBX01, WCBBX01, 22,  0},	/*  1 */
	{  1, 322, 174, 348, WCFBX02, WCBBX02, 23,  1},	/*  2 */
	{176, 322, 230, 348, WCFBX03, WCBBX03, 23, 23},	/*  3 */
	{232, 322, 398, 348, WCFBX04, WCBBX04, 23, 30},	/*  4 */
	{400, 322, 510, 348, WCFBX05, WCBBX05, 23, 51}	/*  5 */
};

int8_t	*wdbxlb0[] = {	/* display box labels -- row 0 */

	"",			/*  0 */

#ifndef PYCP
	"\320\301  \320\303  \320\305  \320\307  \320\311  \
\321\301  \321\303  \321\305  \321\307  \321\311  \
\322\301  \322\303  \322\305  \322\307  \322\311  \323\301  ",	/*  1 */
#endif

	"Waveshpe    Voice",	/*  2 */
	"Store",		/*  3 */
	"Pnt     Offst",	/*  4 */
	"Harmonic #"		/*  5 */
};

int8_t	*wdbxlb1[] = {	/* display box labels -- row 1 */

	"",			/*  0 */
	"",			/*  1 */
	"Instrument    Slot",	/*  2 */
	"Fetch",		/*  3 */
	"        Final",	/*  4 */
	"Value"			/*  5 */
};

struct curpak wd_flds = {

	stdctp1,	/* curtype */
	nokey,		/* premove */
	nokey,		/* pstmove */
	cxkstd,		/* cx_key */
	cykstd,		/* cy_key */
	wdcxupd,	/* cx_upd */
	wdcyupd,	/* cy_upd */
	wdykup,		/* xy_up */
	wdykdn,		/* xy_dn */
	wdxkey,		/* x_key */
	select,		/* e_key */
	stdmkey,	/* m_key */
	stddkey,	/* d_key */
	wdnfld,		/* not_fld */
	wd_fet1,	/* curfet */
	wdboxes,	/* csbp */
	crate1,		/* cratex */
	crate1,		/* cratey */
	CT_GRAF,	/* cmtype */
	WCURX,		/* cxval */
	WCURY		/* cyval */
};

/*
   =============================================================================
	updfpu() -- update the FPU with a new waveshape
   =============================================================================
*/

void updfpu(void)
{
	volatile uint16_t *wsp1;
	int16_t *wsp2;

	/* calculate instrument source and FPU destination pointers */

	wsp1 = io_fpu + FPU_OWST + (curvce << 9) + (curwslt ? 0 : 0x0100) + 1;
	wsp2 = curwslt ? vbufs[curvce].idhwvbf : vbufs[curvce].idhwvaf;

	memcpyw(wsp1, wsp2, NUMWPNT);

	/* make endpoints track */

	*(wsp1 - 1) = (uint16_t)*(wsp2 - 1);			/* lowest point */
	*(wsp1 + NUMWPNT) = (uint16_t)*(wsp2 + NUMWPNT - 1);	/* highest point */

#if	DOUBLED

	/* do outputs again to get around hardware bug */

	memcpyw(wsp1, wsp2, NUMWPNT);

	*(wsp1 - 1) = (uint16_t)*(wsp2 - 1);			/* lowest point */
	*(wsp1 + NUMWPNT) = (uint16_t)*(wsp2 + NUMWPNT - 1);	/* highest point */
#endif

	curwfnl = wsp2[curwpnt] >> 5;			/* udpate final value */
}

/*
   =============================================================================
	wsupd() -- update the instrument definition and FPU for new WS offsets
   =============================================================================
*/

void wsupd(void)
{
	register int16_t i;
	register int16_t *wsp1, *wsp2;

	/* update the offsets[] array from the instrument definition */

	wsp2 = curwslt ? vbufs[curvce].idhwvbo : vbufs[curvce].idhwvao;

	for (i = 0; i < NUMWPNT; i++)
		offsets[i + 1] = wsp2[i] >> 5;

	offsets[0] = offsets[1];

	wscalc();		/* calculate the final values */

	/* update the final values in the instrument definition */

	wsp1 = curwslt ? vbufs[curvce].idhwvbf : vbufs[curvce].idhwvaf;

	for (i = 0; i < NUMWPNT; i++)
		wsp1[i] = wsbuf[1 + i] << 5;

	updfpu();
	wsnmod[curvce][curwslt] = TRUE;			/* tag WS as modified */
}

/*
   =============================================================================
	whupd() -- update the FPU for new WS harmonics
   =============================================================================
*/

void whupd(void)
{
	register int16_t i;
	register int16_t *wsp1;

	/* update the final values in the instrument definition */

	wsp1 = curwslt ? vbufs[curvce].idhwvbf : vbufs[curvce].idhwvaf;

	for (i = 0; i < NUMWPNT; i++)
		wsp1[i] = wsbuf[i + 1] << 5;

	updfpu();	/* update the FPU */
	wsnmod[curvce][curwslt] = TRUE;			/* tag WS as modified */
}

/*
   =============================================================================
	pntsup() -- update waveshape points with the cursor 'brush'
   =============================================================================
*/

void pntsup(void)
{
	register struct instdef *ip;
	int16_t *ov;
	register int16_t i, j, k, tv, curdif;
	int16_t cwnp, cwin;

	ip = &vbufs[curvce];			/* instrument definition */

	ov = curwslt	? ip->idhwvbo		/* offsets in definition */
			: ip->idhwvao;

	cwnp   = wdcurct[curwdth][0];		/* number of points effected */

	cwin   = wdcurct[curwdth][1];		/* table increment */

	curdif = lstwoff - curwoff;		/* calculate the difference */


	for (i = 0 , k = 0; i < cwnp; i++ , k += cwin) {

		if (i EQ 0) {			/* first point */

			ov[curwpnt] = curwoff << 5;

		} else {			/* subsequent points */

			j = curwpnt + i;	/* update point on the right */

			if (j < NUMWPNT) {	/* ... if it exists */

				tv = (ov[j] >> 5) -
					(int16_t)((((int32_t)curdif * (int32_t)wdcurtb[k])
					  + WCROUND) / WCSCALE);

				if (tv GT 1023)
					tv = 1023;
				else if (tv LT -1023)
					tv = -1023;

				ov[j] = tv << 5;
			}

			j = curwpnt - i;	/* update point on the left */

			if (j GE 0) {		/* ... if it exists */

				tv = (ov[j] >> 5) -
					(int16_t)((((int32_t)curdif * (int32_t)wdcurtb[k])
					  + WCROUND) / WCSCALE);

				if (tv GT 1023)
					tv = 1023;
				else if (tv LT -1023)
					tv = -1023;

				ov[j] = tv << 5;
			}
		}
	}

	wsupd();
}

/*
   =============================================================================
	wdintp() -- interpolate between waveshape points
   =============================================================================
*/

void wdintp(void)
{
	register struct instdef *ip;
	register int16_t *ov;
	register int16_t i, j, k, n;
	register long t;
	int16_t to, from;

	to   = curwpnt;
	from = wplast;

	ip   = &vbufs[curvce];
	ov   = curwslt ? ip->idhwvbo : ip->idhwvao;

	ov[curwpnt] = curwoff << 5;	/* force current point value */

	if (from > to) {	/* make 'from' the leftmost point number */

		i = from;
		from = to;
		to = i;
	}

	n = to - from;		/* number of points */

	if (n > 1) {		/* have to have at least 1 point difference */

		k = ov[from] >> 5;
		t = ((long)((long)(ov[to] >> 5) - (long)k) << 16) / n;
		j = 1 + from;
		--n;

		for (i = 0; i < n; i++)
			ov[j++] = ((int16_t)((t * (1 + i)) >> 16) + k) << 5;
	}

	wplast = curwpnt;
	wvlast = curwoff;

	wsupd();
}

/*
   =============================================================================
	wdykdn() -- cursor y finger down processing
   =============================================================================
*/

void wdykdn(void)
{
	if (wpntsv EQ 0)
		return;

	lstwpnt = curwpnt;
	lstwoff = curwoff;
}

/*
   =============================================================================
	wdykup() -- cursor y finger up processing
   =============================================================================
*/

void wdykup(void)
{
	if ((wpntsv EQ 0) OR (wdupdfl EQ FALSE))
		return;

	if (wpntsv EQ 1) {			/* offsets */

		if (curwdth EQ NUMWIDS)
			wdintp();	/* interpolate mode */
		else
			pntsup();	/* brush mode */

	} else {				/* harmonics */

		adj(curwhrm);	/* adjust vknm[curwhrm][] */
		wscalc();	/* recalculate the waveshape */
		whupd();	/* update the FPU */
	}

	wdswin(0);		/* display updated waveshape */
	wdswin(2);
	wdswin(4);

	wdupdfl = FALSE;
}

/*
   =============================================================================
	wdcyupd() -- update cursor y location
   =============================================================================
*/

void wdcyupd(void)
{
	register struct instdef *ip;
	register int16_t *hv;
	register int8_t wsgn;
	int16_t wval;

	ip = &vbufs[curvce];

	switch (wpntsv) {

	case 0:		/* nothing selected -- just move cursor */

		cyval += cyrate;

		if (cyval GT (CYMAX - 1))
			cyval = CYMAX - 1;
		else if (cyval LT 1)
			cyval = 1;

		return;

	case 1:		/* offset selected */

		curwoff -= cyrate;

		if (curwoff GT 1023)
			curwoff = 1023;
		else if (curwoff LT -1023)
			curwoff = -1023;

		cyval = WPOFF - ((curwoff * WPSF1) / WPSF2);

		if (curwoff < 0) {

			wval = - curwoff;
			wsgn = '-';

		} else {

			wval = curwoff;
			wsgn = '+';
		}

		sprintf(bfs, "%c%04d", wsgn, wval);

		if (v_regs[5] & 0x0180)
			vbank(0);

		vcputsv(waveob, 64, wdbox[4][4], wdbox[4][5], wdbox[4][6],
			wdbox[4][7] + WOFF_OFF, bfs, 14);

		wdupdfl = TRUE;
		return;

	case 2:		/* harmonic selected */

		hv = curwslt ? ip->idhwvbh : ip->idhwvah;

		curwhrv = abs(hv[curwhrm]) - cyrate;

		if (curwhrv > 100)
			curwhrv = 100;
		else if (curwhrv < 0)
			curwhrv = 0;

		curwhrv = (hv[curwhrm] < 0) ? -curwhrv : curwhrv;

		hv[curwhrm] = curwhrv;
		vmtab[curwhrm] = curwhrv;

		if (curwhrv < 0) {

			wval = -curwhrv;
			wsgn = '-';

		} else {

			wval = curwhrv;
			wsgn = '+';
		}

		if (v_regs[5] & 0x0180)
			vbank(0);

		sprintf(bfs, "%c%03d", wsgn, wval);

		vcputsv(waveob, 64, wdbox[5][4], wdbox[5][5],
			wdbox[5][6] + 1, wdbox[5][7] + WHRV_OFF, bfs, 14);

		if (curwhrv < 0)
			cyval = WBOFF - ((-curwhrv * WBSF1) / WBSF2);
		else
			cyval = WBOFF - ((curwhrv * WBSF1) / WBSF2);

		wdupdfl = TRUE;
		return;
	}
}

/*
   =============================================================================
	wdcxupd() -- update cursor x location
   =============================================================================
*/

void wdcxupd(void)
{
	switch (wpntsv) {

	case 0:		/* nothing selected - just move cursor */

		cxval += cxrate;

		if (cxval GT (CXMAX - 1))
			cxval = CXMAX - 1;
		else if (cxval LT 1)
			cxval = 1;

		return;

	case 1:		/* offset selected - maybe do interpolate move */

		if (curwdth NE NUMWIDS)
			return;

		curwpnt += sign(cxrate, wxrate);

		if (curwpnt GE NUMWPNT)
			curwpnt = NUMWPNT - 1;
		else if (curwpnt < 0)
			curwpnt = 0;

		cxval = (curwpnt << 1) + 2;

		if (v_regs[5] & 0x0180)
			vbank(0);

		sprintf(bfs, "%03d", curwpnt);
		vcputsv(waveob, 64, wdbox[4][4], wdbox[4][5],
			wdbox[4][6], wdbox[4][7] + WPNT_OFF, bfs, 14);
	}
}

/*
   =============================================================================
	wdnfld() -- process not-in-field key entry
   =============================================================================
*/

int16_t wdnfld(int16_t k)
{
	register int16_t *hv;
	register struct instdef *ip;

	if (astat) {

		if (whatbox()) {

			ip = &vbufs[curvce];
			hv = curwslt ? ip->idhwvbh : ip->idhwvah;

			if (hitbox EQ 0) {	/* waveshape area */

				switch (wpntsv) {

				case 0:		/* nothing selected */

					if (k EQ 8)  {		/* - */

						if (--curwdth < 0)
							curwdth = NUMWIDS;

						wdswin(4);
						return(SUCCESS);

					} else if (k EQ 9) {	/* + */

						if (++curwdth > NUMWIDS)
							curwdth = 0;

						wdswin(4);
						return(SUCCESS);
					}

					return(FAILURE);

				case 1:		/* offset selected */

					if (k EQ 8)  {		/* - */

						if (curwdth EQ NUMWIDS)
							return(FAILURE);

						if (--curwdth LT 0)
							curwdth = NUMWIDS - 1;

						wdswin(4);
						return(SUCCESS);

					} else if (k EQ 9) {	/* + */

						if (curwdth EQ NUMWIDS) {

							wdintp();
							wdswin(0);
							wdswin(2);

						} else if (++curwdth GE NUMWIDS)
							curwdth = 0;

						wdswin(4);
						return(SUCCESS);
					}

					return(FAILURE);

				case 2:		/* harmonic selected */

					if (k EQ 8)  {		/* - */

						if (hv[curwhrm] > 0)
							hv[curwhrm] = -hv[curwhrm];
						else
							return(FAILURE);

					} else if (k EQ 9) {	/* + */

						if (hv[curwhrm] < 0)
							hv[curwhrm] = -hv[curwhrm];
						else
							return(FAILURE);

					} else {

						return(FAILURE);
					}

					curwhrv = hv[curwhrm];
					vmtab[curwhrm] = curwhrv;
					adj(curwhrm);
					wscalc();
					whupd();
					wdswin(0);
					wdswin(4);
					wdswin(5);
					return(SUCCESS);
				}

			} else if (hitbox EQ 1) {	/* harmonic legend */

				if (k EQ 8)  {		/* - */

					if (hv[curwhrm] > 0)
						hv[curwhrm] = -hv[curwhrm];
					else
						return(FAILURE);

				} else if (k EQ 9) {	/* + */

					if (hv[curwhrm] < 0)
						hv[curwhrm] = -hv[curwhrm];
					else
						return(FAILURE);

				} else {

					return(FAILURE);
				}

				curwhrv = hv[curwhrm];
				vmtab[curwhrm] = curwhrv;
				adj(curwhrm);
				wscalc();
				whupd();
				wdswin(0);
				wdswin(4);
				wdswin(5);
				return(SUCCESS);
			}

			return (FAILURE);
		}

		return(FAILURE);
	}

	return(FAILURE);
}

/*
   =============================================================================
	wdxkey() -- process X key
   =============================================================================
*/

void wdxkey(void)
{
	if (NOT astat)
		return; /* FAILURE */

	stcrow = cyval / 14;
	stccol = cxval >> 3;

	if (stcrow EQ 23) {

		if ((stccol GE 2) OR (stccol LE 8)) {

			clrws();

		} else if ((stccol GE 38) AND (stccol LE 42)) {

			memsetw(curwslt ? vbufs[curvce].idhwvbo
					: vbufs[curvce].idhwvbo,
				0, NUMWPNT);

			curwoff = 0;
			wsupd();

		} else if ((stccol GE 51) AND (stccol LE 58)) {

			memsetw(vmtab, 0, NUMHARM);
			curwhrv = 0;
			wadj();
			wscalc();
			whupd();

		} else {

			return; /* FAILURE */
		}

		wsnmod[curvce][curwslt] = TRUE;
		wwins();
		return; /* SUCCESS */
	}

	return; /* FAILURE */
}

/*
   =============================================================================
	wdfield() -- setup field routines for the waveshape editor
   =============================================================================
*/

void wdfield(void)
{
	curslim = 307;

	curset(&wd_flds);
}
