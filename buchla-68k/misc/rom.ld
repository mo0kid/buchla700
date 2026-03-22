OUTPUT_FORMAT("elf32-m68k")
ENTRY(start)
SECTIONS
{
    .text (0x100000):
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
        edata = .;
    }

    .bss (0x400):
    {
        sbss = .;
        *(.bss .bss.*)
        ebss = .;
    }
}
