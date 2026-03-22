/*
 *  Copyright (C) 2017 The Contributors
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or (at
 *  your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 *  General Public License for more details.
 *
 *  A copy of the GNU General Public License can be found in the file
 *  "gpl.txt" in the top directory of this repository.
 */

#include <all.h>

#define ver(...) _ver(cpu_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(cpu_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(cpu_verbose, 2, __VA_ARGS__)

int32_t cpu_verbose = 0;

#define MIDAS_ABS "midas.abs"

#define CPU_FREQ 7000000
#define PER_SEC 100000

#define APP_START 0x10000

#define RAM_START 0x0
#define RAM_SIZE 0x100000

#define ROM_START 0x100000
#define ROM_SIZE 0x10000

typedef void (*hw_init_t)(void);
typedef void (*hw_quit_t)(void);
typedef bool (*hw_exec_t)(void);
typedef uint32_t (*hw_read_t)(uint32_t off, int32_t sz);
typedef void (*hw_write_t)(uint32_t off, int32_t sz, uint32_t val);

typedef struct {
	uint32_t addr_beg;
	uint32_t addr_end;
	uint32_t irq;
	hw_init_t init;
	hw_quit_t quit;
	hw_exec_t exec;
	hw_read_t read;
	hw_write_t write;
} hw_t;

typedef struct {
	uint32_t text_loc;
	uint32_t text_len;
	uint32_t data_loc;
	uint32_t data_len;
	uint32_t bss_loc;
	uint32_t bss_len;
	size_t load_len;
	SDL_RWops *ops;
} abs_t;

static uint64_t freq;
static uint64_t quan;

SDL_mutex *cpu_mutex;

static bool reset = true;

static uint8_t ram_data[RAM_SIZE];
static uint8_t rom_data[ROM_SIZE];

static uint32_t ram_ro_beg = 0x1234;
static uint32_t ram_ro_end = 0x1234;
static uint32_t ram_rw_beg = 0x1234;
static uint32_t ram_rw_end = 0x1234;

static uint32_t rom_ro_beg;
static uint32_t rom_ro_end;
static uint32_t rom_rw_beg;
static uint32_t rom_rw_end;

static hw_t hw_map[] = {
	{ 0x180000, 0x200000, 2, fpu_init, fpu_quit, fpu_exec, fpu_read, fpu_write },
	{ 0x200000, 0x280002, 1, vid_init, vid_quit, vid_exec, vid_read, vid_write },
	{ 0x3a0001, 0x3a4001, 4, tim_init, tim_quit, tim_exec, tim_read, tim_write },
	{ 0x3a4001, 0x3a8001, 0, lcd_init, lcd_quit, lcd_exec, lcd_read, lcd_write },
	{ 0x3a8001, 0x3ac001, 5, ser_init, ser_quit, ser_exec, ser_read, ser_write },
	{ 0x3ac001, 0x3b0001, 5, mid_init, mid_quit, mid_exec, mid_read, mid_write },
	{ 0x3b0001, 0x3b4001, 0, fdd_init, fdd_quit, fdd_exec, fdd_read, fdd_write },
	{ 0x3b4001, 0x3b8001, 0, snd_init, snd_quit, snd_exec, snd_read, snd_write },
	{ 0x3b8001, 0x3bc001, 0, led_init, led_quit, led_exec, led_read, led_write },
	{ 0x3bc001, 0x3c0001, 3, kbd_init, kbd_quit, kbd_exec, kbd_read, kbd_write }
};

static hw_t *hw_by_addr(uint32_t addr)
{
	for (int32_t i = 0; i < ARRAY_COUNT(hw_map); ++i) {
		if (addr >= hw_map[i].addr_beg && addr < hw_map[i].addr_end) {
			return hw_map + i;
		}
	}

	return NULL;
}

static void hw_init(void)
{
	inf("starting hardware");

	for (int32_t i = 0; i < ARRAY_COUNT(hw_map); ++i) {
		hw_map[i].init();
	}
}

static void hw_quit(void)
{
	inf("halting hardware");

	for (int32_t i = 0; i < ARRAY_COUNT(hw_map); ++i) {
		hw_map[i].quit();
	}
}

static uint32_t hw_exec(void)
{
	uint32_t irq = 0;

	for (int32_t i = 0; i < ARRAY_COUNT(hw_map); ++i) {
		if (hw_map[i].exec() && hw_map[i].irq > irq) {
			irq = hw_map[i].irq;
		}
	}

	return irq;
}

static uint32_t hw_off(hw_t *hw, uint32_t addr)
{
	if ((hw->addr_beg & 0x1) == 0) {
		return addr - hw->addr_beg;
	}

	return (addr - hw->addr_beg) / 2;
}

static void open_abs(const char *path, abs_t *abs)
{
	abs->ops = SDL_RWFromFile(path, "rb");

	if (abs->ops == NULL) {
		fail("error while opening .abs file %s", path);
	}

	if (SDL_ReadBE16(abs->ops) != 0x601b) {
		fail("invalid .abs file %s", path);
	}

	abs->text_len = SDL_ReadBE32(abs->ops);
	abs->data_len = SDL_ReadBE32(abs->ops);
	abs->bss_len = SDL_ReadBE32(abs->ops);

	SDL_ReadBE32(abs->ops);
	SDL_ReadBE32(abs->ops);

	abs->text_loc = SDL_ReadBE32(abs->ops);

	SDL_ReadBE16(abs->ops);

	abs->data_loc = SDL_ReadBE32(abs->ops);
	abs->bss_loc = SDL_ReadBE32(abs->ops);

	inf("text 0x%x:0x%x data 0x%x:0x%x bss 0x%x:0x%x",
			abs->text_loc, abs->text_len, abs->data_loc, abs->data_len, abs->bss_loc, abs->bss_len);

	abs->load_len = (size_t)SDL_RWsize(abs->ops) - 36;
}

static void load_abs(const char *path, abs_t *abs, uint8_t *data)
{
	size_t loaded = 0;

	while (loaded < abs->load_len) {
		size_t n_rd = SDL_RWread(abs->ops, data + loaded, 1, abs->load_len - loaded);

		if (n_rd == 0) {
			fail("error while reading .abs file %s", path);
		}

		loaded += n_rd;
	}

	SDL_RWclose(abs->ops);
}

static void bios_init(void)
{
	inf("loading BIOS file %s", bios);

	abs_t abs;
	open_abs(bios, &abs);

	if (abs.text_loc != ROM_START || abs.text_loc + abs.text_len != abs.data_loc ||
			abs.load_len != abs.text_len + abs.data_len || abs.load_len > ROM_SIZE) {
		fail("invalid BIOS file %s", bios);
	}

	load_abs(bios, &abs, rom_data);

	rom_ro_beg = abs.text_loc;
	rom_ro_end = abs.text_loc + abs.text_len + abs.data_len;
	rom_rw_beg = abs.bss_loc;
	rom_rw_end = abs.bss_loc + abs.bss_len;

	ver("rom_ro_beg 0x%08x rom_ro_end 0x%08x", rom_ro_beg, rom_ro_end);
	ver("rom_rw_beg 0x%08x rom_rw_end 0x%08x", rom_rw_beg, rom_rw_end);

	// Patch the BIOS rwabs serial-number check to always pass.
	// The check has a d7-doubling bug in indexed addressing that
	// compares boot-sector bytes at wrong offsets against stored
	// values.  On real hardware the access timer prevented the check
	// from running, but in the emulator the delay between boot and
	// first disk access triggers it.
	// Binary pattern: cmp.w d1,d0 (B041) / beq.w (6700 xxxx) /
	// moveq #-14,d0 (70F2).  Change beq.w to bra.w.
	{
		for (size_t i = 0; i + 7 < abs.load_len; ++i) {
			if (rom_data[i] == 0xb0 && rom_data[i + 1] == 0x41 &&
					rom_data[i + 2] == 0x67 && rom_data[i + 3] == 0x00 &&
					rom_data[i + 6] == 0x70 && rom_data[i + 7] == 0xf2) {
				rom_data[i + 2] = 0x60;  // beq.w → bra.w
				inf("patched rwabs serial check at ROM offset 0x%04x", (int)i);
				break;
			}
		}
	}
}

static void midas_init(void)
{
	SDL_RWops *ops = SDL_RWFromFile(MIDAS_ABS, "rb");

	if (ops == NULL) {
		return;
	}

	SDL_RWclose(ops);

	inf("loading MIDAS file " MIDAS_ABS);

	abs_t abs;
	open_abs(MIDAS_ABS, &abs);

	if (abs.text_loc != APP_START ||
			abs.text_loc + abs.text_len != abs.data_loc ||
			abs.data_loc + abs.data_len != abs.bss_loc ||
			abs.load_len != abs.text_len + abs.data_len ||
			abs.bss_loc + abs.bss_len > RAM_SIZE) {
		fail("invalid MIDAS file " MIDAS_ABS);
	}

	load_abs(MIDAS_ABS, &abs, ram_data + APP_START - RAM_START);

	ram_ro_beg = ram_rw_beg = APP_START;
	ram_ro_end = ram_rw_end = RAM_START + RAM_SIZE;
}

uint32_t m68k_read_disassembler_8(uint32_t addr)
{
	return m68k_read_memory_8(addr);
}

uint32_t m68k_read_disassembler_16(uint32_t addr)
{
	return m68k_read_memory_16(addr);
}

uint32_t m68k_read_disassembler_32(uint32_t addr)
{
	return m68k_read_memory_32(addr);
}

uint32_t m68k_read_memory_8(uint32_t addr)
{
	ver3("mem rd 0x%08x:8", addr);

	if (addr >= ram_ro_beg && addr <= ram_ro_end - 1) {
		return ram_data[addr - RAM_START];
	}

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 1) {
		return ram_data[addr - RAM_START];
	}

	if (addr >= rom_ro_beg && addr <= rom_ro_end - 1) {
		return rom_data[addr - ROM_START];
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 1) {
		// ROM has its BSS section in RAM.
		return ram_data[addr - RAM_START];
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		return hw->read(hw_off(hw, addr), 1);
	}

	if (addr <= APP_START - 1) {
		return ram_data[addr];
	}

	fail("invalid read 0x%08x:8", addr);
}

uint32_t m68k_read_memory_16(uint32_t addr)
{
	ver3("mem rd 0x%08x:16", addr);

	if (addr >= ram_ro_beg && addr <= ram_ro_end - 2) {
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 8) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 0);
	}

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 2) {
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 8) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 0);
	}

	if (addr >= rom_ro_beg && addr <= rom_ro_end - 2) {
		return
				((uint32_t)rom_data[addr - ROM_START + 0] << 8) |
				((uint32_t)rom_data[addr - ROM_START + 1] << 0);
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 2) {
		// ROM has its BSS section in RAM.
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 8) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 0);
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		return hw->read(hw_off(hw, addr), 2);
	}

	if (addr <= APP_START - 2) {
		return
				((uint32_t)ram_data[addr + 0] << 8) |
				((uint32_t)ram_data[addr + 1] << 0);
	}

	fail("invalid read 0x%08x:16", addr);
}

uint32_t m68k_read_memory_32(uint32_t addr)
{
	ver3("mem rd 0x%08x:32", addr);

	if (reset) {
		if (addr == 0) {
			addr += ROM_START;
		}
		else if (addr == 4) {
			addr += ROM_START;
			reset = false;
		}
		else {
			fail("invalid reset sequence");
		}
	}

	if (addr >= ram_ro_beg && addr <= ram_ro_end - 4) {
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 24) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 16) |
				((uint32_t)ram_data[addr - RAM_START + 2] <<  8) |
				((uint32_t)ram_data[addr - RAM_START + 3] <<  0);
	}

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 4) {
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 24) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 16) |
				((uint32_t)ram_data[addr - RAM_START + 2] <<  8) |
				((uint32_t)ram_data[addr - RAM_START + 3] <<  0);
	}

	if (addr >= rom_ro_beg && addr <= rom_ro_end - 4) {
		return
				((uint32_t)rom_data[addr - ROM_START + 0] << 24) |
				((uint32_t)rom_data[addr - ROM_START + 1] << 16) |
				((uint32_t)rom_data[addr - ROM_START + 2] <<  8) |
				((uint32_t)rom_data[addr - ROM_START + 3] <<  0);
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 4) {
		// ROM has its BSS section in RAM.
		return
				((uint32_t)ram_data[addr - RAM_START + 0] << 24) |
				((uint32_t)ram_data[addr - RAM_START + 1] << 16) |
				((uint32_t)ram_data[addr - RAM_START + 2] <<  8) |
				((uint32_t)ram_data[addr - RAM_START + 3] <<  0);
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		return hw->read(hw_off(hw, addr), 4);
	}

	if (addr <= APP_START - 4) {
		return
				((uint32_t)ram_data[addr + 0] << 24) |
				((uint32_t)ram_data[addr + 1] << 16) |
				((uint32_t)ram_data[addr + 2] <<  8) |
				((uint32_t)ram_data[addr + 3] <<  0);
	}

	fail("invalid read 0x%08x:32", addr);
}

void m68k_write_memory_8(uint32_t addr, uint32_t val)
{
	ver3("mem wr 0x%08x:8 0x%02x", addr, val);

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 1) {
		ram_data[addr - RAM_START] = (uint8_t)val;
		return;
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 1) {
		// ROM has its BSS section in RAM.
		ram_data[addr - RAM_START] = (uint8_t)val;
		return;
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		hw->write(hw_off(hw, addr), 1, val);
		return;
	}

	if (addr <= APP_START - 1) {
		ram_data[addr] = (uint8_t)val;
		return;
	}

	// once midas.abs gets loaded, activate RAM

	if (addr == APP_START) {
		ram_data[addr] = (uint8_t)val;
		ram_rw_beg = APP_START;
		ram_rw_end = RAM_START + RAM_SIZE;
		return;
	}

	fail("invalid write 0x%08x:8 0x%02x", addr, val);
}

void m68k_write_memory_16(uint32_t addr, uint32_t val)
{
	ver3("mem wr 0x%08x:16 0x%04x", addr, val);

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 2) {
		ram_data[addr - RAM_START + 0] = (uint8_t)(val >> 8);
		ram_data[addr - RAM_START + 1] = (uint8_t)(val >> 0);
		return;
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 2) {
		// ROM has its BSS section in RAM.
		ram_data[addr - RAM_START + 0] = (uint8_t)(val >> 8);
		ram_data[addr - RAM_START + 1] = (uint8_t)(val >> 0);
		return;
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		hw->write(hw_off(hw, addr), 2, val);
		return;
	}

	if (addr <= APP_START - 2) {
		ram_data[addr + 0] = (uint8_t)(val >> 8);
		ram_data[addr + 1] = (uint8_t)(val >> 0);
		return;
	}

	fail("invalid write 0x%08x:16 0x%04x", addr, val);
}

void m68k_write_memory_32(uint32_t addr, uint32_t val)
{
	ver3("mem wr 0x%08x:32 0x%08x", addr, val);

	if (addr >= ram_rw_beg && addr <= ram_rw_end - 4) {
		ram_data[addr - RAM_START + 0] = (uint8_t)(val >> 24);
		ram_data[addr - RAM_START + 1] = (uint8_t)(val >> 16);
		ram_data[addr - RAM_START + 2] = (uint8_t)(val >>  8);
		ram_data[addr - RAM_START + 3] = (uint8_t)(val >>  0);
		return;
	}

	if (addr >= rom_rw_beg && addr <= rom_rw_end - 4) {
		// ROM has its BSS section in RAM.
		ram_data[addr - RAM_START + 0] = (uint8_t)(val >> 24);
		ram_data[addr - RAM_START + 1] = (uint8_t)(val >> 16);
		ram_data[addr - RAM_START + 2] = (uint8_t)(val >>  8);
		ram_data[addr - RAM_START + 3] = (uint8_t)(val >>  0);
		return;
	}

	hw_t *hw = hw_by_addr(addr);

	if (hw != NULL) {
		hw->write(hw_off(hw, addr), 4, val);
		return;
	}

	if (addr <= APP_START - 4) {
		ram_data[addr + 0] = (uint8_t)(val >> 24);
		ram_data[addr + 1] = (uint8_t)(val >> 16);
		ram_data[addr + 2] = (uint8_t)(val >>  8);
		ram_data[addr + 3] = (uint8_t)(val >>  0);
		return;
	}

	fail("invalid write 0x%08x:32 0x%08x", addr, val);
}

uint8_t cpu_peek(int32_t addr)
{
	if (addr >= RAM_START && addr <= RAM_START + RAM_SIZE - 1) {
		return ram_data[addr - RAM_START];
	}

	if (addr >= ROM_START && addr <= ROM_START + ROM_SIZE - 1) {
		return rom_data[addr - ROM_START];
	}

	return 0;
}

void cpu_poke(int32_t addr, uint8_t val)
{
	if (addr >= RAM_START && addr <= RAM_START + RAM_SIZE - 1) {
		ram_data[addr - RAM_START] = val;
	}

	if (addr >= ROM_START && addr <= ROM_START + ROM_SIZE - 1) {
		rom_data[addr - ROM_START] = val;
	}
}

/* -------------------------------------------------------------------------- */
/* Analog input FIFO for XBIOS X_ANALOG                                       */
/*                                                                            */
/* MIDAS reads panel analog inputs (HT, VT, tempo, time scaling) via          */
/* XBIOS X_ANALOG.  A 68000 handler at 0x9000 intercepts trap 14 func 8      */
/* and returns values from a circular buffer in RAM.                           */
/*                                                                            */
/* RAM layout (0x9080–0x90A3):                                                */
/*   0x9080: 16-word circular buffer (32 bytes)                               */
/*   0x90A0: head index (word, read pointer, 0–15)                            */
/*   0x90A2: tail index (word, write pointer, 0–15)                           */
/*                                                                            */
/* Packed format: (signal << 8) | (status << 7) | value                       */
/* -------------------------------------------------------------------------- */

#define ANA_BUF   0x9080
#define ANA_HEAD  0x90A0
#define ANA_TAIL  0x90A2
#define ANA_MASK  15

void cpu_analog(int32_t sig, int32_t val)
{
	uint16_t packed = (uint16_t)(((sig & 0x7F) << 8) | (1 << 7) | (val & 0x7F));

	int32_t tail = ((int32_t)cpu_peek(ANA_TAIL) << 8) |
			(int32_t)cpu_peek(ANA_TAIL + 1);
	int32_t head = ((int32_t)cpu_peek(ANA_HEAD) << 8) |
			(int32_t)cpu_peek(ANA_HEAD + 1);

	/* check if full */
	if (((tail + 1) & ANA_MASK) == (head & ANA_MASK)) {
		return;
	}

	int32_t off = ANA_BUF + (tail & ANA_MASK) * 2;

	cpu_poke(off, (uint8_t)(packed >> 8));
	cpu_poke(off + 1, (uint8_t)(packed & 0xFF));

	tail = (tail + 1) & ANA_MASK;
	cpu_poke(ANA_TAIL, (uint8_t)(tail >> 8));
	cpu_poke(ANA_TAIL + 1, (uint8_t)(tail & 0xFF));
}

static void inst_cb(void)
{
	uint32_t pc = m68k_get_reg(NULL, M68K_REG_PC);
	uint32_t op = m68k_read_memory_16(pc);

	gdb_inst(op == 0x4e4f);

	if (op == 0x4e4d) {
		uint32_t sp = m68k_get_reg(NULL, M68K_REG_SP);
		uint32_t fun = m68k_read_memory_16(sp);

		switch (fun) {
		case 1:
			ver2("BIOS B_RDAV %u", m68k_read_memory_16(sp + 2));
			break;

		case 2:
			ver2("BIOS B_GETC %u", m68k_read_memory_16(sp + 2));
			break;

		case 3:
			ver2("BIOS B_PUTC %u %u",
					m68k_read_memory_16(sp + 2),
					m68k_read_memory_16(sp + 4));
			break;

		case 4:
			ver2("BIOS B_RDWR %u 0x%08x %u %u %u",
					m68k_read_memory_16(sp + 2),
					m68k_read_memory_32(sp + 4),
					m68k_read_memory_16(sp + 8),
					m68k_read_memory_16(sp + 10),
					m68k_read_memory_16(sp + 12));
			break;

		case 5:
			ver2("BIOS B_SETV %u 0x%08x",
					m68k_read_memory_16(sp + 2),
					m68k_read_memory_32(sp + 4));
			break;

		case 7:
			ver2("BIOS B_GBPB %u", m68k_read_memory_16(sp + 2));
			break;

		case 8:
			ver2("BIOS B_THRE %u", m68k_read_memory_16(sp + 2));
			break;

		case 9:
			ver2("BIOS B_MCHG %u", m68k_read_memory_16(sp + 2));
			break;

		case 10:
			ver2("BIOS B_DMAP");
			break;

		default:
			fail("invalid function: BIOS %d", fun);
		}
	}
	else if (op == 0x4e4e) {
		uint32_t sp = m68k_get_reg(NULL, M68K_REG_SP);
		uint32_t fun = m68k_read_memory_16(sp);

		switch (fun) {
		case 0:
			ver2("XBIOS X_PIOREC %u", m68k_read_memory_16(sp + 2));
			break;

		case 1:
			ver2("XBIOS X_SETPRT %u 0x%02x 0x%02x 0x%02x 0x%02x",
					m68k_read_memory_16(sp + 2),
					m68k_read_memory_16(sp + 4),
					m68k_read_memory_16(sp + 6),
					m68k_read_memory_16(sp + 8),
					m68k_read_memory_16(sp + 10));
			break;

		case 2:
			ver2("XBIOS X_FLOPRD 0x%08x 0x%08x %u %u %u %u %u",
					m68k_read_memory_32(sp + 2),
					m68k_read_memory_32(sp + 6),
					m68k_read_memory_16(sp + 10),
					m68k_read_memory_16(sp + 12),
					m68k_read_memory_16(sp + 14),
					m68k_read_memory_16(sp + 16),
					m68k_read_memory_16(sp + 18));
			break;

		case 3:
			ver2("XBIOS X_FLOPWR 0x%08x 0x%08x %u %u %u %u %u",
					m68k_read_memory_32(sp + 2),
					m68k_read_memory_32(sp + 6),
					m68k_read_memory_16(sp + 10),
					m68k_read_memory_16(sp + 12),
					m68k_read_memory_16(sp + 14),
					m68k_read_memory_16(sp + 16),
					m68k_read_memory_16(sp + 18));
			break;

		case 4:
			ver2("XBIOS X_FORMAT 0x%08x 0x%08x %u %u %u %u %u 0x%08x %u",
					m68k_read_memory_32(sp + 2),
					m68k_read_memory_32(sp + 6),
					m68k_read_memory_16(sp + 10),
					m68k_read_memory_16(sp + 12),
					m68k_read_memory_16(sp + 14),
					m68k_read_memory_16(sp + 16),
					m68k_read_memory_16(sp + 18),
					m68k_read_memory_32(sp + 20),
					m68k_read_memory_16(sp + 24));
			break;

		case 5:
			ver2("XBIOS X_VERIFY 0x%08x 0x%08x %u %u %u %u %u",
					m68k_read_memory_32(sp + 2),
					m68k_read_memory_32(sp + 6),
					m68k_read_memory_16(sp + 10),
					m68k_read_memory_16(sp + 12),
					m68k_read_memory_16(sp + 14),
					m68k_read_memory_16(sp + 16),
					m68k_read_memory_16(sp + 18));
			break;

		case 6:
			ver2("XBIOS X_PRBOOT 0x%08x %u %u %u",
					m68k_read_memory_32(sp + 2),
					m68k_read_memory_16(sp + 6),
					m68k_read_memory_16(sp + 8),
					m68k_read_memory_16(sp + 10));
			break;

		case 7:
			ver2("XBIOS X_RANDOM");
			break;

		case 8:
			ver2("XBIOS X_ANALOG");
			break;

		case 9:
			ver2("XBIOS X_CLRAFI");
			break;

		case 10:
			ver2("XBIOS X_APICHK");
			break;

		case 11:
			ver2("XBIOS X_MTDEFS ");
			break;

		default:
			fail("invalid function: XBIOS %d", fun);
		}
	}
}

void cpu_init(void)
{
	cpu_mutex = SDL_CreateMutex();

	if (cpu_mutex == NULL) {
		fail("SDL_CreateMutex() failed: %s", SDL_GetError());
	}

	freq = SDL_GetPerformanceFrequency();
	quan = freq / PER_SEC;

	inf("freq %" PRIu64 " quan %" PRIu64, freq, quan);

	hw_init();
	bios_init();
	midas_init();

	m68k_init();
	m68k_set_cpu_type(M68K_CPU_TYPE_68000);
	m68k_set_instr_hook_callback(inst_cb);
	m68k_pulse_reset();
}

void cpu_quit(void)
{
	hw_quit();
	SDL_DestroyMutex(cpu_mutex);
}

void cpu_loop(void)
{
	inf("entering CPU loop");
	int32_t count = 0;

	while (SDL_AtomicGet(&run) != 0) {
		uint64_t until = SDL_GetPerformanceCounter() + quan;

		if (SDL_LockMutex(cpu_mutex) < 0) {
			fail("SDL_LockMutex() failed: %s", SDL_GetError());
		}

		m68k_execute(CPU_FREQ / PER_SEC);
		uint32_t irq = hw_exec();

		if (irq > 0) {
			ver2("irq %u", irq);
		}

		m68k_set_irq(irq);

		if (SDL_UnlockMutex(cpu_mutex) < 0) {
			fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
		}

		if ((++count & 0x1ff) == 0) {
			SDL_Delay(0);
		}

		while (SDL_GetPerformanceCounter() < until) {
			for (int32_t i = 0; i < 100; ++i) {
				_mm_pause();
			}
		}
	}

	inf("leaving CPU loop");
}
