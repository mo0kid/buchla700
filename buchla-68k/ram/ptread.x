/*
   =============================================================================
	ptread.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		nopatch(void);
extern	void		ptioerr(void);
extern	int16_t		ptread(FILE *fp);
extern	int16_t		stashp(void);
