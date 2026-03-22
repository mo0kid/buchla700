/*
   =============================================================================
	scfield.c -- external declarations
   =============================================================================
*/

#pragma once

#include "curpak.h"
#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	fet	sc_fet1[];
extern	struct	curpak	sc_flds;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		cp2time(int16_t cx);
extern	int16_t		deladat(void);
extern	int16_t		delevts(int16_t etp, int32_t thetime);
extern	int16_t		ef_null(int16_t n);
extern	int16_t		et_null(int16_t n);
extern	void		icancel(void);
extern	void		istart(void);
extern	int16_t		nd_null(int16_t n, int16_t k);
extern	int16_t		rd_null(int16_t n);
extern	void		scfield(void);
extern	int16_t		scntfld(int16_t k);
extern	void		sdcxu(void);
extern	void		sdcyu(void);
extern	void		sdmkey(void);
extern	void		sdxkey(void);
