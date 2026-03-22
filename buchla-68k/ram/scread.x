/*
   =============================================================================
	scread.c -- external declarations
   =============================================================================
*/

#pragma once

#include "score.h"
#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		noevent(int16_t sn);
extern	void		scioerr(int16_t sn, struct s_entry *ep);
extern	int16_t		scread(int16_t ns, FILE *fp);
