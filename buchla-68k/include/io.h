/*
   ============================================================================
	io.h -- Buchla 700 I/O library definitions
	Version 12 -- 1987-09-25 -- D.N. Lynx Crowe
   ============================================================================
*/

#pragma once

#include "fspars.h"		/* file system parameters */
#include "stdint.h"

struct devtabl;
struct channel;

typedef int16_t (*chclo)(io_arg arg);
typedef int16_t (*devop)(int8_t *name, uint16_t flag, struct channel *chp, struct devtabl *dp);

struct channel {		/* channel table entry */

	int16_t	c_read;		/* read routine index */
	int16_t	c_write;	/* write routine index */
	int16_t	c_ioctl;	/* ioctl routine index */
	int16_t	c_seek;		/* seek routine index */
	chclo	c_close;	/* close function pointer */
	io_arg	c_arg;		/* argument to channel driver */
};

struct device {			/* device control structure */

	int16_t	d_read;		/* read routine code */
	int16_t	d_write;	/* write routine code */
	int16_t	d_ioctl;	/* ioctl routine code */
	int16_t	d_seek;		/* seek routine code */
	devop	d_open;		/* special open function */
	int16_t	d_kind;		/* kind of device */
};

struct devtabl {		/* device table entry */

	int8_t	*d_name;	/* device name */
	struct	device	*d_dev;	/* pointer to device structure */
};
