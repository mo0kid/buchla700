/*
   =============================================================================
	pause.c -- output a message and wait for a CR
	Version 3 -- 1987-07-15 -- D.N. Lynx Crowe
   =============================================================================
*/

#include "ram.h"

void pause(int8_t *s)
{
	writeln(CON_DEV, s);
	writeln(CON_DEV, "\r\n");
	waitcr();
}

