/*
   =============================================================================
	chksec.c -- external declarations
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

extern	int8_t		cmgtags[N_ETYPES];
extern	int8_t		cmgtype[N_ETYPES];
extern	int16_t		cmslens[N_ETYPES];
extern	int16_t		ehdlist[N_ETYPES];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		chksec(int16_t ns);
extern	void		edelta(struct s_entry *ep, int32_t btime, int32_t delta);
extern	void		ehfix(struct s_entry *cbp, struct s_entry *cep);
extern	struct	s_entry	*madjsec(struct s_entry *sbp, int32_t btime);
extern	int16_t		oktocm(struct s_entry *ep);
extern	int16_t		oktode(struct s_entry *ep);
extern	int16_t		oktodg(struct s_entry *ep);
extern	int32_t		sizesec(void);
