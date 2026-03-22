/*
   =============================================================================
	filesys.c -- external declarations
   =============================================================================
*/

#pragma once

#include "biosdefs.h"
#include "fspars.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int32_t		_berrno;
extern	int16_t		_bpbin;
extern	int16_t		_dirin;
extern	int16_t		_dirmod;
extern	struct	dirent	*_dptr;
extern	int16_t		_fatin;
extern	int16_t		_fatmod;
extern	struct	bpb	*_thebpb;
extern	struct	dirent	_thedir[MAXDIRNT];
extern	uint8_t		_thefat[MAXFAT * BPSEC];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		ClsFile(struct fcb *fcp);
extern	int16_t		DelFile(struct fcb *fcp);
extern	int16_t		_alcnew(struct fcb *fcp);
extern	int16_t		_cl2lsn(struct bpb *bpp, int16_t clnum);
extern	void		_clsvol(void);
extern	void		_deadio(struct fcb *fcp, int16_t err);
extern	struct	dirent	*_dsnew(void);
extern	struct	dirent	*_dsrch(struct dirent *de);
extern	int16_t		_fmake(struct fcb *fcp);
extern	int16_t		_ftrnc(struct dirent *dp);
extern	int16_t		_getfat(uint8_t *bufad, struct bpb *bpp, int16_t nfat);
extern	int16_t		_gtcl12(uint8_t *fat, int16_t cl);
extern	int16_t		_inifcb(struct fcb *fcp, int8_t *name, int8_t *ext, uint16_t flags);
extern	int16_t		_newcls(void);
extern	int16_t		_nsic(struct fcb *fcp, struct bpb *bpp, uint8_t *fp);
extern	int16_t		_opfcb(struct fcb *fcp);
extern	int16_t		_opnvol(void);
extern	int16_t		_rdfat(uint8_t *bufad, struct bpb *bpp);
extern	int16_t		_rdroot(struct dirent *buf, struct bpb *bpp);
extern	int16_t		_seek(struct fcb *fcp);
extern	int16_t		fcbinit(int8_t *name, struct fcb *fcp);
