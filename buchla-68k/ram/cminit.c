/*
   =============================================================================
	cminit.c -- C-Meta parser functions
	Version 5 -- 1987-07-10 -- D.N. Lynx Crowe

	Some parser functions in C, modelled after HyperMeta(tm).
	Designed for, but not dedicated to,  LR(k), top-down, recursive parsing.
   =============================================================================
*/

#include "ram.h"

#define	CM_DBLK		if (!QQanch) while (*QQip EQ ' ') ++QQip

int16_t	QQsw;		/* parser result switch */
int16_t	QQanch;		/* parser anchored match switch */

int8_t	*QQin;		/* parser initial input pointer */
int8_t	*QQip;		/* parser current input pointer */
int8_t	*QQop;		/* parser string output pointer */

int32_t	QQnum;		/* parser numeric result */
int16_t	QQlnum;		/* parser list element number result */
int8_t	QQdig;		/* parser digit result */
int8_t	QQchr;		/* parser character result */

int8_t	QQstr[CM_MXSTR];	/* parser string result */

/*
   =============================================================================
	CMinit(ip) -- initialize the parser to work on the string at 'ip'.
   =============================================================================
*/

void CMinit(int8_t *ip)
{
	register int16_t i;
	register int8_t *t;

	QQip = ip;
	QQin = ip;
	QQsw = TRUE;
	QQanch = FALSE;
	QQdig = '?';
	QQchr = '?';
	QQnum = 0;
	QQop = QQstr;
	t = QQstr;

	for (i = 0; i < CM_MXSTR; i++)
		*t++ = '\0';
}

/*
   =============================================================================
	CMchr(c) -- attempt to match character 'c' in the input.
   =============================================================================
*/

int16_t CMchr(int8_t c)
{
	CM_DBLK;

	if (c NE *QQip)
		return(QQsw = FALSE);

	QQchr = *QQip++;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMuchr(c) -- attempt to match character 'c' in the input, ignoring case.
   =============================================================================
*/

int16_t CMuchr(int8_t c)
{
	register int8_t t;

	CM_DBLK;

	t = *QQip;

	if (isascii(c))
		if (isupper(c))
			c = _tolower(c);

	if (isascii(t))
		if (isupper(t))
			t = _tolower(t);

	if (c NE t)
		return(QQsw = FALSE);

	QQchr = *QQip++;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMstr(s) -- attempt to match string at 's' in the input.
   =============================================================================
*/

int16_t CMstr(int8_t *s)
{
	register int8_t *t;
	int8_t *q;

	CM_DBLK;

	t = QQip;
	q = s;

	while (*s) {

		if (*t++ NE *s++)
			return(QQsw = FALSE);
	}

	QQop = QQstr;

	while ((*QQop++ = *q++)) ;

	QQip = t;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMustr(s) -- attempt to match string 's' in the input, ignoring case.
   =============================================================================
*/

int16_t CMustr(int8_t *s)
{
	register int8_t *t, t1, t2;
	int8_t *q;

	CM_DBLK;

	t = QQip;
	q = s;

	while (*s) {

		t1 = *t++;
		t2 = *s++;

		if (isascii(t1))
			if (isupper(t1))
				t1 = _tolower(t1);

		if (isascii(t2))
			if (isupper(t2))
				t2 = _tolower(t2);

		if (t1 NE t2)
			return(QQsw = FALSE);
	}

	QQop = QQstr;

	while ((*QQop++ = *q++)) ;

	QQip = t;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMlong() -- attempt to parse a digit string in the input as a long.
   =============================================================================
*/

int16_t CMlong(void)
{
	register int8_t *p;
	register int32_t n;
	register int8_t c;

	CM_DBLK;

	p = QQip;
	n = 0L;
	c = *p++;

	if (!isascii(c))
		return(QQsw = FALSE);

	if (!isdigit(c))
		return(QQsw = FALSE);

	n = c - '0';

	while ((c = *p)) {

		if (!isascii(c))
			break;

		if (!isdigit(c))
			break;

		n = (n * 10) + (c - '0');
		++p;
	}

	QQip = p;
	QQnum = n;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMdig() -- attempt to match a digit in the input string.
   =============================================================================
*/

int16_t CMdig(void)
{
	register int8_t c;

	CM_DBLK;

	c = *QQip;

	if (!isascii(c))
		return(QQsw = FALSE);

	if (!isdigit(c))
		return(QQsw = FALSE);

	QQdig = c;
	++QQip;
	return(QQsw = TRUE);
}

/*
   =============================================================================
	CMlist(l) -- attempt to match a string from the list 'l' in the input.
   =============================================================================
*/

int16_t CMlist(int8_t *l[])
{
	register int16_t	n;
	register int8_t	*p, *q;

	CM_DBLK;

	n = 0;

	while ((p = *l++)) {

		q = p;

		if (CMstr(p)) {

			QQop = QQstr;

			while ((*QQop++ = *q++)) ;

			QQlnum = n;
			return(QQsw = TRUE);
		}

		++n;
	}

	return(QQsw = FALSE);
}

/*
   =============================================================================
	CMulist(l) -- attempt to match a string from the list 'l' in the input
	ignoring case in both the list and the input string.
   =============================================================================
*/

int16_t CMulist(int8_t *l[])
{
	register int16_t	n;
	register int8_t	*p, *q;

	CM_DBLK;

	n = 0;

	while ((p = *l++)) {

		q = p;

		if (CMustr(p)) {

			QQop = QQstr;

			while ((*QQop++ = *q++)) ;

			QQlnum = n;
			return(QQsw = TRUE);
		}

		++n;
	}

	return(QQsw = FALSE);
}

/*
   =============================================================================
	CMstat(msg) -- output 'msg and dump parser status.  Returns QQsw.
   =============================================================================
*/

int16_t CMstat(int8_t *msg)
{
	register int8_t *tp;

	tp = QQin;
	printf("%s\r\n", msg);
	printf("  QQsw: %s, QQanch: %s, QQchr: 0x%02x <%c>, QQdig: %c\r\n",
		(QQsw ? "OK" : "NOGO"), (QQanch ? "anchored" : "deblanked"),
		QQchr, (isascii(QQchr) ? (isprint(QQchr) ? QQchr : ' ') : ' '),
		QQdig);
	printf("  QQnum: %ld, QQlnum: %d\r\n", QQnum, QQlnum);
	printf("  QQstr: %s\r\n", QQstr);
	printf("  {%s}\r\n", QQin);
	printf("   ");

	while (tp++ NE QQip)
		printf(" ");

	printf("^\r\n");
	return(QQsw);
}

