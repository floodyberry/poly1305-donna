/*
	by Andrew Moon

	Implements SIMD vectorization based on the algorithm described in http://cr.yp.to/papers.html#neoncrypto

	Unrolled to 2 powers, i.e. 64 byte block size
*/


#include "portable-jane.h"
#include "poly1305-donna.h"
#include <emmintrin.h>
typedef __m128i xmmi;

static const uint32_t ALIGN(16) poly1305_x64_sse2_message_mask[4] = {(1 << 26) - 1, 0, (1 << 26) - 1, 0};
static const uint32_t ALIGN(16) poly1305_x64_sse2_5[4] = {5, 0, 5, 0};
static const uint32_t ALIGN(16) poly1305_x64_sse2_1shl128[4] = {(1 << 24), 0, (1 << 24), 0};

typedef struct poly1305_power_t {
	union {
		xmmi v;
		uint64_t u[2];
		uint32_t d[4];
	} R20,R21,R22,R23,R24,S21,S22,S23,S24;
} poly1305_power;

typedef struct poly1305_state_internal_t {
	poly1305_power P[2];     /* 288 bytes, top 32 bit halves unused = 144 bytes of free storage */
	union {
		xmmi H[5];           /*       80 bytes  */
		uint32_t HH[20];
	};
	/* uint32_t r0,r1,r2,r3,r4;      [20 bytes] */
	/* uint32_t pad0,pad1,pad2,pad3; [16 bytes] */
	uint32_t started;        /*        4 bytes  */
	uint32_t leftover;       /*        4 bytes  */
	uint8_t buffer[64];      /*       64 bytes  */
} poly1305_state_internal;   /* 448 bytes total + 63 bytes for alignment = 503 bytes raw */

static poly1305_state_internal
*poly1305_aligned_state(poly1305_state *state) {
	return (poly1305_state_internal *)(((size_t)state + 63) & ~63);
}

/* copy 0-63 bytes */
static void
poly1305_block_copy(uint8_t *dst, const uint8_t *src, size_t bytes) {
	size_t offset = 0;
	if (bytes & 32) {
		_mm_storeu_si128((xmmi *)(dst + offset + 0), _mm_loadu_si128((xmmi *)(src + offset + 0)));
		_mm_storeu_si128((xmmi *)(dst + offset + 16), _mm_loadu_si128((xmmi *)(src + offset + 16)));
		offset += 32;
	}
	if (bytes & 16) { _mm_storeu_si128((xmmi *)(dst + offset + 0), _mm_loadu_si128((xmmi *)(src + offset + 0))); offset += 16; }
	if (bytes &  8) { *(uint64_t *)(dst + offset) = *(uint64_t *)(src + offset); offset += 8; }
	if (bytes &  4) { *(uint32_t *)(dst + offset) = *(uint32_t *)(src + offset); offset += 4; }
	if (bytes &  2) { *(uint16_t *)(dst + offset) = *(uint16_t *)(src + offset); offset += 2; }
	if (bytes &  1) { *( uint8_t *)(dst + offset) = *( uint8_t *)(src + offset);              }
}

/* zero 0-15 bytes */
static void
poly1305_block_zero(uint8_t *dst, size_t bytes) {
	if (bytes &  8) { *(uint64_t *)dst = 0; dst += 8; }
	if (bytes &  4) { *(uint32_t *)dst = 0; dst += 4; }
	if (bytes &  2) { *(uint16_t *)dst = 0; dst += 2; }
	if (bytes &  1) { *( uint8_t *)dst = 0; }
}

void
poly1305_init(poly1305_state *state, const unsigned char key[32]) {
	poly1305_state_internal *st = poly1305_aligned_state(state);
	poly1305_power *p;
	uint32_t t0,t1,t2,t3;
	uint32_t r0,r1,r2,r3,r4;

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

	/* store r in un-used space of st->P[1] */
	p = &st->P[1];
	p->R20.d[1] = r0;
	p->R20.d[3] = r1;
	p->R21.d[1] = r2;
	p->R21.d[3] = r3;
	p->R22.d[1] = r4;

	/* store pad */
	p->R23.d[1] = U8TO32_LE(key + 16);
	p->R23.d[3] = U8TO32_LE(key + 20);
	p->R24.d[1] = U8TO32_LE(key + 24);
	p->R24.d[3] = U8TO32_LE(key + 28);

	/* H = 0 */
	st->H[0] = _mm_setzero_si128();
	st->H[1] = _mm_setzero_si128();
	st->H[2] = _mm_setzero_si128();
	st->H[3] = _mm_setzero_si128();
	st->H[4] = _mm_setzero_si128();

	st->started = 0;
	st->leftover = 0;
}

static void
poly1305_first_block(poly1305_state_internal *st, const uint8_t *m) {
	const xmmi MMASK = _mm_load_si128((xmmi *)poly1305_x64_sse2_message_mask);
	const xmmi FIVE = _mm_load_si128((xmmi*)poly1305_x64_sse2_5);
	const xmmi HIBIT = _mm_load_si128((xmmi*)poly1305_x64_sse2_1shl128);
	xmmi T5,T6;
	poly1305_power *p;
	uint64_t t[5];
	uint32_t r0,r1,r2,r3,r4;
	uint32_t r20,r21,r22,r23,r24;
	uint32_t s21,s22,s23,s24;
	uint32_t pad0,pad1,pad2,pad3;
	uint32_t b;
	uint32_t i;

	/* pull out stored info */
	p = &st->P[1];

	r0 = p->R20.d[1];
	r1 = p->R20.d[3];
	r2 = p->R21.d[1];
	r3 = p->R21.d[3];
	r4 = p->R22.d[1];

	pad0 = p->R23.d[1];
	pad1 = p->R23.d[3];
	pad2 = p->R24.d[1];
	pad3 = p->R24.d[3];

	/* compute powers r^2,r^4 */
	r20 = r0;
	r21 = r1;
	r22 = r2;
	r23 = r3;
	r24 = r4;
	for (i = 0; i < 2; i++) {
		s21 = r21 * 5;
		s22 = r22 * 5;
		s23 = r23 * 5;
		s24 = r24 * 5;

		t[0]  = mul32x32_64(r20,r20  ) + mul32x32_64(r22*2,s23) + mul32x32_64(r24*2,s21);
		t[1]  = mul32x32_64(r20,r21*2) + mul32x32_64(r24*2,s22) + mul32x32_64(r23  ,s23);
		t[2]  = mul32x32_64(r21,r21  ) + mul32x32_64(r20*2,r22) + mul32x32_64(r24*2,s23);
		t[3]  = mul32x32_64(r20,r23*2) + mul32x32_64(r21*2,r22) + mul32x32_64(r24  ,s24);
		t[4]  = mul32x32_64(r22,r22  ) + mul32x32_64(r20*2,r24) + mul32x32_64(r23*2,r21);

						r20 = (uint32_t)t[0] & 0x3ffffff; b = (uint32_t)(t[0] >> 26);
		t[1] += b;      r21 = (uint32_t)t[1] & 0x3ffffff; b = (uint32_t)(t[1] >> 26);
		t[2] += b;      r22 = (uint32_t)t[2] & 0x3ffffff; b = (uint32_t)(t[2] >> 26);
		t[3] += b;      r23 = (uint32_t)t[3] & 0x3ffffff; b = (uint32_t)(t[3] >> 26);
		t[4] += b;      r24 = (uint32_t)t[4] & 0x3ffffff; b = (uint32_t)(t[4] >> 26);
		r20 += b * 5;   b = (r20 >> 26); r20 &= 0x3ffffff;
		r21 += b;

		p->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r20), _MM_SHUFFLE(1,0,1,0));
		p->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r21), _MM_SHUFFLE(1,0,1,0));
		p->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r22), _MM_SHUFFLE(1,0,1,0));
		p->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r23), _MM_SHUFFLE(1,0,1,0));
		p->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r24), _MM_SHUFFLE(1,0,1,0));
		p->S21.v = _mm_mul_epu32(p->R21.v, FIVE);
		p->S22.v = _mm_mul_epu32(p->R22.v, FIVE);
		p->S23.v = _mm_mul_epu32(p->R23.v, FIVE);
		p->S24.v = _mm_mul_epu32(p->R24.v, FIVE);
		p--;
	}

	/* put saved info back */
	p = &st->P[1];
	p->R20.d[1] = r0;
	p->R20.d[3] = r1;
	p->R21.d[1] = r2;
	p->R21.d[3] = r3;
	p->R22.d[1] = r4;
	p->R23.d[1] = pad0;
	p->R23.d[3] = pad1;
	p->R24.d[1] = pad2;
	p->R24.d[3] = pad3;

	/* H = [Mx,My] */
	T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_loadl_epi64((xmmi *)(m + 16)));
	T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_loadl_epi64((xmmi *)(m + 24)));
	st->H[0] = _mm_and_si128(MMASK, T5);
	st->H[1] = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
	st->H[2] = _mm_and_si128(MMASK, T5);
	st->H[3] = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	st->H[4] = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);
}

static void
poly1305_blocks(poly1305_state_internal *st, const uint8_t *m, size_t bytes) {
	const xmmi MMASK = _mm_load_si128((xmmi *)poly1305_x64_sse2_message_mask);
	const xmmi FIVE = _mm_load_si128((xmmi*)poly1305_x64_sse2_5);
	const xmmi HIBIT = _mm_load_si128((xmmi*)poly1305_x64_sse2_1shl128);

	poly1305_power *p;
	xmmi H0,H1,H2,H3,H4;
	xmmi T0,T1,T2,T3,T4,T5,T6;
	xmmi M0,M1,M2,M3,M4;
	xmmi C1,C2;

	H0 = st->H[0];
	H1 = st->H[1];
	H2 = st->H[2];
	H3 = st->H[3];
	H4 = st->H[4];

	while (bytes >= 64) {
		/* H *= [r^4,r^4] */
		p = &st->P[0];
		T0 = _mm_mul_epu32(H0, p->R20.v);
		T1 = _mm_mul_epu32(H0, p->R21.v);
		T2 = _mm_mul_epu32(H0, p->R22.v);
		T3 = _mm_mul_epu32(H0, p->R23.v);
		T4 = _mm_mul_epu32(H0, p->R24.v);
		T5 = _mm_mul_epu32(H1, p->S24.v); T6 = _mm_mul_epu32(H1, p->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H2, p->S23.v); T6 = _mm_mul_epu32(H2, p->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H3, p->S22.v); T6 = _mm_mul_epu32(H3, p->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H4, p->S21.v); T6 = _mm_mul_epu32(H4, p->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H1, p->R21.v); T6 = _mm_mul_epu32(H1, p->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H2, p->R20.v); T6 = _mm_mul_epu32(H2, p->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H3, p->S24.v); T6 = _mm_mul_epu32(H3, p->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H4, p->S23.v); T6 = _mm_mul_epu32(H4, p->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H1, p->R23.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H2, p->R22.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H3, p->R21.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H4, p->R20.v);                                   T4 = _mm_add_epi64(T4, T5);

		/* H += [Mx,My]*[r^2,r^2] */
		T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_loadl_epi64((xmmi *)(m + 16)));
		T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_loadl_epi64((xmmi *)(m + 24)));
		M0 = _mm_and_si128(MMASK, T5);
		M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
		M2 = _mm_and_si128(MMASK, T5);
		M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

		p = &st->P[1];
		T5 = _mm_mul_epu32(M0, p->R20.v); T6 = _mm_mul_epu32(M0, p->R21.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M1, p->S24.v); T6 = _mm_mul_epu32(M1, p->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M2, p->S23.v); T6 = _mm_mul_epu32(M2, p->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M3, p->S22.v); T6 = _mm_mul_epu32(M3, p->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M4, p->S21.v); T6 = _mm_mul_epu32(M4, p->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M0, p->R22.v); T6 = _mm_mul_epu32(M0, p->R23.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M1, p->R21.v); T6 = _mm_mul_epu32(M1, p->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M2, p->R20.v); T6 = _mm_mul_epu32(M2, p->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M3, p->S24.v); T6 = _mm_mul_epu32(M3, p->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M4, p->S23.v); T6 = _mm_mul_epu32(M4, p->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M0, p->R24.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M1, p->R23.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M2, p->R22.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M3, p->R21.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M4, p->R20.v);                                   T4 = _mm_add_epi64(T4, T5);

		/* H += [Mx,My] */
		T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 32)), _mm_loadl_epi64((xmmi *)(m + 48)));
		T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 40)), _mm_loadl_epi64((xmmi *)(m + 56)));
		M0 = _mm_and_si128(MMASK, T5);
		M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
		M2 = _mm_and_si128(MMASK, T5);
		M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

		T0 = _mm_add_epi64(T0, M0);
		T1 = _mm_add_epi64(T1, M1);
		T2 = _mm_add_epi64(T2, M2);
		T3 = _mm_add_epi64(T3, M3);
		T4 = _mm_add_epi64(T4, M4);

		/* reduce */
		C1 = _mm_srli_epi64(T0, 26); C2 = _mm_srli_epi64(T3, 26); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_and_si128(T3, MMASK); T1 = _mm_add_epi64(T1, C1); T4 = _mm_add_epi64(T4, C2); 
		C1 = _mm_srli_epi64(T1, 26); C2 = _mm_srli_epi64(T4, 26); T1 = _mm_and_si128(T1, MMASK); T4 = _mm_and_si128(T4, MMASK); T2 = _mm_add_epi64(T2, C1); T0 = _mm_add_epi64(T0, _mm_mul_epu32(C2, FIVE)); 
		C1 = _mm_srli_epi64(T2, 26); C2 = _mm_srli_epi64(T0, 26); T2 = _mm_and_si128(T2, MMASK); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_add_epi64(T3, C1); T1 = _mm_add_epi64(T1, C2);
		C1 = _mm_srli_epi64(T3, 26);                              T3 = _mm_and_si128(T3, MMASK);                                T4 = _mm_add_epi64(T4, C1);
		
		/* H = (H*[r^4,r^4] + [Mx,My]*[r^2,r^2] + [Mx,My]) */
		H0 = T0;
		H1 = T1;
		H2 = T2;
		H3 = T3;
		H4 = T4;

		m += 64;
		bytes -= 64;
	}

	st->H[0] = H0;
	st->H[1] = H1;
	st->H[2] = H2;
	st->H[3] = H3;
	st->H[4] = H4;
}

static size_t
poly1305_combine(poly1305_state_internal *st, const uint8_t *m, size_t bytes) {
	const xmmi MMASK = _mm_load_si128((xmmi *)poly1305_x64_sse2_message_mask);
	const xmmi HIBIT = _mm_load_si128((xmmi*)poly1305_x64_sse2_1shl128);
	const xmmi FIVE = _mm_load_si128((xmmi*)poly1305_x64_sse2_5);

	poly1305_power *p;
	xmmi H0,H1,H2,H3,H4;
	xmmi M0,M1,M2,M3,M4;
	xmmi T0,T1,T2,T3,T4,T5,T6;
	xmmi C1,C2;

	uint32_t r0,r1,r2,r3,r4;
	uint32_t h0,h1,h2,h3,h4;
	uint32_t b;
	uint32_t consumed = 0;

	H0 = st->H[0];
	H1 = st->H[1];
	H2 = st->H[2];
	H3 = st->H[3];
	H4 = st->H[4];

	/* p = [r^2,r^2] */
	p = &st->P[1];

	if (bytes >= 32) {
		/* H *= [r^2,r^2] */
		T0 = _mm_mul_epu32(H0, p->R20.v);
		T1 = _mm_mul_epu32(H0, p->R21.v);
		T2 = _mm_mul_epu32(H0, p->R22.v);
		T3 = _mm_mul_epu32(H0, p->R23.v);
		T4 = _mm_mul_epu32(H0, p->R24.v);
		T5 = _mm_mul_epu32(H1, p->S24.v); T6 = _mm_mul_epu32(H1, p->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H2, p->S23.v); T6 = _mm_mul_epu32(H2, p->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H3, p->S22.v); T6 = _mm_mul_epu32(H3, p->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H4, p->S21.v); T6 = _mm_mul_epu32(H4, p->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(H1, p->R21.v); T6 = _mm_mul_epu32(H1, p->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H2, p->R20.v); T6 = _mm_mul_epu32(H2, p->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H3, p->S24.v); T6 = _mm_mul_epu32(H3, p->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H4, p->S23.v); T6 = _mm_mul_epu32(H4, p->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(H1, p->R23.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H2, p->R22.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H3, p->R21.v);                                   T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(H4, p->R20.v);                                   T4 = _mm_add_epi64(T4, T5);
		
		/* H += [Mx,My] */
		T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_loadl_epi64((xmmi *)(m + 16)));
		T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_loadl_epi64((xmmi *)(m + 24)));
		M0 = _mm_and_si128(MMASK, T5);
		M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
		M2 = _mm_and_si128(MMASK, T5);
		M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

		T0 = _mm_add_epi64(T0, M0);
		T1 = _mm_add_epi64(T1, M1);
		T2 = _mm_add_epi64(T2, M2);
		T3 = _mm_add_epi64(T3, M3);
		T4 = _mm_add_epi64(T4, M4);

		/* reduce */
		C1 = _mm_srli_epi64(T0, 26); C2 = _mm_srli_epi64(T3, 26); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_and_si128(T3, MMASK); T1 = _mm_add_epi64(T1, C1); T4 = _mm_add_epi64(T4, C2); 
		C1 = _mm_srli_epi64(T1, 26); C2 = _mm_srli_epi64(T4, 26); T1 = _mm_and_si128(T1, MMASK); T4 = _mm_and_si128(T4, MMASK); T2 = _mm_add_epi64(T2, C1); T0 = _mm_add_epi64(T0, _mm_mul_epu32(C2, FIVE)); 
		C1 = _mm_srli_epi64(T2, 26); C2 = _mm_srli_epi64(T0, 26); T2 = _mm_and_si128(T2, MMASK); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_add_epi64(T3, C1); T1 = _mm_add_epi64(T1, C2);
		C1 = _mm_srli_epi64(T3, 26);                              T3 = _mm_and_si128(T3, MMASK);                                T4 = _mm_add_epi64(T4, C1);
		
		/* H = (H*[r^2,r^2] + [Mx,My]) */
		H0 = T0;
		H1 = T1;
		H2 = T2;
		H3 = T3;
		H4 = T4;

		consumed = 32;
	}

	/* finalize, H *= [r^2,r] */
	r0 = p->R20.d[1];
	r1 = p->R20.d[3];
	r2 = p->R21.d[1];
	r3 = p->R21.d[3];
	r4 = p->R22.d[1];

	p->R20.d[2] = r0;
	p->R21.d[2] = r1;
	p->R22.d[2] = r2;
	p->R23.d[2] = r3;
	p->R24.d[2] = r4;
	p->S21.d[2] = r1 * 5;
	p->S22.d[2] = r2 * 5;
	p->S23.d[2] = r3 * 5;
	p->S24.d[2] = r4 * 5;

	/* H *= [r^2,r] */
	T0 = _mm_mul_epu32(H0, p->R20.v);
	T1 = _mm_mul_epu32(H0, p->R21.v);
	T2 = _mm_mul_epu32(H0, p->R22.v);
	T3 = _mm_mul_epu32(H0, p->R23.v);
	T4 = _mm_mul_epu32(H0, p->R24.v);
	T5 = _mm_mul_epu32(H1, p->S24.v); T6 = _mm_mul_epu32(H1, p->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H2, p->S23.v); T6 = _mm_mul_epu32(H2, p->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H3, p->S22.v); T6 = _mm_mul_epu32(H3, p->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H4, p->S21.v); T6 = _mm_mul_epu32(H4, p->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H1, p->R21.v); T6 = _mm_mul_epu32(H1, p->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H2, p->R20.v); T6 = _mm_mul_epu32(H2, p->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H3, p->S24.v); T6 = _mm_mul_epu32(H3, p->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H4, p->S23.v); T6 = _mm_mul_epu32(H4, p->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H1, p->R23.v);                                   T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H2, p->R22.v);                                   T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H3, p->R21.v);                                   T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H4, p->R20.v);                                   T4 = _mm_add_epi64(T4, T5);

	C1 = _mm_srli_epi64(T0, 26); C2 = _mm_srli_epi64(T3, 26); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_and_si128(T3, MMASK); T1 = _mm_add_epi64(T1, C1); T4 = _mm_add_epi64(T4, C2); 
	C1 = _mm_srli_epi64(T1, 26); C2 = _mm_srli_epi64(T4, 26); T1 = _mm_and_si128(T1, MMASK); T4 = _mm_and_si128(T4, MMASK); T2 = _mm_add_epi64(T2, C1); T0 = _mm_add_epi64(T0, _mm_mul_epu32(C2, FIVE)); 
	C1 = _mm_srli_epi64(T2, 26); C2 = _mm_srli_epi64(T0, 26); T2 = _mm_and_si128(T2, MMASK); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_add_epi64(T3, C1); T1 = _mm_add_epi64(T1, C2);
	C1 = _mm_srli_epi64(T3, 26);                              T3 = _mm_and_si128(T3, MMASK);                                T4 = _mm_add_epi64(T4, C1);

	/* H = H[0]+H[1] */
	H0 = _mm_add_epi64(T0, _mm_srli_si128(T0, 8));
	H1 = _mm_add_epi64(T1, _mm_srli_si128(T1, 8));
	H2 = _mm_add_epi64(T2, _mm_srli_si128(T2, 8));
	H3 = _mm_add_epi64(T3, _mm_srli_si128(T3, 8));
	H4 = _mm_add_epi64(T4, _mm_srli_si128(T4, 8));

	h0 = _mm_cvtsi128_si32(H0)    ; b = (h0 >> 26); h0 &= 0x3ffffff;
	h1 = _mm_cvtsi128_si32(H1) + b; b = (h1 >> 26); h1 &= 0x3ffffff;
	h2 = _mm_cvtsi128_si32(H2) + b; b = (h2 >> 26); h2 &= 0x3ffffff;
	h3 = _mm_cvtsi128_si32(H3) + b; b = (h3 >> 26); h3 &= 0x3ffffff;
	h4 = _mm_cvtsi128_si32(H4) + b; b = (h4 >> 26); h4 &= 0x3ffffff;
	h0 =              h0 + (b * 5);

	st->HH[0] = h0;
	st->HH[1] = h1;
	st->HH[2] = h2;
	st->HH[3] = h3;
	st->HH[4] = h4;

	return consumed;
}

void
poly1305_update(poly1305_state *state, const unsigned char *m, size_t bytes) {
	poly1305_state_internal *st = poly1305_aligned_state(state);
	size_t want;

	/* need at least 32 initial bytes to start the accelerated branch */
	if (!st->started) {
		if ((st->leftover == 0) && (bytes > 32)) {
			poly1305_first_block(st, m);
			m += 32;
			bytes -= 32;
		} else {
			want = (32 - st->leftover);
			if (want > bytes)
					want = bytes;
			poly1305_block_copy(st->buffer + st->leftover, m, want);
			bytes -= want;
			m += want;
			st->leftover += want;
			if ((st->leftover < 32) || (bytes == 0))
				return;
			poly1305_first_block(st, st->buffer);
			st->leftover = 0;
		}
		st->started = 1;
	}

	/* handle leftover */
	if (st->leftover) {
		want = (64 - st->leftover);
		if (want > bytes)
				want = bytes;
		poly1305_block_copy(st->buffer + st->leftover, m, want);
		bytes -= want;
		m += want;
		st->leftover += want;
		if (st->leftover < 64)
			return;
		poly1305_blocks(st, st->buffer, 64);
		st->leftover = 0;
	}

	/* process 64 byte blocks */
	if (bytes >= 64) {
		want = (bytes & ~63);
		poly1305_blocks(st, m, want);
		m += want;
		bytes -= want;
	}

	if (bytes) {
		poly1305_block_copy(st->buffer + st->leftover, m, bytes);
		st->leftover += bytes;
	}
}

void
poly1305_finish(poly1305_state *state, unsigned char mac[16]) {
	poly1305_state_internal *st = poly1305_aligned_state(state);
	uint32_t leftover = st->leftover;
	uint8_t *m = st->buffer;
	uint64_t t[5];
	uint32_t h0,h1,h2,h3,h4;
	uint32_t r0,r1,r2,r3,r4;
	uint32_t s1,s2,s3,s4;
	uint32_t t0,t1,t2,t3;
	uint32_t g0,g1,g2,g3,g4;
	uint32_t b, nb;
	uint64_t f0,f1,f2,f3;
	uint64_t c;
	poly1305_power *p;

	if (st->started) {
		size_t consumed = poly1305_combine(st, m, leftover);
		leftover -= consumed;
		m += consumed;
	}

	/* st->HH will either be 0 or have the combined result */
	h0 = st->HH[0];
	h1 = st->HH[1];
	h2 = st->HH[2];
	h3 = st->HH[3];
	h4 = st->HH[4];

	p = &st->P[1];
	r0 = p->R20.d[1];
	r1 = p->R20.d[3];
	r2 = p->R21.d[1];
	r3 = p->R21.d[3];
	r4 = p->R22.d[1];
	s1 = r1 * 5;
	s2 = r2 * 5;
	s3 = r3 * 5;
	s4 = r4 * 5;

	if (leftover < 16) goto poly1305_donna_atmost15bytes;

poly1305_donna_atleast16bytes:
	t0 = U8TO32_LE(m);
	t1 = U8TO32_LE(m+4);
	t2 = U8TO32_LE(m+8);
	t3 = U8TO32_LE(m+12);

	h0 += t0 & 0x3ffffff;
	h1 += ((((uint64_t)t1 << 32) | t0) >> 26) & 0x3ffffff;
	h2 += ((((uint64_t)t2 << 32) | t1) >> 20) & 0x3ffffff;
	h3 += ((((uint64_t)t3 << 32) | t2) >> 14) & 0x3ffffff;
	h4 += (t3 >> 8) | (1 << 24);

poly1305_donna_mul:
	t[0]  = mul32x32_64(h0,r0) + mul32x32_64(h1,s4) + mul32x32_64(h2,s3) + mul32x32_64(h3,s2) + mul32x32_64(h4,s1);
	t[1]  = mul32x32_64(h0,r1) + mul32x32_64(h1,r0) + mul32x32_64(h2,s4) + mul32x32_64(h3,s3) + mul32x32_64(h4,s2);
	t[2]  = mul32x32_64(h0,r2) + mul32x32_64(h1,r1) + mul32x32_64(h2,r0) + mul32x32_64(h3,s4) + mul32x32_64(h4,s3);
	t[3]  = mul32x32_64(h0,r3) + mul32x32_64(h1,r2) + mul32x32_64(h2,r1) + mul32x32_64(h3,r0) + mul32x32_64(h4,s4);
	t[4]  = mul32x32_64(h0,r4) + mul32x32_64(h1,r3) + mul32x32_64(h2,r2) + mul32x32_64(h3,r1) + mul32x32_64(h4,r0);

	                h0 = (uint32_t)t[0] & 0x3ffffff; c =           (t[0] >> 26);
	t[1] += c;      h1 = (uint32_t)t[1] & 0x3ffffff; b = (uint32_t)(t[1] >> 26);
	t[2] += b;      h2 = (uint32_t)t[2] & 0x3ffffff; b = (uint32_t)(t[2] >> 26);
	t[3] += b;      h3 = (uint32_t)t[3] & 0x3ffffff; b = (uint32_t)(t[3] >> 26);
	t[4] += b;      h4 = (uint32_t)t[4] & 0x3ffffff; b = (uint32_t)(t[4] >> 26);
	h0 += b * 5;

	m += 16;
	leftover -= 16;
	if (leftover >= 16) goto poly1305_donna_atleast16bytes;

	/* final bytes */
poly1305_donna_atmost15bytes:
	if (!leftover) goto poly1305_donna_finish;

	m[leftover++] = 1;
	poly1305_block_zero(m + leftover, 16 - leftover);
	leftover = 16;

	t0 = U8TO32_LE(m+0);
	t1 = U8TO32_LE(m+4);
	t2 = U8TO32_LE(m+8);
	t3 = U8TO32_LE(m+12);

	h0 += t0 & 0x3ffffff;
	h1 += ((((uint64_t)t1 << 32) | t0) >> 26) & 0x3ffffff;
	h2 += ((((uint64_t)t2 << 32) | t1) >> 20) & 0x3ffffff;
	h3 += ((((uint64_t)t3 << 32) | t2) >> 14) & 0x3ffffff;
	h4 += (t3 >> 8);

	goto poly1305_donna_mul;

poly1305_donna_finish:
	             b = h0 >> 26; h0 = h0 & 0x3ffffff;
	h1 +=     b; b = h1 >> 26; h1 = h1 & 0x3ffffff;
	h2 +=     b; b = h2 >> 26; h2 = h2 & 0x3ffffff;
	h3 +=     b; b = h3 >> 26; h3 = h3 & 0x3ffffff;
	h4 +=     b; b = h4 >> 26; h4 = h4 & 0x3ffffff;
	h0 += b * 5; b = h0 >> 26; h0 = h0 & 0x3ffffff;
	h1 +=     b;

	g0 = h0 + 5; b = g0 >> 26; g0 &= 0x3ffffff;
	g1 = h1 + b; b = g1 >> 26; g1 &= 0x3ffffff;
	g2 = h2 + b; b = g2 >> 26; g2 &= 0x3ffffff;
	g3 = h3 + b; b = g3 >> 26; g3 &= 0x3ffffff;
	g4 = h4 + b - (1 << 26);

	b = (g4 >> 31) - 1;
	nb = ~b;
	h0 = (h0 & nb) | (g0 & b);
	h1 = (h1 & nb) | (g1 & b);
	h2 = (h2 & nb) | (g2 & b);
	h3 = (h3 & nb) | (g3 & b);
	h4 = (h4 & nb) | (g4 & b);

	/* pad */
	f0 = ((h0      ) | (h1 << 26)) + (uint64_t)p->R23.d[1];
	f1 = ((h1 >>  6) | (h2 << 20)) + (uint64_t)p->R23.d[3];
	f2 = ((h2 >> 12) | (h3 << 14)) + (uint64_t)p->R24.d[1];
	f3 = ((h3 >> 18) | (h4 <<  8)) + (uint64_t)p->R24.d[3];

	U32TO8_LE(mac +  0, (uint32_t)f0); f1 += (f0 >> 32);
	U32TO8_LE(mac +  4, (uint32_t)f1); f2 += (f1 >> 32);
	U32TO8_LE(mac +  8, (uint32_t)f2); f3 += (f2 >> 32);
	U32TO8_LE(mac + 12, (uint32_t)f3);
}

void
poly1305_auth(unsigned char mac[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	poly1305_state state;
	poly1305_init(&state, key);
	poly1305_update(&state, m, inlen);
	poly1305_finish(&state, mac);
}

