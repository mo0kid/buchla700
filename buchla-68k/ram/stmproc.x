/*
   =============================================================================
	stmproc.c -- external declarations
   =============================================================================
*/

#pragma once

#include "patch.h"
#include "stdint.h"
#include "wordq.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	defent	defents[RAWDEFS];
extern	int16_t		defptr[NDEFSTMS];
extern	uint8_t		dmatch[];
extern	int16_t		dpecpos;
extern	int16_t		dpepred;
extern	int16_t		dpesucc;
extern	int16_t		dtfree;
extern	struct	patch	patches[MAXPATCH];
extern	int8_t		ptdsbuf[50];
extern	struct	wordq	ptefifo;
extern	uint16_t	ptewrds[NPTEQELS];
extern	int16_t		ptfree;
extern	int16_t		stmptr[NDEFSTMS];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		cprdpe(int16_t np);
extern	int16_t		cprpte(int16_t np);
extern	void		dpte(int16_t pe, int16_t row, uint16_t atr);
extern	void		dptw(void);
extern	int16_t		dt_alc(void);
extern	void		dt_del(int16_t de);
extern	void		entrpte(void);
extern	int16_t		find1st(void);
extern	int16_t		finddpe(void);
extern	int16_t		findnxt(int16_t cp);
extern	int16_t		findprv(int16_t cp);
extern	int16_t		findpte(void);
extern	void		initpt(void);
extern	int16_t		pt_alc(void);
extern	void		pt_del(int16_t pe);
extern	void		srdspte(void);
extern	void		stmproc(uint16_t trg);
