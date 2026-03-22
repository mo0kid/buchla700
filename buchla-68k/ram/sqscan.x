/*
   =============================================================================
	sqscan.c -- external declarations
   =============================================================================
*/

#pragma once

#include "score.h"
#include "stdint.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		chkstop;
extern	int8_t		*nlist[];
extern	int16_t		notetab[];
extern	int16_t		octab[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		Pcheck(struct s_entry *ptr, int8_t *msg);
extern	int16_t		Qadv(void);
extern	int16_t		Qevent(void);
extern	int16_t		Qnote(void);
extern	int16_t		Qseq(void);
extern	struct	n_entry	*insnevt(struct n_entry *nsp, int16_t nt, int16_t grp, int16_t note, int16_t vel);
extern	void		nospace(int8_t *et);
extern	void		sqinit(void);
extern	int16_t		sqscan(int8_t *ip);
