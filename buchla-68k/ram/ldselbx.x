/*
   =============================================================================
	ldselbx.c -- external declarations
   =============================================================================
*/

#pragma once

#include "fields.h"
#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int16_t		ft2lt[];
extern	struct	selbox	ldboxes[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		clrerms(void);
extern	void		clrlsel(void);
extern	void		dpy_scr(int16_t color, int16_t ns);
extern	void		endltyp(void);
extern	int16_t		getit(void);
extern	int16_t		lcancel(int16_t lct);
extern	void		ldermsg(int8_t *p1, int8_t *p2, int8_t *p3, int16_t p4, int16_t p5);
extern	int16_t		ldfnbox(int16_t n);
extern	void		lst_scr(void);
extern	int16_t		ndx_scr(int16_t slot);
extern	void		savefc(int16_t kind);
extern	int16_t		scskip(FILE *fp, int16_t ns);
extern	int16_t		skp_ec(FILE *fp, int32_t len);
extern	void		skperr(int16_t sn);
