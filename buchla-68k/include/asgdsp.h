/*
   =============================================================================
	asgdsp.h -- assignment editor common parameter header file
	Version 8 -- 1988-04-18 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "vsdd.h"

struct	asgent	{	/* assignment table library entry structure */

	int16_t	a_mop;			/* MIDI output port */
	int16_t	a_tun;			/* tuning table number */

	int16_t	a_aux;			/* auxiliary control state */
	int16_t	a_intn;			/* intensity */
	int16_t	a_rate;			/* rate */
	int16_t	a_dpth;			/* depth */

	int16_t	a_i2grp[12];		/* instrument to group table */
	int16_t	a_gpdyn[12];		/* group dynamics table */

	int16_t	a_v2grp[12];		/* voice to group table */
	int16_t	a_mctln[4];		/* MIDI controller number table */
	int16_t	a_g2prt[12][2];		/* group to port and channel table */
	int16_t	a_k2grp[88];		/* port 1 key to group assigment table */

	int8_t	a_name[16];		/* assignment table name */
};

#define	ASGOBJ		8		/* display object number */
#define	ASGPRI		8		/* display object priority */

#define	ASGNFL		V_RES3		/* display object flags */

#define	AK_BASE		158		/* top y value of group 1 select line */

#define	AKSTART		19718		/* word offset for keyboard icon */

#define	AK_CURS		1		/* cursor color */
#define	AK_BORD		10		/* display border color */

#define	AK_SELC		15		/* selected key line color */
#define	AK_SELC2	13		/* first selected key color */

#define	AK_WKEYT	6		/* top keyboard icon white key color */
#define	AK_BKEYT	7		/* top keyboard icon black key color */
#define	AK_WKEYB	8		/* bot keyboard icon white key color */
#define	AK_BKEYB	9		/* bot keyboard icon black key color */
#define	AK_LINE		14		/* keyboard icon line color */

#define	AK_MODC		13		/* assignment table modified color */
#define	AK_ENTRY	12		/* data entry hilite color */

#define	ACFBX00		11		/* foreground color */
#define	ACFBX01		11		/* foreground color */
#define	ACFBX02		11		/* foreground color */
#define	ACFBX03		11		/* foreground color */
#define	ACFBX04		11		/* foreground color */
#define	ACFBX05		11		/* foreground color */
#define	ACFBX06		11		/* foreground color */
#define	ACFBX07		11		/* foreground color */
#define	ACFBX08		11		/* foreground color */
#define	ACFBX09		11		/* foreground color */
#define	ACFBX10		11		/* foreground color */

#define	ACBBX00		2		/* background color */
#define	ACBBX01		2		/* background color */
#define	ACBBX02		2		/* background color */
#define	ACBBX03		4		/* background color */
#define	ACBBX04		3		/* background color */
#define	ACBBX05		2		/* background color */
#define	ACBBX06		3		/* background color */
#define	ACBBX07		5		/* background color */
#define	ACBBX08		3		/* background color */
#define	ACBBX09		4		/* background color */
#define	ACBBX10		2		/* background color */
