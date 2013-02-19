/*
	by Andrew Moon
	
	Implements SIMD vectorization based on the algorithm described in http://cr.yp.to/papers.html#neoncrypto
*/


#include "portable-jane.h"
#include <emmintrin.h>
typedef __m128i xmmi;

static const uint32_t ALIGN(16) poly1305_x64_sse2_message_mask[4] = {(1 << 26) - 1, 0, (1 << 26) - 1, 0};
static const uint32_t ALIGN(16) poly1305_x64_sse2_5[4] = {5, 0, 5, 0};
static const uint32_t ALIGN(16) poly1305_x64_sse2_1shl128[4] = {(1 << 24), 0, (1 << 24), 0};

void
poly1305_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	const xmmi MMASK = _mm_load_si128((xmmi *)poly1305_x64_sse2_message_mask);
	const xmmi FIVE = _mm_load_si128((xmmi*)poly1305_x64_sse2_5);
	const xmmi HIBIT = _mm_load_si128((xmmi*)poly1305_x64_sse2_1shl128);

	xmmi M0,M1,M2,M3,M4;
	xmmi H0,H1,H2,H3,H4;
	xmmi T0,T1,T2,T3,T4,T5,T6;
	xmmi C1,C2;

	uint64_t t0,t1,t2,t3,t4;
	uint64_t h0,h1,h2;
	uint64_t r0,r1,r2;
	uint64_t r20,r21,r22;
	uint64_t rp0,rp1,rp2;
	uint64_t g0,g1,g2,c,nc;
	uint64_t s1,s2;
	uint64_t s21,s22;
	size_t j, powers, blocksize, p;
	uint128_t d[3];
	
	struct {
		union {
			xmmi v;
			uint64_t u[2];
			uint32_t d;
		} R20,R21,R22,R23,R24,S21,S22,S23,S24;
	} P[13], *power, *initial_power, *rsquared;

	unsigned char mp[16];

	/* clamp key */
	t0 = U8TO64_LE(&key[0]);
	t1 = U8TO64_LE(&key[8]);

	r0 = t0 & 0xffc0fffffff; t0 >>= 44; t0 |= t1 << 20;
	r1 = t0 & 0xfffffc0ffff; t1 >>= 24;
	r2 = t1 & 0x00ffffffc0f;

	/* pre-compute */
	s1 = r1 * (5 << 2);
	s2 = r2 * (5 << 2);

	/* sum */
	h0 = 0;
	h1 = 0;
	h2 = 0;

	if (inlen < 16) goto poly1305_donna_atmost15bytes;
	if (inlen < 32) goto poly1305_donna_atmost31bytes;

	/* vectorize M0,M1 across H */
	T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_loadl_epi64((xmmi *)(m + 16)));
	T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_loadl_epi64((xmmi *)(m + 24)));
	H0 = _mm_and_si128(MMASK, T5);
	H1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
	H2 = _mm_and_si128(MMASK, T5);
	H3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	H4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

	inlen -= 32;
	m += 32;

	powers = (inlen / 768) + 1;
	powers = (powers > 13) ? 13 : powers;
	blocksize = powers * 32;
	initial_power = &P[0];
	power = &P[powers - 1];
	rsquared = power;
	p = 0;

	/* r^2 */
	if (1) {
		d[0] = add128(mul64x64_128(r0, r0), mul64x64_128(r1 * 2, s2));
		d[1] = add128(mul64x64_128(r2, s2), mul64x64_128(r0 * 2, r1));
		d[2] = add128(mul64x64_128(r1, r1), mul64x64_128(r2 * 2, r0));

		                           r20 = lo128(d[0]) & 0xfffffffffff; c = shr128(d[0], 44);
		d[1] = add128_64(d[1], c); r21 = lo128(d[1]) & 0xfffffffffff; c = shr128(d[1], 44);
		d[2] = add128_64(d[2], c); r22 = lo128(d[2]) & 0x3ffffffffff; c = shr128(d[2], 42);
		r20 += c * 5; c = (r20 >> 44); r20 = r20 & 0xfffffffffff; 
		r21 += c;

		s21 = r21 * (5 << 2);
		s22 = r22 * (5 << 2);

		rp0 = r20;
		rp1 = r21;
		rp2 = r22;

		power->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)( r20                     ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((r20 >> 26) | (r21 << 18)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((r21 >> 8)               ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((r21 >> 34) | (r22 << 10)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((r22 >> 16)              )            ), _MM_SHUFFLE(1,0,1,0));

		power->S21.v = _mm_mul_epu32(power->R21.v, FIVE);
		power->S22.v = _mm_mul_epu32(power->R22.v, FIVE);
		power->S23.v = _mm_mul_epu32(power->R23.v, FIVE);
		power->S24.v = _mm_mul_epu32(power->R24.v, FIVE);

		power -= 1;
		p += 1;
	}

	/* r^4 */
	if (powers > 1) {
		d[0] = add128(mul64x64_128(r20, r20), mul64x64_128(r21 * 2, s22));
		d[1] = add128(mul64x64_128(r22, s22), mul64x64_128(r20 * 2, r21));
		d[2] = add128(mul64x64_128(r21, r21), mul64x64_128(r22 * 2, r20));

		                           rp0 = lo128(d[0]) & 0xfffffffffff; c = shr128(d[0], 44);
		d[1] = add128_64(d[1], c); rp1 = lo128(d[1]) & 0xfffffffffff; c = shr128(d[1], 44);
		d[2] = add128_64(d[2], c); rp2 = lo128(d[2]) & 0x3ffffffffff; c = shr128(d[2], 42);
		rp0 += c * 5; c = (rp0 >> 44); rp0 = rp0 & 0xfffffffffff; 
		rp1 += c;

		power->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)( rp0                     ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp0 >> 26) | (rp1 << 18)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp1 >> 8)               ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp1 >> 34) | (rp2 << 10)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp2 >> 16)              )            ), _MM_SHUFFLE(1,0,1,0));

		power->S21.v = _mm_mul_epu32(power->R21.v, FIVE);
		power->S22.v = _mm_mul_epu32(power->R22.v, FIVE);
		power->S23.v = _mm_mul_epu32(power->R23.v, FIVE);
		power->S24.v = _mm_mul_epu32(power->R24.v, FIVE);

		power -= 1;
		p += 1;
	}
	
	/* r^6, r^8... */
	for (; p < powers; p++) {
		d[0] = add128(add128(mul64x64_128(rp0, r20), mul64x64_128(rp1, s22)), mul64x64_128(rp2, s21));
		d[1] = add128(add128(mul64x64_128(rp0, r21), mul64x64_128(rp1, r20)), mul64x64_128(rp2, s22));
		d[2] = add128(add128(mul64x64_128(rp0, r22), mul64x64_128(rp1, r21)), mul64x64_128(rp2, r20));

		                           rp0 = lo128(d[0]) & 0xfffffffffff; c = shr128(d[0], 44);
		d[1] = add128_64(d[1], c); rp1 = lo128(d[1]) & 0xfffffffffff; c = shr128(d[1], 44);
		d[2] = add128_64(d[2], c); rp2 = lo128(d[2]) & 0x3ffffffffff; c = shr128(d[2], 42);
		rp0 += c * 5; c = (rp0 >> 44); rp0 = rp0 & 0xfffffffffff; 
		rp1 += c;

		power->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)( rp0                     ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp0 >> 26) | (rp1 << 18)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp1 >> 8)               ) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp1 >> 34) | (rp2 << 10)) & 0x3ffffff), _MM_SHUFFLE(1,0,1,0));
		power->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128((uint32_t)((rp2 >> 16)              )            ), _MM_SHUFFLE(1,0,1,0));

		power->S21.v = _mm_mul_epu32(power->R21.v, FIVE);
		power->S22.v = _mm_mul_epu32(power->R22.v, FIVE);
		power->S23.v = _mm_mul_epu32(power->R23.v, FIVE);
		power->S24.v = _mm_mul_epu32(power->R24.v, FIVE);

		power -= 1;
	}

	if (inlen < 32) goto poly1305_donna_combine;

poly1305_donna_multirounds:
	/* H *= [r^z,r^z] */
	power = initial_power;
	T0 = _mm_mul_epu32(H0, power->R20.v);
	T1 = _mm_mul_epu32(H0, power->R21.v);
	T2 = _mm_mul_epu32(H0, power->R22.v);
	T3 = _mm_mul_epu32(H0, power->R23.v);
	T4 = _mm_mul_epu32(H0, power->R24.v);
	T5 = _mm_mul_epu32(H1, power->S24.v); T6 = _mm_mul_epu32(H1, power->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H2, power->S23.v); T6 = _mm_mul_epu32(H2, power->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H3, power->S22.v); T6 = _mm_mul_epu32(H3, power->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H4, power->S21.v); T6 = _mm_mul_epu32(H4, power->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H1, power->R21.v); T6 = _mm_mul_epu32(H1, power->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H2, power->R20.v); T6 = _mm_mul_epu32(H2, power->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H3, power->S24.v); T6 = _mm_mul_epu32(H3, power->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H4, power->S23.v); T6 = _mm_mul_epu32(H4, power->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H1, power->R23.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H2, power->R22.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H3, power->R21.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H4, power->R20.v);                                       T4 = _mm_add_epi64(T4, T5);

	for (p = 1; p < powers; p++) {
		/* H += [Mx,My]*[r^(z-p*2),r^(z-p*2))] */
		T5 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_loadl_epi64((xmmi *)(m + 16)));
		T6 = _mm_unpacklo_epi64(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_loadl_epi64((xmmi *)(m + 24)));
		M0 = _mm_and_si128(MMASK, T5);
		M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
		M2 = _mm_and_si128(MMASK, T5);
		M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

		m += 32;

		power++;

		T5 = _mm_mul_epu32(M0, power->R20.v); T6 = _mm_mul_epu32(M0, power->R21.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M1, power->S24.v); T6 = _mm_mul_epu32(M1, power->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M2, power->S23.v); T6 = _mm_mul_epu32(M2, power->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M3, power->S22.v); T6 = _mm_mul_epu32(M3, power->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M4, power->S21.v); T6 = _mm_mul_epu32(M4, power->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
		T5 = _mm_mul_epu32(M0, power->R22.v); T6 = _mm_mul_epu32(M0, power->R23.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M1, power->R21.v); T6 = _mm_mul_epu32(M1, power->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M2, power->R20.v); T6 = _mm_mul_epu32(M2, power->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M3, power->S24.v); T6 = _mm_mul_epu32(M3, power->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M4, power->S23.v); T6 = _mm_mul_epu32(M4, power->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
		T5 = _mm_mul_epu32(M0, power->R24.v);                                       T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M1, power->R23.v);                                       T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M2, power->R22.v);                                       T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M3, power->R21.v);                                       T4 = _mm_add_epi64(T4, T5);
		T5 = _mm_mul_epu32(M4, power->R20.v);                                       T4 = _mm_add_epi64(T4, T5);
	}

	/* reduce */
	C1 = _mm_srli_epi64(T0, 26); C2 = _mm_srli_epi64(T3, 26); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_and_si128(T3, MMASK); T1 = _mm_add_epi64(T1, C1); T4 = _mm_add_epi64(T4, C2); 
	C1 = _mm_srli_epi64(T1, 26); C2 = _mm_srli_epi64(T4, 26); T1 = _mm_and_si128(T1, MMASK); T4 = _mm_and_si128(T4, MMASK); T2 = _mm_add_epi64(T2, C1); T0 = _mm_add_epi64(T0, _mm_mul_epu32(C2, FIVE)); 
	C1 = _mm_srli_epi64(T2, 26); C2 = _mm_srli_epi64(T0, 26); T2 = _mm_and_si128(T2, MMASK); T0 = _mm_and_si128(T0, MMASK); T3 = _mm_add_epi64(T3, C1); T1 = _mm_add_epi64(T1, C2);
	C1 = _mm_srli_epi64(T3, 26);                              T3 = _mm_and_si128(T3, MMASK);                                T4 = _mm_add_epi64(T4, C1);

	/* H += [Mx,My] */
	T5 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 16)), 8));
	T6 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 24)), 8));
	M0 = _mm_and_si128(MMASK, T5);
	M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
	M2 = _mm_and_si128(MMASK, T5);
	M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
	M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);

	m += 32;
	inlen -= powers * 32;

	H0 = _mm_add_epi64(T0, M0);
	H1 = _mm_add_epi64(T1, M1);
	H2 = _mm_add_epi64(T2, M2);
	H3 = _mm_add_epi64(T3, M3);
	H4 = _mm_add_epi64(T4, M4);

	if (inlen >= blocksize) goto poly1305_donna_multirounds;
	if (inlen >= 32) {
		powers = (inlen / 32);
		blocksize = powers * 32;
		initial_power = rsquared - (powers - 1);
		goto poly1305_donna_multirounds;
	}

poly1305_donna_combine:
	/* finalize, H *= [r^2,r] */
	power = initial_power + powers - 1;
	power->R20.u[1] = (uint32_t)( r0                    ) & 0x3ffffff;
	power->R21.u[1] = (uint32_t)((r0 >> 26) | (r1 << 18)) & 0x3ffffff;
	power->R22.u[1] = (uint32_t)((r1 >> 8)              ) & 0x3ffffff;
	power->R23.u[1] = (uint32_t)((r1 >> 34) | (r2 << 10)) & 0x3ffffff;
	power->R24.u[1] = (uint32_t)((r2 >> 16)             )            ;

	power->S21.u[1] = power->R21.u[1] * 5;
	power->S22.u[1] = power->R22.u[1] * 5;
	power->S23.u[1] = power->R23.u[1] * 5;
	power->S24.u[1] = power->R24.u[1] * 5;

	/* H *= [r^2,r] */
	T0 = _mm_mul_epu32(H0, power->R20.v);
	T1 = _mm_mul_epu32(H0, power->R21.v);
	T2 = _mm_mul_epu32(H0, power->R22.v);
	T3 = _mm_mul_epu32(H0, power->R23.v);
	T4 = _mm_mul_epu32(H0, power->R24.v);
	T5 = _mm_mul_epu32(H1, power->S24.v); T6 = _mm_mul_epu32(H1, power->R20.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H2, power->S23.v); T6 = _mm_mul_epu32(H2, power->S24.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H3, power->S22.v); T6 = _mm_mul_epu32(H3, power->S23.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H4, power->S21.v); T6 = _mm_mul_epu32(H4, power->S22.v); T0 = _mm_add_epi64(T0, T5); T1 = _mm_add_epi64(T1, T6);
	T5 = _mm_mul_epu32(H1, power->R21.v); T6 = _mm_mul_epu32(H1, power->R22.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H2, power->R20.v); T6 = _mm_mul_epu32(H2, power->R21.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H3, power->S24.v); T6 = _mm_mul_epu32(H3, power->R20.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H4, power->S23.v); T6 = _mm_mul_epu32(H4, power->S24.v); T2 = _mm_add_epi64(T2, T5); T3 = _mm_add_epi64(T3, T6);
	T5 = _mm_mul_epu32(H1, power->R23.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H2, power->R22.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H3, power->R21.v);                                       T4 = _mm_add_epi64(T4, T5);
	T5 = _mm_mul_epu32(H4, power->R20.v);                                       T4 = _mm_add_epi64(T4, T5);

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

	t0 = _mm_cvtsi128_si32(H0)    ; c = (t0 >> 26); t0 &= 0x3ffffff;
	t1 = _mm_cvtsi128_si32(H1) + c; c = (t1 >> 26); t1 &= 0x3ffffff;
	t2 = _mm_cvtsi128_si32(H2) + c; c = (t2 >> 26); t2 &= 0x3ffffff;
	t3 = _mm_cvtsi128_si32(H3) + c; c = (t3 >> 26); t3 &= 0x3ffffff;
	t4 = _mm_cvtsi128_si32(H4) + c; c = (t4 >> 26); t4 &= 0x3ffffff;
	t0 =              t0 + (c * 5); c = (t0 >> 26); t0 &= 0x3ffffff;
	t1 =              t1 + c;

	h0 = ((t0      ) | (t1 << 26)             ) & 0xfffffffffffull;
	h1 = ((t1 >> 18) | (t2 <<  8) | (t3 << 34)) & 0xfffffffffffull;
	h2 = ((t3 >> 10) | (t4 << 16)             ) & 0x3ffffffffffull;

	if (inlen < 16) goto poly1305_donna_atmost15bytes;

poly1305_donna_atmost31bytes:
	t0 = U8TO64_LE(m + 0);
	t1 = U8TO64_LE(m + 8);
	h0 += t0 & 0xfffffffffff;
	t0 = shr128_pair(t1, t0, 44);
	h1 += t0 & 0xfffffffffff;
	h2 += (t1 >> 24) | ((uint64_t)1 << 40);

poly1305_donna_mul:
	d[0] = add128(add128(mul64x64_128(h0, r0), mul64x64_128(h1, s2)), mul64x64_128(h2, s1));
	d[1] = add128(add128(mul64x64_128(h0, r1), mul64x64_128(h1, r0)), mul64x64_128(h2, s2));
	d[2] = add128(add128(mul64x64_128(h0, r2), mul64x64_128(h1, r1)), mul64x64_128(h2, r0));
	                           h0 = lo128(d[0]) & 0xfffffffffff; c = shr128(d[0], 44);
	d[1] = add128_64(d[1], c); h1 = lo128(d[1]) & 0xfffffffffff; c = shr128(d[1], 44);
	d[2] = add128_64(d[2], c); h2 = lo128(d[2]) & 0x3ffffffffff; c = shr128(d[2], 42);
	h0   += c * 5;  

	m += 16;
	inlen -= 16;
	if (inlen >= 16) goto poly1305_donna_atmost31bytes;

	/* final bytes */
poly1305_donna_atmost15bytes:
	if (!inlen) goto poly1305_donna_finish;

	for (j = 0; j < inlen; j++) mp[j] = m[j];
	mp[j++] = 1;
	for (; j < 16; j++)	mp[j] = 0;
	inlen = 16;

	t0 = U8TO64_LE(mp+0);
	t1 = U8TO64_LE(mp+8);
	h0 += t0 & 0xfffffffffff;
	t0 = shr128_pair(t1, t0, 44);
	h1 += t0 & 0xfffffffffff;
	h2 += (t1 >> 24);

	goto poly1305_donna_mul;

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
}
