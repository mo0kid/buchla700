/*
   =============================================================================
	vputs.c -- video display string put functions
	Version 2 -- 1987-03-30 -- D.N. Lynx Crowe
	(c) Copyright 1987 -- D.N. Lynx Crowe

	These functions drive the video character write function vputc()
	which puts characters into a 82716 video RAM character object.

	Full attribute format is assumed.
   =============================================================================
*/

#include "ram.h"

/*
   =============================================================================
	vputs(obase, row, col, str, attrib)

	Write string str to video RAM object pointed to by obase
	at (row,col) with attr used for all characters.
   =============================================================================
*/

void vputs(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t attr)
{
	int16_t	c;

	while ((c = *str++)) {

		vputc(obase, row, col, c, attr);

		if (++col GE 64) {

			col = 0;

			if (++row GE 25)
				row = 0;
		}
	}
}

/*
   =============================================================================
	vputsa(obase, row, col, str, attrib)

	Write string str in video RAM pointed to by obase starting
	at (row, col) using attributes from the words pointed to by attr.
   =============================================================================
*/

void vputsa(volatile uint16_t *obase, int16_t row, int16_t col, int8_t *str, uint16_t *attr)
{
	int16_t	c;

	while ((c = *str++)) {

		vputc(obase, row, col, c, *attr++);

		if (++col GE 64) {

			col = 0;

			if (++row GE 25)
				row = 0;
		}
	}
}

