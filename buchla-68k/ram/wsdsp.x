/*
   =============================================================================
	wsdsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		wavpal[16][3];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		advwcur(void);
extern	void		clrws(void);
extern	void		dsws(int16_t how);
extern	void		hdraw(int16_t *hv, int16_t h);
extern	void		iniwslb(void);
extern	void		wdbord(void);
extern	void		wdpoint(int16_t x, int16_t y, int16_t pen);
extern	void		wdswin(int16_t n);
extern	void		wsdsp(void);
extern	void		wwins(void);
