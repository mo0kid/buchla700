/*
   =============================================================================
	glcinit.c -- LCD drivers for the Epson GLC controller chip
	Version 5 -- 1988-08-03 -- D.N. Lynx Crowe
	(c) Copyright 1987, 1988 -- D.N. Lynx Crowe

	GLCinit()

		Initializes the GLC.

	GLCcrc(row, col)

		Positions the GLC cursor at ('row', 'col') preparatory
		to writing text.  Returns the calculated cursor address.

	GLCcxy(x, y)

		Positions the GLC cursor at ('x', 'y') preparatory to
		writing graphics.  Returns a bit mask for the pixel.
		Leaves the cursor address in lcdcurs.
		Limits:  0 LE x LE 511,  0 LE y LE 63.

	GLCwrts(s)

		Writes the character string pointed to by 's' at the
		current cursor position on the LCD display.
		Cursor must start and end on the same line.
		No error checks are done.

	GLCtext(row, col, s)

		Sets the GLC cursor to ('row', 'col'), then writes the
		character string pointed to by 's'.
		Cursor must start and end on the same line.
		No error checks are done.

	GLCdisp(dsp, crs, blk1, blk2, blk3)

		Sets the overall display, cursor and block status values.

	GLCcurs(crs)

		Turns the cursor on or off.
   =============================================================================
*/

#include "ram.h"

int16_t		lcdbase;	/* LCD graphics base address */
int16_t		lcdbit;		/* LCD graphics pixel bit mask */
int16_t		lcdcol;		/* LCD text column */
int16_t		lcdctl1;	/* LCD display control -- command */
int16_t		lcdctl2;	/* LCD display control -- data */
int16_t		lcdcurs;	/* LCD graphics pixel byte address */
int16_t		lcdrow;		/* LCD text row */
int16_t		lcdx;		/* LCD graphics x */
int16_t		lcdy;		/* LCD graphics y */

/* GLC initialization values */

uint8_t glc_is1[] = { 0x12, 0x05, 0x07, 0x54, 0x58, 0x3F, 0x55, 0x00 };
uint8_t glc_is2[] = { 0x00, 0x00, 0x3F, 0x00, 0x20, 0x3F, 0x00, 0x00 };

/*
   =============================================================================
	GLCdisp(dsp, crs, blk1, blk2, blk3) -- set GLC display status
	Sets the overall display, cursor and block status values.
   =============================================================================
*/

void GLCdisp(int16_t dsp, int16_t crs, int16_t blk1, int16_t blk2, int16_t blk3)
{
	register int16_t val;

	val = ((blk3 & 3) << 6) | ((blk2 & 3) << 4) | ((blk1 & 3) << 2) |
		(crs & 3);

	lcdctl1 = G_DSPCTL | (dsp & 1);
	lcdctl2 = val;

	LCD_WC = (uint8_t)lcdctl1;
	LCD_WD = (uint8_t)lcdctl2;

}

/*
   =============================================================================
	GLCcurs() -- turns the cursor on or off
   =============================================================================
*/

void GLCcurs(int16_t crs)
{
	lcdctl2 = (crs & 3) | (lcdctl2 & ~3);

	LCD_WC = (uint8_t)lcdctl1;
	LCD_WD = (uint8_t)lcdctl2;
}

/*
   =============================================================================
	GLCinit() -- initialize GLC
	Initializes the GLC.
   =============================================================================
*/

void GLCinit(void)
{
	register int16_t	i;
	register int32_t ic;
	register uint8_t *gp;

	lcdbase = G_PLANE2;	/* set defaults for graphics variables */
	lcdx = 0;
	lcdy = 0;
	lcdbit = 0x01;

	lcdrow = 0;		/* set default for text variables */
	lcdcol = 0;

	lcdctl1 = G_DSPCTL;
	lcdctl2 = 0;

	LCD_WC = G_INIT;	/* initialize the GLC */
	gp = &glc_is1[0];

	for (i = 0; i < 8; i++)
		LCD_WD = *gp++;

	LCD_WC = G_SETSAD;	/* setup scroll registers */
	gp = &glc_is2[0];

	for (i = 0; i < 8; i++)
		LCD_WD = *gp++;

	LCD_WC = G_HSCRL;	/* clear the horizontal scroll counter */
	LCD_WD = 0;

	LCD_WC = G_OVRLAY;	/* setup the display mode */
	LCD_WD = 0x08;

	GLCdisp(G_OFF, G_B2, G_ON, G_ON, G_OFF);


	LCD_WC = G_CRSWR;	/* set cursor at (0,0) in G_PLANE1 */
	LCD_WD = G_PLANE1 & 0xFF;
	LCD_WD = (G_PLANE1 >> 8) & 0xFF;

	LCD_WC = G_CRSMRT;	/* set cursor motion forward */

	LCD_WC = G_MWRITE;	/* write zeros to GLC RAM */

	for (ic = 0; ic < 65536L; ic++)
		LCD_WD = 0;

	LCD_WC = G_CRSWR;	/* set cursor to (0,0) in G_PLANE1 */
	LCD_WD = G_PLANE1 & 0xFF;
	LCD_WD = (G_PLANE1 >> 8) & 0xFF;

	LCD_WC = G_CRSFRM;	/* setup a blinking underline cursor */
	LCD_WD = 0x04;
	LCD_WD = 0x06;

	/* enable display */

	GLCdisp(G_ON, G_B2, G_ON, G_ON, G_OFF);
}

/*
   =============================================================================
	GLCcrc(row, col) -- position GLC text cursor
	Positions the GLC cursor at ('row', 'col') preparatory
	to writing text.  Returns calculated cursor address.
   =============================================================================
*/

int16_t GLCcrc(int16_t row, int16_t col)
{
	int16_t curad;

	curad = col + (row * 85);	/* calculate cursor location */

	LCD_WC = G_CRSWR;		/* send cursor address to GLC */
	LCD_WD = (uint8_t)(curad & 0xFF);
	LCD_WD = (uint8_t)((curad >> 8) & 0xFF);

	lcdrow = row;			/* set text cursor variables */
	lcdcol = col;

	return(curad);			/* return calculated cursor address */
}

/*
   =============================================================================
	GLCcxy(x, y) -- position GLC graphics cursor
	Positions the GLC cursor at ('x', 'y') preparatory to
	writing graphics.  Returns a bit mask for the pixel.
	Leaves cursor address in lcdcurs.
	Limits:  0 LE x LE 511,  0 LE y LE 63.
   =============================================================================
*/

int16_t GLCcxy(int16_t x, int16_t y)
{
	register int16_t curad, xby6;

	/* calculate cursor address */

	xby6 = x % 6;
	curad = lcdbase + (85 * (63 - y)) + (x / 6) + (xby6 >> 3);
	lcdcurs = curad;

	/* send cursor address to GLC */

	LCD_WC = G_CRSWR;
	LCD_WD = (uint8_t)(curad & 0xFF);
	LCD_WD = (uint8_t)((curad >> 8) & 0xFF);

	/* set graphics variables */

	lcdx = x;
	lcdy = y;

	/* calculate bit mask */

	lcdbit = 0x01 << (xby6 & 0x07);

	return(lcdbit);
}

/*
   =============================================================================
	GLCwrts(s) -- write text string to GLC
	Writes the character string pointed to by 's' at the
	current cursor position on the LCD display.
	Cursor must start and end on the same line.
	No error checks are done.
   =============================================================================
*/

void GLCwrts(int8_t *s)
{
	LCD_WC = G_CRSMRT;	/* set cursor motion =  right */

	LCD_WC = G_MWRITE;	/* set to write data */

	while (*s) {		/* write string to GLC */

		LCD_WD = (uint8_t)*s++;
		lcdcol++;	/* keep column variable up to date */
	}
}

/*
   =============================================================================
	GLCtext(row, col, s) -- position GLC cursor and write text
	Sets the GLC cursor to ('row', 'col'), then writes the
	character string pointed to by 's'.
	Cursor must start and end on the same line.
	No error checks are done.
   =============================================================================
*/

void GLCtext(int16_t row, int16_t col, int8_t *s)
{
	register int16_t curad;

	curad = col + (row * 85);	/* calculate cursor address */

	LCD_WC = G_CRSWR;		/* send cursor address to GLC */
	LCD_WD = (uint8_t)(curad & 0xFF);
	LCD_WD = (uint8_t)((curad >> 8) & 0xFF);

	lcdrow = row;			/* set GLC text cursor variables */
	lcdcol = col;

	LCD_WC = G_CRSMRT;		/* set cursor motion = right */

	LCD_WC = G_MWRITE;		/* set to write data */

	while (*s) {			/* write string to GLC */

		LCD_WD = (uint8_t)*s++;
		lcdcol++;		/* keep cursor column up to date */
	}
}


