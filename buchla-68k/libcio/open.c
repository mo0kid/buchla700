/*
   =============================================================================
	open.c -- open a file for the Buchla 700 C I/O library functions
	Version 11 -- 1988-01-31 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

static struct device condev  = { 2, 2, 1, 0, _nopo,   CON_DEV };
static struct device filedev = { 1, 1, 0, 1, _fileop,      -1 };

/*
   =============================================================================
	device table:  contains names and pointers to device control structures
   =============================================================================
*/

static struct devtabl devtabl[] = {

	{ "con:", &condev  },	/* console device */
	{ "CON:", &condev  },

	{      0, &filedev }	/* this MUST be the last entry */
};

/*
   =============================================================================
	open(name, flag, mode) -- Opens file 'name' with flags 'flag'
	and access mode 'mode'.  File will be ASCII unless opened with O_RAW.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t open(int8_t *name, uint16_t flags)
{
	register struct devtabl	*dp;
	register struct channel	*chp;
	register struct device	*dev;
	int16_t	fd;
	uint16_t mdmask;

	/* search for a free channel */

	for (chp = chantab, fd = 0 ; fd < MAXCHAN ; ++chp, ++fd)
		if (chp->c_close EQ _badfc)
			goto fndchan;

	errno = EMFILE;		/* no channels available */
	return(FAILURE);

fndchan:	/* found a channel to use */

	for (dp = devtabl; dp->d_name; ++dp)	 /* search for the device */
		if (strcmp(dp->d_name, name) EQ 0)
			break;

	dev = dp->d_dev;
	mdmask = (flags & 3) + 1;

	if (mdmask & 1) {	/* see if device is readable */

		if ((chp->c_read = dev->d_read) EQ 0) {

			errno = EACCES;		/* can't read */
			return(FAILURE);
		}
	}

	if (mdmask & 2) {	/* see if device is writeable */

		if ((chp->c_write = dev->d_write) EQ 0) {

			errno = EACCES;		/* can't write */
			return(FAILURE);
		}
	}

	/* setup the channel table entries */

	chp->c_arg   = (io_arg)(int32_t)dp->d_dev->d_kind;
	chp->c_ioctl = dev->d_ioctl;
	chp->c_seek  = dev->d_seek;
	chp->c_close = _nopc;

	if ((*dev->d_open)(name, flags, chp, dp) < 0) {	/* open */

		chp->c_close = _badfc;	/* couldn't open for some reason */
		return(FAILURE);
	}

	return(fd);
}

/*
   =============================================================================
	opena(name, flag, mode) -- Opens ASCII file 'name' with flags 'flags'
	Newline translation will be done.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t opena(int8_t *name, uint16_t flags)
{
	return(open(name, flags));
}

/*
   =============================================================================
	openb(name, flag, mode) -- Opens binary file 'name' with flags 'flags'.
	No newline translation is done.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t openb(int8_t *name, uint16_t flags)
{
	return(open(name, flags|O_RAW));
}

/*
   =============================================================================
	creat(name, mode) -- Creates file 'name'.
	The created file is initially open for writing only.  The file
	will be ASCII.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t creat(int8_t *name)
{
	return(open(name, O_WRONLY|O_TRUNC|O_CREAT));
}

/*
   =============================================================================
	creata(name, mode) -- Creates ASCII file 'name'.
	The created file is initially open for writing only.
	Files created with creata() do newline translations.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t creata(int8_t *name)
{
	return(open(name, O_WRONLY|O_TRUNC|O_CREAT));
}

/*
   =============================================================================
	creatb(name, mode) -- create binary file 'name'.
	The created file is initially open for writing only.
	Files created with creatb don't do newline translations.
	Returns a file descriptor (small positive integer) if successful, or
	FAILURE (-1) if an error occurred.
   =============================================================================
*/

int16_t creatb(int8_t *name)
{
	return(open(name, O_WRONLY|O_TRUNC|O_CREAT|O_RAW));
}

/*
   =============================================================================
	_fileop(name, flag, mode, chp, dp) -- Opens disk file 'name' with
	flags 'flag' in mode 'mode' with channel pointer 'chp' and
	device pointer 'dp'.  Returns SUCCESS (0) or FAILURE (-1).
   =============================================================================
*/

int16_t _fileop(int8_t *name, uint16_t flags, struct channel *chp, struct devtabl *dp)
{
	register struct fcb *fp;
	int8_t	tmpname[9], tmpext[4];

	(void)dp;

	/* search for an available fcb entry */

	for (fp = _fcbtab; fp < (_fcbtab + MAXDFILE); ++fp)
		if (fp->modefl EQ 0)
			goto havefcb;

	errno = ENFILE;		/* no fcb space available for file */
	return (FAILURE);

havefcb:

	/* setup the initial fcb */

	if (_inifcb(fp, FilName(name, tmpname), FilExt(name, tmpext), flags)) {

		errno = EINVAL;		/* bad file name or flags */
		return(FAILURE);
	}

	if (_opfcb(fp))			/* open the file */
		return(FAILURE);

	chp->c_arg   = fp;		/* allocate the channel */
	chp->c_close = _filecl;

	return(SUCCESS);
}


