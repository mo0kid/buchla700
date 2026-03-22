/*
   =============================================================================
	adfield.c -- external declarations
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

extern	struct	fet	ad_fet1[];
extern	struct	curpak	ad_flds;
extern	int16_t		adbox[][8];
extern	int8_t		*adbxlb[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		ad_xkey(void);
extern	void		adcxupd(void);
extern	void		adcyupd(void);
extern	void		adfield(void);
