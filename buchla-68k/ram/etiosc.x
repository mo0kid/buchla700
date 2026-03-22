/*
   =============================================================================
	etiosc.c -- external declarations
   =============================================================================
*/

#pragma once

#include "instdsp.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		ndvals[10];
extern	int8_t		notes[];
extern	int16_t		pitches[];
extern	int16_t		ratio[100];
extern	int8_t		sfdsp[];
extern	int8_t		sharps[];
extern	int16_t		shrpflt[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		cnvc2p(int8_t *buf, int16_t cv);
extern	int16_t		cnvp2c(void);
extern	int16_t		ef_iosc(int16_t nn);
extern	int16_t		et_iosc(int16_t nn);
extern	void		int2rat(int16_t rat);
extern	int16_t		nd_iosc(int16_t nn, int16_t k);
extern	int16_t		rd_iosc(int16_t nn);
extern	void		setoscb(int16_t n, int16_t v);
extern	void		setosyn(int16_t n, int16_t v, int16_t t);
extern	void		setoval(struct instdef *ip, int16_t v, int16_t val);
