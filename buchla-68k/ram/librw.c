/*
   =============================================================================
	librw.c -- MIDAS librarian read / write functions
	Version 22 -- 1988-11-18 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

/*
   =============================================================================
	wrt_asg() -- write an assignment on the disk
   =============================================================================
*/

int16_t wrt_asg(int16_t slot)
{
	register FILE *fp;
	register int16_t	i;
	int8_t cstemp[8];

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_ASG), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the assignments", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_ASG);			/* make header */

	for (i = 0; i < NASGLIB; i++)
		lcsum += chksum(&asgtab[i + 1], (int32_t)(sizeof (struct asgent)));

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_asg():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		streset();
		return(FAILURE);
	}

	for (i = 0; i < NASGLIB; i++) {

		if (wr_ec(fp, &asgtab[i + 1], (int32_t)(sizeof (struct asgent)))) {

			streset();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_asg() -- read an assignment library from the disk
   =============================================================================
*/

int16_t get_asg(void)
{
	register FILE *fp;
	register int16_t	i;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_ASG), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the assignments", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_asg():  hdr=[%-.56s]\n", &ldhead);
#endif


	for (i = 0; i < NASGLIB; i++) {

		if (rd_ec(fp, &asgtab[i + 1], (int32_t)(sizeof (struct asgent)))) {

			clrlsel();
			return(FAILURE);
		}
	}

	clrlsel();
	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_orc() -- write an orchestra on the disk
   =============================================================================
*/

int16_t wrt_orc(int16_t slot, int16_t lorh)
{
	register FILE *fp;
	register int16_t	i;
	register struct instdef *ip;
	int8_t cstemp[8];

	if (lorh)
		ldbusy("       Writing Hi Orch");
	else
		ldbusy("       Writing Lo Orch");

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_ORC), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the orchestra", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_ORC);			/* make header */

	for (i = 0; i < NINORC; i++) {

		ip = &idefs[i + 1 + (lorh ? NINORC : 0)];

		lcsum += chksum(ip, (int32_t)OR_LEN1);
		lcsum += chksum(ip->idhwvao, (int32_t)OR_LEN2);
		lcsum += chksum(ip->idhwvbo, (int32_t)OR_LEN2);
	}

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_orc():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		streset();
		return(FAILURE);
	}

	for (i = 0; i < NINORC; i++) {

		ip = &idefs[i + 1 + (lorh ? NINORC : 0)];

		if (wr_ec(fp, ip, (int32_t)OR_LEN1)) {		/* functions */

			streset();
			return(FAILURE);
		}

		if (wr_ec(fp, ip->idhwvao, (int32_t)OR_LEN2)) {	/* WS A */

			streset();
			return(FAILURE);
		}

		if (wr_ec(fp, ip->idhwvbo, (int32_t)OR_LEN2)) {	/* WS B */

			streset();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_orc() -- read an orchestra from the disk
   =============================================================================
*/

int16_t get_orc(int16_t lorh, int16_t kind)
{
	register FILE *fp;
	register int16_t	i;
	register struct instdef *ip;

	if (lorh)
		ldbusy("       Reading Hi Orch");
	else
		ldbusy("       Reading Lo Orch");

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, kind), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the orchestra", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_orc():  hdr=[%-.56s]\n", &ldhead);
#endif


	for (i = 0; i < NINORC; i++) {

		ip = &idefs[i + 1 + (lorh ? NINORC : 0)];

		if (rd_ec(fp, ip, (int32_t)OR_LEN1)) {		/* functions */

			clrlsel();
			return(FAILURE);
		}

		if (rd_ec(fp, ip->idhwvao, (int32_t)OR_LEN2)) {	/* WS A */

			clrlsel();
			return(FAILURE);
		}

		if (rd_ec(fp, ip->idhwvbo, (int32_t)OR_LEN2)) {	/* WS B */

			clrlsel();
			return(FAILURE);
		}

		/* unpack offsets (and eventually harmonics) into finals */

		memcpyw(ip->idhwvaf, ip->idhwvao, NUMWPNT);
		memcpyw(ip->idhwvbf, ip->idhwvbo, NUMWPNT);
	}

	clrlsel();
	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_tun() -- write a tuning library on the disk
   =============================================================================
*/

int16_t wrt_tun(int16_t slot)
{
	register FILE *fp;
	register int16_t	i;
	int8_t cstemp[8];

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_TUN), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the tunings", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_TUN);			/* make header */

	for (i = 0; i < NTUNSLIB; i++) {

		lcsum += chksum(&tunlib[i + 1], 256L);
		lcsum += chksum(&tunname[i + 1], 32L);
	}

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_tun():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		streset();
		return(FAILURE);
	}

	for (i = 0; i < NTUNSLIB; i++) {

		if (wr_ec(fp, &tunlib[i + 1], 256L)) {

			streset();
			return(FAILURE);
		}

		if (wr_ec(fp, &tunname[i + 1], 32L)) {

			streset();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_tun() -- read a tuning library from the disk
   =============================================================================
*/

int16_t get_tun(void)
{
	register FILE *fp;
	register int16_t	i;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_TUN), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the tunings", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_tun():  hdr=[%-.56s]\n", &ldhead);
#endif


	for (i = 0; i < NTUNSLIB; i++) {

		if (rd_ec(fp, &tunlib[i + 1], 256L)) {

			clrlsel();
			return(FAILURE);
		}

		if (rd_ec(fp, &tunname[i + 1], 32L)) {

			clrlsel();
			return(FAILURE);
		}
	}

	clrlsel();
	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_pat() -- write a patch file on the disk
   =============================================================================
*/

int16_t wrt_pat(int16_t slot)
{
	register FILE *fp;
	int8_t cstemp[8];

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_PAT), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the patches", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_PAT);			/* make header */

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_pat():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {		/* header */

		streset();
		return(FAILURE);
	}

	if (ptwrite(fp)) {				/* patches */

		streset();
		return(FAILURE);
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_pat() -- read a patch file from the disk
   =============================================================================
*/

int16_t get_pat(void)
{
	register FILE *fp;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_PAT), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the patches", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_pat():  hdr=[%-.56s]\n", &ldhead);
#endif

	if (lrasw EQ 0)		/* clear all patches if in replace mode */
		initpt();

	if (ptread(fp)) {

		clrlsel();
		return(FAILURE);
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	clrlsel();
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_scr() -- write a score file on the disk
   =============================================================================
*/

int16_t wrt_scr(int16_t slot)
{
	register FILE *fp;
	register int16_t	i;
	int8_t cstemp[8];

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_SCR), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the scores", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_SCR);			/* make header */

	lcsum += sntlreq;

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_scr():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {		/* header */

		streset();
		return(FAILURE);
	}

	if (wr_ec(fp, &sntlreq, 4L)) {		/* total longs required */

		streset();
		return(FAILURE);
	}

	for (i = 0; i < N_SCORES; i++) {	/* scores */

		if (scwrite(i, fp)) {

			streset();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_scr() -- read a score file from the disk
   =============================================================================
*/

int16_t get_scr(void)
{
	register FILE *fp;
	register int16_t	i;
	int32_t tnl;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_SCR), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the scores", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_scr():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (rd_ec(fp, &tnl, 4L)) {	/* longs required */

		clrlsel();
		return(FAILURE);
	}

	if (lrasw EQ 0)		/* clear all scores if in replace mode */
		scinit();

	for (i = 0; i < N_SCORES; i++) {	/* read scores */

		if (scread(i, fp)) {

			clrlsel();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */

	p_bak = p_cur = p_ctr = p_fwd = scp = E_NULL;
	t_cur = t_ctr = 0L;
	t_bak = t_cur - TO_BAK;
	t_fwd = t_cur + TO_FWD;

	selscor(0);

	clrlsel();
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_seq() -- write a sequence file on the disk
   =============================================================================
*/

int16_t wrt_seq(int16_t slot)
{
	register FILE *fp;
	int8_t cstemp[8];

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_SEQ), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the sequences", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_SEQ);			/* make header */

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_seq():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {		/* header */

		streset();
		return(FAILURE);
	}

	if (sqwrite(fp)) {				/* sequences */

		streset();
		return(FAILURE);
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_seq() -- read a sequence file from the disk
   =============================================================================
*/

int16_t get_seq(void)
{
	register FILE *fp;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_SEQ), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the sequences", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_seq():  hdr=[%-.56s]\n", &ldhead);
#endif

	initsq();

	if (sqread(fp)) {

		clrlsel();
		return(FAILURE);
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	clrlsel();
	return(SUCCESS);
}

/*
   =============================================================================
	wrt_wav() -- write a waveshape library on the disk
   =============================================================================
*/

int16_t wrt_wav(int16_t slot)
{
	register FILE *fp;
	register int16_t	i;
	int8_t cstemp[8];
	register struct wstbl *wp;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(slot, FT_WAV), "w");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't create a file",
			" for the waveshapes", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		streset();
		return(FAILURE);
	}

	makelh(FT_WAV);			/* make header */

	for (i = 0; i < NUMWAVS; i++) {

		wp = &wslib[i];

		lcsum += chksum(wp->offset, (int32_t)(NUMWPNT * 2));
		lcsum += chksum(wp->harmon, (int32_t)(NUMHARM * 2));
	}

	sprintf(cstemp, "%08.8lX", lcsum);
	memcpy(ldhead.l_csum, cstemp, 8);

#if	DEBUGIT
	if (debugsw)
		printf("wrt_wav():  hdr=[%-.56s]\n", &ldhead);
#endif


	if (wr_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		streset();
		return(FAILURE);
	}

	for (i = 0; i < NUMWAVS; i++) {

		wp = &wslib[i];

		if (wr_ec(fp, wp->offset, (int32_t)(NUMWPNT * 2))) {

			streset();
			return(FAILURE);
		}

		if (wr_ec(fp, wp->harmon, (int32_t)(NUMHARM * 2))) {

			streset();
			return(FAILURE);
		}
	}

	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}

/*
   =============================================================================
	get_wav() -- read a waveshape library from the disk
   =============================================================================
*/

int16_t get_wav(void)
{
	register FILE *fp;
	register int16_t	i;
	register struct wstbl *wp;

	preio();	/* kill LCD backlight */

	fp = fopenb(slotnam(ldslot, FT_WAV), "r");

	if ((FILE *)NULL EQ fp) {

		ldermsg("Couldn't open the file",
			" for the waveshapes", (int8_t *)NULL,
			LD_EMCF, LD_EMCB);

		postio();		/* restore LCD backlight */
		clrlsel();
		return(FAILURE);
	}

	memcpy(ldfile, "        ", 8);
	memcpy(ldcmnt, "                                     ", 37);
	ldswin(3);
	ldswin(5);


	if (rd_ec(fp, &ldhead, (int32_t)LH_LEN)) {			/* header */

		clrlsel();
		return(FAILURE);
	}

#if	DEBUGIT
	if (debugsw)
		printf("get_wav():  hdr=[%-.56s]\n", &ldhead);
#endif


	for (i = 0; i < NUMWAVS; i++) {

		wp = &wslib[i];

		if (rd_ec(fp, wp->offset, (int32_t)(NUMWPNT * 2))) {

			clrlsel();
			return(FAILURE);
		}

		if (rd_ec(fp, wp->harmon, (int32_t)(NUMHARM * 2))) {

			clrlsel();
			return(FAILURE);
		}

		/* unpack offsets (and eventually harmonics) into finals */

		memcpyw(wp->final, wp->offset, NUMWPNT);
	}

	clrlsel();
	fclose(fp);
	postio();		/* restore LCD backlight */
	return(SUCCESS);
}


