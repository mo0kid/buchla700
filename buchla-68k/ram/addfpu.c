/*
   =============================================================================
	addfpu.c -- FPU time functions
	Version 1 -- 1987-09-14 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

#define	MAXSEGT		32767

/*
   =============================================================================
	addfpu() -- find next higher FPU time 'k' milliseconds greater than 't'
   =============================================================================
*/

uint16_t addfpu(uint16_t t, int16_t k)
{
	uint16_t x, y;
	int32_t z;

	x = fromfpu(t);

	if (x EQ MAXSEGT)
		return(t);

	y = t;
	z = (int32_t)x + k;

	if (z GE MAXSEGT)
		return(tofpu(MAXSEGT));

	while ((y EQ t) OR (z > x))
		y = tofpu(++x);

	return(y);
}

/*
   =============================================================================
	subfpu() -- find next lower FPU time 'k' milliseconds less than 't'
   =============================================================================
*/

uint16_t subfpu(uint16_t t, int16_t k)
{
	uint16_t x, y;
	int32_t z;

	x = fromfpu(t);

	if (x EQ 1)
		return(t);

	y = t;
	z = (int32_t)x - k;

	if (z LE 1)
		return(tofpu(1));

	while ((y EQ t) OR (z < x))
		y = tofpu(--x);

	return(y);
}

