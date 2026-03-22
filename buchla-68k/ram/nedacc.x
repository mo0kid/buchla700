/*
   =============================================================================
	nedacc.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		accnote(void);
extern	void		donote(void);
extern	int16_t		ned_acc(int16_t grp);
extern	int16_t		ned_end(int16_t grp);
extern	int16_t		ned_mvb(int16_t grp);
extern	int16_t		ned_mve(int16_t grp);
extern	int16_t		ned_mvn(int16_t grp);
extern	int16_t		ned_nat(int16_t grp);
extern	int16_t		nedesub(int16_t grp, int16_t note);
