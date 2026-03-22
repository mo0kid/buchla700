/*
   =============================================================================
	idfield.c -- external declarations
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

extern	struct	fet	id_fet1[];
extern	struct	curpak	id_flds;
extern	int8_t		*srctbl[];
extern	int16_t		zoneinc[9];
extern	int16_t		zonemax[9];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		idcxupd(void);
extern	void		idcyupd(void);
extern	void		idfield(void);
extern	int16_t		idnfld(int16_t k);
extern	void		idx_key(void);
extern	void		ikydn(void);
extern	void		ikyup(void);
