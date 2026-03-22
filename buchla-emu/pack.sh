#!/bin/bash

VER=0.1

NAME=buchla-${VER}
DIR=/tmp/${NAME}

OS=$(uname)

rm -rf ${DIR}
mkdir ${DIR}

function copy()
{
	if [ -e ${1} ]; then
		cp ${1} ${DIR}
	else
		echo "missing ${1} file" >&2
		exit 1
	fi
}

copy buchla-os-x
copy buchla-linux
copy buchla-win.exe

copy vera.ttf
copy bios.abs
copy midas.abs
copy buchla.disk

(cd /tmp; zip -r ${NAME}.zip ${NAME})
mv ${DIR}.zip .
