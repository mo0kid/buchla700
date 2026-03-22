/*
   =============================================================================
	read.c -- file read functions for the C I/O Library
	Version 9 -- 1987-10-28 -- D.N. Lynx Crowe

	int
	read(fd, buff, len)
	char *buff;

		Reads 'len' bytes from file 'fd' into 'buff'.
		Returns FAILURE (-1) for errors, number of bytes read
		if successful.

	int
	_getsec(fp, buf, len)
	register struct fcb *fp;
	char *buf;
	unsigned len;

		Gets 'len' bytes into 'buf' from file 'fp'.
		Returns FAILURE (-1) for errors, SUCCESS (0) if successful.

	int
	_filerd(fp, buffer, len)
	register struct fcb *fp;
	char *buffer;
	unsigned len;

		Reads 'len' bytes into 'buffer' from 'fp'.
		Returns FAILURE (-1) for errors, number of bytes read
		if successful.

   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

static int16_t (*t_read[])(io_arg arg, void *buff, int16_t len) = {

	_badfio,	/* 0 - invalid type */
	_filerd,	/* 1 - disk file read */
	_conin		/* 2 - console read */
};

/*
   =============================================================================
	read(fd, buff, len) -- Reads 'len' bytes from file 'fd' into 'buff'.
	Returns FAILURE (-1) for errors, number of bytes read if successful.
   =============================================================================
*/

int16_t read(int16_t fd, void *buff, int16_t len)
{
	register struct channel *chp;

	if (fd < 0 OR fd > MAXCHAN) {	/* check fd range */

		errno = EBADF;	/* bad fd */
		return(FAILURE);
	}

	chp = &chantab[fd];	/* point at the channel table */
	return((*t_read[chp->c_read])(chp->c_arg, buff, len));	/* do the read */
}

/*
   =============================================================================
	_getsec(fp, buf, len) -- Gets 'len' bytes into 'buf' from file 'fp'.
	Returns FAILURE (-1) for errors, SUCCESS (0) if successful.
   =============================================================================
*/

int16_t _getsec(struct fcb *fp, void *buf, int16_t len)
{
	if ((errno = ReadRN(fp, Wrkbuf)) NE 0)	/* get current sector */
		return(FAILURE);

	memcpy(buf, Wrkbuf + fp->offset, len);	/* move what we need */

	if ((fp->offset = (fp->offset + len) & (BPSEC - 1)) EQ 0) {

		++fp->curlsn;			/* advance the sector number */

		if (_seek(fp) < 0)		/* seek to the next sector */
			return(FAILURE);
	}

	return(SUCCESS);			/* return:  all bytes read */
}

/*
   =============================================================================
	_filerd(fp, buffer, len) -- Reads 'len' bytes into 'buffer' from 'fp'.
	Returns FAILURE (-1) for errors, number of bytes read if successful.
   =============================================================================
*/

int16_t _filerd(io_arg arg, void *buffer, int16_t len)
{
	struct fcb *fp;
	int8_t *buffer8;
	register int16_t l;
	register int16_t j, k;
	register int32_t cpos, npos;

	fp = (struct fcb *)arg;
	buffer8 = buffer;

	l = 0;
	cpos = fp->offset + ((int32_t)fp->curlsn << FILESHFT);
	npos = cpos + len;

#if	DEBUGIT
	if (fsdebug)
		printf("_filerd():  len=%u, curpos=%ld, newpos=%ld, curlen=%ld\n",
			len, cpos, npos, fp->curlen);
#endif

	if (npos GT fp->curlen) {

		len = (int16_t)(fp->curlen - cpos);

#if	DEBUGIT
	if (fsdebug)
		printf("_filerd():  len adjusted to %u\n", len);
#endif
	}

	if (fp->offset) {	/* see if we start in the middle of a sector */

		if ((l = BPSEC - fp->offset) > len)	/* see what we need */
			l = len;

		if (_getsec(fp, buffer8, l))	/* read what we can */
			return(len);	/* return if ERROR */
	}

	if ((k = (len - l) / BPSEC)) {		/* see what we still need */
		if ((j = blkrd(fp, buffer8 + l, k)) NE 0)
			return((k - j) * BPSEC + l);	/* return bytes read */
	}

	l += k * BPSEC;			/* adjust l by what we just read */

	if (l < len)	/* see if we still need a partial sector */
		if (_getsec(fp, buffer8 + l, len - l))	/* read partial sector */
			return(l);		/* return if ERROR or EOF */

	return(len);				/* return - got the whole thing */
}

