#include "poly1305-defines.h"

void
poly1305_donna_unrolled_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	uint32_t t0,t1,t2,t3;
	uint32_t h0,h1,h2,h3,h4;
	uint32_t r0,r1,r2,r3,r4;
	uint32_t s1,s2,s3,s4;
	uint32_t j;
	uint64_t t[5];
	uint64_t f0,f1,f2,f3,f4;
	uint64_t g0,g1,g2,g3,g4,c;
	unsigned char mp[16];

	/* clamp key */
	t0 = U8TO32_LE(key+0);
	t1 = U8TO32_LE(key+4);
	t2 = U8TO32_LE(key+8);
	t3 = U8TO32_LE(key+12);

	r0 = t0 & 0x3ffffff; t0 >>= 26; t0 |= t1 << 6;
	r1 = t0 & 0x3ffff03; t1 >>= 20; t1 |= t2 << 12;
	r2 = t1 & 0x3ffc0ff; t2 >>= 14; t2 |= t3 << 18;
	r3 = t2 & 0x3f03fff; t3 >>= 8;
	r4 = t3 & 0x00fffff;

	s1 = r1 * 5;
	s2 = r2 * 5;
	s3 = r3 * 5;
	s4 = r4 * 5;

	h0 = 0;
	h1 = 0;
	h2 = 0;
	h3 = 0;
	h4 = 0;

	/* full blocks */
	if (inlen < 16) goto poly1305_donna_atmost15bytes;
poly1305_donna_16bytes:
	m += 16;
	inlen -= 16;

	t0 = U8TO32_LE(m-16);
	t1 = U8TO32_LE(m-12);
	t2 = U8TO32_LE(m-8);
	t3 = U8TO32_LE(m-4);

	h0 += t0 & 0x3ffffff;
	h1 += ((((uint64_t)t1 << 32) | t0) >> 26) & 0x3ffffff;
	h2 += ((((uint64_t)t2 << 32) | t1) >> 20) & 0x3ffffff;
	h3 += ((((uint64_t)t3 << 32) | t2) >> 14) & 0x3ffffff;
	h4 += (t3 >> 8) | (1 << 24);


poly1305_donna_mul:
	t[0]  = mul32x32_64(h0,r0);
	t[1]  = mul32x32_64(h0,r1) + mul32x32_64(h1,r0);
	t[2]  = mul32x32_64(h0,r2) + mul32x32_64(h2,r0) + mul32x32_64(h1,r1);
	t[3]  = mul32x32_64(h0,r3) + mul32x32_64(h3,r0) + mul32x32_64(h1,r2) + mul32x32_64(h2,r1);
	t[4]  = mul32x32_64(h0,r4) + mul32x32_64(h4,r0) + mul32x32_64(h3,r1) + mul32x32_64(h1,r3) + mul32x32_64(h2,r2);

	t[0] += mul32x32_64(h4,s1) + mul32x32_64(h1,s4) + mul32x32_64(h2,s3) + mul32x32_64(h3,s2);
	t[1] += mul32x32_64(h4,s2) + mul32x32_64(h2,s4) + mul32x32_64(h3,s3);
	t[2] += mul32x32_64(h4,s3) + mul32x32_64(h3,s4);
	t[3] += mul32x32_64(h4,s4);

	                h0 = (uint32_t)t[0] & 0x3ffffff; c = (uint32_t)(t[0] >> 26);
	t[1] += c;      h1 = (uint32_t)t[1] & 0x3ffffff; c = (uint32_t)(t[1] >> 26);
	t[2] += c;      h2 = (uint32_t)t[2] & 0x3ffffff; c = (uint32_t)(t[2] >> 26);
	t[3] += c;      h3 = (uint32_t)t[3] & 0x3ffffff; c = (uint32_t)(t[3] >> 26);
	t[4] += c;      h4 = (uint32_t)t[4] & 0x3ffffff; c = (uint32_t)(t[4] >> 26);
	h0 +=   c * 5; c = h0 >> 26; h0 = h0 & 0x3ffffff;
	h1 +=   c;     c = h1 >> 26; h1 = h1 & 0x3ffffff;
	h2 +=   c;

	if (inlen >= 16) goto poly1305_donna_16bytes;

	/* partial block */
poly1305_donna_atmost15bytes:
	if (!inlen) goto poly1305_donna_finish;

	for (j = 0; j < inlen; j++) mp[j] = m[j];
	mp[j++] = 1;
	for (; j < 16; j++)	mp[j] = 0;
	inlen = 0;

	t0 = U8TO32_LE(mp+0);
	t1 = U8TO32_LE(mp+4);
	t2 = U8TO32_LE(mp+8);
	t3 = U8TO32_LE(mp+12);

	h0 += t0 & 0x3ffffff; t0 >>= 26; t0 |= t1 << 6;
	h1 += t0 & 0x3ffffff; t1 >>= 20; t1 |= t2 << 12;
	h2 += t1 & 0x3ffffff; t2 >>= 14; t2 |= t3 << 18;
	h3 += t2 & 0x3ffffff; t3 >>= 8;
	h4 += t3;
	
	goto poly1305_donna_mul;

poly1305_donna_finish:
	f0 = (h0      ) | (h1 << 26);
	f1 = (h1 >>  6) | (h2 << 20);
	f2 = (h2 >> 12) | (h3 << 14);
	f3 = (h3 >> 18) | (h4 <<  8);
	f4 = (h4 >> 24);

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

	U32TO8_LE(&out[ 0], f0); f1 += (f0 >> 32);
	U32TO8_LE(&out[ 4], f1); f2 += (f1 >> 32);
	U32TO8_LE(&out[ 8], f2); f3 += (f2 >> 32);
	U32TO8_LE(&out[12], f3);
}
