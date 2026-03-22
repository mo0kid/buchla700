/*
   =============================================================================
	smscrl.c -- MIDAS-VII smooth scrolling functions
	Version 37 -- 1989-11-16 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	OLDSCRL		0

#include "ram.h"

#define	SS_NSL		16			/* number of scrolled lines */
#define	SS_TOP		(2 * (SS_NSL + 1))	/* total line count */
#define	SS_LIM		(SS_TOP - SS_NSL)	/* top line limit */
#define	SS_LEN		48			/* length of a scrolled line */
#define	NSCANS		14			/* number of scan lines */
#define	TOPSCAN		(NSCANS - 1)		/* top scan line */

int8_t	TheBuf[66];				/* display build buffer */

int8_t	*(*BakLine)(void);		/* next line backward function pointer */
int8_t	*(*FwdLine)(void);		/* next line forward function pointer */

int16_t	PdScDnF;			/* scroll down flag */
int16_t	PdScUpF;			/* scroll up flag */

int16_t	CurLine;			/* top line being displayed */
int16_t	CurScan;			/* current scan line */
int16_t	DupLine;			/* write pointer for other page */
int16_t	ScrlObj;			/* object descriptor table index */

int8_t	*LinePtr;			/* line to scroll onto screen */

uint16_t	LineAtr;		/* attribute for the new line */

volatile	uint16_t	*LineBuf;	/* current display memory pointer */
volatile	uint16_t	*OldLine;	/* old display memory pointer */
volatile	uint16_t	*ScObAdr;	/* display memory base pointer */

int16_t	LineCon = SS_LEN * 3;		/* line offset constant */
int16_t	LineLen = SS_LEN;		/* length of a scrolled line */
int16_t	SmScLim = SS_LIM;		/* top line limit */
int16_t	SmScNsl = SS_NSL;		/* number of scrolled lines */
int16_t	SmScTop = SS_TOP;		/* total line count */

/*
   =============================================================================
	LineFwd() -- return the next patch line in the forward direction
   =============================================================================
*/

int8_t *LineFwd(void)
{
	register int16_t j, k;

	for (j = 0; j < 48; j++)
		TheBuf[j] = ' ';

	TheBuf[0]  = '\260';
	TheBuf[48] = '\0';

	if (0 EQ ptecpos)
		return((int8_t *)NULL);

	if (0 EQ (j = findnxt(ptecpos)))
		return((int8_t *)NULL);

	ptecpos = j;

	memcpyw(&ptebuf.defnum, &patches[ptecpos].defnum, 6);
	pteset = TRUE;
	pte2buf();

	k = ptecpos;

	for (j = 0; j < 8; j++)
		if (0 EQ (k = findnxt(k)))
			return(TheBuf);

	dspdfst(&TheBuf[ 2], patches[k].defnum);
	dspdfst(&TheBuf[15], patches[k].stmnum);
	dspdest(&TheBuf[28], &patches[k]);

	for (j = 0; j < 50; j++)
		if(TheBuf[j] EQ '\0')
			TheBuf[j] = ' ';

	TheBuf[48] = '\0';
	return(TheBuf);
}

/*
   =============================================================================
	LineBak() -- return the next patch line in the backward direction
   =============================================================================
*/

int8_t *LineBak(void)
{
	register int16_t j, k;

	for (j = 0; j < 48; j++)
		TheBuf[j] = ' ';

	TheBuf[0]  = '\260';
	TheBuf[48] = '\0';

	if (0 EQ ptecpos)
		return((int8_t *)NULL);

	if (0 EQ (j = findprv(ptecpos)))
		return((int8_t *)NULL);

	ptecpos = j;

	memcpyw(&ptebuf.defnum, &patches[ptecpos].defnum, 6);
	pteset = TRUE;
	pte2buf();

	k = ptecpos;

	for (j = 0; j < 7; j++)
		if (0 EQ (k = findprv(k)))
			return(TheBuf);

	dspdfst(&TheBuf[ 2], patches[k].defnum);
	dspdfst(&TheBuf[15], patches[k].stmnum);
	dspdest(&TheBuf[28], &patches[k]);

	for (j = 0; j < 50; j++)
		if(TheBuf[j] EQ '\0')
			TheBuf[j] = ' ';

	TheBuf[48] = '\0';
	return(TheBuf);
}

/*
   =============================================================================
	WrVideo() -- write a line to the video display
   =============================================================================
*/

void WrVideo(int16_t row, int16_t col, int8_t *str, uint16_t atr)
{
	register int8_t chr;

	if (v_regs[5] & 0x0180)
		vbank(0);

	while ('\0' NE (chr = *str++)) {

		vputcv(ScObAdr, row, col, chr,
			(col EQ 0) ? PTBATR : atr, LineLen);

		col++;
	}
}

/*
   =============================================================================
	SetDTop() -- set the top line of the display
   =============================================================================
*/

void SetDTop(int16_t row, int16_t scan)
{
	if (v_regs[5] & 0x0180)
		vbank(0);

	LineBuf = (uint16_t *)((int8_t *)ScObAdr + (row * LineCon));

	if (OldLine NE LineBuf)
		v_odtab[ScrlObj][2] = (uint16_t)((int32_t)LineBuf >> 1);

	OldLine = LineBuf;

	v_odtab[ScrlObj][0] = (v_odtab[ScrlObj][0] & 0x0FFF) | (uint16_t)(scan << 12);
}

/*
   =============================================================================
	UpdVid() -- update the video display on both pages
   =============================================================================
*/

void UpdVid(int16_t row, int16_t col, int8_t *str, uint16_t atr)
{
	WrVideo(CurLine + row, col, str, atr);

	DupLine = CurLine + SmScNsl + 2 + row;

	if (DupLine < SmScTop)
		WrVideo(DupLine, col, str, PTPATR);

	DupLine = CurLine - SmScNsl - 2 + row;

	if (DupLine GE 0)
		WrVideo(DupLine, col, str, PTPATR);
}

/*
   =============================================================================
	bgncm() -- begin patch display cursor motion
   =============================================================================
*/

void bgncm(void)
{
	register int16_t j;

	memcpyw(&ptebuf.defnum, &patches[ptecpos].defnum, 6);
	pteset = TRUE;
	pte2buf();

	memcpy(TheBuf, ptdebuf, 48);

	for (j = 0; j < 50; j++)
		if(TheBuf[j] EQ '\0')
			TheBuf[j] = ' ';

	TheBuf[0] = '\260';
	TheBuf[1] = ' ';
	TheBuf[48] = '\0';

	UpdVid(7, 0, TheBuf, PTPATR);
	ctcoff();
}

/*
   =============================================================================
	stopcm() -- stop patch display cursor motion
   =============================================================================
*/

void stopcm(void)
{
	if (PdScDnF)
		SetDTop(CurLine, CurScan = TOPSCAN);
	else if (PdScUpF)
		SetDTop(++CurLine, CurScan = TOPSCAN);

	if (NOT ctcsw) {		/* if we scrolled ... */

		if (ptecpos) {		/* if something is there ... */

			/* refresh editing variables */

			memcpyw(&ptebuf.defnum, &patches[ptecpos].defnum, 6);
			pteset = TRUE;
			pte2buf();
			setptcv();

		} else {		/* ... nothing there */

			voidpb();	/* void the patch buffer */
		}
	}

	ctcon();			/* re-enable cursor */

	PdScDnF = FALSE;		/* turn off the scrolling flags */
	PdScUpF = FALSE;
}

/*
   =============================================================================
	stopsm() -- stop sequence display cursor motion
   =============================================================================
*/

void stopsm(void)
{
	if (PdScDnF)
		SetDTop(CurLine, CurScan = TOPSCAN);
	else if (PdScUpF)
		SetDTop(++CurLine, CurScan = TOPSCAN);

	memcpyw(&seqbuf, &seqtab[curslin], NSEQW);
	dsqlin(sqdebuf, curslin);
	sqdeflg = TRUE;
	ctcon();

	PdScDnF = FALSE;
	PdScUpF = FALSE;
}

/*
   =============================================================================
	smscrl() -- smooth scroll the text display up or down
   =============================================================================
*/

void smscrl(void)
{
	if (PdScUpF) {			/* SCROLL UP (toward NEW data) ? */

		if (CurScan EQ TOPSCAN) {	/* ready for a new line ? */

			if ((int8_t *)NULL NE (LinePtr = (*FwdLine)())) {	/* get a line */

				if (CurLine EQ SmScLim) {	/* *** swap display pages *** */

					/* update page we're going to */

					WrVideo(SmScNsl, 0, LinePtr, LineAtr);

					/* point at new page */

					SetDTop(CurLine = 0, CurScan = TOPSCAN);

				} else {		/* *** stay on this page *** */

					/* update scroll target line */

					WrVideo(CurLine + SmScNsl, 0, LinePtr, LineAtr);

					/* update other page if it's in range */

					DupLine = CurLine - 2;

					if (DupLine GE 0)
						WrVideo(DupLine, 0, LinePtr, LineAtr);
				}

					/* do first scroll up of new line */

					SetDTop(CurLine, --CurScan);
			}

		} else {		/* scrolling -- scroll some more */

			if (CurScan EQ 0)
				SetDTop(++CurLine, CurScan = TOPSCAN);
			else
				SetDTop(CurLine, --CurScan);
		}

	} else if (PdScDnF) {		/* SCROLL DOWN (toward old data) ? */

		if (CurScan EQ TOPSCAN) {	/* ready for a new line ? */

			if ((int8_t *)NULL NE (LinePtr = (*BakLine)())) {	/* get a line */

				if (CurLine EQ 0) {	/* *** swap display pages *** */

					/* update page we're going to */

					WrVideo(SmScLim - 1, 0, LinePtr, LineAtr);

					/* point at new page */

					SetDTop(CurLine = SmScLim - 1, CurScan = 0);

				} else {		/* *** stay on this page *** */

					/* update scroll target line */

					WrVideo(CurLine - 1, 0, LinePtr, LineAtr);

					/* update other page if it's in range */

					DupLine = CurLine + SmScNsl + 1;

					if (DupLine < SmScTop)
						WrVideo(DupLine, 0, LinePtr, LineAtr);

					/* do first scroll down of new line */

					SetDTop(--CurLine, CurScan = 0);
				}
			}

		} else {		/* scrolling -- scroll some more */

			if (CurScan NE TOPSCAN)
				SetDTop(CurLine, ++CurScan);
		}
	}
}

/*
   =============================================================================
	smxupd() -- patch / sequence smooth scroll X axis update
   =============================================================================
*/

void smxupd(void)
{
	int16_t oldcx;

	oldcx = cxval;

	if (submenu) {

		vtccol = XTOC(vtxval += cxrate);

		if (vtccol > 60)
			vtxval = CTOX(vtccol = 60);
		else if (vtccol < 2)
			vtxval = CTOX(vtccol = 2);

	} else {

		cxval += cxrate;

		if (cxval > CTOX(48))
			cxval = CTOX(48);
		else if (cxval < CTOX(2))
			cxval = CTOX(2);

		if (cxval EQ oldcx)
			return;

		if (47 EQ XTOC(cxval)) {

			if (v_regs[5] & 0x0180)
				vbank(0);

			vvputsv(obj10, 16, PDBORFG, PDSEQBG,
				7, 0, "\260", 14, 14, cg3);

			vsplot4(obj10, 16, PDPTRFG,
				7, 0, "\274", 14, 14, cg3);

		} else if (48 EQ XTOC(cxval)) {

			if (v_regs[5] & 0x0180)
				vbank(0);

			vvputsv(obj10, 16, PDBORFG, PDSEQBG,
				7, 0, "\260", 14, 14, cg3);

			vsplot4(obj10, 16, PDPTRFG,
				7, 0, "\277", 14, 14, cg3);

		}

		return;
	}
}

/*
   =============================================================================
	smy_up() -- patch display smooth scrolling
   =============================================================================
*/

void smy_up(int16_t tag)
{

	if (0 EQ ptecpos) {		/* see if anything is there */

		dptw();			/* try to find something ... */
		return;			/* ... may scroll next time */
	}

	if (ctcsw)			/* if we haven't scrolled yet ... */
		bgncm();		/* ... setup for scrolling */

	if (tag < 0) {		/* scroll up */

		if (0 EQ findnxt(ptecpos))
			return;

		PdScUpF = TRUE;
		PdScDnF = FALSE;
		smscrl();

	} else if (tag > 0) {	/* scroll down */

		if (0 EQ findprv(ptecpos))
			return;

		PdScDnF = TRUE;
		PdScUpF = FALSE;
		smscrl();
	}
}

/*
   =============================================================================
	smyupd() -- patch display smooth scroll Y axis update
   =============================================================================
*/

void smyupd(void)
{
	if (submenu) {

		vtcrow = YTOR(vtyval += cyrate);

		if (vtcrow > 23)
			vtyval = RTOY(vtcrow = 23);
		else if (vtcrow < 19)
			vtyval = RTOY(vtcrow = 19);

	}

#if	OLDSCRL
	smy_up(cyrate);
#endif
}

/*
   =============================================================================
	sqy_up() -- sequence smooth scrolling
   =============================================================================
*/

void sqy_up(int16_t tag)
{
	if (ctcsw)
		ctcoff();

	if (tag < 0) {		/* scroll up */

		PdScUpF = TRUE;
		PdScDnF = FALSE;
		smscrl();

	} else if (tag > 0) {	/* scroll down */

		PdScDnF = TRUE;
		PdScUpF = FALSE;
		smscrl();
	}
}

/*
   =============================================================================
	sqyupd() -- sequence smooth scroll Y axis update
   =============================================================================
*/

void sqyupd(void)
{
	if (submenu) {

		vtcrow = YTOR(vtyval += cyrate);

		if (vtcrow > 23)
			vtyval = RTOY(vtcrow = 23);
		else if (vtcrow < 19)
			vtyval = RTOY(vtcrow = 19);

	}

#if	OLDSCRL
	sqy_up(cyrate);
#endif
}

