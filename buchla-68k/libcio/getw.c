/*
   =============================================================================
	getw.c -- get a 68000 word from a stream file
	Version 2 -- 1987-10-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	getw(stream) -- get a word from 'stream'

	Reads a word from 'stream' in Motorola 68000 byte order.
	No special alignment is assumed in the file.
   =============================================================================
*/

int16_t getw(FILE *stream)
{
	int16_t temp;
	register int8_t *t;

	t = (int8_t *)&temp;

	*t++ = (int8_t)fgetc(stream);
	*t = (int8_t)fgetc(stream);

	return(temp);
}

