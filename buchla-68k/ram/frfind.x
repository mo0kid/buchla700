/*
   =============================================================================
	frfind.c -- external declarations
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

extern	struct	s_entry	*ehfind(int16_t eh, int32_t te, int16_t d1, int16_t d2);
extern	struct	s_entry	*ep_adj(struct s_entry *sep, int16_t sdir, int32_t tval);
extern	struct	s_entry	*findev(struct s_entry *ep, int32_t te, int16_t et, int16_t d1, int16_t d2);
extern	struct	s_entry	*frfind(int32_t tval, int16_t sdir);
