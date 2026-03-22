/*
   ============================================================================
	write.c -- write() and friends
	Version 17 -- 1987-10-27 -- D.N. Lynx Crowe
   ============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

/* write routine dispatch table */

static	int16_t	(*wr_tab[])(io_arg arg, void *buff, int16_t len) = {

	_badfio,	/* 0 - invalid entry */
	_filewr,	/* 1 - disk file */
	_conwr		/* 2 - console device */
};

/*
   ============================================================================
	_putsec(fp, buf, len) -- write 'len' bytes from 'buf' on file 'fp'
   ============================================================================
*/

int16_t _putsec(struct fcb *fp, void *buf, int16_t len)
{
#if DEBUGIT
	if (fsdebug)
		printf("_putsec($%08lX, $%08lx, %d):  initial curlsn=%ld\n",
			fp, buf, len, fp->curlsn);
#endif

	if ((errno = ReadRN(fp, Wrkbuf)) EQ 1) {	/* try to read sector */

#if DEBUGIT
	if (fsdebug)
		printf("_putsec():  ReadRN saw EOF at curlsn=%ld, asects=%ld\n",
			fp->curlsn, fp->asects);
#endif

		errno = 0;			/* we're at EOF */
		memset(Wrkbuf, 0x1A, BPSEC);	/* pad end of sector */

	} else if (errno)
			return(FAILURE);

	memcpy(Wrkbuf + fp->offset, buf, len);	/* move in the new data */

	if ((errno = WriteRN(fp, Wrkbuf)) NE 0) {	/* write the sector */

#if DEBUGIT
	if (fsdebug)
		printf("_putsec():  WriteRN() FAILED (%d) - curlsn=%ld\n",
			errno, fp->curlsn);
#endif

		return(FAILURE);
	}

	if ((fp->offset = (fp->offset + len) & (BPSEC - 1)) EQ 0) {

		++fp->curlsn;		/* update file position */

		if (_seek(fp) < 0) {

#if DEBUGIT
	if (fsdebug)
		printf("_putsec():  _seek() failed - curlsn=%ld, asects=%ld\n",
			fp->curlsn, fp->asects);
#endif

			return(FAILURE);
		}
	}

#if DEBUGIT
	if (fsdebug)
		printf("_putsec():  final curlsn=%ld, offset=%d, len=%d\n",
			fp->curlsn, fp->offset, len);
#endif

	return(SUCCESS);
}

/*
   ============================================================================
	_filewr(fp, buffer, len) -- write 'len' bytes on file 'fp'
	from 'buffer'.
   ============================================================================
*/

int16_t _filewr(io_arg arg, void *buffer, int16_t len)
{
	struct fcb *fp;
	int8_t *buffer8;
	register int16_t j, k, l;
	int16_t clustr;
	register int32_t cpos;

	fp = (struct fcb *)arg;
	buffer8 = buffer;

	cpos = fp->offset + ((int32_t)fp->curlsn << FILESHFT);	/* get position */

	if (fp->de.bclust EQ 0) {	/* see if we need to allocate */

#if DEBUGIT
	if (fsdebug)
		if (cpos)
			printf("_filewr():  ERROR - bclust EQ 0 and curpos (%ld) NE 0\n",
				cpos);
#endif

		if (0 EQ (clustr = _newcls())) {	/* allocate a cluster */

			errno = EIO;
			return(len);
		}

		fp->de.bclust = micon16((uint16_t)clustr);	/* update FCB */
		_ptcl12(_thefat, clustr, 0x0FF8);	/* update FAT */
		_fatmod = TRUE;
		fp->curdsn = _cl2lsn(_thebpb, clustr);	/* set curdsn */
		fp->curcls = clustr;
		fp->clsec = 0;
		fp->asects = _thebpb->clsiz;
#if DEBUGIT
	if (fsdebug) {

		printf("_filewr():  allocated initial cluster=%d, asects=%ld\n",
			clustr, fp->asects);
		SnapFCB(fp);
	}
#endif
	}

	l = 0;			/* zero the length-written counter */

#if DEBUGIT
	if (fsdebug)
		printf("_filewr():  init pos=%ld, len=%u, curcls=%u, offset=%u\n",
			cpos, len, fp->curcls, fp->offset);
#endif

	if (fp->offset) {	/* see if we have a partial sector to fill */

		if ((l = (BPSEC - fp->offset)) > len)
			l = len;

		if (_putsec(fp, buffer8, l))	/* fill up the sector */
			return(-1);
	}

	if ((k = (len - l) / BPSEC)) {	/* write out any full sectors */

		if ((j = blkwr(fp, buffer8 + l, k)) NE 0) {

			l += (k - j) * BPSEC;	/* update amount written */

			if ((cpos + l) > fp->curlen) 	/* udpate file length */
				fp->de.flen = micon32((uint32_t)(fp->curlen = cpos + l));

#if DEBUGIT
	if (fsdebug)
		printf("_filewr():  ERROR - curlen=%ld, curlsn=%ld, curdsn=%ld\n",
			fp->curlen, fp->curlsn, fp->curdsn);
#endif

			return(l);
		}

		l += k * BPSEC;		/* update amount written */
	}

	if (l < len) {			/* write out partial sector at end */

		if (_putsec(fp, buffer8 + l, len - l)) {

			if ((cpos + l) > fp->curlen)	/* update file length */
				fp->de.flen = micon32((uint32_t)(fp->curlen = cpos + l));

#if DEBUGIT
	if (fsdebug)
		printf("_filewr():  ERROR - curlen=%ld, curlsn=%ld, curdsn=%ld\n",
			fp->curlen, fp->curlsn, fp->curdsn);
#endif

			return(l);
		}
	}

	if ((cpos + len) > fp->curlen) 		/* update file length */
		fp->de.flen = micon32((uint32_t)(fp->curlen = cpos + len));

#if DEBUGIT
	if (fsdebug)
		printf("_filewr():  final curlen=%ld, flen=$%08lX, curlsn=%ld, curdsn=%ld\n",
			fp->curlen, fp->de.flen, fp->curlsn, fp->curdsn);
#endif

	return(len);
}

/*
   ============================================================================
	write(fd, buff, len) -- write 'len' bytes from 'buff' on file 'fd'
   ============================================================================
*/

int16_t write(int16_t fd, void *buff, int16_t len)
{
	register struct channel *chp;

	if ((fd < 0) OR (fd > MAXCHAN)) {

		errno = EBADF;
		return(-1);
	}

	chp = &chantab[fd];

	return((*wr_tab[chp->c_write])(chp->c_arg, buff, len));
}

