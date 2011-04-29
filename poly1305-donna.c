#include "poly1305-defines.h"

static void
poly1305_donna_sum(uint32_t out[5], const uint32_t in[5]) {
	out[0] += in[0];
	out[1] += in[1];
	out[2] += in[2];
	out[3] += in[3];
	out[4] += in[4];
}

static void 
poly1305_donna_mul(uint32_t out[5], const uint32_t in[5]) {
	uint32_t r0,r1,r2,r3,r4,s0,s1,s2,s3,s4,c;
	uint64_t t[5];

	r0 = out[0];
	r1 = out[1];
	r2 = out[2];
	r3 = out[3];
	r4 = out[4];

	s0 = in[0];
	s1 = in[1];
	s2 = in[2];
	s3 = in[3];
	s4 = in[4];

	t[0]  = mul32x32_64(r0,s0);
	t[1]  = mul32x32_64(r0,s1) + mul32x32_64(r1,s0);
	t[2]  = mul32x32_64(r0,s2) + mul32x32_64(r2,s0) + mul32x32_64(r1,s1);
	t[3]  = mul32x32_64(r0,s3) + mul32x32_64(r3,s0) + mul32x32_64(r1,s2) + mul32x32_64(r2,s1);
	t[4]  = mul32x32_64(r0,s4) + mul32x32_64(r4,s0) + mul32x32_64(r3,s1) + mul32x32_64(r1,s3) + mul32x32_64(r2,s2);

	r1 *= 5;
	r2 *= 5;
	r3 *= 5;
	r4 *= 5;

	t[0] += mul32x32_64(r4,s1) + mul32x32_64(r1,s4) + mul32x32_64(r2,s3) + mul32x32_64(r3,s2);
	t[1] += mul32x32_64(r4,s2) + mul32x32_64(r2,s4) + mul32x32_64(r3,s3);
	t[2] += mul32x32_64(r4,s3) + mul32x32_64(r3,s4);
	t[3] += mul32x32_64(r4,s4);

	                r0 = (uint32_t)t[0] & 0x3ffffff; c = (uint32_t)(t[0] >> 26);
	t[1] += c;      r1 = (uint32_t)t[1] & 0x3ffffff; c = (uint32_t)(t[1] >> 26);
	t[2] += c;      r2 = (uint32_t)t[2] & 0x3ffffff; c = (uint32_t)(t[2] >> 26);
	t[3] += c;      r3 = (uint32_t)t[3] & 0x3ffffff; c = (uint32_t)(t[3] >> 26);
	t[4] += c;      r4 = (uint32_t)t[4] & 0x3ffffff; c = (uint32_t)(t[4] >> 26);
	r0 +=   c * 5; c = r0 >> 26; r0 = r0 & 0x3ffffff;
	r1 +=   c;     c = r1 >> 26; r1 = r1 & 0x3ffffff;
	r2 +=   c;

	out[0] = r0;
	out[1] = r1;
	out[2] = r2;
	out[3] = r3;
	out[4] = r4;
}

static void
poly1305_donna_expand(uint32_t out[5], const unsigned char buf[16]) {
	uint32_t t0,t1,t2,t3;

	t0 = U8TO32_LE(buf+0);
	t1 = U8TO32_LE(buf+4);
	t2 = U8TO32_LE(buf+8);
	t3 = U8TO32_LE(buf+12);

	out[0] = t0 & 0x3ffffff; t0 >>= 26; t0 |= t1 << 6;
	out[1] = t0 & 0x3ffffff; t1 >>= 20; t1 |= t2 << 12;
	out[2] = t1 & 0x3ffffff; t2 >>= 14; t2 |= t3 << 18;
	out[3] = t2 & 0x3ffffff; t3 >>= 8;
	out[4] = t3;
}

static void
poly1305_donna_contract(unsigned char buf[16], const uint32_t in[5], const unsigned char s[16]) {
	uint64_t f0,f1,f2,f3,f4;
	uint64_t g0,g1,g2,g3,g4,c;

	f0 = (in[0]      ) | (in[1] << 26);
	f1 = (in[1] >>  6) | (in[2] << 20);
	f2 = (in[2] >> 12) | (in[3] << 14);
	f3 = (in[3] >> 18) | (in[4] <<  8);
	f4 = (in[4] >> 24);

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

	U32TO8_LE(&buf[ 0], f0); f1 += (f0 >> 32);
	U32TO8_LE(&buf[ 4], f1); f2 += (f1 >> 32);
	U32TO8_LE(&buf[ 8], f2); f3 += (f2 >> 32);
	U32TO8_LE(&buf[12], f3);
}


void
poly1305_donna_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	uint32_t h[5] = {0}, r[5], p[5], j;
	unsigned char mp[16];

	/* clamp key */
	poly1305_donna_expand(r, key);
	r[1] &= 0x3ffff03;
	r[2] &= 0x3ffc0ff;
	r[3] &= 0x3f03fff;
	r[4] &= 0x00fffff;
	
	/* full blocks */
	while (inlen >= 16) {
		poly1305_donna_expand(p, m);
		p[4] |= (1 << 24);
		poly1305_donna_sum(h, p);
		poly1305_donna_mul(h, r);
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
		poly1305_donna_expand(p, mp);
		poly1305_donna_sum(h, p);
		poly1305_donna_mul(h, r);
	}

	poly1305_donna_contract(out, h, &key[16]);
}
