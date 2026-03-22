/*
   =============================================================================
	cmeta.h -- C-Meta parser macro header
	Version 3 -- 1987-04-30 -- D.N. Lynx Crowe
   =============================================================================
*/

#pragma once

#include "stddefs.h"

#define	CM_CHR(c)	CMchr(c)
#define	CM_UCHR(c)	CMuchr(c)

#define	CM_STR(s)	CMstr(s)
#define	CM_USTR(s)	CMustr(s)

#define	CM_NUM		CMlong()
#define	CM_DIG		CMdig()

#define	CM_LIST(l)	CMlist(l)
#define	CM_ULIST(l)	CMulist(l)

#define	CM_OK		return (QQsw = TRUE)
#define	CM_NOGO		return (QQsw = FALSE)

#define	CM_DBLK		if (!QQanch) while (*QQip EQ ' ') ++QQip
