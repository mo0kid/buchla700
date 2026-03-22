/*
   =============================================================================
	fsinit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "biosdefs.h"
#include "fspars.h"
#include "io.h"
#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	FILE		Cbuffs[NSTREAMS];
extern	int32_t		Stdbuf[MAXDFILE][BUFSIZL];
extern	int32_t		*Stdbufs;
extern	int8_t		Wrkbuf[BPSEC];
extern	int16_t		_b_sect;
extern	int16_t		_b_side;
extern	int16_t		_b_tbuf[9][256];
extern	int16_t		_b_trak;
extern	int16_t		_b_tsec;
extern	struct	fcb	_fcbtab[MAXDFILE];
extern	struct	channel	chantab[MAXCHAN];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		InitCH(struct channel *cp, int16_t rdi, int16_t wri, int16_t ioi, int16_t ski, chclo cfp, io_arg charg);
extern	void		InitFS(void);
extern	void		Init_CB(FILE *fp, uint8_t flags, int16_t unit, int32_t *bufad, int16_t bufsize);
extern	int16_t		_badfd(void);
extern	int16_t		_noper(void);

extern	int16_t		_badfc(io_arg arg);
extern	int16_t		_badfio(io_arg arg, void *buff, int16_t len);
extern	int16_t		_nopc(io_arg arg);
extern	int16_t		_nopo(int8_t *name, uint16_t flags, struct channel *chp, struct devtabl *dp);
