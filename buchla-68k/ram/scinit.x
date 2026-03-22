/*
   =============================================================================
	scinit.c -- external declarations
   =============================================================================
*/

#pragma once

#include "score.h"
#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	struct	s_entry	*e_alc(int16_t w);
extern	struct	s_entry	*e_clr(struct s_entry *e1);
extern	int16_t		e_del(struct s_entry *e1);
extern	struct	s_entry	*e_ins(struct s_entry *e1, struct s_entry *e2);
extern	struct	s_entry	*e_rmv(struct s_entry *e1);
extern	void		eh_ins(struct s_entry *ne, int16_t et);
extern	void		eh_rmv(struct s_entry *ev, int16_t et);
extern	int32_t		evleft(void);
extern	void		sc_clr(int16_t ns);
extern	int32_t		scinit(void);
extern	int16_t		selscor(int16_t ns);
