# Check, whether FLOPVBL == flopvbl and FLOCK == flock. If yes, then COUNT == 2.

OBJD=${1}

if [ -z "${OBJD}" ]; then
	OBJD=m68k-none-elf-objdump
fi

COUNT=$(${OBJD} --syms bios.elf |
               grep -i -e flopvbl -e flock |
               cut -c -8 |
               sort |
               uniq |
               wc -l)

if [ ${COUNT} != 2 ]; then
    echo "FLOPVBL or FLOCK mismatch. See ram/timeint.s for more information."
    rm bios.elf
    exit 1
fi

echo "symbols match"
exit 0
