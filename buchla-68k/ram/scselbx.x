/*
   =============================================================================
	scselbx.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		*nedlbl[];
extern	struct	selbox	sdboxes[];
extern	int8_t		*sdmenus[][3];
extern	int16_t		sdmht[][3];
extern	int16_t		sdmlim[][4];
extern	int8_t		sdmln3[];
extern	int8_t		sdmln4[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		bspscur(void);
extern	void		clkset(int16_t st);
extern	void		dosecop(void);
extern	void		dsects(void);
extern	void		dsgtmap(void);
extern	void		dsgtme(int16_t n);
extern	void		dsgtmn(int16_t n, int16_t f);
extern	void		hilitnt(int16_t nop);
extern	void		hilitop(int16_t n);
extern	int16_t		ingroup(void);
extern	int16_t		insect(void);
extern	void		scmenu(int16_t n);
extern	int16_t		sdboxfn(int16_t n);
extern	void		sdmenu(int16_t n);
extern	void		sdmtxt(int16_t row, int16_t col, int8_t *txt, int16_t tag);
extern	void		showam(int16_t asg);
extern	void		showsm(void);
extern	void		showtm(void);
extern	void		svtdsp(volatile uint16_t *obj, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *buf);
extern	void		svtstop(void);
