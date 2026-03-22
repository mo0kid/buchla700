/*
   ============================================================================
	croot.c -- Root for Buchla 700 C programs
	Version 8 -- 1987-06-29 -- D.N. Lynx Crowe

	This version can be setup for I/O redirection or not, depending on the
	value of REDIRECT.  If redirection is supported, so are command line
	arguments, which must be passed to Croot() at 'cp' by the startup code.

	Normally, this won't be selected, as this is a dedicated application
	that doesn't expect command line arguments or I/O redirection.
   ============================================================================
*/

#define	ROOTMSG	"{Buchla 700 Croot - Version 8 - 1987-06-29}"

#include "ram.h"

#define	REDIRECT	0	/* non-zero for command line stuff */

#define	MAXARGS		30	/* maximum number of command line arguments */

void (*_clsall)(void);

static	int16_t	Argc;
static	int8_t	*Argv[MAXARGS];

/*
   ============================================================================
	exit() -- return control to the BIOS
   ============================================================================
*/

void exit(void)
{
	(*_clsall)();		/* close all open files */
	xtrap15();		/* return to the BIOS */
}


#if	REDIRECT

/*
   ============================================================================
	_eredir(name) -- output I/O redirection error message to stderr
   ============================================================================
*/

static
_eredir(name)
char *name;
{
	char buff[200];

	strcpy(buff, "Can't open file for redirection: ");
	strcat(buff, name);
	strcat(buff, "\n");
	write(2, buff, strlen(buff));
	exit();
}

#endif

/*
   ============================================================================
	Croot(cp) -- C root module for the Buchla 700
   ============================================================================
*/

void Croot(int8_t *cp)
{
	register	int8_t	*fname;
	register	int16_t	k;

	Argv[0] = ROOTMSG;
	Argc = 1;

	_clsall = _fd_cls;
	InitFS();

#if	REDIRECT

	while (Argc < MAXARGS) {	/* handle command line arguments */

		while (*cp EQ ' ' OR *cp EQ '\t')	/* skip whitespace */
			++cp;

		if (*cp EQ 0)			/* check for end of line */
			break;

		if (*cp EQ '>') {		/* > - redirect output */

			k = 1;	/* stdout */
			goto redir;

		} else if (*cp EQ '<') {	/* < - redirect input */

			k = 0;	/* stdin */
redir:
			while (*++cp EQ ' ' OR *cp EQ '\t')	/* skip whitespace */
				;

			fname = cp;	/* pointer to start of name */

			while (*++cp)	/* skip to whitespace */
				if (*cp EQ ' ' OR *cp EQ '\t') {

					*cp++ = 0;
					break;
				}

			close(k);	/* close old assignment */

			if (k)
				k = creat(fname, 0666);		/* stdout */
			else
				k = open(fname, O_RDONLY);	/* stdin */

			if (k EQ -1)
				_eredir(fname);

		} else {	/* collect a command line argument */

			Argv[Argc++] = cp;

			while (*++cp)	/* find end of argument */
				if (*cp EQ ' ' OR *cp EQ '\t') {

					*cp++ = 0;
					break;
				}
		}
	}

#else
	(void)cp;
	(void)k;
	(void)fname;
#endif

	main();			/* call application */
	exit();			/* exit in case the application didn't */
}

