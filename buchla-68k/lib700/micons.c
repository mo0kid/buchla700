/*
   =============================================================================
	micons.c -- motorola / intel format conversion functions
	Version 3 -- 1987-06-11 -- D.N. Lynx Crowe

	micon16(wi)

		Convert between motorola and intel format for a short.

	micon32(wi)

		Convert between motorola and intel format for a long.
   =============================================================================
*/

#include "ram.h"

#define	TESTER	0	/* define non-zero for a test program */

/*
   =============================================================================
	micon16(wi) -- Convert between motorola and intel format for a short.
   =============================================================================
*/

uint16_t micon16(uint16_t wi)
{
	return(((wi << 8) & 0xFF00u) | ((wi >> 8) & 0x00FFu));
}

/*
   =============================================================================
	micon32(wi) -- Convert between motorola and intel format for a long.
   =============================================================================
*/

uint32_t micon32(uint32_t wi)
{
	return(((wi << 24) & 0xFF000000ul) | ((wi << 8) & 0x00FF0000ul) |
		((wi >> 8) & 0x0000FF00ul) | ((wi >> 24) & 0x000000FFul));
}

#if	TESTER

#include "ram.h"

/*
   =============================================================================
	test program for micon functions
   =============================================================================
*/

main()
{
	printf("micons(0x1234) returned 0x%04x\n", micons(0x1234));

	if (sizeof (int) == 4)
		printf("miconi(0x1234) returned 0x%04x\n", miconi(0x1234));
	else
		printf("miconi(0x12345678L) returned 0x%08lx\n",
			miconi(0x12345678L));

	printf("miconl(0x12345678L) returned 0x%08lx\n",
		miconl(0x12345678L));
}

#endif

