/*
   =============================================================================
	blkwr.c -- write a block of 0..32767 sectors
	Version 14 -- 1987-12-15 -- D.N. Lynx Crowe

	int
	blkwr(fcp, buf, ns)
	struct fcb *fcp;
	char *buf;
	int ns;

		Writes 'ns' sectors from file 'fcp' into 'buf'.
		Returns the number of unwritten sectors,
		or 0 if all were written.
   =============================================================================
*/

#define	DEBUGIT		0

#include "ram.h"

#if	TBUFFER

/*
   =============================================================================
	_secwr(buf, rec) -- write a logical sector into the track buffer
   =============================================================================
*/

int32_t _secwr(int8_t *buf, int16_t rec)
{
	register int16_t	track, side, sector;

	if (_thebpb->dspt NE 9)			/* make sure we can do this */
		return(ERR07);

	if (_thebpb->recsiz NE 512)
		return(ERR07);

	track = rec / _thebpb->dspc;		/* desired track */
	sector = rec - (track * _thebpb->dspc);	/* logical sector */

	if (sector GE _thebpb->dspt) {		/* adjust sector and side */

		sector -= _thebpb->dspt;
		side = 1;

	} else {

		side = 0;
	}

#if	DEBUGIT
	if (fsdebug) {

		printf("_secwr($%08.8LX, %d):  track=%d, side=%d, sector=%d\n",
			buf, rec, track, side, sector);
		printf("_secwr():  _b_trak=%d, _b_side=%d, _b_sect=%d, _b_tsec=%d\n",
			_b_trak, _b_side, _b_sect, _b_tsec);
	}
#endif

	if ((track NE _b_trak) OR (side NE _b_side))	/* track in buffer ? */
		return(0L);

	memcpy((int8_t *)_b_tbuf[sector], buf, 512);	/* update the buffer */

#if	DEBUGIT
	if (fsdebug)
		printf("_secwr():  updated track buffer\n");
#endif

	return(0L);
}

#endif

/*
   =============================================================================
	blkwr(fcp, buf, ns) -- write 'ns' sectors from file 'fcp' into 'buf'.
	Returns the number of unwritten sectors, or 0 if all were written.
   =============================================================================
*/

int16_t blkwr(struct fcb *fcp, int8_t *buf, int16_t ns)
{
	int32_t	rc;
	int16_t	clustr;

	while (ns > 0) {		/* write a sector at a time */

		if (fcp->asects) {

			if (fcp->curlsn LT fcp->asects) {

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  [1] ns=%d, curlsn=%ld, curdsn=%ld, curcls=%u, buf=$%08lX\n",
			ns, fcp->curlsn, fcp->curdsn, fcp->curcls, buf);
#endif

				if ((rc = BIOS(B_RDWR, 1, buf, 1, (int16_t)fcp->curdsn, 0))) {

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  B_RDWR failed, rc=%ld\n", rc);
#endif

					_berrno = rc;	/* log the error */
					errno = EIO;
					return(ns);	/* return unwritten sector count */
				}

#if	TBUFFER
				_secwr(buf, (int16_t)fcp->curdsn);
#endif

				rc = _nsic(fcp, _thebpb, _thefat);

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  _nsic() rc=%ld\n", rc);
#endif

				if (--ns EQ 0)		/* done if no more to do */
					return(0);

				if (rc < 0) {		/* bad cluster ? */

					errno = EIO;	/* set error number */
					return(ns);	/* return unwritten sector count */
				}

				buf += _thebpb->recsiz;

			} else if (fcp->curlsn EQ fcp->asects) {

				if (_alcnew(fcp)) {	/* allocate a cluster */

					errno = EIO;	/* set error number */
					return(ns);	/* return unwritten sector count */
				}

				fcp->modefl &= ~FC_EOF;	/* clear EOF flag */

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  [2] ns=%d, curlsn=%ld, curdsn=%ld, curcls=%u, buf=$%08lX\n",
			ns, fcp->curlsn, fcp->curdsn, fcp->curcls, buf);
#endif

				if ((rc = BIOS(B_RDWR, 1, buf, 1, (int16_t)fcp->curdsn, 0))) {

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  B_RDWR failed, rc=%ld\n", rc);
#endif

					_berrno = rc;	/* log the error */
					errno = EIO;
					return(ns);	/* return unwritten sector count */
				}

#if	TBUFFER
				_secwr(buf, (int16_t)fcp->curdsn);
#endif

				++fcp->curlsn;
				++fcp->clsec;
				++fcp->curdsn;

				if (--ns EQ 0)
					return(0);

				buf += _thebpb->recsiz;	/* advance buffer pointer */
			}

		} else {

			if (0 EQ (clustr = _newcls())) {

				errno = EIO;
				return(ns);
			}

			fcp->de.bclust = micon16((uint16_t)clustr);
			_ptcl12(_thefat, clustr, 0x0FF8);
			_fatmod = TRUE;
			fcp->curdsn = _cl2lsn(_thebpb, clustr);
			fcp->curcls = clustr;
			fcp->clsec = 0;
			fcp->asects = _thebpb->clsiz;
			fcp->modefl &= ~FC_EOF;

			fcp->modefl &= ~FC_EOF;	/* clear EOF flag */

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  [3] ns=%d, curlsn=%ld, curdsn=%ld, curcls=%u, buf=$%08lX\n",
			ns, fcp->curlsn, fcp->curdsn, fcp->curcls, buf);
#endif

			if ((rc = BIOS(B_RDWR, 1, buf, 1, (int16_t)fcp->curdsn, 0))) {

#if	DEBUGIT
	if (fsdebug)
		printf("blkwr():  B_RDWR failed, rc=%ld\n", rc);
#endif

				_berrno = rc;	/* log the error */
				errno = EIO;
				return(ns);	/* return unwritten sector count */
			}

#if	TBUFFER
			_secwr(buf, (int16_t)fcp->curdsn);
#endif

			++fcp->curlsn;
			++fcp->clsec;
			++fcp->curdsn;

			if (--ns EQ 0)
				return(0);

			buf += _thebpb->recsiz;	/* advance buffer pointer */
		}
	}

	return(ns);	/* return (will be zero or negative) */
}

