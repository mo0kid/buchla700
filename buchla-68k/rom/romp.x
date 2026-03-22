/*
   =============================================================================
	romp.c -- external declarations
   =============================================================================
*/

#pragma once

#include "regs.h"
#include "setjmp.h"
#include "stdint.h"

#define	MAXFNLN		13		/* xxxxxxxx.xxx + CR */
#define	MAXARGLN	80		/* maximum argument length */
#define	MAXCMDLN	128		/* maximum command line length */
#define	MAXHS		80		/* maximum help string length */
#define	MAXID		90		/* maximum ID string length */

#define	PDATELN		14

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	volatile	uint16_t	*obj0;

extern	int32_t		afi;
extern	int16_t		aflag;
extern	int8_t		ahex[];
extern	int8_t		*aptr;
extern	int16_t		argln;
extern	int8_t		argsep;
extern	int8_t		argstr[MAXARGLN+1];
extern	int16_t		asig;
extern	int16_t		astat;
extern	int16_t		aval;
extern	int16_t		b0flag;
extern	int16_t		b1flag;
extern	uint16_t	baroff;
extern	uint16_t	baron;
extern	int16_t		baseled;
extern	int8_t		bfname[MAXFNLN+1];
extern	int8_t		cmdline[MAXCMDLN+1];
extern	int16_t		cmdunit;
extern	int8_t		*d_cur;
extern	int8_t		*d_last;
extern	int8_t		*d_next;
extern	int16_t		dflag;
extern	int16_t		exflag;
extern	int16_t		first1;
extern	int32_t		ftimer;
extern	int16_t		goflag;
extern	int8_t		hs_mtst[MAXHS+1];
extern	int8_t		idbuf[MAXID+1];
extern	int16_t		ilast;
extern	int16_t		inext;
extern	int16_t		iplev;
extern	int16_t		ledcntr;
extern	int8_t		*monptr;
extern	int16_t		monsw;
extern	uint16_t	*p_ba0;
extern	uint16_t	*p_ba1;
extern	uint16_t	p_bv0;
extern	uint16_t	p_bv1;
extern	int8_t		*p_end;
extern	int8_t		*p_from;
extern	int32_t		p_goto;
extern	int32_t		p_len;
extern	int8_t		*p_to;
extern	int32_t		p_value;
extern	int32_t		p_width;
extern	int8_t		promdate[PDATELN+1];
extern	int16_t		redo;
extern	struct	regs	*regptr;
extern	jmp_buf		restart;
extern	int8_t		*rlist[];
extern	int16_t		rnum;
extern	int16_t		sigadr[];
extern	int16_t		sigtab[128][2];
extern	int8_t		*sptr;
extern	uint16_t	swoff;
extern	uint16_t	swon;
extern	uint16_t	*tba0;
extern	uint16_t	*tba1;
extern	int8_t		*vrlist[];
extern	int16_t		vrnum;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	int16_t		bphit(void);
extern	int16_t		cp_boot(void);
extern	int16_t		cp_chek(void);
extern	int16_t		cp_copy(void);
extern	int16_t		cp_dump(void);
extern	int16_t		cp_fill(void);
extern	int16_t		cp_go(void);
extern	int16_t		cp_ilev(void);
extern	int16_t		cp_ldmp(void);
extern	int16_t		cp_monc(void);
extern	int16_t		cp_monl(void);
extern	int16_t		cp_mons(void);
extern	int16_t		cp_mset(void);
extern	int16_t		cp_mtst(void);
extern	int16_t		cp_null(void);
extern	int16_t		cp_read(void);
extern	int16_t		cp_rset(void);
extern	int16_t		cp_vrst(void);
extern	int16_t		cp_wdmp(void);
extern	int16_t		cp_wfil(void);
extern	int16_t		cp_wset(void);
extern	int16_t		cx_adsp(void);
extern	int16_t		cx_boot(void);
extern	int16_t		cx_bpb(void);
extern	int16_t		cx_chek(void);
extern	int16_t		cx_copy(void);
extern	int16_t		cx_crsh(void);
extern	int16_t		cx_dini(void);
extern	int16_t		cx_dump(void);
extern	int16_t		cx_exit(void);
extern	int16_t		cx_fill(void);
extern	int16_t		cx_go(void);
extern	int16_t		cx_help(void);
extern	int16_t		cx_ilev(void);
extern	int16_t		cx_ldmp(void);
extern	int16_t		cx_load(void);
extern	int16_t		cx_mlod(void);
extern	int16_t		cx_mon(void);
extern	int16_t		cx_mset(void);
extern	int16_t		cx_mtst(void);
extern	int16_t		cx_next(void);
extern	int16_t		cx_omap(void);
extern	int16_t		cx_read(void);
extern	int16_t		cx_regs(void);
extern	int16_t		cx_rest(void);
extern	int16_t		cx_rset(void);
extern	int16_t		cx_vreg(void);
extern	int16_t		cx_vrst(void);
extern	int16_t		cx_wdmp(void);
extern	int16_t		cx_wfil(void);
extern	int16_t		cx_writ(void);
extern	int16_t		cx_wset(void);
extern	int16_t		cx_zap(void);
extern	int16_t		ddump(int8_t *loc, int8_t *lastloc, int16_t nwide, int16_t unit);
extern	void		do_cmd(void);
extern	int16_t		do_srec(int8_t *line);
extern	void		dobar(int16_t nb, int16_t bv);
extern	void		dosw(int16_t nb, int16_t sv);
extern	int16_t		dtext(int8_t *loc, int8_t *lastloc, int16_t nwide, int16_t unit);
extern	uint16_t	exp_c(int16_t c);
extern	int16_t		getarg(void);
extern	int16_t		getcmd(void);
extern	int16_t		getlong(int32_t *var);
extern	int16_t		ldump(uint32_t *loc, uint32_t *lastloc, int16_t nwide, int16_t unit);
extern	void		main(void);
extern	void		padr(void *adr, int16_t unit);
extern	int16_t		pclr(void);
extern	void		progid(void);
extern	int16_t		pscan(void);
extern	void		puthn(uint32_t num, int16_t cw, int16_t unit);
extern	void		putn(uint32_t num, int16_t cw, int16_t unit);
extern	void		rompbp(uint32_t d0, ...);
extern	int16_t		setp(void *var, void *deflt);
extern	int16_t		setvar(int32_t *var, int32_t deflt);
extern	void		showcr(void);
extern	void		showrs(struct regs *rp);
extern	int16_t		waitcr2(void);
extern	int16_t		wdump(uint16_t *loc, uint16_t *lastloc, int16_t nwide, int16_t unit);
extern	int16_t		xdtoi(int16_t c);
