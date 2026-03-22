/*
   =============================================================================
	stdio.h -- Standard I/O Package header for the Buchla 700
	Version 6 -- 1987-10-20 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "fspars.h"		/* file system parameters */
#include "stdint.h"

#define EOF	-1

#define	fgetc	getc
#define	fputc	putc

#define	_BUSY	0x01u
#define	_ALLBUF	0x02u
#define	_DIRTY	0x04u
#define	_EOF	0x08u
#define	_IOERR	0x10u

typedef struct {

	int8_t	*_bp;		/* current position in buffer */
	int8_t	*_bend;		/* last character in buffer + 1 */
	int8_t	*_buff;		/* address of buffer */
	int16_t	_unit;		/* fd token returned by open */
	uint8_t	_flags;		/* {_BUSY, _ALLBUF, _DIRTY, _EOF, _IOERR} */
	int8_t	_bytbuf;	/* single byte buffer for unbuffered streams */
	int16_t	_buflen;	/* length of buffer */

} FILE;

#define	stdin	(&Cbuffs[0])
#define	stdout	(&Cbuffs[1])
#define	stderr	(&Cbuffs[2])

#define	getchar()	getc(stdin)
#define	putchar(c)	putc(c, stdout)
#define	feof(fp)	(((fp)->_flags & _EOF) != 0)
#define	ferror(fp)	(((fp)->_flags & _IOERR) != 0)
#define	clearerr(fp)	((fp)->_flags &= ~(_IOERR | _EOF))
#define	fileno(fp)	((fp)->_unit)
