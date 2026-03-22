/*
   =============================================================================
	idselbx.c -- external declarations
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

extern	struct	selbox	idboxes[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		bx_null(void);
extern	void		cdnicur(void);
extern	void		cupicur(void);
extern	int16_t		edfunc(int16_t n);
extern	void		endityp(void);
extern	void		iclrwin(int16_t n);
extern	int16_t		idfnbox(int16_t n);
extern	void		idtxput(int16_t row, int16_t col, int8_t *txt, int16_t tag);
extern	void		showfn(void);
extern	void		showim(void);
extern	void		showpt(int16_t q);
