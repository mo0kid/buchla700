/*
   =============================================================================
	conin.c -- read from the console
	Version 6 -- 1987-06-30 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

uint8_t _ConBuf[258];	/* console input buffer */
int16_t _CBused;

int16_t _conin(io_arg arg, void *buff, int16_t len)
{
	int16_t 	nbp;
	register int16_t l;

	(void)arg;

	if (_ConBuf[1] EQ 0) {

		_ConBuf[0] = 255;
		_ConBuf[1] = _ConBuf[2] = 0;

		readbuf(CON_DEV, (int8_t *)_ConBuf);
		writeln(CON_DEV, "\r\n");

		if (_ConBuf[2] EQ 0x1a) {

			_ConBuf[1] = 0;
			return(0);
		}

		nbp = ++_ConBuf[1];
		_ConBuf[nbp++ + 1] = '\r';
		_ConBuf[nbp + 1] = '\n';
		_CBused = 2;
	}

	if ((l = _ConBuf[1]) > len)
		l = len;

	memcpy(buff, (_ConBuf + _CBused), l);
	_CBused += l;
	_ConBuf[1] = (uint8_t)(_ConBuf[1] - l);
	return (l);
}

