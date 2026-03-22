/*
   =============================================================================
	strtol.c -- convert a string of ASCII digits to a long
	Version 1 -- 1987-06-12
   =============================================================================
*/

#include "ram.h"

#define DIGIT(x) (isdigit(x) ? (x)-'0' : islower(x) ? (x)+10-'a' : (x)+10-'A')

#define MBASE   ('z' - 'a' + 1 + 10)

int32_t strtol(int8_t *str, int8_t **ptr, int16_t base)
{
	register int32_t val;
	register int16_t c;
	int16_t xx, neg = 0;

	if (ptr != (int8_t **)0)
		*ptr = str; /* in case no number is formed */

	if (base < 0 || base > MBASE)
		return (0); /* base is invalid -- should be a fatal error */

	if (!isalnum(c = *str)) {

		while (isspace(c))
			c = *++str;

		switch (c) {

		case '-':
			neg++;
			/* fall through */

		case '+':
			c = *++str;
			/* fall through */
		}
	}

	if (base == 0) {
		if (c != '0')
			base = 10;
		else if (str[1] == 'x' || str[1] == 'X')
			base = 16;
		else
			base = 8;
	}

	/*
		for any base > 10, the digits incrementally following
		9 are assumed to be "abc...z" or "ABC...Z"
	*/

	if (!isalnum(c) || (xx = DIGIT(c)) >= base)
		return (0); /* no number formed */

	if (base == 16 && c == '0' && isxdigit(str[2]) &&
	   (str[1] == 'x' || str[1] == 'X'))
		c = *(str += 2); /* skip over leading "0x" or "0X" */

	for (val = -DIGIT(c); isalnum(c = *++str) && (xx = DIGIT(c)) < base; )
		 /* accumulate neg avoids surprises near MAXLONG */
		val = base * val - xx;

	if (ptr != (int8_t **)0)
		*ptr = str;

	return (neg ? val : -val);
}

