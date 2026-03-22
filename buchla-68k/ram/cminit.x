/*
   =============================================================================
	cminit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

#define	CM_MXSTR	257	/* maximum parser string result length */

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		QQanch;
extern	int8_t		QQchr;
extern	int8_t		QQdig;
extern	int8_t		*QQin;
extern	int8_t		*QQip;
extern	int16_t		QQlnum;
extern	int32_t		QQnum;
extern	int8_t		*QQop;
extern	int8_t		QQstr[CM_MXSTR];
extern	int16_t		QQsw;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		CMchr(int8_t c);
extern	int16_t		CMdig(void);
extern	void		CMinit(int8_t *ip);
extern	int16_t		CMlist(int8_t *l[]);
extern	int16_t		CMlong(void);
extern	int16_t		CMstat(int8_t *msg);
extern	int16_t		CMstr(int8_t *s);
extern	int16_t		CMuchr(int8_t c);
extern	int16_t		CMulist(int8_t *l[]);
extern	int16_t		CMustr(int8_t *s);
