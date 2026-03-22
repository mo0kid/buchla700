#!/bin/bash

if [ -z "${1}" -o -z "${2}" ]; then
    echo "usage: mkhd.sh cross-nm elf-file"
    exit 1
fi

CROSS_NM=${1}
ELF_FILE=${2}

${CROSS_NM} --help >/dev/null 2>&1

if [ ${?} -ne 0 ]; then
    echo "error while executing ${CROSS_NM}"
    exit 1
fi

if [ ! -e ${ELF_FILE} ]; then
    echo "${ELF_FILE} does not exist"
    exit 1
fi

getsym() {
    NAME=${1}
    HEX=$(${CROSS_NM} ${ELF_FILE} | grep ' '${NAME}'$' | cut -c -8)
    RET=$(printf '%d' 0x${HEX})
    printf '  %7s  %10s  %6s\n' ${NAME} 0x${HEX} ${RET} >&2
}

echo "creating header for ${ELF_FILE}'s sections:" >&2
echo >&2

getsym stext; SYM_STEXT=${RET}
getsym etext; SYM_ETEXT=${RET}
getsym sdata; SYM_SDATA=${RET}
getsym edata; SYM_EDATA=${RET}
getsym sbss;  SYM_SBSS=${RET}
getsym ebss;  SYM_EBSS=${RET}

echo >&2

LEN_TEXT=$((${SYM_SDATA} - ${SYM_STEXT}))
LEN_DATA=$((${SYM_EDATA} - ${SYM_SDATA}))
LEN_IMAG=$((${LEN_TEXT} + ${LEN_DATA}))
LEN_BSS=$((${SYM_EBSS} - ${SYM_SBSS}))

printf '  sz_text  0x%08x  %6s\n' ${LEN_TEXT} ${LEN_TEXT} >&2
printf '  sz_data  0x%08x  %6s\n' ${LEN_DATA} ${LEN_DATA} >&2
printf '  sz_imag  0x%08x  %6s\n' ${LEN_IMAG} ${LEN_IMAG} >&2
printf '   sz_bss  0x%08x  %6s\n' ${LEN_BSS}  ${LEN_BSS}  >&2

echo >&2

out8() {
    VAL8=${1}
    HEX8=$(printf '%x' ${VAL8})
    printf "\x${HEX8}"
}

out16() {
    VAL16=${1}
    HI16=$((VAL16 / 256))
    LO16=$((VAL16 % 256))
    out8 ${HI16}
    out8 ${LO16}
}

out32() {
    VAL32=${1}
    HI32=$((VAL32 / 65536))
    LO32=$((VAL32 % 65536))
    out16 ${HI32}
    out16 ${LO32}
}

out16 24603
out32 ${LEN_TEXT}
out32 ${LEN_DATA}
out32 ${LEN_BSS}
out32 0
out32 0
out32 ${SYM_STEXT}
out16 65535
out32 ${SYM_SDATA}
out32 ${SYM_SBSS}
