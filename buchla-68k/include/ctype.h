/*
   ============================================================================
	ctype.h -- extended character macros, ala' Unix(tm)
	Version 8 -- 1987-06-16 -- D.N. Lynx Crowe

	These macros are a superset of those provided for System 5 Unix(tm).

	This set of macros will return status for characters 0x80..0xFF as
	though they were in the range 0x00..0x7F for compatibility with
	the equivalent Lattice C macros.  This means that isascii(c) should
	be used if it is necessary to restrict the results to true ASCII.

		isascii(c)  non-zero if c is ASCII

		isprint(c)  non-zero if c is printable (including blank)
		isgraph(c)  non-zero if c is graphic (excluding blank)
		iscntrl(c)  non-zero if c is control character

		isalpha(c)  non-zero if c is alpha
		isupper(c)  non-zero if c is upper case
		islower(c)  non-zero if c is lower case

		isdigit(c)  non-zero if c is a digit (0 to 9)
		isxdigit(c) non-zero if c is a hexadecimal digit (0 to 9, A to F, a to f)

		isalnum(c)  non-zero if c is alpha or digit

		isspace(c)  non-zero if c is white space
		ispunct(c)  non-zero if c is punctuation

		iscsym(c)   non-zero if valid character for C symbols
		iscsymf(c)  non-zero if valid first character for C symbols

		toascii(c)  returns c masked to 7 bits

		_tolower(c) returns the lower case version of c
		_toupper(c) returns the upper case version of c
   ============================================================================
*/

#pragma once

#include "stdint.h"

/* Digital Research / Alcyon C table definitions */

#define	_C	0x01	/* control 00.1F */
#define	_P	0x02	/* punctuation */
#define	_N	0x04	/* numeric 0..9 */
#define	_U	0x08	/* upper case */
#define	_L	0x10	/* lower case */
#define	_S	0x20	/* whitespace */
#define	_B	0x40	/* blank */
#define	_X	0x80	/* hex digit */

#define	isascii(c)	(!((c) & ~0x7f))

#define	isprint(c)	(__atab[(c) & 0xff] & (_P | _U | _L | _N | _B))
#define	isgraph(c)	(__atab[(c) & 0xff] & (_P | _U | _L | _N))
#define	iscntrl(c)	(__atab[(c) & 0xff] & _C)

#define	isalpha(c)	(__atab[(c) & 0xff] & (_U | _L))
#define	isupper(c)	(__atab[(c) & 0xff] & _U)
#define	islower(c)	(__atab[(c) & 0xff] & _L)

#define	isdigit(c)	(__atab[(c) & 0xff] & _N)
#define	isxdigit(c)	(__atab[(c) & 0xff] & _X)

#define	isalnum(c)	(__atab[(c) & 0xff] & (_U | _L | _N))

#define	isspace(c)	(__atab[(c) & 0xff] & _S)
#define	ispunct(c)	(__atab[(c) & 0xff] & _P)

#define	iscsym(c)	(isalnum(c) || (((c) & 0x7f) == 0x5f))
#define	iscsymf(c)	(isalpha(c) || (((c) & 0x7f) == 0x5f))

#define	toascii(c)	((int8_t)((c) & 0x7f))

#define _toupper(c)	((int8_t)((c) - 'a' + 'A'))
#define _tolower(c)	((int8_t)((c) - 'A' + 'a'))
