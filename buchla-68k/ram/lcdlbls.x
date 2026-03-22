/*
   =============================================================================
	lcdlbls.c -- external declarations
   =============================================================================
*/

#pragma once

#include "midas.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		BarType[14];
extern	int16_t		arpar[];
extern	int16_t		artitab[];
extern	int8_t		*aslbls[];
extern	int8_t		*potlbls[];
extern	int16_t		sl2gain[32];
extern	int16_t		src2var[14];
extern	int8_t		*swtlbls[];
extern	LPF		t_eq[];
extern	LPF		t_inst[];
extern	LPF		t_libr[];
extern	LPF		t_load[];
extern	LPF		t_ngrp[];
extern	LPF		t_other[];
extern	LPF		t_prmtr[];
extern	LPF		t_voice[];
extern	uint16_t	vmasks[16];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		artclr(void);
extern	void		doslide(void);
extern	void		l_adfl(int16_t stat, int16_t _2);
extern	void		l_asgn(int16_t stat, int16_t _2);
extern	void		l_clock(int16_t stat, int16_t _2);
extern	void		l_dflt(int16_t stat, int16_t _2);
extern	void		l_eq(int16_t stat, int16_t _2);
extern	void		l_goto(int16_t stat, int16_t _2);
extern	void		l_group(int16_t stat, int16_t grp);
extern	void		l_init(int16_t stat, int16_t _2);
extern	void		l_inst(int16_t stat, int16_t _2);
extern	void		_l_load(void);
extern	void		l_load(int16_t stat, int16_t _2);
extern	void		l_none(int16_t _1, int16_t _2);
extern	void		l_other(int16_t stat, int16_t _2);
extern	void		l_prmtr(int16_t stat, int16_t _2);
extern	void		l_voice(int16_t stat, int16_t vce);
extern	void		lcd_on(void);
extern	void		lcdlbls(void);
extern	void		loadkey(int16_t key);
extern	void		newpps(int16_t trg, int16_t grp, int16_t src, int16_t ival);
extern	int16_t		newsv(int16_t grp, int16_t src, int16_t ival);
extern	void		pcancel(int16_t pm);
extern	void		postio(void);
extern	void		preio(void);
extern	void		quiet(int16_t _1, int16_t _2);
extern	void		rpctl(int16_t stat, int16_t _2);
extern	void		selasg(int16_t n);
extern	void		selins(int16_t ival);
extern	void		sendart(int16_t vce, int16_t par, int16_t ival);
extern	void		setlamp(int16_t stat, int16_t _2);
extern	void		setsv(int16_t grp, int16_t src, int16_t ival);
extern	void		settmpo(int16_t val);
extern	void		settune(void);
extern	void		trapper(int16_t stat, int16_t _2);
extern	void		ulamp(void);
