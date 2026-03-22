/*
   ============================================================================
	wordq.h -- header for word queue functions
	Version 1 -- 1988-11-02 -- D.N. Lynx Crowe
   ============================================================================
*/

#pragma once

#include "stdint.h"

struct	wordq {

	int16_t		qsize;		/* maximum queue length */
	int16_t		qlen;		/* current queue length */
	int16_t		qin;		/* in pointer */
	int16_t 	qout;		/* out pointer */
	int16_t		qhi;		/* high water mark */
	int16_t		qlo;		/* low water mark */
	uint16_t	*qbuf;		/* base of queue */
};
