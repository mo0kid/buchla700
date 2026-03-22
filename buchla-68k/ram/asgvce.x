/*
   =============================================================================
	asgvce.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		asgvce(int16_t grp, int16_t port, int16_t chan, int16_t key, int16_t vel);
extern	void		clrnl(void);
extern	void		ne_bgn(int16_t grp, int16_t key, int16_t vel);
extern	void		ne_end(int16_t trg, int16_t grp);
extern	void		showvel(int16_t g, int16_t v);
