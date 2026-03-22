/*
   =============================================================================
	ptdisp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "patch.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		ptabpal[16][3];
extern	int8_t		pthead[];
extern	int8_t		*ptmcon[];
extern	uint16_t	seqflag[16];
extern	int16_t		seqline[16];
extern	uint16_t	seqstim[16];
extern	struct	seqent	seqtab[NSLINES];
extern	uint16_t	seqtime[16];
extern	uint16_t	sregval[16];
extern	uint16_t	trstate[16];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		ptdisp(void);
extern	void		ptwin(int16_t n);
extern	void		ptwins(void);
