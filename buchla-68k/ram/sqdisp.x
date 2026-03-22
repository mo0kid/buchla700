/*
   =============================================================================
	sqdisp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		curslin;
extern	int16_t		seqpal[16][3];
extern	uint16_t	sqatype[];
extern	int8_t		*sqdsptb[];
extern	int8_t		sqhead[];
extern	int8_t		*sqmcon[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int8_t		*SqBakLn(void);
extern	int8_t		*SqFwdLn(void);
extern	void		dcursq(void);
extern	void		dsact(int8_t *buf, uint16_t act, uint16_t dat);
extern	void		dsqlin(int8_t *buf, int16_t slin);
extern	void		dstw(void);
extern	void		initsq(void);
extern	void		sqdisp(void);
extern	void		sqwin(int16_t n);
extern	void		sqwins(void);
