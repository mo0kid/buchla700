/*
   =============================================================================
	tdfield.c -- external declarations
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

extern	struct	fet	td_fet1[];
extern	struct	curpak	td_flds;
extern	int16_t		tdbox[][8];
extern	int8_t		*tdbxlb[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		tdcxupd(void);
extern	void		tdcyupd(void);
extern	void		tdfield(void);
