/*
   =============================================================================
	ldselbx.c -- librarian box selection functions
	Version 46 -- 1988-11-18 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

int16_t	ft2lt[] = {	/* file type to load type map */

	LT_ASG,
	LT_ORL,
	LT_ORH,
	LT_SCR,
	LT_TUN,
	LT_WAV,
	LT_ORL,
	LT_PAT,
	LT_SEQ
};

struct	selbox	ldboxes[] = {

	{  1,   1, 510,  13,      0, ldfnbox},	/*  0 - index area label */
	{  1,  14, 510, 293,      1, ldfnbox},	/*  1 - index area */
	{  1, 294,  78, 307,      2, ldfnbox},	/*  2 - file name label */
	{ 80, 294, 143, 307,      3, ldfnbox},	/*  3 - file name */
	{145, 294, 214, 307,      4, ldfnbox},	/*  4 - comment label */
	{216, 294, 510, 307,      5, ldfnbox},	/*  5 - comment */
	{  1, 308,  70, 321,      6, ldfnbox},	/*  6 - fetch */
	{  1, 322,  70, 335,      7, ldfnbox},	/*  7 - replace / append */
	{  1, 336,  70, 349,      8, ldfnbox},	/*  8 - lo orch / hi orch */
	{ 72, 308, 255, 349,      9, ldfnbox},	/*  9 - store */
	{257, 308, 510, 349,     10, ldfnbox},	/* 10 - message window */

	{  0,   0,   0,   0, 	  0, FN_NULL}	/* end of table */
};

/*
   =============================================================================
	skperr() -- complain about an error while skipping a score
   =============================================================================
*/

void skperr(int16_t sn)
{
	int8_t	scid[32];
	int8_t	erms[64];

	clrlsel();

	sprintf(scid, "  score %d", sn + 1);
	sprintf(erms, "  errno = %d", errno);

	ldermsg("Couldn't skip", scid, erms,
		LD_EMCF, LD_EMCB);
}

/*
   =============================================================================
	skp_ec() -- skip with error checking
   =============================================================================
*/

int16_t skp_ec(FILE *fp, int32_t len)
{
	register int32_t count;
	register int16_t c;
	int8_t buf[64];

	for (count = 0; count < len; count++) {

		errno = 0;

		if (EOF EQ (c = getc(fp))) {

			sprintf(buf, "errno = %d", errno);

			ldermsg("Unexpected EOF",
				buf, (int8_t *)NULL, LD_EMCF, LD_EMCB);

#if	DEBUGIT
			if (debugsw)
				FILEpr(fp);
#endif

			fclose(fp);
			postio();		/* restore LCD backlight */
			return(FAILURE);
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	scskip() -- skip a score starting with its section list
   =============================================================================
*/

int16_t scskip(FILE *fp, int16_t ns)
{
	register int16_t go;
	int8_t etype;
	int8_t erms[64];

	go = TRUE;

	if (skp_ec(fp, (int32_t)(N_SECTS * 12))) { 	/* skip section times */

		skperr(ns);
		return(FAILURE);
	}

	if (rd_ec(fp, &etype, 1L)) {	/* read first score header event */

		skperr(ns);
		return(FAILURE);
	}

	if (etype NE EV_SCORE) {	/* complain if it's not a score event */

		sprintf(erms, "  score %d  etype = %d", ns + 1, etype);

		ldermsg("Bad score --", "  1st event is wrong",
			erms, LD_EMCF, LD_EMCB);

		return(FAILURE);
	}

	if (skp_ec(fp, (int32_t)(scsizes[(int16_t)etype][1] - 1))) {	/* skip data */

		skperr(ns);
		return(FAILURE);
	}


	do {		/* skip remaining score events */

		if (rd_ec(fp, &etype, 1L)) {	/* get event type */

			skperr(ns);
			return(FAILURE);
		}

		/* skip the event's data */

		if (skp_ec(fp, (int32_t)(scsizes[(int16_t)etype][1] - 1))) {

			skperr(ns);
			return(FAILURE);
		}

		if (etype EQ EV_FINI)		/* check for score end */
			go = FALSE;

	} while (go);

	return(SUCCESS);
}

/*
   =============================================================================
	ldermsg() -- display an error message if none is up already
   =============================================================================
*/

void ldermsg(int8_t *p1, int8_t *p2, int8_t *p3, int16_t p4, int16_t p5)
{
	int8_t msgbuf[64];

	if (NOT lderrsw) {			/* put up new messages only */

		strcpy(msgbuf, "ERROR: ");
		strcat(msgbuf, p1);

		ldwmsg(p1, p2, p3, p4, p5);
	}

	lderrsw = TRUE;				/* set error state */
}

/*
   =============================================================================
	clrerms() -- clear an error message from the message window
   =============================================================================
*/

void clrerms(void)
{
	if (lderrsw) {

		lderrsw = FALSE;
		lmwclr();
		ldswin(10);
	}
}

/*
   =============================================================================
	clrlsel() -- clear library selection
   =============================================================================
*/

void clrlsel(void)
{
	if (lselsw) {

		if (lrasw) {

			lksel   = -1;
			ldpass  = 0;
			pkctrl  = oldpk;
			sliders = oldsl;
			swpt    = oldsw;
			lcdlbls();
			setleds();
			fcindex();

		} else {

			dslslot(ldslot, ldbox[1][4], ldrow);
		}
	}

	fcreset();
}

/*
   =============================================================================
	endltyp() -- end function for virtual typewriter
   =============================================================================
*/

void endltyp(void)
{
	lmwclr();
	ldswin(10);
}

/*
   =============================================================================
	savefc() -- save name and comment from loaded or stored file
   =============================================================================
*/

void savefc(int16_t kind)
{
	int16_t fi;

	fi = ft2lt[kind - 1];

	if (kind EQ FT_ORC)
		fi = lorchl ? LT_ORH : LT_ORL;

	memcpy(loadedf[fi], ldfile, 8);
	memcpy(loadedc[fi], ldcmnt, 37);
}

/*
   =============================================================================
	lcancel() -- cancel librarian selections
   =============================================================================
*/

int16_t lcancel(int16_t lct)
{
	int16_t rc;

	rc = FALSE;

	if ((lct NE 0) AND lselsw) {

		rc = TRUE;
		clrlsel();
	}

	if ((lct NE 1) AND (lstrsw OR (NOT ckstor()))) {

		rc = TRUE;
		streset();
	}

	if ((lct NE 2) AND ldelsw) {

		rc = TRUE;
		ldelsw = FALSE;
		dslslot(ldslot, ldbox[1][4], ldrow);
	}

	return(rc);
}

/*
   =============================================================================
	dpy_scr() -- display score contents entry
   =============================================================================
*/

void dpy_scr(int16_t color, int16_t ns)
{
	int8_t buf[40];
	int32_t scl;

	if (ndisp NE 0)
		return;

	if (v_regs[5] & 0x0180)
		vbank(0);

	if (ldmap[ns] EQ -1)
		strcpy(buf, "  ");
	else
		sprintf(buf, "%02d", 1 + ldmap[ns]);

	vcputsv(librob, 64, ldbox[1][4], ldbox[1][5], 1 + ns, 1, buf, 14);

	if (-1L EQ (scl = sindex[ns].sclen))
		strcpy(buf, "{ empty score  }      0");
	else
		sprintf(buf, "%-16.16s  %5ld", sindex[ns].scfnm, scl);

	vcputsv(librob, 64, color, ldbox[1][5], 1 + ns, 4, buf, 14);
}

/*
   =============================================================================
	lst_scr() -- list the score contents directory
   =============================================================================
*/

void lst_scr(void)
{
	register int16_t i;
	uint16_t cx;

	if (ndisp NE 0)
		return;

	point = ldpoint;

	cx = exp_c(ldbox[0][5]);

	if (v_regs[5] & 0x0180)
		vbank(0);

	vbfill4(librob, 128, ldbox[0][0], ldbox[0][1],
		ldbox[0][2], ldbox[0][3], cx);

	tsplot4(librob, 64, ldbox[0][4], ldbox[0][6], ldbox[0][7],
		"No Score Name       Length", 14);

	lseg(  8, 13,  23, 13, LUNDRLN);
	lseg( 32, 13, 159, 13, LUNDRLN);
	lseg(168, 13, 215, 13, LUNDRLN);

	cx = exp_c(ldbox[1][5]);

	vbfill4(librob, 128, ldbox[1][0], ldbox[1][1],
		ldbox[1][2], ldbox[1][3], cx);

	for (i = 0; i < N_SCORES; i++)
		dpy_scr(ldbox[1][4], i);
}

/*
   =============================================================================
	ndx_scr() -- display the table of contents for a score
   =============================================================================
*/

int16_t ndx_scr(int16_t slot)
{
	register FILE *fp;
	register int16_t i;
	register int32_t rlen = 12345;
	int32_t rdlen;
	int8_t msgbuf1[64];
	int8_t msgbuf2[64];

	ldpass = 0;

	for (i = 0; i < N_SCORES; i++) {

		sindex[i].sclen = -1L;
		memset(sindex[i].scfnm, ' ', 16);
	}

	errno = 0;

	if ((FILE *)NULL EQ (fp = fopenb(slotnam(slot, FT_SCR), "r"))) {

		sprintf(msgbuf2, "  errno = %d", errno);

		ldermsg("Couldn't open the file",
			"  for the scores", msgbuf2,
			LD_EMCF, LD_EMCB);

		clrlsel();
		return(FAILURE);
	}

	errno = 0;

	if (fseek(fp, 60L, 1)) {		/* seek past header */

		sprintf(msgbuf2, "  errno = %d", errno);

		ldermsg("Seek failure",
			(int8_t *)NULL, msgbuf2,
			LD_EMCF, LD_EMCB);


#if DEBUGIT
		if (debugsw)
			FILEpr(fp);
#endif

		fclose(fp);
		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}


#if DEBUGIT
	if (debugsw)
		FILEpr(fp);
#endif

	for (i = 0; i < N_SCORES; i++) {

		if (rd_ec(fp, &rdlen, 4L)) {

			sprintf(msgbuf1, "  of score %d", i + 1);
			sprintf(msgbuf2, "  errno = %d", errno);

			ldermsg("Unable to read the length",
				msgbuf1, msgbuf2,
				LD_EMCF, LD_EMCB);


#if DEBUGIT
			if (debugsw)
				FILEpr(fp);
#endif

			clrlsel();
			return(FAILURE);
		}

		sindex[i].sclen = rdlen;

		if (-1L NE rdlen) {

			if (rd_ec(fp, sindex[i].scfnm, 16L)) {

				sprintf(msgbuf1, "  of score %d", i + 1);
				sprintf(msgbuf2, "  errno = %d", errno);

				ldermsg("Unable to read the name",
					msgbuf1, msgbuf2,
					LD_EMCF, LD_EMCB);


#if DEBUGIT
				if (debugsw)
					FILEpr(fp);
#endif

				clrlsel();
				return(FAILURE);
			}

			errno = 0;

			if (scskip(fp, i)) {

				sprintf(msgbuf1, "  score %d", i + 1);
				sprintf(msgbuf2, "  errno=%d  rlen=%ld",
					errno, rlen);

				ldermsg("Unable to skip past",
					msgbuf1, msgbuf2,
					LD_EMCF, LD_EMCB);


#if DEBUGIT
				if (debugsw)
					FILEpr(fp);
#endif

				fclose(fp);
				postio();		/* restore LCD backlight */
				clrlsel();
				return(FAILURE);
			}
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	ldpass = 1;
	lst_scr();


	point = GLCplot;
	GLCcurs(G_ON);

	if (ismode NE IS_NULL) {	/* cancel inst. mode */

		ismode  = IS_NULL;
		pkctrl  = oldpk;
		sliders = oldsl;
		swpt    = oldsw;
		lcdlbls();
	}

	if (gomode NE GO_NULL) {	/* cancel goto mode */

		gomode = GO_NULL;
		pkctrl = oldpk;
		lseg(GOTO_XL, GOTO_Y, GOTO_XR, GOTO_Y, 0);
	}

	if (asmode) {			/* cancel assign mode */

		asmode = 0;
		pkctrl = oldpk;
		swpt   = oldsw;
		lseg(ASGN_XL, ASGN_Y, ASGN_XR, ASGN_Y, 0);
	}

	if ((pkctrl EQ PK_PFRM) OR (pkctrl EQ PK_NOTE))
		oldpk = pkctrl;

	if (sliders NE LS_LIBR)
		oldsl = sliders;

	oldsw   = swpt;
	swpt    = &t_libr;
	pkctrl  = PK_LIBR;
	sliders = LS_LIBR;

	lcdlbls();
	setleds();

	return(SUCCESS);
}

/*
   =============================================================================
	getit() -- read selected file
   =============================================================================
*/

int16_t getit(void)
{
	ldkind = ftkind(ldslot);

	if (ldkind EQ -1) {

		ldermsg("Unknown file type",
			(int8_t *)NULL, (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		clrlsel();
		return(FAILURE);
	}

	ldbusy("         Reading file");

	switch (ldkind) {

	case FT_ASG:

		if (get_asg())
			return(FAILURE);

		break;

	case FT_ORH:
	case FT_ORL:
	case FT_ORC:

		if (get_orc(lorchl, ldkind))
			return(FAILURE);

		break;

	case FT_PAT:

		if (get_pat())
			return(FAILURE);

		break;

	case FT_SCR:

		if (get_scr())
			return(FAILURE);

		break;

	case FT_SEQ:

		if (get_seq())
			return(FAILURE);

		break;

	case FT_TUN:

		if (get_tun())
			return(FAILURE);

		break;

	case FT_WAV:

		if (get_wav())
			return(FAILURE);

		break;

	default:

		ldermsg("ldkind bad",
			(int8_t *)NULL, (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, filecat[ldslot].fcname, 8);
	memcpy(ldcmnt, filecat[ldslot].fccmnt, 37);
	savefc(ldkind);

	clrlsel();

	if (lrasw) {

		ldswin(0);
		ldswin(8);
	}

	ldswin(3);
	ldswin(5);
	showsiz();
	return(SUCCESS);
}

/*
   =============================================================================
	ldfnbox() -- librarian display box hit processor
   =============================================================================
*/

int16_t ldfnbox(int16_t n)
{
	register int16_t col, i, slot, sn;

	col = hitcx >> 3;

	if (lderrsw)
		clrerms();

	switch (n) {

	case 1:		/* index area */

		if (lcancel(0))
			return(SUCCESS);

		if (lselsw) {		/* something already selected ? */

			if (lrasw) {	/* content mode ? */

				if (ldkind EQ FT_SCR) {		/* score */

					sn = ldline(hitcy) - 1;

					if (sindex[sn].sclen NE -1L) {

						if ((1 + sn) NE ldrow) {

							dpy_scr(ldbox[1][4], ldrow - 1);
							ldrow = 1 + sn;
						}

						dpy_scr(LD_SELC, sn);
						lksel = sn;

					} else {

						lksel = -1;
					}

					return(SUCCESS);
				}
			}

			if (ldrow NE ldline(hitcy)) {

				clrlsel();
				return(SUCCESS);
			}

			return(getit());

		} else {	/* nothing selected yet */

			if (0 NE (ldrow = ldline(hitcy))) {

				if (col EQ 11) {

					if (catin AND ltagged) {

						slot = lin2slt(ldrow);

						if (slot EQ tagslot) {

							putcat();
							ltagged = FALSE;
							showcat();
						}
					}

				} else {

					if (-1 NE (ldslot = lin2slt(ldrow))) {

						lselsw = TRUE;
						ldswin(8);
						ldkind = ftkind(ldslot);

						for (i = 0; i < N_SCORES; i++)
							ldmap[i] = i;

						if (lrasw AND (ldkind EQ FT_SCR))
							return(ndx_scr(ldslot));

						dslslot(ldslot, LD_SELC, ldrow);
						return(SUCCESS);
					}
				}
			}

			clrlsel();
			return(FAILURE);
		}

	case 3:		/* file name field */

		if (lcancel(3))
			return(SUCCESS);

		if (lmwtype NE 1) {

			lmwvtyp();		/* setup for the typewriter */
			ldswin(10);		/* display the typewriter */

			vtsetup(librob, vtdisp, 10, ldfile, 22, 33,
				advlcur, bsplcur, nokey, nokey, endltyp,
				ldbox[n][4], ldbox[n][5]);

		} else {

			vtyper();
		}

		return(SUCCESS);

	case 5:		/* comment field */

		if (lcancel(3))
			return(SUCCESS);

		if (lmwtype NE 1) {

			lmwvtyp();		/* setup for the typewriter */
			ldswin(10);		/* display the typewriter */

			vtsetup(librob, vtdisp, 27, ldcmnt, 22, 33,
				advlcur, bsplcur, nokey, nokey, endltyp,
				ldbox[n][4], ldbox[n][5]);

		} else {

			vtyper();
		}

		return(SUCCESS);

	case 6:		/* "Index" */

		if (lcancel(0))
			return(SUCCESS);

		clrlsel();
		return(fcindex());

	case 7:		/* "Content" */

		if (lselsw AND lrasw)
			return(getit());

		lrasw = NOT lrasw;
		ldswin(7);
		return(SUCCESS);

	case 8:		/* "Hi Orch" / "Lo Orch" */

		lorchl = NOT lorchl;
		ldswin(8);
		return(SUCCESS);


	case 9:		/* "Store" */

		if (lcancel(1))
			return(SUCCESS);

		if (cyval < 321) {

			/* row 22:  "Store", "Score", or "Hi Orch" */

			if (cxval < 120) {

				/* "Store" */

				if (lstrsw) {

					storit();

				 } else {

					lstrsw = TRUE;
					ldswin(9);
				}

				return(SUCCESS);

			} else if ((cxval > 135) AND (cxval < 176)) {

				/* "Score" */

				lscrsw = NOT lscrsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);

			} else if (cxval > 191) {

				/* "Hi Orch" */

				lorchsw = NOT lorchsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);
			}

		} else if ((cyval > 321) AND (cyval < 335)) {

			/* row 23:  "Waves",  "Patch",  or "Lo Orch" */

			if (cxval < 120) {		/* "Waves" */

				lwavsw = NOT lwavsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);

			} else if ((cxval > 135) AND (cxval < 176)) {

				/* "Patch" */

				lpatsw = NOT lpatsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);

			} else if (cxval > 191) {	/* "Lo Orch" */

				lorclsw = NOT lorclsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);
			}

		} else if (cyval > 335) {

			/* row 24:  "Assgn", "Seqnc", or "Tunings" */

			if (cxval < 120) {		/* "Assgn" */

				lasgsw = NOT lasgsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);

			} else if ((cxval > 135) AND (cxval < 176)) {

				/* "Seqnc" */

				lseqsw = NOT lseqsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);

			} else if (cxval > 191) {	/* "Tunings" */

				ltunsw = NOT ltunsw;
				ldswin(9);

				if (lstrsw)
					storit();

				return(SUCCESS);
			}
		}

		return(FAILURE);

	default:

		lcancel(3);
		return(FAILURE);
	}
}

