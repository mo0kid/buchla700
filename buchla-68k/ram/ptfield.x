/*
   =============================================================================
	ptfield.c -- external declarations
   =============================================================================
*/

#pragma once

#include "curpak.h"
#include "fields.h"
#include "patch.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	curpak	pt_flds;
extern	int8_t		*smdata[];
extern	int8_t		*ssdata[];
extern	int8_t		*stdata[];
extern	int8_t		*trdata[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int8_t		*dfpdat(struct patch *pp);
extern	void		dspdest(int8_t *buf, struct patch *pp);
extern	void		dspdfst(int8_t *buf, uint16_t val);
extern	void		pafpu1(int8_t *bf, int8_t *ad, int16_t gt, int16_t gn, struct patch *pp);
extern	void		pafpu2(int8_t *bf, int8_t *ad, int16_t os, int16_t gt, int16_t gn, struct patch *pp);
extern	void		pafpu3(int8_t *bf, int8_t *ad, struct patch *pp);
extern	void		ptekey(void);
extern	void		ptfield(void);
extern	void		ptmkey(void);
extern	void		ptxkey(void);
