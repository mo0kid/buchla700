/*
   =============================================================================
	showcfg.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "stdint.h"

#define	MAXPAT		35

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		cfg_00[64][3];
extern	int8_t		cfg_01[64][3];
extern	int8_t		cfg_02[64][3];
extern	int8_t		cfg_03[64][3];
extern	int8_t		cfg_04[64][3];
extern	int8_t		cfg_05[64][3];
extern	int8_t		cfg_06[64][3];
extern	int8_t		cfg_07[64][3];
extern	int8_t		cfg_08[64][3];
extern	int8_t		cfg_09[64][3];
extern	int8_t		cfg_10[64][3];
extern	int8_t		cfg_11[64][3];
extern	int8_t		*cfgptr[12];
extern	struct	fet	id_fet2[];
extern	struct	fet	id_fet3[];
extern	struct	selbox	idmbox[];
extern	uint16_t	pat[MAXPAT][16];
extern	int16_t		patctab[MAXPAT];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		dispcfg(int16_t nn);
extern	void		dispws(int16_t ws);
extern	int16_t		imfnbox(int16_t n);
extern	void		putpat(int16_t pn, int16_t px, int16_t py, int16_t patc);
extern	void		showcfg(int16_t nn);
extern	void		wcmenu(int16_t wc);
