/*
   =============================================================================
	fopen.c -- open a stream file for the Buchla 700 C I/O Library
	Version 4 -- 1987-06-30 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

FILE *_opener(int8_t *name, int8_t *mode, uint16_t raw)
{
	register FILE *fp;
	register int16_t plusopt;

	fp = Cbuffs;

	while ( fp->_flags ) {

		if ( ++fp GE (Cbuffs + NSTREAMS))
			return(NULL);
	}

	plusopt = mode[1] EQ '+';

	switch (0x007F & *mode) {

	case 'r':	/* read mode */
		if ((fp->_unit = open(name, (plusopt ? O_RDWR : O_RDONLY) | raw)) EQ -1)
			return(NULL);
		break;

	case 'w':	/* write mode */
		if ((fp->_unit = open(name, (plusopt ? O_RDWR : O_WRONLY)|O_CREAT|O_TRUNC|raw)) EQ -1)
			return(NULL);

		break;
	
	case 'a':	/* append mode */
		if ((fp->_unit = open(name, (plusopt ? O_RDWR : O_WRONLY)|O_CREAT|raw)) EQ -1)
			return(NULL);

		if (lseek(fp->_unit, 0L, 2) < 0) {

			close(fp->_unit);
			return(NULL);		/* couldn't append */
		}

		break;

	default:
		errno = EINVAL;
		return(NULL);
	}

	fp->_flags  = _BUSY;
	fp->_buflen = BUFSIZ;
	fp->_buff   = 0; 
	fp->_bend   = 0; /* nothing in buffer */
	fp->_bp     = 0;
	return(fp);
}

FILE *fopen(int8_t *name, int8_t *mode)
{
	return(_opener(name, mode, 0));
}

FILE *fopena(int8_t *name, int8_t *mode)
{
	return(_opener(name, mode, 0));
}

FILE *fopenb(int8_t *name, int8_t *mode)
{
	return(_opener(name, mode, O_RAW));
}

