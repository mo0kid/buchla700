/*
   =============================================================================
	tundsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		*tdlabl[];
extern	int16_t		tunpal[16][3];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		advtcur(void);
extern	void		bsptcur(void);
extern	void		dsttval(int16_t row, int16_t col, int16_t val, int16_t fg, int16_t bg);
extern	void		gettun(int16_t n);
extern	void		inittl(void);
extern	void		inittt(int16_t n);
extern	void		puttun(int16_t n);
extern	void		td_incr(int16_t mode);
extern	void		td_intp(int16_t mode);
extern	void		td_trcp(int16_t mode);
extern	void		tdswin(int16_t n);
extern	int16_t		tt_incr(int16_t from, int16_t to);
extern	int16_t		tt_intp(int16_t from, int16_t to);
extern	void		tt_trcp(int16_t start, int16_t finish, int16_t dest);
extern	void		tundsp(void);
extern	void		twins(void);
