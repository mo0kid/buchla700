/*
   =============================================================================
	sqselbx.c -- external declarations
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

extern	int8_t		actcol[];
extern	int16_t		action;
extern	int8_t		nextact[];
extern	struct	seqent	seqbuf;
extern	int8_t		seqvcol[];
extern	struct	selbox	sqboxes[];
extern	int8_t		sqdebuf[50];
extern	int16_t		sqdeflg;
extern	int8_t		sqhilit[][8];
extern	uint16_t	sqidata[];
extern	int16_t		sqmenu;
extern	uint16_t	sqndata[];
extern	int8_t		sqopreq[];
extern	int8_t		sqvcol[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		endssm(int16_t row, int16_t col);
extern	void		hilitsq(int8_t n);
extern	void		movestc(int16_t r, int16_t c);
extern	void		postcm(void);
extern	void		setsqm(int16_t r, int16_t c);
extern	int16_t		sqenter(void);
extern	int16_t		sqfnbox(int16_t n);
