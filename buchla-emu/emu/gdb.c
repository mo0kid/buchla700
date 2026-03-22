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

#define ver(...) _ver(gdb_verbose, 0, __VA_ARGS__)
#define ver2(...) _ver(gdb_verbose, 1, __VA_ARGS__)
#define ver3(...) _ver(gdb_verbose, 2, __VA_ARGS__)

int32_t gdb_verbose = 0;

#define PORT 12053
#define SZ_BUF 10000

#define RES_ERR \
	((result_t){ .ok = false })

#define RES_OK \
	((result_t){ .ok = true })

#define RES_DAT(_out, _n_out) \
	((result_t){ .ok = true, .out = (uint8_t *)_out, .n_out = (int32_t)_n_out })

#define LOCK_NONE 0
#define LOCK_REQ 1
#define LOCK_ACK 2
#define LOCK_BP 3

typedef enum {
	STATE_HEAD,
	STATE_DATA,
	STATE_CHECK_1,
	STATE_CHECK_2,
	STATE_ACK
} state_t;

typedef struct {
	bool ok;
	const uint8_t *out;
	int32_t n_out;
} result_t;

static TCPsocket lis;
static SDLNet_SocketSet set;

static state_t state;
static SDL_atomic_t lock;

void gdb_init(void)
{
	ver("gdb init");

	IPaddress addr;

	if (SDLNet_ResolveHost(&addr, NULL, PORT) < 0) {
		fail("SDLNet_ResolveHost() failed: %s", SDLNet_GetError());
	}

	lis = SDLNet_TCP_Open(&addr);

	if (lis == NULL) {
		fail("SDLNet_TCP_Open() failed: %s", SDLNet_GetError());
	}

	set = SDLNet_AllocSocketSet(2);

	if (set == NULL) {
		fail("SDLNet_AllocSocketSet() failed: %s", SDLNet_GetError());
	}

	if (SDLNet_TCP_AddSocket(set, lis) < 0) {
		fail("SDLNet_AddSocket() failed: %s", SDLNet_GetError());
	}

	SDL_AtomicSet(&lock, 0);
}

void gdb_quit(void)
{
	ver("gdb quit");

	SDLNet_FreeSocketSet(set);
	SDLNet_TCP_Close(lis);
}

void gdb_inst(bool bp)
{
	ver3("gdb inst");

	if (!bp && SDL_AtomicGet(&lock) == LOCK_NONE) {
		return;
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	if (bp) {
		ver2("-> lock bp");
		SDL_AtomicSet(&lock, LOCK_BP);

		while (SDL_AtomicGet(&lock) != LOCK_REQ) {
			SDL_Delay(100);
		}
	}

	ver2("<- lock req");
	ver2("-> lock ack");
	SDL_AtomicSet(&lock, LOCK_ACK);

	while (SDL_AtomicGet(&lock) == LOCK_ACK) {
		SDL_Delay(100);
	}

	ver2("<- lock none / req");

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}
}

static void wait_cpu(void)
{
	while (SDL_AtomicGet(&lock) != LOCK_ACK) {
		SDL_Delay(100);
	}

	ver2("<- lock ack");
}

static void stop_cpu(void)
{
	ver2("-> lock req");
	SDL_AtomicSet(&lock, LOCK_REQ);

	wait_cpu();
}

static void cont_cpu(void)
{
	ver2("-> lock none");
	SDL_AtomicSet(&lock, LOCK_NONE);
}

static int32_t hex_digit(char c)
{
	if (c >= '0' && c <= '9') {
		return c - '0';
	}

	if (c >= 'a' && c <= 'f') {
		return 10 + c - 'a';
	}

	if (c >= 'A' && c <= 'F') {
		return 10 + c - 'A';
	}

	return -1;
}

static int32_t hex_num(const char **pp)
{
	int32_t res = 0;
	int32_t dig;

	while ((dig = hex_digit(**pp)) >= 0) {
		res = (res << 4) | dig;
		++*pp;
	}

	return res;
}

static result_t com_reason(void)
{
	// 0x05 = SIGTRAP
	return RES_DAT("S05", 3);
}

static void set_pc(const char **req)
{
	int32_t addr = hex_num(req);

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	m68k_set_reg(M68K_REG_PC, (uint32_t)addr);

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}
}

static result_t com_cont(const char *req)
{
	if (req[0] != 0) {
		set_pc(&req);
	}

	cont_cpu();

	return RES_OK;
}

static result_t com_step(const char *req)
{
	if (req[0] != 0) {
		set_pc(&req);
	}

	stop_cpu();

	// 0x05 = SIGTRAP
	return RES_DAT("S05", 3);
}

static result_t com_rd_reg(void)
{
	static char buf[(8 + 8 + 2) * 8 + 1];

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	uint32_t d0 = m68k_get_reg(NULL, M68K_REG_D0);
	uint32_t d1 = m68k_get_reg(NULL, M68K_REG_D1);
	uint32_t d2 = m68k_get_reg(NULL, M68K_REG_D2);
	uint32_t d3 = m68k_get_reg(NULL, M68K_REG_D3);
	uint32_t d4 = m68k_get_reg(NULL, M68K_REG_D4);
	uint32_t d5 = m68k_get_reg(NULL, M68K_REG_D5);
	uint32_t d6 = m68k_get_reg(NULL, M68K_REG_D6);
	uint32_t d7 = m68k_get_reg(NULL, M68K_REG_D7);

	uint32_t a0 = m68k_get_reg(NULL, M68K_REG_A0);
	uint32_t a1 = m68k_get_reg(NULL, M68K_REG_A1);
	uint32_t a2 = m68k_get_reg(NULL, M68K_REG_A2);
	uint32_t a3 = m68k_get_reg(NULL, M68K_REG_A3);
	uint32_t a4 = m68k_get_reg(NULL, M68K_REG_A4);
	uint32_t a5 = m68k_get_reg(NULL, M68K_REG_A5);
	uint32_t a6 = m68k_get_reg(NULL, M68K_REG_A6);
	uint32_t a7 = m68k_get_reg(NULL, M68K_REG_A7);

	uint32_t ps = m68k_get_reg(NULL, M68K_REG_SR);
	uint32_t pc = m68k_get_reg(NULL, M68K_REG_PC);

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	sprintf(buf,
			"%08x%08x%08x%08x%08x%08x%08x%08x"
			"%08x%08x%08x%08x%08x%08x%08x%08x"
			"%08x%08x",
			d0, d1, d2, d3, d4, d5, d6, d7,
			a0, a1, a2, a3, a4, a5, a6, a7,
			ps, pc);

	return RES_DAT(buf, sizeof buf - 1);
}

static result_t com_wr_reg(const char *req)
{
	uint32_t d0, d1, d2, d3, d4, d5, d6, d7;
	uint32_t a0, a1, a2, a3, a4, a5, a6, a7;
	uint32_t ps, pc;

	if (sscanf(req,
			"%08x%08x%08x%08x%08x%08x%08x%08x"
			"%08x%08x%08x%08x%08x%08x%08x%08x"
			"%08x%08x",
			&d0, &d1, &d2, &d3, &d4, &d5, &d6, &d7,
			&a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7,
			&ps, &pc) != 8 + 8 + 2) {
		return RES_DAT("E01", 3);
	}

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	m68k_set_reg(M68K_REG_D0, d0);
	m68k_set_reg(M68K_REG_D1, d1);
	m68k_set_reg(M68K_REG_D2, d2);
	m68k_set_reg(M68K_REG_D3, d3);
	m68k_set_reg(M68K_REG_D4, d4);
	m68k_set_reg(M68K_REG_D5, d5);
	m68k_set_reg(M68K_REG_D6, d6);
	m68k_set_reg(M68K_REG_D7, d7);

	m68k_set_reg(M68K_REG_A0, a0);
	m68k_set_reg(M68K_REG_A1, a1);
	m68k_set_reg(M68K_REG_A2, a2);
	m68k_set_reg(M68K_REG_A3, a3);
	m68k_set_reg(M68K_REG_A4, a4);
	m68k_set_reg(M68K_REG_A5, a5);
	m68k_set_reg(M68K_REG_A6, a6);
	m68k_set_reg(M68K_REG_A7, a7);

	m68k_set_reg(M68K_REG_SR, ps);
	m68k_set_reg(M68K_REG_PC, pc);

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	return RES_DAT("OK", 2);
}

static result_t com_rd_mem(const char *req)
{
	int32_t addr = hex_num(&req);

	if (*req++ != ',') {
		return RES_DAT("E01", 3);
	}

	int32_t len = hex_num(&req);

	if (*req != 0 || len == 0) {
		return RES_DAT("E01", 3);
	}

	if (len > 10000) {
		len = 10000;
	}

	static char buf[10000 * 2 + 1];

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	for (int32_t i = 0; i < len; ++i) {
		uint8_t byte = cpu_peek(addr + i);
		sprintf(buf + i * 2, "%02x", byte);
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	return RES_DAT(buf, len * 2);
}

static result_t com_wr_mem(const char *req)
{
	int32_t addr = hex_num(&req);

	if (*req++ != ',') {
		return RES_DAT("E01", 3);
	}

	int32_t len = hex_num(&req);

	if (*req++ != ':') {
		return RES_DAT("E01", 3);
	}

	if (SDL_LockMutex(cpu_mutex) < 0) {
		fail("SDL_LockMutex() failed: %s", SDL_GetError());
	}

	int32_t i;

	for (i = 0; i < len; ++i) {
		int32_t hi = hex_digit(*req++);

		if (hi < 0) {
			break;
		}

		int32_t lo = hex_digit(*req++);

		if (lo < 0) {
			break;
		}

		cpu_poke(addr + i, (uint8_t)((hi << 4) | lo));
	}

	if (SDL_UnlockMutex(cpu_mutex) < 0) {
		fail("SDL_UnlockMutex() failed: %s", SDL_GetError());
	}

	return RES_DAT("OK", 2);
}

static result_t handle(const char *req)
{
	result_t res;

	switch (req[0]) {
	case '?':
		res = com_reason();
		break;

	case 'c':
		res = com_cont(req + 1);
		break;

	case 'C':
		res = com_cont(req + 4);
		break;

	case 's':
		res = com_step(req + 1);
		break;

	case 'S':
		res = com_step(req + 4);
		break;

	case 'g':
		res = com_rd_reg();
		break;

	case 'G':
		res = com_wr_reg(req + 1);
		break;

	case 'm':
		res = com_rd_mem(req + 1);
		break;

	case 'M':
		res = com_wr_mem(req + 1);
		break;

	default:
		res = RES_DAT("", 0);
		break;
	}

	if (!res.ok || res.n_out > SZ_BUF - 5) {
		fail("unexpected result");
	}

	if (res.out == NULL) {
		return RES_OK;
	}

	static const uint8_t *hex = (uint8_t *)"0123456789abcdef";
	static uint8_t buf[SZ_BUF];

	buf[0] = '$';
	memcpy(buf + 1, res.out, (size_t)res.n_out);

	int32_t sum = 0;

	for (int32_t i = 0; i < res.n_out; ++i) {
		sum = (sum + res.out[i]) % 256;
	}

	buf[res.n_out + 1] = '#';
	buf[res.n_out + 2] = hex[sum / 16];
	buf[res.n_out + 3] = hex[sum % 16];
	buf[res.n_out + 4] = 0;

	ver2("resp %s", (char *)buf);
	return RES_DAT(buf, res.n_out + 4);
}

static result_t input(uint8_t byte)
{
	static int32_t n_buf;
	static uint8_t buf[SZ_BUF];
	static int32_t sum;
	static int32_t check;

	int32_t hex;
	result_t res;

	ver3("input %c st %d n %d", byte, (int32_t)state, n_buf);

	if (state == STATE_HEAD && byte == 0x03) {
		stop_cpu();
		state = STATE_ACK;
		return RES_DAT("$S05#b8", 7);
	}

	switch (state) {
	case STATE_HEAD:
		if (byte != '$') {
			err("expected '$'");
			return RES_ERR;
		}

		sum = 0;
		n_buf = 0;
		state = STATE_DATA;
		return RES_OK;

	case STATE_DATA:
		if (n_buf == SZ_BUF - 1) {
			err("packet too long");
			return RES_ERR;
		}

		if (byte == '#') {
			state = STATE_CHECK_1;
			return RES_DAT("+", 1);
		}

		sum = (sum + byte) % 256;
		buf[n_buf] = byte;
		++n_buf;
		return RES_OK;

	case STATE_CHECK_1:
		hex = hex_digit((char)byte);

		if (hex < 0) {
			err("malformed checksum (0x%02x)", byte);
			return RES_ERR;
		}

		check = hex << 4;
		state = STATE_CHECK_2;
		return RES_OK;

	case STATE_CHECK_2:
		hex = hex_digit((char)byte);

		if (hex < 0) {
			err("malformed checksum (0x%02x)", byte);
			return RES_ERR;
		}

		check |= hex;

		if (sum != check) {
			err("invalid checksum");
			return RES_ERR;
		}

		buf[n_buf] = 0;
		ver2("pack %s", buf);

		res = handle((char *)buf);

		if (!res.ok) {
			return RES_ERR;
		}

		if (res.out == NULL) {
			state = STATE_HEAD;
			return RES_OK;
		}

		state = STATE_ACK;
		return RES_DAT(res.out, res.n_out);

	case STATE_ACK:
		if (byte != '+') {
			err("invalid ACK (0x%02x)", byte);
			return RES_ERR;
		}

		state = STATE_HEAD;
		return RES_OK;

	default:
		fail("invalid state");
	}

	// not reached, but Eclipse doesn't know
	return RES_ERR;
}

static void con_close(TCPsocket con)
{
	if (SDLNet_TCP_DelSocket(set, con) < 0) {
		fail("SDLNet_TCP_DelSocket() failed: %s", SDLNet_GetError());
	}

	SDLNet_TCP_Close(con);
	cont_cpu();
}

void gdb_loop(void)
{
	inf("entering GDB loop");
	TCPsocket con = NULL;

	while (SDL_AtomicGet(&run) != 0) {
		int32_t n_act = SDLNet_CheckSockets(set, 100);

		if (n_act < 0) {
			fail("SDLNet_CheckSockets() failed: %s", SDLNet_GetError());
		}

		if (SDL_AtomicGet(&lock) == LOCK_BP) {
			ver2("<- lock bp");
			stop_cpu();
			state = STATE_ACK;

			if (con == NULL) {
				cont_cpu();
				continue;
			}

			if (SDLNet_TCP_Send(con, "$S05#b8", 7) != 7) {
				err("connection error");
				con_close(con);
				con = NULL;
				continue;
			}

			continue;
		}

		if (n_act == 0) {
			continue;
		}

		if (SDLNet_SocketReady(lis) != 0) {
			ver("incoming connection");

			if (con != NULL) {
				ver("closing old");
				con_close(con);
			}

			ver("accepting new");
			con = SDLNet_TCP_Accept(lis);

			if (con == NULL) {
				fail("SDLNet_TCP_Accept() failed: %s", SDLNet_GetError());
			}

			if (SDLNet_TCP_AddSocket(set, con) < 0) {
				fail("SDLNet_AddSocket() failed: %s", SDLNet_GetError());
			}

			stop_cpu();
			state = STATE_ACK;
			continue;
		}

		if (con == NULL || SDLNet_SocketReady(con) == 0) {
			continue;
		}

		ver3("reading");
		uint8_t byte;

		if (SDLNet_TCP_Recv(con, &byte, 1) < 1) {
			ver("peer closed");
			con_close(con);
			con = NULL;
			continue;
		}

		result_t res = input(byte);

		if (!res.ok) {
			err("invalid packet from GDB");
			con_close(con);
			con = NULL;
			continue;
		}

		if (res.out == NULL) {
			continue;
		}

		if (SDLNet_TCP_Send(con, res.out, res.n_out) != res.n_out) {
			err("connection error");
			con_close(con);
			con = NULL;
			continue;
		}
	}

	if (con != NULL) {
		con_close(con);
	}

	inf("leaving GDB loop");
}
