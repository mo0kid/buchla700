/*
   =============================================================================
	vputsv.c -- video display string put functions
	Version 1 -- 1988-10-06 -- D.N. Lynx Crowe
	(c) Copyright 1988 -- D.N. Lynx Crowe

	These functions drive the video character write function vputc()
	which puts characters into a 82716 video RAM character object.

	Full attribute format is assumed.
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	vputsv(obase, row, col, str, attr, len)

	Write string str to video RAM object pointed to by obase
	at (row,col) with attr used for all characters. Line length is len.
   =============================================================================
*/

void vputsv(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t attr, int16_t len)
{
	int16_t	c;

	while ((c = *str++)) {

		vputcv(obase, row, col, c, attr, len);

		if (++col GE 64) {

			col = 0;

			if (++row GE 25)
				row = 0;
		}
	}
}

/*
   =============================================================================
	vputsav(obase, row, col, str, attr, len)

	Write string str in video RAM pointed to by obase starting
	at (row, col) using attributes from the words pointed to by attr.
	Line length is len.
   =============================================================================
*/

void vputsav(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t *attr, int16_t len)
{
	int16_t	c;

	while ((c = *str++)) {

		vputcv(obase, row, col, c, *attr++, len);

		if (++col GE 64) {

			col = 0;

			if (++row GE 25)
				row = 0;
		}
	}
}

