/*
   =============================================================================
	instdsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "midas.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		fnoff[NFINST];
extern	int16_t		idbox[][8];
extern	int8_t		*idbxlbl[];
extern	int8_t		idhlbl[];
extern	int16_t		inspal[16][3];
extern	int8_t		*osclbl[];
extern	int32_t		rngdiv[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		addpch(int16_t p1, int16_t p2);
extern	void		allwins(void);
extern	void		dosync(int16_t vce);
extern	void		drawfn(int16_t fn, int16_t how, int16_t pen, int16_t wn);
extern	void		drawpt(int16_t px, int16_t py, int16_t pc);
extern	void		dswin(int16_t n);
extern	void		idbord(void);
extern	void		idcpfch(void);
extern	void		idpoint(int16_t x, int16_t y, int16_t pen);
extern	void		idvlblc(void);
extern	void		idvlbld(void);
extern	void		idvtyp(void);
extern	void		instdsp(void);
extern	int16_t		irand(int16_t range);
extern	void		oscdsp(int16_t row, int16_t val, int16_t n, int8_t *lbl, int16_t frq);
extern	void		pltws(int16_t ws[], int16_t pen);
extern	void		reshowi(void);
extern	int16_t		xgetran(int16_t mlt);
