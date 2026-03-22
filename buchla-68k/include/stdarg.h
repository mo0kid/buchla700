/*
   =============================================================================
	stdarg.h -- variable argument list macros
	Version 1 -- 2017-07-07 -- Thomas Lopatic
   =============================================================================
*/

#pragma once

#include "stdint.h"

typedef	int8_t	*va_list;

#define	va_start(ap, last)	(ap = (int8_t *)&last + sizeof last)
#define	va_arg(ap, type)	(ap += sizeof (type), ((type *)ap)[-1])
#define	va_end(ap)
