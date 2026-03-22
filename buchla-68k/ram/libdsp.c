/*
   =============================================================================
	libdsp.c -- MIDAS librarian display
	Version 64 -- 1988-11-17 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGRE		0
#define	DEBUGWE		0

#include "ram.h"

#if	DEBUGRE
short	debugre = 1;
#endif

#if	DEBUGWE
short	debugwe = 1;
#endif

int8_t	*ftypes[][3] = {	/* file types  (must match libdsp.h) */

	{"ASG", "Assignmnt", "Assignmnt"},	/* FT_ASG */
	{"ORL", "Orchestra", "Orchestra"},	/* FT_ORL */
	{"ORH", "Orchestra", "Orchestra"},	/* FT_ORH */
	{"SCR",	"    Score", "Score"},		/* FT_SCR */
	{"TUN", "   Tuning", "Tuning"},		/* FT_TUN */
	{"WAV", "Waveshape", "Waveshape"},	/* FT_WAV */
	{"ORC", "Orchestra", "Orchestra"},	/* FT_ORC */
	{"PAT", "    Patch", "Patch"},		/* FT_PAT */
	{"SEQ", " Sequence", "Sequence"}	/* FT_SEQ */
};

int8_t	ld_em1[] = "No files stored on disk";
int8_t	ld_em2[] = " by this operation";

int16_t	lbrpal[16][3] = {	/* librarian color palette */

	{0, 0, 0},	/* 0 */
	{3, 3, 3},	/* 1 */
	{1, 0, 0},	/* 2 */
	{1, 1, 0},	/* 3 */
	{2, 1, 0},	/* 4 (was 2, 2, 0) */
	{1, 1, 0},	/* 5 */
	{2, 1, 0},	/* 6 (was 2, 2, 0) */
	{1, 0, 0},	/* 7 */
	{0, 1, 1},	/* 8 (was 0, 1, 0) */
	{1, 0, 0},	/* 9 */
	{1, 1, 0},	/* 10 */
	{2, 2, 2},	/* 11 */
	{2, 3, 3},	/* 12 */
	{3, 3, 0},	/* 13 */
	{3, 0, 0},	/* 14 */
	{0, 0, 0}	/* 15 */
};

/*
   =============================================================================
	ftkind() -- return the file type for a given file catalog slot

		ns = catalog slot index
		-1 returned on error   (returns 1..NFTYPES for a good type)
   =============================================================================
*/

int16_t ftkind(int16_t ns)
{
	register int16_t i;

	for (i = 0; i < NFTYPES; i++)
		if (0 EQ memcmpu(filecat[ns].fcextn, ftypes[i][0], 3))
			return(++i);

	return(-1);
}

/*
   =============================================================================
	fctstr() -- return a string showing the file catalog entry type

		ns = catalog slot index
		just = 0: right justify string,  1: left justify string
   =============================================================================
*/

int8_t *fctstr(int16_t ns, int16_t just)
{
	static int8_t fcbad[11];
	register int16_t i;

	for (i = 0; i < NFTYPES; i++)
		if (0 EQ memcmpu(filecat[ns].fcextn, ftypes[i][0], 3))
			return(ftypes[i][just ? 2 : 1]);

	sprintf(fcbad, "?? %3.3s  ??", filecat[ns].fcextn);
	return(fcbad);
}

/*
   =============================================================================
	ocslot() -- determine if a slot is occupied
   =============================================================================
*/

int16_t ocslot(int16_t slot)
{
	if (memcmp(filecat[slot].fcsize, "000", 3)
	    AND (0 NE filecat[slot].fcsize[0]))
		return(TRUE);
	else
		return(FALSE);
}

/*
   =============================================================================
	ldline() -- determine which catalog line the cursor is on, if any
   =============================================================================
*/

int16_t ldline(int16_t cy)
{
	if (cy > 292)
		return(0);

	if (cy < 14)
		return(0);

	return(cy / 14);
}

/*
   =============================================================================
	lin2slt() -- determine which slot a line corresponds to, if any

		-1 returned on error  (0..FCMAX-1 returned for a good slot)
   =============================================================================
*/

int16_t lin2slt(int16_t line)
{
	register int16_t slot, row;

	row = 0;

	for (slot = 0; slot < FCMAX; slot++)
		if (ocslot(slot))
			if (++row EQ line)
				return(slot);

	return(-1);
}

/*
   =============================================================================
	exp_c() -- expand a 4 bit color to 16 bits
   =============================================================================
*/

uint16_t exp_c(int16_t c)
{
	uint16_t r;

	r = (uint16_t)c & 0x000F;	/* use low 4 bits as the basis */
	r |= r << 4;			/* turn them into 8 bits */
	r |= r << 8;			/* make it a full 16 bits */

	return(r);
}

/*
   =============================================================================
	ldwmsg() -- display a message in the message window
   =============================================================================
*/

void ldwmsg(int8_t *line1, int8_t *line2, int8_t *line3, int16_t fgcolor, int16_t bgcolor)
{
	lderrsw = FALSE;		/* clear error switch */
	lmwtype = 2;			/* message type */
	submenu = FALSE;

	if (ndisp NE 0)
		return;

	if (v_regs[5] & 0x0180)
		vbank(0);

	/* clear the window */

	vbfill4(librob, 128, ldbox[10][0], ldbox[10][1],
		ldbox[10][2], ldbox[10][3], exp_c(bgcolor));

	if ((int8_t *)NULL NE line1)
		tsplot4(librob, 64, fgcolor, ldbox[10][6], ldbox[10][7],
			line1, 14);

	if ((int8_t *)NULL NE line2)
		tsplot4(librob, 64, fgcolor, (ldbox[10][6] + 1), ldbox[10][7],
			line2, 14);

	if ((int8_t *)NULL NE line3)
		tsplot4(librob, 64, fgcolor, (ldbox[10][6] + 2), ldbox[10][7],
			line3, 14);
}

/*
   =============================================================================
	chksum() -- checksum an area of memory
   =============================================================================
*/

int32_t chksum(void *area, int32_t len)
{
	uint8_t *area8;
	int32_t cs, i;

	area8 = area;
	cs = 0L;

	for (i = 0; i < len; i++)
		cs += 0x000000FFL & *area8++;

	return(cs);
}

/*
   =============================================================================
	makelh() -- make a library header
   =============================================================================
*/

void makelh(int16_t kind)
{
	memset(ldhead.l_csum, '?', 8);			/* checksum */
	memcpy(ldhead.l_name, ldfile, 8);		/* file name */
	memcpy(ldhead.l_type, ftypes[kind - 1][0], 3);	/* file type */
	memcpy(ldhead.l_cmnt, ldcmnt, 37);		/* comment */

	lcsum = chksum(ldhead.l_name, (int32_t)(LH_LEN - 8));
}

/*
   =============================================================================
	ldbusy() -- put up a "Busy" message
   =============================================================================
*/

void ldbusy(int8_t *msg)
{
	if (ndisp NE 0)
		return;

	ldwmsg((int8_t *)NULL, "    Busy - Please stand by", msg,
		ldbox[10][4], ldbox[10][5]);
}

/*
   =============================================================================
	noslot() -- complain about not finding a slot we expected
   =============================================================================
*/

void noslot(int16_t fctype)
{
	sprintf(ldmsg1, " the %s file,", ftypes[fctype - 1][2]);

	ldermsg("Can't find a slot for",
		ldmsg1, " and one was expected", LD_EMCF, LD_EMCB);
}

/*
   =============================================================================
	wr_ec() -- write with error checking
   =============================================================================
*/

int16_t wr_ec(FILE *fp, void *from, int32_t len)
{
	uint8_t *from8, c;
	int32_t count;

	from8 = from;

	for (count = 0; count < len; count++) {

		errno = 0;
		c  = *from8++;

		if (EOF EQ putc(c, fp)) {

			sprintf(errbuf, "errno = %d", errno);

			ldermsg("Disk may be full",
				errbuf, (int8_t *)NULL, LD_EMCF, LD_EMCB);

			fclose(fp);
			postio();		/* restore LCD backlight */
			return(FAILURE);
		}

#if	DEBUGWE
	if (debugsw AND debugwe)
		printf(" %02.2X", 0x00FF & c);
#endif
	}

	return(SUCCESS);
}

/*
   =============================================================================
	rd_ec() -- read with error checking
   =============================================================================
*/

int16_t rd_ec(FILE *fp, void *to, int32_t len)
{
	uint8_t *to8;
	int32_t count;
	int16_t c;

	to8 = to;

	for (count = 0; count < len; count++) {

		errno = 0;

		if (EOF EQ (c = getc(fp))) {

			sprintf(errbuf, "errno = %d", errno);

			ldermsg("Unexpected EOF",
				errbuf, (int8_t *)NULL, LD_EMCF, LD_EMCB);

			fclose(fp);
			postio();		/* restore LCD backlight */
			return(FAILURE);

		} else {

			*to8++ = (uint8_t)c;

#if	DEBUGRE
	if (debugsw AND debugre)
		printf(" %02.2X", 0x00FF & c);
#endif
		}
	}

	return(SUCCESS);
}

/*
   =============================================================================
	srchcat() -- search the file catalog

		returns -1 on 'not found',  slot 0..FCMAX-1 if found
   =============================================================================
*/

int16_t srchcat(int8_t extn[])
{
	register int16_t fcslot;

	for (fcslot = 0; fcslot < FCMAX; fcslot++) {

		if (ocslot(fcslot))
			if (0 EQ (memcmp(filecat[fcslot].fcname, ldfile, 8))
			    AND (0 EQ memcmpu(filecat[fcslot].fcextn, extn, 3)))
				return(fcslot);
	}

	return(-1);
}

/*
   =============================================================================
	clrcat() -- clear the file catalog
   =============================================================================
*/

void clrcat(void)
{
	register int16_t i;
	int8_t fcebuf[1 + sizeof (struct fcat)];

	for (i = 0; i < FCMAX; i++) {

		sprintf(fcebuf, "000 Empty-%02.2d ??? %-37.37s%c%c",
			i, "1234567890123456789012345678901234567",
			A_CR, A_LF);

		memcpy(&filecat[i], fcebuf, sizeof (struct fcat));
	}
}

/*
   =============================================================================
	clreq() -- return number of clusters needed for a file

		Assumes the BPB pointer is valid.
   =============================================================================
*/

int16_t clreq(int32_t bytes)
{
	register int16_t rclusts;
	register int32_t clmask;

	clmask = _thebpb->clsizb - 1;

	rclusts = (int16_t)(bytes / _thebpb->clsizb)
		  + ((bytes & clmask) ? 1 : 0);

	return(rclusts);
}

/*
   =============================================================================
	spacerq() -- return space required for storing a file
   =============================================================================
*/

int16_t spacerq(int16_t kind)
{
	register int16_t howmuch;
	register int32_t k;

	k = 0L;

	switch (kind) {

	case FT_ASG:	/* Assignment file */

		k = (sizeof (struct asgent) * (int32_t)NASGLIB) + (int32_t)LH_LEN;
		break;

	case FT_ORL:
	case FT_ORH:
	case FT_ORC:

		k = ((OR_LEN1 + (2 * OR_LEN2)) * (int32_t)NINORC) + (int32_t)LH_LEN;
		break;

	case FT_PAT:	/* Patch file */

		k = ptsizer() + (int32_t)LH_LEN;
		break;

	case FT_SCR:	/* Score file */

		k = scsizer() + (int32_t)LH_LEN;
		break;

	case FT_SEQ:	/* Sequence file */

		k = sqsizer() + (int32_t)LH_LEN;
		break;

	case FT_TUN:	/* Tuning file */

		k = (NTUNSLIB * 256L) + (NTUNSLIB * 32L) + (int32_t)LH_LEN;
		break;

	case FT_WAV:	/* Waveshape file */

		k = ((int32_t)NUMWAVS * OR_LEN2) + (int32_t)LH_LEN;
		break;

	default:

		k = 0L;
		break;
	}

	howmuch = k ? clreq(k) : -1;
	ndbytes = k;
	return(howmuch);
}

/*
   =============================================================================
	ckstor() -- check for storage type selection
   =============================================================================
*/

int16_t ckstor(void)
{
	if (lasgsw)			/* assignments */
		return(SUCCESS);

	if (lorchsw)			/* hi orch */
		return(SUCCESS);

	if (lorclsw)			/* lo orch */
		return(SUCCESS);

	if (lpatsw)			/* patches */
		return(SUCCESS);

	if (lscrsw)			/* score */
		return(SUCCESS);

	if (lseqsw)			/* sequences */
		return(SUCCESS);

	if (ltunsw)			/* tunings */
		return(SUCCESS);

	if (lwavsw)			/* waveshapes */
		return(SUCCESS);

	return(FAILURE);
}

/*
   =============================================================================
	ckdups() -- check for duplicate file type entries in the file catalog
   =============================================================================
*/

int16_t ckdups(void)
{
	if (lasgsw)
		if (-1 NE srchcat("asg"))
			return(FT_ASG);

	if (lorchsw)
		if (-1 NE srchcat("orh"))
			return(FT_ORH);

	if (lorclsw)
		if (-1 NE srchcat("orl"))
			return(FT_ORL);

	if (lorchsw OR lorclsw)
		if (-1 NE srchcat("orc"))
			return(FT_ORC);

	if (lpatsw)
		if (-1 NE srchcat("pat"))
			return(FT_PAT);

	if (lscrsw)
		if (-1 NE srchcat("scr"))
			return(FT_SCR);

	if (lseqsw)
		if (-1 NE srchcat("seq"))
			return(FT_SEQ);

	if (ltunsw)
		if (-1 NE srchcat("tun"))
			return(FT_TUN);

	if (lwavsw)
		if (-1 NE srchcat("wav"))
			return(FT_WAV);
	return(0);
}

/*
   =============================================================================
	showsiz() -- display disk capacity and usage

		Forces the disk to be read to get the BPB and FAT.
   =============================================================================
*/

int16_t showsiz(void)
{
	register int16_t dcap, drem, dused;

	_bpbin = FALSE;		/* force disk to be read */

	dcap = dspace(0);

	if (dcap EQ -1) {

		ldermsg("Disk not ready ?",
			(int8_t *)NULL, (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		return(FAILURE);
	}

	drem = dspace(1);
	dused = dcap - drem;

	sprintf(ldmsg1, "Microdisk capacity %4u blocks", dcap);
	sprintf(ldmsg2, "This disk consumes %4u blocks", dused);
	sprintf(ldmsg3, "Available space is %4u blocks", drem);

	ldwmsg(ldmsg1, ldmsg2, ldmsg3, ldbox[10][4], ldbox[10][5]);
	return(SUCCESS);
}

/*
   =============================================================================
	getcat() -- get the file catalog from disk
   =============================================================================
*/

int16_t getcat(int16_t msgsw)
{
	register FILE *fp;
	int16_t	rc, fesize;

	ldidsiz = FALSE;		/* we didn't show the size (yet) */
	_bpbin  = FALSE;		/* guarantee we read the directory */
	catin   = FALSE;		/* catalog not valid */

	errno = 0;
	preio();			/* kill LCD backlight */
	fp = fopenb(CATNAME, "r");	/* open the catalog file */

	if (NULL EQ fp) {

		clrcat();
		catin = TRUE;

		if (msgsw) {		/* see if we show the message */

			showsiz();
			ldidsiz = TRUE;	/* showed the size */
		}

		return(SUCCESS);	/* no catalog is OK, too */
	}

	fesize = sizeof(struct fcat);
	memset(filecat, 0, sizeof (struct fcat) * FCMAX);


	errno = 0;
	rc = fread(filecat, fesize, FCMAX, fp);

	if (rc NE FCMAX) {

		if (rc) {

			sprintf(ldmsg1, "  fread returned %d", rc);
			sprintf(ldmsg2, "  errno = %d, fesize=%d",
				errno, fesize);

			ldermsg("Unable to read catalog",
				ldmsg1, ldmsg2, LD_EMCF, LD_EMCB);

			catin = FALSE;

		} else {

			ldermsg("File catalog is NULL",
				(int8_t *)NULL, (int8_t *)NULL,
				LD_EMCF, LD_EMCB);

			clrcat();
			catin = TRUE;
		}

		fclose(fp);
		postio();		/* restore LCD backlight */
		return(FAILURE);
	}

	catin = TRUE;
	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	putcat() -- write the updated catalog on disk
   =============================================================================
*/

int16_t putcat(void)
{
	register FILE *fp;
	register int16_t	i, rc, fesize;

	for (i = 0; i < FCMAX; i++) {		/* clean up the catalog */

		filecat[i].fceol[0] = A_CR;
		filecat[i].fceol[1] = A_LF;
	}

	errno = 0;
	preio();			/* kill LCD backlight */
	fp = fopenb(CATNAME, "w");	/* open the catalog file */

	if (NULL EQ fp) {

		sprintf(ldmsg2, "  errno = %d", errno);

		ldermsg("Unable to open catalog",
				(int8_t *)NULL, ldmsg2, LD_EMCF, LD_EMCB);

		return(FAILURE);
	}

	fesize = sizeof (struct fcat);


	errno = 0;
	rc = fwrite(filecat, fesize, FCMAX, fp);

	if (rc NE FCMAX) {

		if (rc) {

			sprintf(ldmsg1, "  fwrite returned %d", rc);
			sprintf(ldmsg2, "  errno = %d, fesize=%d",
				errno, fesize);

			ldermsg("Can't write catalog",
				ldmsg1, ldmsg2, LD_EMCF, LD_EMCB);

		} else {

			sprintf(ldmsg2, "  errno = %d", errno);

			ldermsg("Disk may be full",
				(int8_t *)NULL, ldmsg2,
				LD_EMCF, LD_EMCB);
		}

		fclose(fp);
		postio();		/* restore LCD backlight */
		return(FAILURE);
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	dslslot() -- display a file catalog entry
   =============================================================================
*/

void dslslot(int16_t slot, int16_t fg, int16_t row)
{
	int16_t color, chilon, chilorc;
	int16_t c;
	int8_t buf[40];

	if (ndisp NE 0)
		return;

	color   = fg;		/* foreground color */
	chilon  = ldbox[1][4];
	chilorc = HILORC;

	/* file type */

	vcputsv(librob, 64, color, ldbox[1][5], row, 1, fctstr(slot, 0), 14);

	/* load letter */

	c = filecat[slot].fcp0;
	buf[0] = 0x007F & c;
	buf[1] = '\0';
	vcputsv(librob, 64, (c & 0x0080) ? chilorc : chilon,
		ldbox[1][5], row, 11, buf, 14);

	/* file name */

	memcpy(buf, filecat[slot].fcname, 8);
	buf[8] = '\0';
	vcputsv(librob, 64, color, ldbox[1][5], row, 13, buf, 14);

	/* comment */

	memcpy(buf, filecat[slot].fccmnt, 37);
	buf[37] = '\0';
	vcputsv(librob, 64, chilon, ldbox[1][5], row, 22, buf, 14);

	/* size */

	memcpy(buf, filecat[slot].fcsize, 3);
	buf[3] = '\0';
	vcputsv(librob, 64, chilon, ldbox[1][5], row, 60, buf, 14);
}

/*
   =============================================================================
	showcat() -- display the file catalog entries
   =============================================================================
*/

int16_t showcat(void)
{
	int16_t fcslot, fcrow, fcount;
	uint16_t bg;
	int16_t fg;

	if (ndisp NE 0)
		return(FAILURE);

	ldswin(0);			/* fix up the title */

	bg = exp_c(ldbox[1][5]);	/* background color */

	if (v_regs[5] & 0x0180)
		vbank(0);

	vbfill4(librob, 128, ldbox[1][0], ldbox[1][1],
		ldbox[1][2], ldbox[1][3], bg);

	fg = ldbox[1][4];		/* foreground color */

	fcrow  = 1;
	fcount = 0;

	for (fcslot = 0; fcslot < FCMAX; fcslot++) {

		if (ocslot(fcslot))  {

			dslslot(fcslot, fg, fcrow);
			fcrow++;
			fcount++;
		}
	}

	return(fcount);
}

/*
   =============================================================================
	fcindex() -- display the file catalog
   =============================================================================
*/

int16_t fcindex(void)
{
	if (NOT lderrsw)
		ldbusy("       Reading catalog");

	if (getcat(1))			/* get catalog, possibly display size */
		return(FAILURE);

	if (NOT lderrsw)
		showcat();		/* display the catalog */

	/* show size if getcat() didn't */

	if ((NOT ldidsiz) AND (NOT lderrsw))
		showsiz();

	return(SUCCESS);
}

/*
   =============================================================================
	streset() -- reset the switches after a store or an error
   =============================================================================
*/

void streset(void)
{
	lstrsw  = FALSE;

	lasgsw  = FALSE;
	lorchsw = FALSE;
	lorclsw = FALSE;
	lpatsw  = FALSE;
	lscrsw  = FALSE;
	lseqsw  = FALSE;
	ltunsw  = FALSE;
	lwavsw  = FALSE;

	ldswin(9);
}

/*
   =============================================================================
	fcreset() -- reset the switches after a fetch or an error
   =============================================================================
*/

void fcreset(void)
{
	lselsw = FALSE;

	ldswin(6);
}

/*
   =============================================================================
	getslot() -- find a free file catalog slot

		returns -1 on error,  slot # 0..FCMAX-1 if a slot was found
   =============================================================================
*/

int16_t getslot(void)
{
	register int16_t i;

	for (i = 0; i < FCMAX; i++)
		if (NOT ocslot(i))
			return(i);

	return(-1);
}

/*
   =============================================================================
	slotnam() -- return the file name for a slot
   =============================================================================
*/

int8_t *slotnam(int16_t slot, int16_t kind)
{
	static	int8_t thename[13];

	sprintf(thename, "M7SLOT%02.2u.%-3.3s",
		slot, ftypes[kind - 1][0]);

	return(thename);
}

/*
   =============================================================================
	wrtfile() -- write a file on the disk
   =============================================================================
*/

int16_t wrtfile(int16_t kind)
{
	register int16_t slot, flspace, tkind;
	int8_t sizetmp[4];

	slot = getslot();

	if (-1 EQ slot) {

		noslot(kind);
		streset();
		return(FAILURE);
	}

	switch (kind) {

	case FT_ASG:

		if (wrt_asg(slot))
			return(FAILURE);
		else
			break;

	case FT_ORL:		/* lo orch write */

		if (wrt_orc(slot, 0))
			return(FAILURE);
		else
			break;

	case FT_ORH:		/* hi orch write */

		if (wrt_orc(slot, 1))
			return(FAILURE);
		else
			break;

	case FT_PAT:

		if (wrt_pat(slot))
			return(FAILURE);
		else
			break;

	case FT_SCR:

		if (wrt_scr(slot))
			return(FAILURE);
		else
			break;

	case FT_SEQ:

		if (wrt_seq(slot))
			return(FAILURE);
		else
			break;


	case FT_TUN:

		if (wrt_tun(slot))
			return(FAILURE);
		else
			break;

	case FT_WAV:

		if (wrt_wav(slot))
			return(FAILURE);
		else
			break;

	default:

		sprintf(ldmsg1, " kind=%d", kind);

		ldermsg("bad wrtfile argument:",
			ldmsg1, (int8_t *)NULL, LD_EMCF, LD_EMCB);

		return(FAILURE);
	}

	/* update the file catalog */

	if ((kind EQ FT_ORL) OR (kind EQ FT_ORH))
		tkind = FT_ORC;
	else
		tkind = kind;

	flspace = spacerq(kind);

	sprintf(sizetmp, "%03.3d", flspace);	/* size */
	memcpy(filecat[slot].fcsize, sizetmp, 3);

	memcpy(filecat[slot].fcname, ldfile, 8);		/* name */
	memcpy(filecat[slot].fcextn, ftypes[tkind - 1][0], 3);	/* type */
	memcpy(filecat[slot].fccmnt, ldcmnt, 37);		/* comment */

	savefc(kind);

	filecat[slot].fceol[0] = A_CR;
	filecat[slot].fceol[1] = A_LF;

	return(SUCCESS);
}

/*
   =============================================================================
	writem() -- write selected files
   =============================================================================
*/

int16_t writem(void)
{
	if (lasgsw)			/* Assignments */
		if (wrtfile(FT_ASG))
			return(FAILURE);

	if (lorchsw)			/* Hi Orch */
		if (wrtfile(FT_ORH))
			return(FAILURE);

	if (lorclsw)			/* Lo Orch */
		if (wrtfile(FT_ORL))
			return(FAILURE);

	if (lpatsw)			/* Patches */
		if (wrtfile(FT_PAT))
			return(FAILURE);

	if (lscrsw)			/* Score */
		if (wrtfile(FT_SCR))
			return(FAILURE);

	if (lseqsw)			/* Sequences */
		if (wrtfile(FT_SEQ))
			return(FAILURE);

	if (ltunsw)			/* Tunings */
		if (wrtfile(FT_TUN))
			return(FAILURE);

	if (lwavsw)			/* Waveshapes */
		if (wrtfile(FT_WAV))
			return(FAILURE);

	return(SUCCESS);
}

/*
   =============================================================================
	storit() -- store selected files on disk
   =============================================================================
*/

int16_t storit(void)
{
	register int16_t weneed, i, slotnd, slothv;
	int16_t	rc, drem;

	/* make sure the file is named */

	if (0 EQ memcmp(ldfile, "        ", 8)) {

		ldermsg("File must be named",
			ld_em1, ld_em2, LD_EMCF, LD_EMCB);

		streset();
		return(FAILURE);
	}

	/* make sure something was selected */

	if (ckstor()) {

		ldermsg("No file type selected",
			ld_em1, ld_em2, LD_EMCF, LD_EMCB);

		streset();
		return(FAILURE);
	}

	if (NOT lderrsw)
		ldbusy("       Storing files");

	if (getcat(0)) {		/* get the catalog */

		streset();
		return(FAILURE);
	}

	/* find out how much space we need to store everything */

	drem   = dspace(1);
	slotnd = 0;
	weneed = 0;


	if (lasgsw) {

		weneed += spacerq(FT_ASG);
		++slotnd;
	}

	if (lorchsw) {

		weneed += spacerq(FT_ORH);
		++slotnd;
	}

	if (lorclsw) {

		weneed += spacerq(FT_ORL);
		++slotnd;
	}

	if (lpatsw) {

		weneed += spacerq(FT_PAT);
		++slotnd;
	}

	if (lscrsw) {

		weneed += spacerq(FT_SCR);
		++slotnd;
	}

	if (lseqsw) {

		weneed += spacerq(FT_SEQ);
		++slotnd;
	}

	if (ltunsw) {

		weneed += spacerq(FT_TUN);
		++slotnd;
	}

	if (lwavsw) {

		weneed += spacerq(FT_WAV);
		++slotnd;
	}

	if (drem < weneed) {

		nospace("file");
		streset();
		return(FAILURE);
	}

	/* see if we have enough catalog space */

	slothv = 0;

	for (i = 0; i < FCMAX; i++)
		if (NOT ocslot(i))
			++slothv;

	if (slothv < slotnd) {

		nospace("file");
		streset();
		return(FAILURE);
	}

	/* make sure the name is unique */

	if ((rc = ckdups())) {

		sprintf(ldmsg1, "Duplicate %s", ftypes[rc - 1][2]);
		ldermsg(ldmsg1, ld_em1, ld_em2, LD_EMCF, LD_EMCB);

		streset();
		return(FAILURE);
	}

	/* write the files */

	rc = writem();

	if (NOT rc)
		ldbusy("       Writing catalog");

	if (putcat()) {

		_clsvol();
		streset();
		showcat();
		return(FAILURE);
	}

	_clsvol();
	streset();
	showcat();

	if (rc)
		return(FAILURE);

	showsiz();
	return(SUCCESS);
}

/*
   =============================================================================
	advlcur() -- advance the librarian display text cursor
   =============================================================================
*/

void advlcur(void)
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
	bsplcur() -- backspace the librarian display text cursor
   =============================================================================
*/

void bsplcur(void)
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
	ldswin() -- display a window
   =============================================================================
*/

void ldswin(int16_t n)
{
	uint16_t cx;
	int16_t cy;

	if (ndisp NE 0)
		return;

	if ((n EQ 10) AND (lmwtype EQ 1))
		cx = exp_c(TTBACK);	/* use black for the typewriter */
	else
		cx = exp_c(ldbox[n][5]);   /* expand the background color */

	/* first, fill the box with the background color */

	if (v_regs[5] & 0x0180)
		vbank(0);

	vbfill4(librob, 128, ldbox[n][0], ldbox[n][1], ldbox[n][2],
		ldbox[n][3], cx);

	/* put in the box label */

	tsplot4(librob, 64, ldbox[n][4], ldbox[n][6], ldbox[n][7],
		ldbxlb0[n], 14);


	switch (n) {	/* final text - overlays above stuff */

	case 0:		/* titles */

		point = ldpoint;

		lseg(  8, 13,  79, 13, LUNDRLN);
		lseg( 88, 13,  95, 13, LUNDRLN);
		lseg(104, 13, 167, 13, LUNDRLN);
		lseg(176, 13, 471, 13, LUNDRLN);
		lseg(480, 13, 504, 13, LUNDRLN);

		return;

	case 1:		/* index area */

		return;

	case 3:		/* current file name */

		tsplot4(librob, 64, ldbox[n][4], ldbox[n][6], ldbox[n][7],
			ldfile, 14);
		return;

	case 5:		/* current comment field */

		tsplot4(librob, 64, ldbox[n][4], ldbox[n][6], ldbox[n][7],
			ldcmnt, 14);
		return;

	case 7:		/* "Replace" / "Append" */

		if (lrasw)
			cy = LD_SELC;
		else
			cy = ldbox[n][4];

		tsplot4(librob, 64, cy, ldbox[n][6], ldbox[n][7],
			"Content", 14);

		return;

	case 8:		/* "Hi Orch" / "Lo Orch" */

		if (lselsw) {

			ldkind = ftkind(ldslot);

			if ((ldkind EQ FT_ORC) OR
			    (ldkind EQ FT_ORL) OR
			    (ldkind EQ FT_ORH))
				cy = LD_SELC;
			else
				cy = ldbox[n][4];

		} else {

			cy = ldbox[n][4];
		}

		tsplot4(librob, 64, cy, ldbox[n][6], ldbox[n][7],
			(lorchl ? "Hi Orch" : "Lo Orch"), 14);

		return;

	case 9:		/* "Store" status */

		cy = lstrsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 22, 10, "Store", 14);

		cy = lscrsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 22, 17, "Score", 14);

		cy = lorchsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 22, 24, "Hi Orch", 14);


		cy = lwavsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 23, 10, "Waves", 14);

		cy = lpatsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 23, 17, "Patch", 14);

		cy = lorclsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 23, 24, "Lo Orch", 14);


		cy = lasgsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 24, 10, "Assgn", 14);

		cy = lseqsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 24, 17, "Seqnc", 14);

		cy = ltunsw ? LD_SELC : ldbox[n][4];
		tsplot4(librob, 64, cy, 24, 24, "Tunings", 14);

		return;

	case 10:	/* typewriter / error messages */

		tsplot4(librob, 64, ldbox[n][4], 22, ldbox[n][7], lmln22, 14);
		tsplot4(librob, 64, ldbox[n][4], 23, ldbox[n][7], lmln23, 14);
		tsplot4(librob, 64, ldbox[n][4], 24, ldbox[n][7], lmln24, 14);

		return;
	}
}

/*
   =============================================================================
	lwins() -- display all librarian windows
   =============================================================================
*/

void lwins(void)
{
	register int16_t i;

	for (i = 0; i < 11; i++)
		ldswin(i);
}

/*
   =============================================================================
	ldpoint() -- plot a point for the lseg function
   =============================================================================
*/

void ldpoint(int16_t x, int16_t y, int16_t pen)
{
	if (v_regs[5] & 0x0180)
		vbank(0);

	vputp(ldoct, x, y, pen);
}

/*
   =============================================================================
	ldbord() -- draw the border for the librarian display
   =============================================================================
*/

void ldbord(void)
{
	point = ldpoint;

	lseg(  0,   0, 511,   0, LBORD);	/* outer border */
	lseg(511,   0, 511, 349, LBORD);
	lseg(511, 349,   0, 349, LBORD);
	lseg(  0, 349,   0,   0, LBORD);

	lseg(  0, 293, 511, 293, LBORD);	/* windows - H lines */
	lseg(511, 308,   0, 308, LBORD);

	lseg( 79, 293,  79, 308, LBORD);	/* windows - V lines */
	lseg(144, 293, 144, 308, LBORD);
	lseg(215, 293, 215, 308, LBORD);
	lseg( 71, 308,  71, 349, LBORD);
	lseg(256, 308, 256, 349, LBORD);
}

/*
   =============================================================================
	lwclr() -- clear the message window text strings
   =============================================================================
*/

void lmwclr(void)
{
	lmwtype = 0;
	submenu = FALSE;

	lmln22 = "";
	lmln23 = "";
	lmln24 = "";
}

/*
   =============================================================================
	lmwvtyp() -- load the typewriter into the message window text strings
   =============================================================================
*/

void lmwvtyp(void)
{
	lmwtype = 1;
	submenu = TRUE;

	lmln22 = vtlin1;
	lmln23 = vtlin2;
	lmln24 = vtlin3;
}

/*
   =============================================================================
	libdsp() -- put up the librarian display
   =============================================================================
*/

void libdsp(void)
{
	librob = &v_score[0];		/* setup display object pointer */
	obj0   = &v_curs0[0];		/* setup cursor object pointer */
	obj2   = &v_tcur[0];		/* setup typewriter cursor pointer */
	ldoct  = &v_obtab[LIBROBJ];	/* setup object control table pointer */

	lselsw  = FALSE;
	ldelsw  = FALSE;
	lstrsw  = FALSE;

	lasgsw	= FALSE;
	lorchsw = FALSE;
	lorclsw = FALSE;
	lpatsw  = FALSE;
	lscrsw  = FALSE;
	lseqsw  = FALSE;
	ltunsw  = FALSE;
	lwavsw  = FALSE;

	lderrsw = FALSE;
	ltagged = FALSE;
	lksel   = -1;

	clrcat();		/* void the catalog */
	catin = FALSE;

	lmwclr();		/* clear the message window text strings */

	dswap();		/* initialize display */

	if (v_regs[5] & 0x0180)
		vbank(0);

	memsetw(librob, 0, 32767);
	memsetw(librob+32767L, 0, 12033);

	SetObj(LIBROBJ, 0, 0, librob, 512, 350,     0,     0,  LIBRFL, -1);
	SetObj(      0, 0, 1,   obj0,  16,  16, LCURX, LCURY, OBFL_00, -1);
	SetObj( TTCURS, 0, 1,   obj2,  16,  16,     0,     0,  TTCCFL, -1);

	arcurs(TTCURC);		/* setup arrow cursor object */
	itcini(TTCURC);		/* setup text cursor object */
	ttcini(TTCURC);		/* setup typewriter cursor object */

	ldbord();		/* draw the border */
	lwins();

	vsndpal(lbrpal);	/* setup the palette */

	SetPri(LIBROBJ, LIBRPRI);
	SetPri(0, GCPRI);	/* display the graphic cursor */

	setgc(LCURX, LCURY);

	chtime = thcwval;	/* turn it into a text cursor */
	cvtime = tvcwval;
	cmtype = CT_TEXT;
	itcpos(cyval / 14, cxval >> 3);
}

