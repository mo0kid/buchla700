/*
   ============================================================================
	objdefs.h -- Object file format for as68  (Atari 1040ST TOS objects)
	Version 7 -- 1987-12-30 -- D.N. Lynx Crowe
   ============================================================================
*/

#pragma once

#include "stdint.h"

struct EXFILE {			/* executable file header */

	uint16_t	F_Magic;	/* File type magic */
	int32_t		F_Text;		/* SIze of text segment */
	int32_t		F_Data;		/* Size of data segment */
	int32_t		F_BSS;		/* Size of BSS segment */
	int32_t		F_Symtab;	/* Size of symbol table */
	int32_t		F_Res1;		/* Reserved area #1 */
	int32_t		F_Res2;		/* Reserved area #2 -- text origin */
	int16_t		F_Res3;		/* Reserved area #3 -- flag word */

					/* data origin - long */
					/* bss origin - long */
};

#define	F_R_C	0x601Au		/* Magic for contiguous file */
#define	F_R_D	0x601Bu		/* Magic for discontiguous file */

struct SYMBOL {			/* Symbol table entry -- 14 bytes */

	int8_t		symname[8];	/* Symbol name  (LJZF) */
	uint16_t	symtype;	/* Symbol type flags */
	int32_t		symvalue;	/* Symbol value */
};

#define	S_Def	0x8000u		/* Defined */
#define	S_Equ	0x4000u		/* Equated */
#define	S_Glb	0x2000u		/* Global */
#define	S_Reg	0x1000u		/* Equated register */
#define	S_Ext	0x0800u		/* External reference */
#define	S_Data	0x0400u		/* Data based relocatable */
#define	S_Text	0x0200u		/* Text based relocatable */
#define	S_BSS	0x0100u		/* BSS based relocatable */
