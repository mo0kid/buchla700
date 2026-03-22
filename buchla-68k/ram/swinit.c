/*
   =============================================================================
	swinit.c -- MIDAS-VII -- more variable definitions and initializations
	Version 12 -- 1988-10-12 -- D.N. Lynx Crowe
   =============================================================================
*/

#define	FET_DEFS	1		/* so fields.h gets things right */

#include "ram.h"

BOOL		se_chg;			/* Score free list changed flag */

LPF		(*oldsw)[];		/* saved swpt value */
LPF		(*swpt)[];		/* switch dispatch table pointer */

LPF		aswtbl[14];		/* assignment switch table */

void		(*curmove)(void);	/* cursor move function */
int16_t		(*curtype)(void);	/* cursor type function */
void		(*cx_key)(void);	/* x rate calculation */
void		(*cx_upd)(void);	/* x update */
void		(*cy_key)(void);	/* y rate calculation */
void		(*cy_upd)(void);	/* y update */
void		(*d_key)(int16_t k);	/* in-field data key processor */
void		(*e_key)(void);		/* E key processor */
void		(*m_key)(void);		/* M key processor */
void		(*itxput)(int16_t row, int16_t col, int8_t *txt, int16_t tag);
				/* instrument menu text put function */
int16_t		(*not_fld)(int16_t k);	/* not-in-field data key processor */
void		(*olddkey)(int16_t k);	/* saved d_key value */
void		(*oldekey)(void);	/* saved e_key value */
void		(*oldmkey)(void);	/* saved m_key value */
void		(*oldxkey)(void);	/* saved x_key value */
void		(*premove)(void);	/* cursor pre-move function */
void		(*pstmove)(void);	/* cursor post-move function */
vtcurs		vt_adv;			/* vtyper data cursor advance function */
vtcurs		vt_bsp;			/* vtyper data cursor backspace function */
vtcurs		vt_cdn;			/* vtyper data cursor down function */
vtcurs		vt_cup;			/* vtyper data cursor up function */
vtchar		vt_dsp;			/* vtyper display function */
vtcurs		vt_stop;		/* vtyper exit function */
void		(*x_key)(void);		/* X key processor */
void		(*xy_dn)(void);		/* cursor - finger on (down) */
void		(*xy_up)(void);		/* cursor - finger off (up) */

int16_t		*cratex;		/* cursor x rate table pointer */
int16_t		*cratey;		/* cursor x rate table pointer */

int16_t		BotEdge;		/* configuration box bottom edge */
int16_t		LftEdge;		/* configuration box left edge */
int16_t		RgtEdge;		/* configuration box right edge */
int16_t		TopEdge;		/* configuration box top edge */

int16_t		BarBcur[14];		/* current bottom-zero bar values */
int16_t		BarCcur[14];		/* current centered-zero bar values */
int16_t		BGeq[14];		/* current EQ bar settings */
int16_t		BGother[14];		/* current other pot bar settings */
int16_t		BGprmtr[14];		/* current parameter pot bar settings */

int16_t		articen[12];		/* voice articulation enable status */
int16_t		grpdyn[12];		/* group dynamics table (0..9) */
int16_t		grploc[12];		/* group location table (0..8) */
int16_t		grpmode[12];		/* group mode - 0 = play, 1 = stdby, 2 = rec */
int16_t		grpsel[12];		/* group select status for instrument selection */
int16_t		grpstat[12];		/* group status - 0 = off, non-0 = on */
int16_t		grptmap[12];		/* group map */
uint16_t	gtctab[12];		/* group to color table */
int16_t		ins2grp[12];		/* instrument to group table (00..NINST-1) */
int16_t		instmod[12];		/* intrument data modified */
int16_t		key2grp[88];		/* port 1 key to group assignment table */
int16_t		lastart[16];		/* last articulation values (by parameter) */
int16_t		lastvce[12];		/* last voice assigned in each group */
int16_t		lastvel[12];		/* last velocity sent to group */
int16_t		ldmap[N_SCORES];	/* gather read map */
int16_t		mctlnum[4];		/* MIDI controller number table (-1, 00..99) */
int16_t		mpbend[48];		/* MIDI pitch bend data, by port and channel */
int16_t		msmstv[3];		/* MIDI state machine state variables */
int16_t		offsets[NUMWPCAL];	/* offsets for current waveshape */
int16_t		oldtun[128];		/* previous tuning table for undo */
int16_t		prstab[NTRIGS];		/* pressure */
int16_t		s_inst[12];		/* instrument selections */
int16_t		s_trns[12];		/* current transposition values */
int16_t		swfifo[NSWFIFO];	/* scroll wheel fifo */
int16_t		txfifo[NTKFIFO];	/* trackball X fifo */
int16_t		tyfifo[NTKFIFO];	/* trackball Y fifo */
int16_t		tuntab[128];		/* current tuning table */
int16_t		vce2grp[12];		/* voice to group table (-1, 1..12)*/
int16_t		vce2trg[12];		/* voice to trigger map (-1 EQ NULL) */
int16_t		veltab[NTRIGS];		/* velocity */
int16_t		vmtab[NUMHARM];		/* harmonics for current waveshape */
int16_t		wsbuf[NUMWPCAL];	/* final values for current waveshape */

int8_t		*lmln22;		/* message window line 22 */
int8_t		*lmln23;		/* message window line 23 */
int8_t		*lmln24;		/* message window line 24 */
int8_t		*vtdeptr;		/* virtual typewriter data entry pointer */

int8_t		*funcndx[256][2];	/* function header pointers */
int8_t		*vlbptr[3];		/* variable label pointers */

int8_t		bfs[128];		/* display generation buffer */
int8_t		caname[16];		/* current assignment table name */
int8_t		dspbuf[65];		/* display generation buffer */
int8_t		ebuf[MAXEBUF+1];	/* edit data entry buffer */
int8_t		errbuf[65];		/* error message build area */
int8_t		idbuf[65];		/* display format conversion work area */
int8_t		keystat[24];		/* front panel key status */
int8_t		ldcmnt[38];		/* comment field */
int8_t		ldfile[9];		/* file name field */
int8_t		ldmsg1[65];		/* messsage build area 1 */
int8_t		ldmsg2[65];		/* messsage build area 2 */
int8_t		ldmsg3[65];		/* messsage build area 3 */
int8_t		loadedc[NLTYPES][37];	/* loaded file comments */
int8_t		loadedf[NLTYPES][8];	/* loaded file names */
int8_t		masens[3];		/* MIDI port active sensing flags */
int16_t		mctlval[NCTRLS];	/* MIDI controller values */
int16_t		mdbyte[3];		/* MIDI data byte buffers */
int8_t		mpsust[48];		/* MIDI sustain status, by port and channel */
int16_t		mrstat[3];		/* MIDI running status */
int8_t		scname[N_SCORES][16];	/* Score names */
int8_t		trgtab[NTRIGS];		/* trigger status */
int8_t		tuncurn[33];		/* current tuning table name */
int8_t		tunname[NTUNS][32];	/* tuning table names */

int32_t		*pspool;		/* Score storage pool pointer */

int32_t		afi;			/* analog processor FIFO value */
int32_t		curtime;		/* current sqscan time */
int32_t		ctime;			/* time at cursor */
int32_t		dvwork;			/* divide work area */
int32_t		frags;			/* Score storage pool fragment count */
int32_t		iotime;			/* saved lcdtime value */
int32_t		lcdontm;		/* LCD backlight on time */
int32_t		lcdtime;		/* LCD backlight timer */
int32_t		lcsum;			/* library checksum */
int32_t		ndbytes;		/* bytes needed for storage */
int32_t		noteoff;		/* note off time */
int32_t		noteon;			/* note on time */
int32_t		noteper;		/* note period */
int32_t		noteval;		/* note value */
int32_t		nrest;			/* number of rests */
int32_t		schksum;		/* Score checksum */
int32_t		se1_cnt;		/* Score - free list E_SIZE1 entry count */
int32_t		se2_cnt;		/* Score - free list E_SIZE2 entry count */
int32_t		se3_cnt;		/* Score - free list E_SIZE3 entry count */
int32_t		snbreq;			/* Score - disk bytes required */
int32_t		snlreq;			/* Score - score bytes required */
int32_t		sntbreq;		/* Score - total disk bytes required */
int32_t		sntlreq;		/* Score - total score bytes required */
int32_t		spcount;		/* Score - storage pool free entry count */
int32_t		swcount;		/* scroll wheel counter */
int32_t		swrate;			/* scroll wheel rate */
int32_t		swtemp;			/* scroll wheel work area */
int32_t		t_bak;			/* time at p_bak */
int32_t		t_cbgn;			/* time at p_cbgn */
int32_t		t_cend;			/* time at p_cend */
int32_t		t_cur;			/* time at p_cur */
int32_t		t_ctr;			/* time at p_ctr */
int32_t		t_fwd;			/* time at p_fwd */
int32_t		t_ins;			/* time at peg */
int32_t		t_note;			/* note duration between p_nbeg and p_nend */
int32_t		t_sbgn;			/* time at p_sbgn */
int32_t		t_sec1;			/* time at p_sec1 */
int32_t		t_sec2;			/* time at p_sec2 */
int32_t		t_sect;			/* section time */
int32_t		t_send;			/* time at p_send */
int32_t		wshfac;			/* waveshape scale factor */

int32_t		hwave[NUMWPCAL];	/* harmonic waveshape generation buffer */
int32_t		nlpersc[N_SCORES];	/* number of longs per score */
int32_t		scsums[N_SCORES];	/* score checksums */
int32_t		spool[MAX_SE];		/* Score storage pool */

int32_t		vknm[NUMHARM][NUMWPCAL];	/* scaled harmonics for current ws */

int32_t		swrmin = SWRMIN;		/* scroll wheel rate threshold */

/*
   =============================================================================
	swinit() -- initialize scroll wheel variables
   =============================================================================
*/

void swinit(void)
{
	swflag  = FALSE;		/* stop the scroll wheel */
	swctrl  = FALSE;		/* ... */
	swdir   = D_FWD;		/* ... */
	swrate  = 0;			/* ... */
	swcount = 0;			/* ... */

	memsetw(swfifo, 0, NSWFIFO);	/* clear scroll wheel fifo */
	swfiin = 0;			/* ... */

	tkinit();			/* initialize the trackball */
}

