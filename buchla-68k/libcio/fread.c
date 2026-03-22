/*
   =============================================================================
	fread.c -- read a stream file
	Version 3 -- 1987-06-29 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	fread(buffer, size, number, stream) -- read 'number' items of size
	'size' bytes from file 'stream' into 'buffer'.
   =============================================================================
*/

int16_t fread(void *buffer, int16_t size, int16_t number, FILE *stream)
{
	uint8_t *buffer8;
	int16_t total;
	register int16_t c,i;

	buffer8 = buffer;

	for (total = 0; total < number; ++total) {

		for (i = size; i; --i) {

			if ((c = getc(stream)) EQ EOF)
				return(total);

			*buffer8++ = (uint8_t)c;
		}
	}
	return(total);
}


