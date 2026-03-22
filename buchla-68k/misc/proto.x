/*
   =============================================================================
	proto.c -- external declarations
   =============================================================================
*/

#pragma once

#include "score.h"
#include "setjmp.h"
#include "slice.h"
#include "stdint.h"
#include "timers.h"
#include "vsdd.h"

/*
   =============================================================================
	external variables
   =============================================================================
*/

extern	int8_t			*M1IoRec;
extern	int8_t			*M2IoRec;
extern	int8_t			*S1IoRec;
extern	int8_t			*S2IoRec;
extern	int8_t			VerDate[];
extern	int8_t			ac_code;
extern	uint32_t		crshpc;
extern	uint32_t		crshrg[16];
extern	uint32_t		crshsp;
extern	uint16_t		crshsr;
extern	uint16_t		crshst[16];
extern	uint32_t		crshus;
extern	int8_t			crshvc[4];
extern	int8_t			edata;
extern	int8_t			end;
extern	int16_t			errno;
extern	int8_t			etext;
extern	void			(*foot1)(int16_t stat);
extern	void			(*foot2)(int16_t stat);
extern	int16_t			fp_resv[];
extern	int32_t			p_dlen;
extern	void			(*pulse1)(void);
extern	void			(*pulse2)(void);
extern	volatile int16_t	timers[NTIMERS];
extern	int32_t			uldivr;
extern	volatile uint16_t	vi_sadr;
extern	volatile uint16_t	vi_scrl;
extern	int16_t			wzcrsh;

/*
   =============================================================================
	external functions
   =============================================================================
*/

extern	void		GLCplot(int16_t x, int16_t y, int16_t val);
extern	void		Lo_RAM(void);
extern	void		VIint(void);
extern	void		_ptcl12(uint8_t *fat, int16_t cl, int16_t val);
extern	void		clrvce(int16_t vce);
extern	void		execins(int16_t vce, int16_t ins, int16_t tag);
extern	void		execkey(int16_t trg, int16_t pch, int16_t vce, int16_t tag);
extern	void		fpuclr(void);
extern	void		fpuint(void);
extern	uint16_t	fromfpu(uint16_t fputime);
extern	void		halt(void);
extern	void		hdvini(void);
extern	void		jumpto(void *addr);
extern	void		longjmp(struct JMP_BUF *env, int16_t val);
extern	void		objclr(int16_t obj);
extern	void		objoff(int16_t obj, int16_t line, int16_t num);
extern	void		objon(int16_t obj, int16_t line, int16_t num);
extern	void		panic(void);
extern	void		procpfl(int16_t trig);
extern	int32_t		rand24(void);
extern	void		rjumpto(void *addr);
extern	void		se_disp(struct s_entry *ep, int16_t sd, struct gdsel *gdstb[], int16_t cf);
extern	struct	s_entry	*se_exec(struct s_entry *ep, int16_t sd);
extern	int16_t		setipl(int16_t arg);
extern	int16_t		setjmp(struct JMP_BUF *env);
extern	void		setsio(void);
extern	uint16_t	setsr(uint16_t sr);
extern	void		sjumpto(void *addr, void *stack);
extern	void		sreset(void);
extern	uint16_t	tofpu(uint16_t time);
extern	int32_t		trap13(int16_t fun, ...);
extern	int32_t		trap14(int16_t fun, ...);
extern	void		trap15(void);
extern	void		tsetup(void);
extern	void		tsplot4(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t row, int16_t col, int8_t *str, int16_t pitch);
extern	int32_t		uldiv(int32_t divid, int32_t divis);
extern	void		vbank(int16_t b);
extern	void		vclrav(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr, int16_t len);
extern	void		vcputs(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str);
extern	void		vcputsv(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str, int16_t pitch);
extern	void		vfwait(void);
extern	void		vputa(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr);
extern	void		vputc(volatile uint16_t *obase, int16_t row, int16_t col, int16_t c, uint16_t attr);
extern	void		vputcv(volatile uint16_t *obase, int16_t row, int16_t col, int16_t c, uint16_t attr, int16_t cols);
extern	void		vputp(struct octent *octad, int16_t xloc, int16_t yloc, int16_t val);
extern	void		vsetav(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr, int16_t len);
extern	void		vsetcv(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t fgbg, int16_t len);
extern	void		vsplot4(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t row, int16_t col, int8_t *str, int16_t pitch, int16_t ht, int16_t cgtab[][256]);
extern	void		vvputsv(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str, int16_t pitch, int16_t ht, int16_t cgtab[][256]);
extern	void		vwputp(struct octent *octad, int16_t xloc, int16_t yloc, int16_t val);
extern	void		vwputs(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str);
extern	void		xtrap15(void);
