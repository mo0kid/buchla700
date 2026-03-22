/*
   =============================================================================
	vsdd.h -- header for Matra-Harris 82716 VSDD video display functions
	Version 10 -- 1987-05-27 -- D.N. Lynx Crowe
	(c) Copyright 1987 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "stdint.h"

#define	VSDD	((uint16_t *)0x200000)

#define	V_CHITE	12u		/* Character height */

/* object descriptor flags */

#define	V_CBS	0x0800u		/* 0 = Bit Map, 1 = Character */
#define	V_RES0	0x0000u		/* Resolution 0: char 16, bit - */
#define	V_RES1	0x0200u		/* Resolution 1: char  6, bit - */
#define	V_RES2	0x0400u		/* Resolution 2: char  8, bit 2 */
#define	V_RES3	0x0600u		/* Resolution 3: char 12, bit 4 */
#define	V_CRS	0x0100u		/* Conceal/Reveal Select */

#define	V_PSE	0x0080u		/* Proportional space enable */
#define	V_FAD	0x0040u		/* Full attributes select */
#define	V_OBL	0x0020u		/* Object blink */
#define	V_BLA	0x0010u		/* Object blank */

#define	V_HCR	0x0008u		/* High color resolution */
#define	V_TDE	0x0004u		/* Transparency detect enable */
#define	V_DCS0	0x0000u		/* Default color select 0 */
#define	V_DCS1	0x0001u		/* Default color select 1 */
#define	V_DCS2	0x0002u		/* Default color select 2 */
#define	V_DCS3	0x0003u		/* Default color select 3 */

/* Preset flags for bitmap and character objects */

#define	V_BTYPE	0u
#define	V_CTYPE	(V_CBS | V_RES2 | ((V_CHITE - 1) << 12))

/* character attribute flags */

#define	C_ALTCS	0x8000u
#define	C_TFGND	0x4000u
#define	C_TBGND	0x2000u
#define	C_WIDE	0x1000u

#define	C_MASK	0x0800u
#define	C_INVRT	0x0400u
#define	C_BLINK	0x0200u
#define	C_ULINE	0x0100u

struct octent {			/* Object control table entry */

	int16_t		ysize,	/* Height of object in pixels */
			xsize;	/* Width of object in pixels */

	int16_t		objx,	/* Object x location */
			objy;	/* Object y location */

	volatile	uint16_t	*obase;	/* Base of object data */

	int8_t		opri,	/* Current object priority */
			obank;	/* Object bank 0..3 */

	uint16_t	odtw0,	/* Object descriptor table word 0 */
			odtw1;	/* Object descriptor table word 1 */
};
