#include "portable-jane.h"

void
poly1305_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	uint64_t t0,t1;
	uint64_t h0,h1,h2;
	uint64_t r0,r1,r2;
	uint64_t g0,g1,g2,c,nc;
	uint64_t s1,s2;
	size_t j;
	uint128_t d[3];
	unsigned char mp[16];

	/* clamp key */
	t0 = U8TO64_LE(&key[0]);
	t1 = U8TO64_LE(&key[8]);

	/* pre-compute multipliers */
	r0 = t0 & 0xffc0fffffff; t0 >>= 44; t0 |= t1 << 20;
	r1 = t0 & 0xfffffc0ffff; t1 >>= 24;
	r2 = t1 & 0x00ffffffc0f;

	s1 = r1 * (5 << 2);
	s2 = r2 * (5 << 2);

	/* state */
	h0 = 0;
	h1 = 0;
	h2 = 0;

	/* full blocks */
	if (inlen < 16) goto poly1305_donna_atmost15bytes;
	if (inlen < 64) goto poly1305_donna_atmost63bytes;

	/* macros */
	#define multiply_by_r_and_partial_reduce() \
		d[0] = add128(add128(mul64x64_128(h0, r0), mul64x64_128(h1, s2)), mul64x64_128(h2, s1)); \
		d[1] = add128(add128(mul64x64_128(h0, r1), mul64x64_128(h1, r0)), mul64x64_128(h2, s2)); \
		d[2] = add128(add128(mul64x64_128(h0, r2), mul64x64_128(h1, r1)), mul64x64_128(h2, r0)); \
		                           h0 = lo128(d[0]) & 0xfffffffffff; c = shr128(d[0], 44); \
		d[1] = add128_64(d[1], c); h1 = lo128(d[1]) & 0xfffffffffff; c = shr128(d[1], 44); \
		d[2] = add128_64(d[2], c); h2 = lo128(d[2]) & 0x3ffffffffff; c = shr128(d[2], 42); \
		h0   += c * 5;  

	#define do_block(offset) \
		/* h += ((1 << 128) + m) */             \
		t0 = U8TO64_LE(m+offset);               \
		t1 = U8TO64_LE(m+offset+8);             \
		h0 += t0 & 0xfffffffffff;               \
		t0 = shr128_pair(t1, t0, 44);           \
		h1 += t0 & 0xfffffffffff;               \
		h2 += (t1 >> 24) | ((uint64_t)1 << 40); \
		/* h = (h * r) % ((1 << 130) - 5) */    \
		multiply_by_r_and_partial_reduce()

/* 4 blocks */
poly1305_donna_64bytes:
	do_block(0)
	do_block(16)
	do_block(32)
	do_block(48)

	m += 64;
	inlen -= 64;

	if (inlen >= 64) goto poly1305_donna_64bytes;
	if (inlen < 16) goto poly1305_donna_atmost15bytes;

/* 1 block */
poly1305_donna_atmost63bytes:
	do_block(0)
	m += 16;
	inlen -= 16;

	if (inlen >= 16) goto poly1305_donna_atmost63bytes;

/* partial block */
poly1305_donna_atmost15bytes:
	if (!inlen) goto poly1305_donna_finish;

	for (j = 0; j < inlen; j++) mp[j] = m[j];
	mp[j++] = 1;
	for (; j < 16; j++)	mp[j] = 0;
	inlen = 0;

	t0 = U8TO64_LE(mp+0);
	t1 = U8TO64_LE(mp+8);
	h0 += t0 & 0xfffffffffff;
	t0 = shr128_pair(t1, t0, 44);
	h1 += t0 & 0xfffffffffff;
	h2 += (t1 >> 24);

	multiply_by_r_and_partial_reduce()

/* finish */
poly1305_donna_finish:
	             c = (h0 >> 44); h0 &= 0xfffffffffff;
	h1 += c;     c = (h1 >> 44); h1 &= 0xfffffffffff;
	h2 += c;     c = (h2 >> 42); h2 &= 0x3ffffffffff;
	h0 += c * 5; 

	g0 = h0 + 5; c = (g0 >> 44); g0 &= 0xfffffffffff;
	g1 = h1 + c; c = (g1 >> 44); g1 &= 0xfffffffffff;
	g2 = h2 + c - ((uint64_t)1 << 42);

	c = (g2 >> 63) - 1;
	nc = ~c;
	h0 = (h0 & nc) | (g0 & c);
	h1 = (h1 & nc) | (g1 & c);
	h2 = (h2 & nc) | (g2 & c);

	t0 = U8TO64_LE(key+16);
	t1 = U8TO64_LE(key+24);
	h0 += (t0 & 0xfffffffffff)    ; c = (h0 >> 44); h0 &= 0xfffffffffff;
	t0 = shr128_pair(t1, t0, 44);
	h1 += (t0 & 0xfffffffffff) + c; c = (h1 >> 44); h1 &= 0xfffffffffff;
	h2 += (t1 >> 24          ) + c;

	U64TO8_LE(&out[ 0], ((h0      ) | (h1 << 44)));
	U64TO8_LE(&out[ 8], ((h1 >> 20) | (h2 << 24)));

	#undef multiply_by_r_and_partial_reduce
	#undef do_block
}
