/*
   ============================================================================
	regs.h -- register structure for Buchla 700 ROMP debug facility
	Version 6 -- 1987-06-15 -- D.N. Lynx Crowe
	(c) Copyright 1987 -- D.N. Lynx Crowe

	Defines the registers saved on the stack when a breakpoint occurs.
   ============================================================================
*/

#pragma once

#include "stdint.h"

struct regs {

	uint32_t	d_reg[8];	/* Data registers d0..d7 */

	uint32_t	a_reg[8];	/* Address registers */

	uint16_t	reg_fill,	/* Filler to keep long alignment */
			reg_sr;		/* Status register */

	uint32_t	reg_pc;	/* Program counter */
};
