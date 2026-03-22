/*
   =============================================================================
	wdfield.c -- external declarations
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

extern	int16_t		wdbox[][8];
extern	int8_t		*wdbxlb0[];
extern	int8_t		*wdbxlb1[];
extern	int16_t		wxrate;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		pntsup(void);
extern	void		updfpu(void);
extern	void		wdcxupd(void);
extern	void		wdcyupd(void);
extern	void		wdfield(void);
extern	void		wdintp(void);
extern	int16_t		wdnfld(int16_t k);
extern	void		wdxkey(void);
extern	void		wdykdn(void);
extern	void		wdykup(void);
extern	void		whupd(void);
extern	void		wsupd(void);
