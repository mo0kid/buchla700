/*
   ============================================================================
	putl.c -- put a Motorola 68000 long word onto a stream file
	Version 2 -- 1987-10-15 -- D.N. Lynx Crowe

	WARNING:  This fails if the stream is ASCII.
   ============================================================================
*/

#include "ram.h"

void putl(int32_t w, FILE *stream)
{
	if (putc(((int16_t)(w >> 24) & 0xFF), stream) < 0)
		return;

	if (putc((int16_t)((w >> 16) & 0xFF), stream) < 0)
		return;

	if (putc((int16_t)((w >> 8) & 0xFF), stream) < 0)
		return;

	putc((int16_t)(w & 0xFF), stream);
}

