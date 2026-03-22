/*
   ============================================================================
	flread.c -- read a long buffer
	Version 2 -- 1987-07-09 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

#define	CHUNK	32256		/* largest practical sized chunk of data */

/*
   ============================================================================
	flread(buff, len, fp) -- Reads 'len' bytes into 'buff' from file 'fp'.

	Returns SUCCESS (0) if OK, EOF (-1) on end of file.
   ============================================================================
*/

int16_t flread(int8_t *buff, int32_t len, FILE *fp)
{
	register int16_t	ilen;

	while (len > 0L) {

		if (len GE (int32_t)CHUNK) {

			if (1 NE fread(buff, CHUNK, 1, fp))
				return(EOF);

			buff += (int32_t)CHUNK;
			len -= (int32_t)CHUNK;

		} else {

			ilen = (int16_t)len;

			if (1 NE fread(buff, ilen, 1, fp))
				return(EOF);

			len = 0L;
		}
	}

	return(SUCCESS);
}


