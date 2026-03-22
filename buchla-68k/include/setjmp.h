/*
   =============================================================================
	setjmp.h -- header for setjmp() and longjmp() functions
	Version 1 -- 1987-06-11 -- D.N. Lynx Crowe

	Registers a0 and d0 are assumed to be scratch registers,
	and are not saved by these functions.

	Register d0 is usually used as the return value register.
	Exception:  Motorola C uses a0 for the return value if it's a pointer.

	This is true of most C compilers for the 68000, including:
	Digital Research / Alcyon, Lattice, Aztec / Manx, Greenhills, Motorola.
   =============================================================================
*/

#pragma once

#include "stdint.h"

struct	JMP_BUF {	/* setjmp() / longjmp() environment structure */

	int32_t	jmpret;		/* return address */

	int32_t	jmp_d1;		/* data registers */
	int32_t	jmp_d2;
	int32_t	jmp_d3;
	int32_t	jmp_d4;
	int32_t	jmp_d5;
	int32_t	jmp_d6;
	int32_t	jmp_d7;

	int32_t	jmp_a1;		/* address registers */
	int32_t	jmp_a2;
	int32_t	jmp_a3;
	int32_t	jmp_a4;
	int32_t	jmp_a5;
	int32_t	jmp_a6;
	int32_t	jmp_a7;
};

typedef struct JMP_BUF jmp_buf;
