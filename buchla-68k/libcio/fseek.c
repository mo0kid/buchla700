/*
   =============================================================================
	fseek.c -- perform a seek on a stream file
	Version 4 -- 1987-10-28 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	fseek(fp, pos, mode) -- position file 'fp' at 'pos' in mode 'mode'.
   =============================================================================
*/

int16_t fseek(FILE *fp, int32_t pos, int16_t mode)
{
	register int32_t lr;

	if (fp->_flags & _DIRTY) {

		if (flush_(fp, -1))
			return(EOF);

	} else {

		if (mode EQ 1 AND fp->_bp)
			pos -= (int32_t)fp->_bend - (int32_t)fp->_bp;
	}

	fp->_bp = fp->_bend = NULL;
	fp->_flags = (uint8_t)(fp->_flags & ~_EOF);

	lr = lseek(fp->_unit, pos, mode);

	if (((struct fcb *)chantab[fp->_unit].c_arg)->modefl & FC_EOF)
		fp->_flags |= _EOF;

	if (lr < 0)
		return(EOF);

	return(0);
}


