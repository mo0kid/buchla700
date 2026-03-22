/*
   =============================================================================
	fwrite.c -- write a stream file
	Version 3 -- 1987-07-09 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	fwrite(buffer, size, number, stream) -- write 'number' items of sixe
	'size' bytes from 'buffer' onto 'stream'.  Returns the number of items
	written.  If 'number' or 'size' is negative, nothing is written, and
	0 is returned.  EOF may cause the last item written to be imcomplete.
	Check with feof() to detect an EOF condition.  Use ferror() to check
	for error conditions.
   =============================================================================
*/

int16_t fwrite(void *buffer, int16_t size, int16_t number, FILE *stream)
{
	uint8_t *buffer8;
	register int16_t i, j;

	buffer8 = buffer;

	if (size < 0)		/* check size for validity */
		return(0);

	if (number < 0)		/* check number for validity */
		return(0);

	for (i = 0; i < number; ++i)
		for (j = 0; j < size; ++j)
			if (putc(*buffer8++, stream) EQ EOF)
				return(i);

	return(number);
}


