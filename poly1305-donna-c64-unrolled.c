#include "poly1305-defines.h"

void
poly1305_donna_c64_unrolled_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	uint64_t t0,t1;
	uint64_t h0,h1,h2;
	uint64_t r0,r1,r2;
	uint64_t f0,f1,f2,f3,f4;
	uint64_t g0,g1,g2,g3,g4,c;
	uint64_t s1,s2;
	uint64_t j;
	uint128_t d[3];
	unsigned char mp[16];

	/* clamp key */
	t0 = U8TO64_LE(&key[0]);
	t1 = U8TO64_LE(&key[8]);
	
	r0 = t0 & 0xffc0fffffff; t0 >>= 44; t0 |= t1 << 20;
	r1 = t0 & 0xfffffc0ffff; t1 >>= 24; 
	r2 = t1 & 0x00ffffffc0f;

	s1 = r1 * (5 << 2);
	s2 = r2 * (5 << 2);

	/* sum */
	h0 = 0;
	h1 = 0;
	h2 = 0;
	
	/* full blocks */
	if (inlen < 16) goto poly1305_donna_atmost15bytes;
poly1305_donna_16bytes:
	m += 16;
	inlen -= 16;

	t0 = U8TO64_LE(m-16);
	t1 = U8TO64_LE(m-8);
	h0 += t0 & 0xfffffffffff; 
	h1 += (uint64_t)((((uint128_t)t1 << 64) | t0) >> 44) & 0xfffffffffff; 
	h2 += (t1 >> 24) | (1ull << 40);

poly1305_donna_mul:
	d[0] = ((uint128_t)h0 * r0) + ((uint128_t)h1 * s2) + ((uint128_t)h2 * s1);
	d[1] = ((uint128_t)h0 * r1) + ((uint128_t)h1 * r0) + ((uint128_t)h2 * s2);
	d[2] = ((uint128_t)h0 * r2) + ((uint128_t)h1 * r1) + ((uint128_t)h2 * r0);

	               h0 = (uint64_t)d[0] & 0xfffffffffff; c = (uint64_t)(d[0] >> 44);
	d[1] +=     c; h1 = (uint64_t)d[1] & 0xfffffffffff; c = (uint64_t)(d[1] >> 44);
	d[2] +=     c; h2 = (uint64_t)d[2] & 0x3ffffffffff; c = (uint64_t)(d[2] >> 42);
	h0   += c * 5;  c = (h0 >> 44); h0 &= 0xfffffffffff;
	h1   += c;

	if (inlen >= 16) goto poly1305_donna_16bytes;

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
	h1 += (uint64_t)((((uint128_t)t1 << 64) | t0) >> 44) & 0xfffffffffff; 
	h2 += (t1 >> 24);

	goto poly1305_donna_mul;

poly1305_donna_finish:
	c = h0;
	f0 = c & 0xffffffff; c >>= 32; c |= h1 << 12;
	f1 = c & 0xffffffff; c >>= 32; c |= h2 << 24;
	f2 = c & 0xffffffff; c >>= 32;
	f3 = c & 0xffffffff; c >>= 32;
	f4 = h2 >> 40;

	g0 = f0 + 5; c = g0 >> 32; g0 &= 0xffffffff;
	g1 = f1 + c; c = g1 >> 32; g1 &= 0xffffffff;
	g2 = f2 + c; c = g2 >> 32; g2 &= 0xffffffff;
	g3 = f3 + c; c = g3 >> 32; g3 &= 0xffffffff;
	g4 = f4 + c - 4;

	c = (uint64_t)((int64_t)g4 >> 63);
	f0 &= c; g0 &= ~c; f0 |= g0; f0 += U8TO32_LE(&key[16]);
	f1 &= c; g1 &= ~c; f1 |= g1; f1 += U8TO32_LE(&key[20]);
	f2 &= c; g2 &= ~c; f2 |= g2; f2 += U8TO32_LE(&key[24]);
	f3 &= c; g3 &= ~c; f3 |= g3; f3 += U8TO32_LE(&key[28]);

	U32TO8_LE(&out[ 0], (uint32_t)f0); f1 += (f0 >> 32);
	U32TO8_LE(&out[ 4], (uint32_t)f1); f2 += (f1 >> 32);
	U32TO8_LE(&out[ 8], (uint32_t)f2); f3 += (f2 >> 32);
	U32TO8_LE(&out[12], (uint32_t)f3);
}
