/*
   =============================================================================
	scope.c -- external declarations
   =============================================================================
*/

#pragma once

#include "curpak.h"
#include "fields.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	struct	curpak	dt_flds;
extern	int8_t		scopebf[65];
extern	int16_t		scopec;
extern	int16_t		scopef;
extern	int16_t		scoper;
extern	int16_t		scopev;

extern	volatile	uint16_t	*scopeob;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		scope(int16_t val);
extern	void		scopeon(void);
extern	void		scptogl(void);
