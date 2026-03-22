OUTPUT_FORMAT("elf32-m68k")
ENTRY(start)
SECTIONS
{
    .text (0x10000):
    {
        stext = .;
        *(.text .text.*)
        *(.rodata .rodata.*)
        . = ALIGN(0x10);
        etext = .;
    }

    .data (etext):
    {
        sdata = .;
        *(.data .data.*)
        . = ALIGN(0x10);
        edata = .;
    }

    .bss (edata):
    {
        sbss = .;
        *(.bss .bss.*)
        ebss = .;
    }

    end = .;
}
