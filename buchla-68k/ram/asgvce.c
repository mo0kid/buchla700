/*
   =============================================================================
	asgvce.c -- MIDAS-VII -- assign voice / enter notes into score
	Version 12 -- 1988-10-03 -- D.N. Lynx Crowe
   =============================================================================
*/

#undef	DEBUGGER 		/* define to enable debug trace */

#define	DEBUGIT		0

#include "ram.h"

/*
   =============================================================================
	clrnl() -- clear note list
   =============================================================================
*/

void clrnl(void)
{
	register int16_t i;

	DB_ENTR("clrnl");

	for (i = 0; i < NNEVTS - 1; i++) {

		nevents[i].nxt   = &nevents[i + 1];
		nevents[i].note  = 0;
		nevents[i].group = 0;
	}

	nevents[NNEVTS - 1].nxt = (struct nevent *)0L;

	nelist = (struct nevent *)0L;
	nefree = &nevents[0];
	nkdown = 0;

	DB_EXIT("clrnl");
}

/*
   =============================================================================
	ne_end() -- enter a note end event
   =============================================================================
*/

void ne_end(int16_t trg, int16_t grp)
{
	register int16_t nn;
	register int32_t fcend;
	register struct nevent *nx;
	register struct n_entry *ep;

	DB_ENTR("ne_end");

	/* must be recording into a voice in record mode ... */

	if ((recsw EQ 0) OR (grpmode[grp] NE 2)) {

		DB_EXIT("ne_end");
		return;			/* ... or, we're done */
	}

	DB_CMNT("ne_end - recording");

	/* make pointers point in the forward direction */

	if (sd EQ D_BAK)
		chgsdf();

	if (se EQ D_BAK)
		chgsef();

	nn = trg & 0x007F;		/* note number */

	if (clksrc NE CK_STEP) {	/* not in step mode */

		DB_CMNT("ne_end - non-step");

		if ((struct n_entry *)E_NULL NE (ep = (struct n_entry *)e_alc(E_SIZE1))) {

			DB_CMNT("ne_end - enter note end");
			ep->e_time  = t_cur;
			ep->e_type  = (int8_t)(EV_NEND | 0x80);
			ep->e_note  = (int8_t)nn;
			ep->e_group = (int8_t)grp;
			ep->e_vel   = SM_SCALE(64);

			p_cur = e_ins((struct s_entry *)ep,
				      ep_adj(p_cur, 0, t_cur))->e_fwd;

			if (t_cur EQ t_ctr)
				newflag = TRUE;

			se_disp((struct s_entry *)ep, D_FWD, gdstbc, 1);

		} else {

			DB_CMNT("ne_end - no space");
		}

		DB_EXIT("ne_end");
		return;

	} else if (nkdown GE 1) {	/* process note entry in step mode */

		DB_CMNT("ne_end - log key up");

		if (0 EQ --nkdown) {	/* if all keys are up ... */
			fcend = 0;

			if (stepenb) {

				/* advance by the note weight */

				DB_CMNT("ne_end - advance weight");
				fcend = fc_val + stepfrm[3][stepint];
				fc_val += stepfrm[stepwgt][stepint];
				sc_trek(fc_val);
				sc_trak(fc_val);
				DB_CMNT("ne_end - doing note ends");
			}

			while (nelist) {

				nn = nelist->note;	/* get note */
				grp = nelist->group;	/* get group */

				if ((struct n_entry *)E_NULL NE
					(ep = (struct n_entry *)e_alc(E_SIZE1))) {

					DB_CMNT("ne_end - enter note end");
					ep->e_time  = t_cur;
					ep->e_type  = (int8_t)(EV_NEND | 0x80);
					ep->e_note  = (int8_t)nn;
					ep->e_group = (int8_t)grp;
					ep->e_vel   = SM_SCALE(64);

					p_cur = e_ins((struct s_entry *)ep,
						      ep_adj(p_cur, 0, t_cur))->e_fwd;

					se_disp((struct s_entry *)ep, D_FWD, gdstbc, 1);

					if (lstendc < NLSTENTS)
						lstends[lstendc++] = ep;

				} else {

					DB_CMNT("ne_end - no space");
				}

				DB_CMNT("ne_end - freeing nevent");
				nx = nelist->nxt;	/* get next nelist ptr */
				nelist->nxt = nefree;	/* free nelist entry */
				nefree = nelist;	/* ... */
				nelist = nx;		/* update nelist */
			}

			lstflag = TRUE;		/* indicate end of list */

			DB_CMNT("ne_end - note ends done");

			if (stepenb) {

				if (fc_val LT fcend) {	/* advance to the interval */

					DB_CMNT("ne_end - advance interval");
					fc_val = fcend;
					sc_trek(fc_val);
					sc_trak(fc_val);
				}
			}
		}

	} else {

		nkdown  = 0;		/* no keys down */

		lstendc = 0;		/* no step entries to delete */
		lstbgnc = 0;
		lstflag = FALSE;
	}

	DB_EXIT("ne_end");
}

/*
   =============================================================================
	ne_bgn() -- enter a note begin event
   =============================================================================
*/

void ne_bgn(int16_t grp, int16_t key, int16_t vel)
{
	register struct n_entry *ep;
	register struct nevent *np;

	DB_ENTR("ne_bgn");

	/* must be recording into a group in record mode ... */

	if ((recsw NE 0) AND (grpmode[grp] EQ 2)) {

		DB_CMNT("ne_bgn - recording");

		/* make pointers point in the forward direction */

		if (sd EQ D_BAK)
			chgsdf();

		if (se EQ D_BAK)
			chgsef();

		if (lstflag) {			/* cancel old list of notes */

			lstbgnc = 0;
			lstendc = 0;
			lstflag = FALSE;
		}

		if (clksrc EQ CK_STEP) {	/* step mode */

			DB_CMNT("ne_bgn - step");
			++nkdown;		/* count keys down */

			if (nefree) {		/* log a key closure */

				np        = nefree;
				nefree    = np->nxt;
				np->note  = key;
				np->group = grp;
				np->nxt   = nelist;
				nelist    = np;
				DB_CMNT("ne_bgn - key logged");

			} else {

				DB_CMNT("ne_bgn - nefree empty");
			}
		}

		if ((struct n_entry *)E_NULL NE
			(ep = (struct n_entry *)e_alc(E_SIZE1))) {

			DB_CMNT("ne_bgn - enter note begin");
			ep->e_time  = t_cur;
			ep->e_type  = (int8_t)(EV_NBEG | 0x80);
			ep->e_note  = (int8_t)key;
			ep->e_group = (int8_t)grp;
			ep->e_vel   = (clksrc EQ CK_STEP) ? SM_SCALE(64) : vel;

			p_cur = e_ins((struct s_entry *)ep,
				      ep_adj(p_cur, 0, t_cur))->e_fwd;

			se_disp((struct s_entry *)ep, D_FWD, gdstbc, 1);

			if (t_cur EQ t_ctr)
				newflag = TRUE;

			if ((clksrc EQ CK_STEP) AND (lstbgnc < NLSTENTS))
				lstbgns[lstbgnc++] = ep;

		} else {

			DB_CMNT("ne_bgn - no space");
		}
	}

	DB_EXIT("ne_bgn");
}

/*
   =============================================================================
	showvel() -- display velocity for a group
   =============================================================================
*/

void showvel(int16_t g, int16_t v)
{
	int8_t buf[6];

	if (v_regs[5] & 0x0180)
		vbank(0);

	lastvel[g] = v;

	sprintf(buf, "%03d", (v / 252));

	vputs(obj8, 5, (g * 5) + 6, buf, SDW11ATR);
}

/*
   =============================================================================
	asgvce() -- assign a voice
   =============================================================================
*/

void asgvce(int16_t grp, int16_t port, int16_t chan, int16_t key, int16_t vel)
{
	register int16_t i;
	register int16_t tv;
	register int16_t vp;
	register int16_t trg;
	register int16_t flag;

	DB_ENTR("asgvce");

	trg = (port << 11) + (chan << 7) + key;	/* trigger number */
	vp  = lastvce[grp] + 1;			/* voice to start with */
	vp  = (vp > 11) ? 0 : vp;		/* ... (adjust into range) */

	DB_CMNT("asgvce - search unassgined");

	for (i = 12; i--; ) {	/* search for unassigned voice */

		if ((vce2trg[vp] EQ -1) AND (vce2grp[vp] EQ (grp + 1))) {

			if ((ndisp EQ 2) AND velflag AND (NOT recsw))
				showvel(grp, vel);

			lastvce[grp] = vp;
			execkey(trg, tuntab[key], vp, 0);
			DB_EXIT("asgvce - free voice");
			return;
		}

		if (++vp > 11)
			vp = 0;
	}

	DB_CMNT("asgvce - seach non-held");

	for (i = 12; i--; ) {	/* search for non-held voice */

		tv = vce2trg[vp];

		if (tv EQ -1)
			flag = TRUE;		/* OK - unassigned */
		else if (0 EQ (tv & (MKEYHELD << 8)))
			flag = TRUE;		/* OK - not held */
		else
			flag = FALSE;		/* NO - held */

		if (flag AND (vce2grp[vp] EQ (grp + 1))) {

			if ((ins2grp[grp] & GTAG1) AND
			    (tv NE trg) AND (tv NE -1))
				legato = 1;

			if ((ndisp EQ 2) AND velflag AND (NOT recsw))
				showvel(grp, vel);

			lastvce[grp] = vp;
			execkey(trg, tuntab[key], vp, 0);
			DB_EXIT("asgvce - stolen voice");
			return;
		}

		if (++vp > 11)
			vp = 0;
	}

	DB_EXIT("asgvce - no voice");
}

