/*
   =============================================================================
	scordsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		*clklbl[];
extern	int8_t		nsvtab[];
extern	int16_t		scorpal[16][3];
extern	int8_t		*sdisp[];
extern	uint16_t	simled[3];
extern	int16_t		var2src[6];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		dclkmd(void);
extern	void		dnedmod(void);
extern	void		ds_angr(void);
extern	void		ds_anmd(void);
extern	void		ds_anrs(void);
extern	void		ds_anvl(void);
extern	void		ds_vel(void);
extern	void		ds_vmod(void);
extern	void		dsanval(int16_t var);
extern	void		dsclk(void);
extern	void		dsgmode(int16_t n);
extern	void		dsgmods(void);
extern	void		dsgmodz(void);
extern	void		dsgstat(int16_t n);
extern	void		dsimode(void);
extern	void		dslocn(void);
extern	void		dsmem(void);
extern	void		dsrpmod(void);
extern	void		dssect(void);
extern	void		dsvmode(int16_t n);
extern	void		makeln(int16_t lnc, int16_t lew);
extern	void		sdsetup(void);
extern	void		sdwin(int16_t n);
extern	void		sdwins(void);
extern	void		uclk(void);
