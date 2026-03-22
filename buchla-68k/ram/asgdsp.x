/*
   =============================================================================
	asgdsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

#define	AK_WIDTH	115	/* width, in words, of keyboard icon */

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	uint16_t	asgkbbt[AK_WIDTH];
extern	int16_t		asgkble[88];
extern	uint16_t	asgkbtp[AK_WIDTH];
extern	int16_t		asgpal[16][3];
extern	int8_t		*asgsrc[];
extern	int16_t		dyntab[10];
extern	int8_t		*gprep[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		adbord(void);
extern	void		adpoint(int16_t x, int16_t y, int16_t pen);
extern	void		adswin(int16_t n);
extern	void		advacur(void);
extern	void		asgdsp(void);
extern	void		asgkb(void);
extern	void		awins(void);
extern	void		bspacur(void);
extern	void		drawk2g(int16_t grp);
extern	void		getasg(int16_t n);
extern	void		inital(void);
extern	void		initat(int16_t n);
extern	void		keycpyw(volatile uint16_t *dest, volatile uint16_t *src, int16_t len, int16_t wk, int16_t bk);
extern	int8_t		*numblk(int8_t *buf, int16_t n);
extern	void		putasg(int16_t n);
extern	void		setaux(int16_t aux);
