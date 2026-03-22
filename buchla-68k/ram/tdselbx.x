/*
   =============================================================================
	tdselbx.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	selbox	tdboxes[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		endttyp(void);
extern	int16_t		tcoladj(int16_t icol);
extern	int16_t		tdfnbox(int16_t n);
extern	void		tdhilit(int16_t from, int16_t to);
