/*
   =============================================================================
	gcurpos.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		andcopy(volatile uint16_t *to, volatile uint16_t *from, uint16_t with, int16_t len);
extern	void		arcurs(int16_t icolor);
extern	int16_t		gcurpos(int16_t xloc, int16_t yloc);
extern	void		sgcoff(void);
extern	void		sgcon(void);
