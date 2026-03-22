/*
   =============================================================================
	ptselbx.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "patch.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		datafmt[];
extern	uint16_t	datasrc[];
extern	int16_t		defcols[];
extern	uint16_t	desdat1[];
extern	uint16_t	desdat2[];
extern	int8_t		desdatf[];
extern	int8_t		destfmt[];
extern	int16_t		destype[];
extern	uint16_t	dfsttab[];
extern	int16_t		dfsttp[];
extern	int16_t		dstcols[];
extern	uint16_t	fpudtab[];
extern	int16_t		fpuetab[];
extern	int8_t		hilitab[][8];
extern	uint16_t	omdtab[];
extern	int16_t		omftab[];
extern	uint16_t	omtabl[];
extern	int16_t		ptbflag;
extern	struct	selbox	ptboxes[];
extern	int8_t		ptdebuf[50];
extern	struct	patch	ptebuf;
extern	int16_t		ptecpos;
extern	uint16_t	ptedat1;
extern	uint16_t	ptedat2;
extern	int16_t		ptedata;
extern	uint16_t	ptedef;
extern	int16_t		ptedest;
extern	int16_t		ptedfok;
extern	int16_t		ptedfst;
extern	int16_t		ptedftp;
extern	int16_t		ptedsok;
extern	int16_t		ptedtok;
extern	int16_t		ptegood;
extern	int16_t		ptemenu;
extern	int16_t		ptepred;
extern	int16_t		pteset;
extern	uint16_t	ptespec;
extern	uint16_t	ptestm;
extern	int16_t		ptestok;
extern	uint16_t	ptesuba;
extern	int16_t		ptesucc;
extern	int8_t		*rawdata[];
extern	int8_t		*rawdest[];
extern	int8_t		*rawdfst[];
extern	int8_t		*rawfpud[];
extern	int8_t		*rawmdat[];
extern	int8_t		*rawmode[];
extern	int16_t		stmcols[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		aftercm(void);
extern	void		badpdat(void);
extern	void		edefstm(int16_t du, int16_t n);
extern	void		endpsm(int16_t row, int16_t col);
extern	void		epatch(void);
extern	void		hilitpm(int8_t n);
extern	void		movectc(int16_t r, int16_t c);
extern	void		ptdest(int16_t du);
extern	int16_t		ptfnbox(int16_t n);
extern	void		setsubm(int16_t r, int16_t c);
