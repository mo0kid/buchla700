/*
   =============================================================================
	ldfield.c -- external declarations
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

extern	struct	fet	ld_fet1[];
extern	struct	curpak	ld_flds;
extern	int16_t		ldbox[][8];
extern	int8_t		*ldbxlb0[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		ld_prmv(void);
extern	void		ldcxupd(void);
extern	void		ldcyupd(void);
extern	void		ldfield(void);
extern	void		ldkey(int16_t k);
extern	void		ldmkey(void);
extern	void		ldxkey(void);
extern	void		loadem(int16_t key);
