/*
   =============================================================================
	libdsp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "stdint.h"
#include "stdio.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t		*ftypes[][3];
extern	int16_t		lbrpal[16][3];
extern	int8_t		ld_em1[];
extern	int8_t		ld_em2[];

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		advlcur(void);
extern	void		bsplcur(void);
extern	int32_t		chksum(void *area, int32_t len);
extern	int16_t		ckdups(void);
extern	int16_t		ckstor(void);
extern	void		clrcat(void);
extern	int16_t		clreq(int32_t bytes);
extern	void		dslslot(int16_t slot, int16_t fg, int16_t row);
extern	uint16_t	exp_c(int16_t c);
extern	int16_t		fcindex(void);
extern	void		fcreset(void);
extern	int8_t		*fctstr(int16_t ns, int16_t just);
extern	int16_t		ftkind(int16_t ns);
extern	int16_t		getcat(int16_t msgsw);
extern	int16_t		getslot(void);
extern	void		ldbord(void);
extern	void		ldbusy(int8_t *msg);
extern	int16_t		ldline(int16_t cy);
extern	void		ldpoint(int16_t x, int16_t y, int16_t pen);
extern	void		ldswin(int16_t n);
extern	void		ldwmsg(int8_t *line1, int8_t *line2, int8_t *line3, int16_t fgcolor, int16_t bgcolor);
extern	void		libdsp(void);
extern	int16_t		lin2slt(int16_t line);
extern	void		lmwclr(void);
extern	void		lmwvtyp(void);
extern	void		lwins(void);
extern	void		makelh(int16_t kind);
extern	void		noslot(int16_t fctype);
extern	int16_t		ocslot(int16_t slot);
extern	int16_t		putcat(void);
extern	int16_t		rd_ec(FILE *fp, void *to, int32_t len);
extern	int16_t		showcat(void);
extern	int16_t		showsiz(void);
extern	int8_t		*slotnam(int16_t slot, int16_t kind);
extern	int16_t		spacerq(int16_t kind);
extern	int16_t		srchcat(int8_t extn[]);
extern	int16_t		storit(void);
extern	void		streset(void);
extern	int16_t		wr_ec(FILE *fp, void *from, int32_t len);
extern	int16_t		writem(void);
extern	int16_t		wrtfile(int16_t kind);
