/*
   ============================================================================
	getc.c -- get a character from a stream file
	Version 3 -- 1987-09-22 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int16_t getc(FILE *ptr)
{
	register int16_t len;

	if (ptr->_bp >= ptr->_bend) {		/* see if the buffer is empty */

		if (ptr->_flags & _EOF)		/* check EOF status */
			return(EOF);

		ptr->_flags = (uint8_t)(ptr->_flags & ~_DIRTY);	/* reset the dirty buffer bit */

		if (ptr->_buff EQ NULL)		/* get a buffer if none exists */
			getbuff(ptr);

		if ((len = read(ptr->_unit, ptr->_buff, ptr->_buflen)) LE 0) {

			ptr->_flags = (uint8_t)(ptr->_flags | ((len EQ 0) ? _EOF : _IOERR));
			return(EOF);
		}

		ptr->_bend = (ptr->_bp = ptr->_buff) + len;
	}

	return(*ptr->_bp++ & 0xFF);
}

