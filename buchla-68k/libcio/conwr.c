/*
   ============================================================================
	conwr.c -- write on the console
	Version 4 -- 1987-06-29 -- D.N. Lynx Crowe
   ============================================================================
*/

#define	_FS_DEF_		/* to avoid unnecessary externals */

#include "ram.h"

/*
   ============================================================================
	_conwr(kind, buff, len) -- write 'len' bytes from 'buff' on the console
	using op 'kind' as the BIOS argument.
   ============================================================================
*/
int16_t _conwr(io_arg arg, void *buff, int16_t len)
{
	int16_t kind;
	int8_t *buff8;
	register int16_t count;

	kind = (int16_t)(int32_t)arg;
	buff8 = buff;

	for (count = 0; count < len; ++count)
		BIOS(B_PUTC, kind, *buff8++);

	return(count);
}

