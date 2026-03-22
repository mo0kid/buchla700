/*
   =============================================================================
	posit.c -- position a file to a specific relative sector
	Version 4 -- 1987-06-29 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	posit(fd, pos) -- position file 'fd' at sector 'pos'.
   =============================================================================
*/

int16_t posit(int16_t fd, int16_t pos)
{
	register struct fcb *fp;

	if ((fd < 0) OR (fd > MAXCHAN)) {

		errno = EBADF;
		return(FAILURE);
	}

	fp = chantab[fd].c_arg;

	if ((chantab[fd].c_seek EQ 0)
	    OR (((int32_t)pos << FILESHFT) > fp->curlen)) {

		errno = EINVAL;
		fp->modefl |= FC_ERR;
		return(FAILURE);
	}

	fp->curlsn = pos;
	fp->offset = 0;

	if (_seek(fp) < 0) {

		errno = EIO;
		fp->modefl |= FC_ERR;
		return(FAILURE);
	}

	return(SUCCESS);
}

