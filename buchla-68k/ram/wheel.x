/*
   =============================================================================
	wheel.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		M_error;
extern	int16_t		M_oldbs;
extern	int16_t		M_state;
extern	int8_t		M_strng[32];
extern	int16_t		msctrl;
extern	int16_t		msflag;
extern	int16_t		msrtag;
extern	int16_t		msxdiv;
extern	int16_t		msxgdv[13];
extern	int16_t		msxmov;
extern	int16_t		msxres;
extern	int16_t		msydiv;
extern	int16_t		msygdv[13];
extern	int16_t		msymov;
extern	int16_t		msyres;
extern	int32_t		swrtab[128];
extern	int16_t		tkboth;
extern	int16_t		tkhdvr;
extern	int16_t		tkvdvr;
extern	int16_t		tkxdvr;
extern	int16_t		tkydvr;
extern	int16_t		txdiv;
extern	int16_t		tydiv;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		MouseEX(int8_t *str);
extern	int16_t		MouseFL(int16_t tc);
extern	void		MouseIN(int16_t c);
extern	int16_t		MouseRD(int8_t *str, int16_t nc, int16_t nt);
extern	void		MouseRT(int16_t t);
extern	int16_t		MouseWK(void);
extern	void		MouseWR(int8_t *str);
extern	void		curproc(void);
extern	void		tkinit(void);
extern	void		txstd(void);
extern	void		txydn(void);
extern	void		txyup(void);
extern	void		tystd(void);
extern	void		wheel(void);
