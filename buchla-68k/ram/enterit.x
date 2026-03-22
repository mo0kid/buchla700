/*
   =============================================================================
	enterit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		LastCol;
extern	int16_t		LastRow;
extern	int16_t		syrate;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		cmfix(void);
extern	void		cmvgen(void);
extern	int16_t		crxrate(int16_t cv);
extern	int16_t		cryrate(int16_t cv);
extern	void		cxgen(void);
extern	void		cxkstd(void);
extern	void		cygen(void);
extern	void		cykstd(void);
extern	int16_t		entbh(int16_t n);
extern	void		enterit(void);
extern	void		nodkey(int16_t k);
extern	void		nokey(void);
extern	int16_t		nonf(int16_t k);
extern	void		stddkey(int16_t k);
extern	void		stdmkey(void);
