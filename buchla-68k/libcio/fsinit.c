/*
   ============================================================================
	fsinit.c -- Initialize file system
	Version 9 -- 1988-01-31 -- D.N. Lynx Crowe
   ============================================================================
*/

#include "ram.h"

int32_t	*Stdbufs;			/* buffer chain pointer */

int8_t	Wrkbuf[BPSEC];			/* sector work buffer */

int32_t	Stdbuf[MAXDFILE][BUFSIZL];	/* standard buffers */

FILE Cbuffs[NSTREAMS];			/* stream file control table */

struct fcb _fcbtab[MAXDFILE];		/* fcb table */

struct channel  chantab[MAXCHAN];	/* channel table:  relates fd's to devices */

#if	TBUFFER

/* WARNING:  this ONLY works for 512 byte sectors, 9 sectors per track */

int16_t	_b_tbuf[9][256];	/* the track buffer */

int16_t	_b_trak;		/* current track */
int16_t	_b_side;		/* current side */
int16_t	_b_sect;		/* current sector */
int16_t	_b_tsec;		/* current base sector of current track */

#endif

/*
   ============================================================================
	_badfio() -- set "bad fd" error on I/O
   ============================================================================
*/

int16_t _badfio(io_arg arg, void *buff, int16_t len)
{
	(void)arg;
	(void)buff;
	(void)len;

	errno = EBADF;		/* set bad fd code */
	return(FAILURE);	/* return with an error indication */
}

/*
   ============================================================================
	_badfc() -- set "bad fd" error on close
   ============================================================================
*/

int16_t _badfc(io_arg arg)
{
	(void)arg;

	errno = EBADF;		/* set bad fd code */
	return(FAILURE);	/* return with an error indication */
}

/*
   ============================================================================
	_nopo() -- null open with no error condition
   ============================================================================
*/

int16_t _nopo(int8_t *name, uint16_t flags, struct channel *chp, struct devtabl *dp)
{
	(void)name;
	(void)flags;
	(void)chp;
	(void)dp;

	return(SUCCESS);	/* return with a non-error indication */
}

/*
   ============================================================================
	_nopc() -- null close with no error condition
   ============================================================================
*/

int16_t _nopc(io_arg arg)
{
	(void)arg;

	return(SUCCESS);	/* return with a non-error indication */
}

/*
   ============================================================================
	InitCH() -- Initialize chantab structure entry
   ============================================================================
*/

void InitCH(struct channel *cp, int16_t rdi, int16_t wri, int16_t ioi, int16_t ski, chclo cfp, io_arg charg)
{
	cp->c_read  = rdi;
	cp->c_write = wri;
	cp->c_ioctl = ioi;
	cp->c_seek  = ski;
	cp->c_close = cfp;
	cp->c_arg   = charg;
}

/*
   ============================================================================
	Init_CB() -- Initialize Cbuff structure entry
   ============================================================================
*/

void Init_CB(FILE *fp, uint8_t flags, int16_t unit, int32_t *bufad, int16_t bufsize)
{
	fp->_bp     = (int8_t *)0L;
	fp->_bend   = (int8_t *)0L;
	fp->_buff   = (int8_t *)bufad;
	fp->_flags  = flags;
	fp->_unit   = unit;
	fp->_bytbuf = 0;
	fp->_buflen = bufsize;
}

/*
   ============================================================================
	InitFS() -- Initialize file system
   ============================================================================
*/

void InitFS(void)
{
	register int16_t i;

	memset(_fcbtab, 0, sizeof _fcbtab);		/* clear fcb table */
	memsetw(Stdbuf, 0, sizeof Stdbuf / 2);		/* clear buffers */

	Init_CB(stdin,  _BUSY, 0, NULL, BUFSIZ);	/* stdin */
	Init_CB(stdout, _BUSY, 1, NULL, 1);		/* stdout */
	Init_CB(stderr, _BUSY, 2, NULL, 1);		/* stderr */

	for (i = 3; i < NSTREAMS; i++)
		Init_CB(&Cbuffs[i], 0, 0, NULL, 0);

	Stdbuf[0][0] = 0L;		/* initialize the buffer list */

	for (i = 1; i < MAXDFILE; i++)
		Stdbuf[i][0] = (int32_t)Stdbuf[i-1];

	Stdbufs = Stdbuf[MAXDFILE-1];

	InitCH(&chantab[0], 2, 0, 1, 0, _nopc, (io_arg)CON_DEV );	/*  0 - stdin  */
	InitCH(&chantab[1], 0, 2, 1, 0, _nopc, (io_arg)CON_DEV );	/*  1 - stdout */
	InitCH(&chantab[2], 0, 2, 1, 0, _nopc, (io_arg)CON_DEV );	/*  2 - stderr */

	for (i = 3; i < MAXCHAN; i++)	/*  3..MAXCHAN-1 - not preassigned */
		InitCH(&chantab[i], 0, 0, 0, 0, _badfc, (io_arg)-1 );

	_bpbin  = FALSE;	/* BPB isn't in memory */
	_dirin  = FALSE;	/* directory isn't in memory */
	_fatin  = FALSE;	/* FAT isn't in memory */
	_fatmod = FALSE;	/* FAT hasn't been changed */
	_dirmod = FALSE;	/* directory hasn't been changed */

#if	TBUFFER
	_b_trak = -1;		/* no track in the buffer */
	_b_side = -1;		/* ... */
#endif
}

