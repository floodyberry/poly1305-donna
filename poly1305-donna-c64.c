#include "poly1305-defines.h"

static DONNA_INLINE void
poly1305_donna_c64_sum(uint64_t out[3], const uint64_t in[2]) {
	out[0] += in[0];
	out[1] += in[1];
	out[2] += in[2];
}

static DONNA_INLINE void
poly1305_donna_c64_mul(uint64_t out[3], const uint64_t in[3]) {
	uint64_t r0,r1,r2,s0,s1,s2,t1,t2,c;
	uint128_t t[3];

	r0 = out[0];
	r1 = out[1];
	r2 = out[2];

	s0 = in[0];
	s1 = in[1];
	s2 = in[2];

	t1 = s1 * (5 << 2);
	t2 = s2 * (5 << 2);

	t[0] = ((uint128_t)r0 * s0) + ((uint128_t)r1 * t2) + ((uint128_t)r2 * t1);
	t[1] = ((uint128_t)r0 * s1) + ((uint128_t)r1 * s0) + ((uint128_t)r2 * t2);
	t[2] = ((uint128_t)r0 * s2) + ((uint128_t)r1 * s1) + ((uint128_t)r2 * s0);

	               r0 = (uint64_t)t[0] & 0xfffffffffff; c = (uint64_t)(t[0] >> 44);
	t[1] +=     c; r1 = (uint64_t)t[1] & 0xfffffffffff; c = (uint64_t)(t[1] >> 44); 
	t[2] +=     c; r2 = (uint64_t)t[2] & 0x3ffffffffff; c = (uint64_t)(t[2] >> 42);
	r0   += c * 5;  c = (r0 >> 44); r0 &= 0xfffffffffff;
	r1   += c;

	out[0] = r0;
	out[1] = r1;
	out[2] = r2;
}

static DONNA_INLINE void
poly1305_donna_c64_expand(uint64_t out[3], const unsigned char buf[16]) {
	uint64_t t0,t1;
	
	t0 = U8TO64_LE(buf+0);
	t1 = U8TO64_LE(buf+8);

	out[0] = t0 & 0xfffffffffff; 
	out[1] = (uint64_t)((((uint128_t)t1 << 64) | t0) >> 44) & 0xfffffffffff; 
	out[2] = (t1 >> 24);
}

static void
poly1305_donna_c64_contract(unsigned char buf[16], const uint64_t in[3], const unsigned char s[16]) {
	uint64_t f0,f1,f2,f3,f4;
	uint64_t g0,g1,g2,g3,g4,c;

	c = in[0]; // 44
	f0 = c & 0xffffffff; c >>= 32; c |= in[1] << 12; // (44 - 32) = 12 + 44 = 56
	f1 = c & 0xffffffff; c >>= 32; c |= in[2] << 24; // (56 - 32) = 24 + 40 = 64
	f2 = c & 0xffffffff; c >>= 32;                   // (64 - 32) = 32
	f3 = c & 0xffffffff; c >>= 32;                   // (34 - 32) = 2
	f4 = in[2] >> 40;                                //

	g0 = f0 + 5; c = g0 >> 32; g0 &= 0xffffffff;
	g1 = f1 + c; c = g1 >> 32; g1 &= 0xffffffff;
	g2 = f2 + c; c = g2 >> 32; g2 &= 0xffffffff;
	g3 = f3 + c; c = g3 >> 32; g3 &= 0xffffffff;
	g4 = f4 + c - 4;

	c = (uint64_t)((int64_t)g4 >> 63);
	f0 &= c; g0 &= ~c; f0 |= g0; f0 += U8TO32_LE(&s[ 0]);
	f1 &= c; g1 &= ~c; f1 |= g1; f1 += U8TO32_LE(&s[ 4]);
	f2 &= c; g2 &= ~c; f2 |= g2; f2 += U8TO32_LE(&s[ 8]);
	f3 &= c; g3 &= ~c; f3 |= g3; f3 += U8TO32_LE(&s[12]);

	U32TO8_LE(&buf[ 0], (uint32_t)f0); f1 += (f0 >> 32);
	U32TO8_LE(&buf[ 4], (uint32_t)f1); f2 += (f1 >> 32);
	U32TO8_LE(&buf[ 8], (uint32_t)f2); f3 += (f2 >> 32);
	U32TO8_LE(&buf[12], (uint32_t)f3);
}

void
poly1305_donna_c64_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	uint64_t h[3] = {0}, r[3], p[3], j;
	unsigned char mp[16];

	/* clamp key */
	poly1305_donna_c64_expand(r, key);
	r[0] &= 0x00000ffc0fffffff;
	r[1] &= 0x00000fffffc0ffff;
	r[2] &= 0x0000000ffffffc0f;
	
	/* full blocks */
	while (inlen >= 16) {
		poly1305_donna_c64_expand(p, m);
		p[2] |= (1ull << 40);
		poly1305_donna_c64_sum(h, p);
		poly1305_donna_c64_mul(h, r);
		m += 16;
		inlen -= 16;
	}

	/* partial block */
	if (inlen) {
		for (j = 0; j < inlen; j++)
			mp[j] = m[j];
		mp[j++] = 1;
		for (; j < 16; j++)
			mp[j] = 0;
		poly1305_donna_c64_expand(p, mp);
		poly1305_donna_c64_sum(h, p);
		poly1305_donna_c64_mul(h, r);
	}

	poly1305_donna_c64_contract(out, h, &key[16]);
}
