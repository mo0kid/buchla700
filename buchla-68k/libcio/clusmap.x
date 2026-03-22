/*
   =============================================================================
	clusmap.c -- external declarations
   =============================================================================
*/

#pragma once

#include "biosdefs.h"
#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		ClusMap(struct fcb *fcp);
extern	struct	fcb	*FCBmode(struct fcb *fcp);
extern	FILE		*FILEfl(FILE *fp);
extern	void		FILEpr(FILE *fp);
extern	void		MapFAT(uint8_t *fat, int16_t ncl, int16_t stops);
extern	struct	fcb	*SnapFCB(struct fcb *fcp);
extern	struct	fcb	*fd2fcb(int16_t fd);
extern	struct	fcb	*fp2fcb(FILE *fp);
