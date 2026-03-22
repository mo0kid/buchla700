/*
   =============================================================================
	swinit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "libdsp.h"
#include "midas.h"
#include "score.h"
#include "scwheel.h"
#include "stddefs.h"
#include "stdint.h"

#include "vtyper.x"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		BGeq[14];
extern	int16_t		BGother[14];
extern	int16_t		BGprmtr[14];
extern	int16_t		BarBcur[14];
extern	int16_t		BarCcur[14];
extern	int16_t		BotEdge;
extern	int16_t		LftEdge;
extern	int16_t		RgtEdge;
extern	int16_t		TopEdge;
extern	int32_t		afi;
extern	int16_t		articen[12];
extern	LPF		aswtbl[14];
extern	int8_t		bfs[128];
extern	int8_t		caname[16];
extern	int16_t		*cratex;
extern	int16_t		*cratey;
extern	int32_t		ctime;
extern	void		(*curmove)(void);
extern	int32_t		curtime;
extern	int16_t		(*curtype)(void);
extern	void		(*cx_key)(void);
extern	void		(*cx_upd)(void);
extern	void		(*cy_key)(void);
extern	void		(*cy_upd)(void);
extern	void		(*d_key)(int16_t k);
extern	int8_t		dspbuf[65];
extern	int32_t		dvwork;
extern	void		(*e_key)(void);
extern	int8_t		ebuf[MAXEBUF+1];
extern	int8_t		errbuf[65];
extern	int32_t		frags;
extern	int8_t		*funcndx[256][2];
extern	int16_t		grpdyn[12];
extern	int16_t		grploc[12];
extern	int16_t		grpmode[12];
extern	int16_t		grpsel[12];
extern	int16_t		grpstat[12];
extern	int16_t		grptmap[12];
extern	uint16_t	gtctab[12];
extern	int32_t		hwave[NUMWPCAL];
extern	int8_t		idbuf[65];
extern	int16_t		ins2grp[12];
extern	int16_t		instmod[12];
extern	int32_t		iotime;
extern	void		(*itxput)(int16_t row, int16_t col, int8_t *txt, int16_t tag);
extern	int16_t		key2grp[88];
extern	int8_t		keystat[24];
extern	int16_t		lastart[16];
extern	int16_t		lastvce[12];
extern	int16_t		lastvel[12];
extern	int32_t		lcdontm;
extern	int32_t		lcdtime;
extern	int32_t		lcsum;
extern	int8_t		ldcmnt[38];
extern	int8_t		ldfile[9];
extern	int16_t		ldmap[N_SCORES];
extern	int8_t		ldmsg1[65];
extern	int8_t		ldmsg2[65];
extern	int8_t		ldmsg3[65];
extern	int8_t		*lmln22;
extern	int8_t		*lmln23;
extern	int8_t		*lmln24;
extern	int8_t		loadedc[NLTYPES][37];
extern	int8_t		loadedf[NLTYPES][8];
extern	void		(*m_key)(void);
extern	int8_t		masens[3];
extern	int16_t		mctlnum[4];
extern	int16_t		mctlval[NCTRLS];
extern	int16_t		mdbyte[3];
extern	int16_t		mpbend[48];
extern	int8_t		mpsust[48];
extern	int16_t		mrstat[3];
extern	int16_t		msmstv[3];
extern	int32_t		ndbytes;
extern	int32_t		nlpersc[N_SCORES];
extern	int16_t		(*not_fld)(int16_t k);
extern	int32_t		noteoff;
extern	int32_t		noteon;
extern	int32_t		noteper;
extern	int32_t		noteval;
extern	int32_t		nrest;
extern	int16_t		offsets[NUMWPCAL];
extern	void		(*olddkey)(int16_t k);
extern	void		(*oldekey)(void);
extern	void		(*oldmkey)(void);
extern	LPF		(*oldsw)[];
extern	int16_t		oldtun[128];
extern	void		(*oldxkey)(void);
extern	void		(*premove)(void);
extern	int16_t		prstab[NTRIGS];
extern	int32_t		*pspool;
extern	void		(*pstmove)(void);
extern	int16_t		s_inst[12];
extern	int16_t		s_trns[12];
extern	int32_t		schksum;
extern	int8_t		scname[N_SCORES][16];
extern	int32_t		scsums[N_SCORES];
extern	int32_t		se1_cnt;
extern	int32_t		se2_cnt;
extern	int32_t		se3_cnt;
extern	BOOL		se_chg;
extern	int32_t		snbreq;
extern	int32_t		snlreq;
extern	int32_t		sntbreq;
extern	int32_t		sntlreq;
extern	int32_t		spcount;
extern	int32_t		spool[MAX_SE];
extern	int32_t		swcount;
extern	int16_t		swfifo[NSWFIFO];
extern	LPF		(*swpt)[];
extern	int32_t		swrate;
extern	int32_t		swrmin;
extern	int32_t		swtemp;
extern	int32_t		t_bak;
extern	int32_t		t_cbgn;
extern	int32_t		t_cend;
extern	int32_t		t_ctr;
extern	int32_t		t_cur;
extern	int32_t		t_fwd;
extern	int32_t		t_ins;
extern	int32_t		t_note;
extern	int32_t		t_sbgn;
extern	int32_t		t_sec1;
extern	int32_t		t_sec2;
extern	int32_t		t_sect;
extern	int32_t		t_send;
extern	int8_t		trgtab[NTRIGS];
extern	int8_t		tuncurn[33];
extern	int8_t		tunname[NTUNS][32];
extern	int16_t		tuntab[128];
extern	int16_t		txfifo[NTKFIFO];
extern	int16_t		tyfifo[NTKFIFO];
extern	int16_t		vce2grp[12];
extern	int16_t		vce2trg[12];
extern	int16_t		veltab[NTRIGS];
extern	int32_t		vknm[NUMHARM][NUMWPCAL];
extern	int8_t		*vlbptr[3];
extern	int16_t		vmtab[NUMHARM];
extern	vtcurs		vt_adv;
extern	vtcurs		vt_bsp;
extern	vtcurs		vt_cdn;
extern	vtcurs		vt_cup;
extern	vtchar		vt_dsp;
extern	vtcurs		vt_stop;
extern	int8_t		*vtdeptr;
extern	int16_t		wsbuf[NUMWPCAL];
extern	int32_t		wshfac;
extern	void		(*x_key)(void);
extern	void		(*xy_dn)(void);
extern	void		(*xy_up)(void);

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		swinit(void);
