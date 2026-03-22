/*
   =============================================================================
	initi.c -- external declarations
   =============================================================================
*/

#pragma once

#include "instdsp.h"
#include "midas.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	uint16_t	dfltins[];
extern	uint16_t	expbit[16];
extern	int16_t		finival[NFINST];
extern	int16_t		ptoftab[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		initi(struct instdef *ip);
extern	void		initil(void);
extern	void		modinst(void);
extern	void		newinst(int16_t inst);
extern	void		newvce(int16_t voice);
extern	void		pntsel(void);
extern	uint16_t	segtime(int16_t pn, uint16_t ptime);
extern	int16_t		selpnt(void);
extern	void		setinst(void);
extern	void		setivce(int16_t voice);
extern	void		setseg(int16_t pn, uint16_t ptime);
extern	uint16_t	timeto(int16_t fn, int16_t pj);
extern	int16_t		ttox(uint16_t time, int16_t window);
extern	int16_t		vtoy(int16_t val, int16_t window);
