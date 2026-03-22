/*
   ============================================================================
	stddefs.h -- Standard definitions for C programs
	Version 12 -- 1987-12-15 -- D.N. Lynx Crowe
	Released to Public Domain - 1987-06 - D.N. Lynx Crowe
   ============================================================================
*/

#pragma once

#include "stdint.h"

/* relational operators */

#define	EQ	==
#define	NE	!=
#define	GE	>=
#define	LE	<=
#define	GT	>
#define	LT	<

/* logical operators */

#define	NOT	!
#define	AND	&&
#define	OR	||

/* manifest constants for function return and flag values */

#define	FAILURE	-1			/*	Function failure return val */
#define SUCCESS	0			/*	Function success return val */

#define	FOREVER	for (;;)		/*	Infinite loop declaration   */

#define	NULL	((void *)0)		/*	Null pointer value	    */

#define	TRUE	1			/*	Function TRUE  value	    */
#define	FALSE	0			/*	Function FALSE value	    */

/* BOOL type definition for flag variables */

typedef	int8_t	BOOL;
