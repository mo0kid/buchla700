/*
   =============================================================================
	sedump.c -- external declarations
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

extern	int8_t		*A6PTR;
extern	int8_t		*A7PTR;
extern	int8_t		*A7TOP;
extern	int32_t		SCdlim;
extern	int16_t		SCnumv;
extern	int16_t		SL_Flag;
extern	int8_t		*actname[];
extern	int8_t		*evkinds[N_ETYPES];
extern	int8_t		*hpname[N_TYPES];
extern	int8_t		*srcname[];
extern	int8_t		*var_lbl[6];
extern	int16_t		x_unrec;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		DOA(void);
extern	void		SCPanic(void);
extern	void		SCcrash(void);
extern	void		SCdump(void);
extern	void		SCslice(void);
extern	void		SCtimes(void);
extern	void		SCvce(int16_t n);
extern	void		SCvces(void);
extern	void		SCvoice(void);
extern	void		SECdump(void);
extern	struct	s_entry	*SEchase(struct s_entry *ep, int32_t n);
extern	void		SEctrl(void);
extern	struct	s_entry	*SEdump(struct s_entry *sep);
extern	void		SEsnap(void);
extern	void		SLdump(void);
extern	int8_t		*ev_kind(struct s_entry *sep);
