/*
   =============================================================================
	getl.c -- get a 68000 long word from a stream file
	Version 2 -- 1987-10-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	getl(stream) -- get a long word from 'stream'

	Reads a long from 'stream' in Motorola 68000 byte order.
	No special alignment is assumed in the file.
   =============================================================================
*/

int32_t getl(FILE *stream)
{
	int32_t temp;
	register int8_t *t;

	t = (int8_t *)&temp;

	*t++ = (int8_t)fgetc(stream);
	*t++ = (int8_t)fgetc(stream);
	*t++ = (int8_t)fgetc(stream);
	*t = (int8_t)fgetc(stream);

	return(temp);
}

