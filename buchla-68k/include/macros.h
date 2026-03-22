/*
   =============================================================================
	macros.h -- utility macros
	Version 3 -- 1988-10-19 -- D.N. Lynx Crowe

	All of the usual comments about side-effects apply.
   =============================================================================
*/

#pragma once

#define	abs(x)		((x) < 0 ? -(x) : (x))
#define	sign(x, y)	((x) < 0 ? -(y) : (y))

#define	min(x, y)	((x) > (y) ? (y) : (x))
#define	max(x, y)	((x) > (y) ? (x) : (y))

#define	inrange(var, lo, hi) \
			(((var) >= (lo)) && ((var) <= (hi)))
