#include "ram.h"

int8_t			ac_code;
int16_t			errno;
int16_t			fp_resv[];
int8_t			VerDate[];

volatile	int16_t		timers[NTIMERS];
volatile	uint16_t	vi_scrl;
volatile	uint16_t	vi_sadr;

int8_t			end;
int8_t			edata;
int8_t			etext;
int32_t			p_dlen;

int8_t  		*S1IoRec;
int8_t			*S2IoRec;
int8_t			*M1IoRec;
int8_t			*M2IoRec;

void			(*foot1)(int16_t stat);
void			(*foot2)(int16_t stat);
void			(*pulse1)(void);
void			(*pulse2)(void);

uint32_t		crshrg[16];
int16_t			wzcrsh;
uint32_t		crshpc;
uint32_t		crshsp;
uint32_t		crshus;
uint16_t		crshst[16];
uint16_t		crshsr;
int8_t			crshvc[4];

int32_t			uldivr;

void clrvce(int16_t vce)
{
}

void execins(int16_t vce, int16_t ins, int16_t tag)
{
}

void execkey(int16_t trg, int16_t pch, int16_t vce, int16_t tag)
{
}

void fpuclr(void)
{
}

void fpuint(void)
{
}

uint16_t fromfpu(uint16_t fputime)
{
    return 0;
}

void halt(void)
{
}

void GLCplot(int16_t x, int16_t y, int16_t val)
{
}

void hdvini(void)
{
}

void jumpto(void *addr)
{
}

void longjmp(struct JMP_BUF *env, int16_t val)
{
}

void Lo_RAM(void)
{
}

void objclr(int16_t obj)
{
}

void objoff(int16_t obj, int16_t line, int16_t num)
{
}

void objon(int16_t obj, int16_t line, int16_t num)
{
}

void panic(void)
{
}

void procpfl(int16_t trig)
{
}

void _ptcl12(uint8_t *fat, int16_t cl, int16_t val)
{
}

int32_t rand24(void)
{
    return 0;
}

void rjumpto(void *addr)
{
}

void se_disp(struct s_entry *ep, int16_t sd, struct gdsel *gdstb[], int16_t cf)
{
}

struct s_entry *se_exec(struct s_entry *ep, int16_t sd)
{
    return 0;
}

int16_t setipl(int16_t arg)
{
    return 0;
}

int16_t setjmp(struct JMP_BUF *env)
{
    return 0;
}

void setsio(void)
{
}

uint16_t setsr(uint16_t sr)
{
    return 0;
}

void sjumpto(void *addr, void *stack)
{
}

void sreset(void)
{
}

uint16_t tofpu(uint16_t time)
{
    return 0;
}

int32_t trap13(int16_t fun, ...)
{
    return 0;
}

int32_t trap14(int16_t fun, ...)
{
    return 0;
}

void trap15(void)
{
}

void tsetup(void)
{
}

void tsplot4(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t row, int16_t col, int8_t *str, int16_t pitch)
{
}

int32_t uldiv(int32_t divid, int32_t divis)
{
    return 0;
}

void vbank(int16_t b)
{
}

void vclrav(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr, int16_t len)
{
}

void vcputs(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str)
{
}

void vcputsv(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str, int16_t pitch)
{
}

void vfwait(void)
{
}

void VIint(void)
{
}

void vputa(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr)
{
}

void vputc(volatile uint16_t *obase, int16_t row, int16_t col, int16_t c, uint16_t attr)
{
}

void vputcv(volatile uint16_t *obase, int16_t row, int16_t col, int16_t c, uint16_t attr, int16_t cols)
{
}

void vputp(struct octent *octad, int16_t xloc, int16_t yloc, int16_t val)
{
}

void vsetav(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t attr, int16_t len)
{
}

void vsetcv(volatile uint16_t *obase, int16_t row, int16_t col, uint16_t fgbg, int16_t len)
{
}

void vsplot4(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t row, int16_t col, int8_t *str, int16_t pitch, int16_t ht, int16_t cgtab[][256])
{
}

void vvputsv(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str, int16_t pitch, int16_t ht, int16_t cgtab[][256])
{
}

void vwputp(struct octent *octad, int16_t xloc, int16_t yloc, int16_t val)
{
}

void vwputs(volatile uint16_t *obase, int16_t nw, int16_t fg, int16_t bg, int16_t row, int16_t col, int8_t *str)
{
}

void xtrap15(void)
{
}
