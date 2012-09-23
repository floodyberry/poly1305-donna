/*
	by Andrew Moon
	implements simd vectorization based on the algorithm described in http://cr.yp.to/papers.html#neoncrypto
*/

#include "poly1305-defines.h"
#include <emmintrin.h>
typedef __m128i xmmi;

static const MM16 uint32_t poly1305_x86_sse2_message_mask[4] = {(1 << 26) - 1, 0, (1 << 26) - 1, 0};
static const MM16 uint32_t poly1305_x86_sse2_5[4] = {5, 0, 5, 0};
static const MM16 uint32_t poly1305_x86_sse2_1shl128[4] = {(1 << 24), 0, (1 << 24), 0};

void
poly1305_auth(unsigned char out[16], const unsigned char *m, size_t inlen, const unsigned char key[32]) {
	xmmi MMASK = _mm_load_si128((xmmi *)poly1305_x86_sse2_message_mask);
	xmmi FIVE = _mm_load_si128((xmmi*)poly1305_x86_sse2_5);
	xmmi HIBIT = _mm_load_si128((xmmi*)poly1305_x86_sse2_1shl128);
	
	struct {
		union {
			xmmi v;
			uint64_t u[2];
			uint32_t d;
		} R20,R21,R22,R23,R24,S21,S22,S23,S24;
	} P[13], *power, *prev, *initial_power, *rsquared;
	xmmi M0,M1,M2,M3,M4;
	xmmi H0,H1,H2,H3,H4;
	xmmi T0,T1,T2,T3,T4,T5,T6;
	xmmi C1,C2;

	uint32_t t0,t1,t2,t3;
	uint32_t h0,h1,h2,h3,h4;
	uint32_t r0,r1,r2,r3,r4;
	uint32_t r20,r21,r22,r23,r24;
	uint32_t s1,s2,s3,s4;
	uint32_t s21,s22,s23,s24;
	uint32_t b, nb;
	size_t powers, p, i, blocksize;
	uint64_t t[5];
	uint64_t c;
	uint64_t f0,f1,f2,f3;
	uint32_t g0,g1,g2,g3,g4;
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

	/* precomp r*5 */
	s1 = r1 * 5;
	s2 = r2 * 5;
	s3 = r3 * 5;
	s4 = r4 * 5;

	h0 = 0;
	h1 = 0;
	h2 = 0;
	h3 = 0;
	h4 = 0;

	if (inlen < 16) goto poly1305_donna_atmost15bytes;
	if (inlen < 32) goto poly1305_donna_16bytes;

	/* vectorize M0,M1 across H */
	T5 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 16)), 8));
	T6 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 24)), 8));
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

	r20 = r0;
	r21 = r1;
	r22 = r2;
	r23 = r3;
	r24 = r4;
	s21 = s1;
	s22 = s2;
	s23 = s3;
	s24 = s4;

	/* r^2, r^4 */
	for (p = 0; (p < powers) && (p < 2); p++) {
		t[0]  = mul32x32_64(r20,r20  ) + mul32x32_64(r22*2,s23) + mul32x32_64(r24*2,s21);
		t[1]  = mul32x32_64(r20,r21*2) + mul32x32_64(r24*2,s22) + mul32x32_64(r23  ,s23);
		t[2]  = mul32x32_64(r21,r21  ) + mul32x32_64(r20*2,r22) + mul32x32_64(r24*2,s23);
		t[3]  = mul32x32_64(r20,r23*2) + mul32x32_64(r21*2,r22) + mul32x32_64(r24  ,s24);
		t[4]  = mul32x32_64(r22,r22  ) + mul32x32_64(r20*2,r24) + mul32x32_64(r23*2,r21);

						r20 = (uint32_t)t[0] & 0x3ffffff; c = (uint32_t)(t[0] >> 26);
		t[1] += c;      r21 = (uint32_t)t[1] & 0x3ffffff; c = (uint32_t)(t[1] >> 26);
		t[2] += c;      r22 = (uint32_t)t[2] & 0x3ffffff; c = (uint32_t)(t[2] >> 26);
		t[3] += c;      r23 = (uint32_t)t[3] & 0x3ffffff; c = (uint32_t)(t[3] >> 26);
		t[4] += c;      r24 = (uint32_t)t[4] & 0x3ffffff; c = (uint32_t)(t[4] >> 26);
		r20 += c * 5;   c = (r20 >> 26); r20 &= 0x3ffffff;
		r21 += c;

		power->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r20), _MM_SHUFFLE(1,0,1,0));
		power->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r21), _MM_SHUFFLE(1,0,1,0));
		power->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r22), _MM_SHUFFLE(1,0,1,0));
		power->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r23), _MM_SHUFFLE(1,0,1,0));
		power->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r24), _MM_SHUFFLE(1,0,1,0));

		/* precomp x5 */
		power->S21.v = _mm_mul_epu32(power->R21.v, FIVE);
		power->S22.v = _mm_mul_epu32(power->R22.v, FIVE);
		power->S23.v = _mm_mul_epu32(power->R23.v, FIVE);
		power->S24.v = _mm_mul_epu32(power->R24.v, FIVE);

		s21 = power->S21.d;
		s22 = power->S22.d;
		s23 = power->S23.d;
		s24 = power->S24.d;

		prev = power;
		power -= 1;
	}
	
	/* r^6, r^8... */
	for (; p < powers; p++) {
		t[0]  = mul32x32_64(rsquared->R20.d,prev->R20.d) + mul32x32_64(rsquared->R21.d,prev->S24.d) + mul32x32_64(rsquared->R22.d,prev->S23.d) + mul32x32_64(rsquared->R23.d,prev->S22.d) + mul32x32_64(rsquared->R24.d,prev->S21.d);
		t[1]  = mul32x32_64(rsquared->R20.d,prev->R21.d) + mul32x32_64(rsquared->R21.d,prev->R20.d) + mul32x32_64(rsquared->R22.d,prev->S24.d) + mul32x32_64(rsquared->R23.d,prev->S23.d) + mul32x32_64(rsquared->R24.d,prev->S22.d);
		t[2]  = mul32x32_64(rsquared->R20.d,prev->R22.d) + mul32x32_64(rsquared->R21.d,prev->R21.d) + mul32x32_64(rsquared->R22.d,prev->R20.d) + mul32x32_64(rsquared->R23.d,prev->S24.d) + mul32x32_64(rsquared->R24.d,prev->S23.d);
		t[3]  = mul32x32_64(rsquared->R20.d,prev->R23.d) + mul32x32_64(rsquared->R21.d,prev->R22.d) + mul32x32_64(rsquared->R22.d,prev->R21.d) + mul32x32_64(rsquared->R23.d,prev->R20.d) + mul32x32_64(rsquared->R24.d,prev->S24.d);
		t[4]  = mul32x32_64(rsquared->R20.d,prev->R24.d) + mul32x32_64(rsquared->R21.d,prev->R23.d) + mul32x32_64(rsquared->R22.d,prev->R22.d) + mul32x32_64(rsquared->R23.d,prev->R21.d) + mul32x32_64(rsquared->R24.d,prev->R20.d);

						r20 = (uint32_t)t[0] & 0x3ffffff; c = (uint32_t)(t[0] >> 26);
		t[1] += c;      r21 = (uint32_t)t[1] & 0x3ffffff; c = (uint32_t)(t[1] >> 26);
		t[2] += c;      r22 = (uint32_t)t[2] & 0x3ffffff; c = (uint32_t)(t[2] >> 26);
		t[3] += c;      r23 = (uint32_t)t[3] & 0x3ffffff; c = (uint32_t)(t[3] >> 26);
		t[4] += c;      r24 = (uint32_t)t[4] & 0x3ffffff; c = (uint32_t)(t[4] >> 26);
		r20 += c * 5;   c = (r20 >> 26); r20 &= 0x3ffffff;
		r21 += c;
	
		power->R20.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r20), _MM_SHUFFLE(1,0,1,0));
		power->R21.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r21), _MM_SHUFFLE(1,0,1,0));
		power->R22.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r22), _MM_SHUFFLE(1,0,1,0));
		power->R23.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r23), _MM_SHUFFLE(1,0,1,0));
		power->R24.v = _mm_shuffle_epi32(_mm_cvtsi32_si128(r24), _MM_SHUFFLE(1,0,1,0));

		/* precomp x5 */
		power->S21.v = _mm_mul_epu32(power->R21.v, FIVE);
		power->S22.v = _mm_mul_epu32(power->R22.v, FIVE);
		power->S23.v = _mm_mul_epu32(power->R23.v, FIVE);
		power->S24.v = _mm_mul_epu32(power->R24.v, FIVE);

		prev = power;
		power -= 1;
	}

	if (inlen < 32) goto poly1305_donna_combine;

poly1305_donna_multirounds:
	/* H *= [r^z,r^z] */
	power = initial_power;
	T0 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R20.v), _mm_mul_epu32(H1, power->S24.v)), _mm_mul_epu32(H2, power->S23.v)), _mm_mul_epu32(H3, power->S22.v)), _mm_mul_epu32(H4, power->S21.v));
	T1 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R21.v), _mm_mul_epu32(H1, power->R20.v)), _mm_mul_epu32(H2, power->S24.v)), _mm_mul_epu32(H3, power->S23.v)), _mm_mul_epu32(H4, power->S22.v));
	T2 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R22.v), _mm_mul_epu32(H1, power->R21.v)), _mm_mul_epu32(H2, power->R20.v)), _mm_mul_epu32(H3, power->S24.v)), _mm_mul_epu32(H4, power->S23.v));
	T3 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R23.v), _mm_mul_epu32(H1, power->R22.v)), _mm_mul_epu32(H2, power->R21.v)), _mm_mul_epu32(H3, power->R20.v)), _mm_mul_epu32(H4, power->S24.v));
	T4 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R24.v), _mm_mul_epu32(H1, power->R23.v)), _mm_mul_epu32(H2, power->R22.v)), _mm_mul_epu32(H3, power->R21.v)), _mm_mul_epu32(H4, power->R20.v));

	for (p = 1; p < powers; p++) {
		/* H += [Mx,My]*[r^(z-p*2),r^(z-p*2))] */
		T5 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 0)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 16)), 8));
		T6 = _mm_or_si128(_mm_loadl_epi64((xmmi *)(m + 8)), _mm_slli_si128(_mm_loadl_epi64((xmmi *)(m + 24)), 8));
		M0 = _mm_and_si128(MMASK, T5);
		M1 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		T5 = _mm_or_si128(_mm_srli_epi64(T5, 52), _mm_slli_epi64(T6, 12));
		M2 = _mm_and_si128(MMASK, T5);
		M3 = _mm_and_si128(MMASK, _mm_srli_epi64(T5, 26));
		M4 = _mm_or_si128(_mm_srli_epi64(T6, 40), HIBIT);
		
		m += 32;

		power++;
		T0 = _mm_add_epi64(T0,_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(M0, power->R20.v), _mm_mul_epu32(M1, power->S24.v)), _mm_mul_epu32(M2, power->S23.v)), _mm_mul_epu32(M3, power->S22.v)), _mm_mul_epu32(M4, power->S21.v)));
		T1 = _mm_add_epi64(T1,_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(M0, power->R21.v), _mm_mul_epu32(M1, power->R20.v)), _mm_mul_epu32(M2, power->S24.v)), _mm_mul_epu32(M3, power->S23.v)), _mm_mul_epu32(M4, power->S22.v)));
		T2 = _mm_add_epi64(T2,_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(M0, power->R22.v), _mm_mul_epu32(M1, power->R21.v)), _mm_mul_epu32(M2, power->R20.v)), _mm_mul_epu32(M3, power->S24.v)), _mm_mul_epu32(M4, power->S23.v)));
		T3 = _mm_add_epi64(T3,_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(M0, power->R23.v), _mm_mul_epu32(M1, power->R22.v)), _mm_mul_epu32(M2, power->R21.v)), _mm_mul_epu32(M3, power->R20.v)), _mm_mul_epu32(M4, power->S24.v)));
		T4 = _mm_add_epi64(T4,_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(M0, power->R24.v), _mm_mul_epu32(M1, power->R23.v)), _mm_mul_epu32(M2, power->R22.v)), _mm_mul_epu32(M3, power->R21.v)), _mm_mul_epu32(M4, power->R20.v)));
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
	power->R20.u[1] = r0;
	power->R21.u[1] = r1;
	power->R22.u[1] = r2;
	power->R23.u[1] = r3;
	power->R24.u[1] = r4;

	power->S21.u[1] = s1;
	power->S22.u[1] = s2;
	power->S23.u[1] = s3;
	power->S24.u[1] = s4;

	/* H *= [r^2,r] */
	T0 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R20.v), _mm_mul_epu32(H1, power->S24.v)), _mm_mul_epu32(H2, power->S23.v)), _mm_mul_epu32(H3, power->S22.v)), _mm_mul_epu32(H4, power->S21.v));
	T1 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R21.v), _mm_mul_epu32(H1, power->R20.v)), _mm_mul_epu32(H2, power->S24.v)), _mm_mul_epu32(H3, power->S23.v)), _mm_mul_epu32(H4, power->S22.v));
	T2 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R22.v), _mm_mul_epu32(H1, power->R21.v)), _mm_mul_epu32(H2, power->R20.v)), _mm_mul_epu32(H3, power->S24.v)), _mm_mul_epu32(H4, power->S23.v));
	T3 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R23.v), _mm_mul_epu32(H1, power->R22.v)), _mm_mul_epu32(H2, power->R21.v)), _mm_mul_epu32(H3, power->R20.v)), _mm_mul_epu32(H4, power->S24.v));
	T4 = _mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_add_epi64(_mm_mul_epu32(H0, power->R24.v), _mm_mul_epu32(H1, power->R23.v)), _mm_mul_epu32(H2, power->R22.v)), _mm_mul_epu32(H3, power->R21.v)), _mm_mul_epu32(H4, power->R20.v));

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

	/* must be reduced in case it goes straight to finish */
	h0 = _mm_cvtsi128_si32(H0)    ; b = (h0 >> 26); h0 &= 0x3ffffff;
	h1 = _mm_cvtsi128_si32(H1) + b; b = (h1 >> 26); h1 &= 0x3ffffff;
	h2 = _mm_cvtsi128_si32(H2) + b; b = (h2 >> 26); h2 &= 0x3ffffff;
	h3 = _mm_cvtsi128_si32(H3) + b; b = (h3 >> 26); h3 &= 0x3ffffff;
	h4 = _mm_cvtsi128_si32(H4) + b; b = (h4 >> 26); h4 &= 0x3ffffff;
	h0 =              h0 + (b * 5);

	if (inlen < 16) goto poly1305_donna_atmost15bytes;

poly1305_donna_16bytes:
	t0 = U8TO32_LE(m);
	t1 = U8TO32_LE(m+4);
	t2 = U8TO32_LE(m+8);
	t3 = U8TO32_LE(m+12);

	m += 16;
	inlen -= 16;

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

	if (inlen >= 16) goto poly1305_donna_16bytes;

	/* final bytes */
poly1305_donna_atmost15bytes:
	if (!inlen) goto poly1305_donna_finish;

	for (i = 0; i < inlen; i++) mp[i] = m[i];
	mp[i++] = 1;
	for (; i < 16; i++)	mp[i] = 0;
	inlen = 0;

	t0 = U8TO32_LE(mp+0);
	t1 = U8TO32_LE(mp+4);
	t2 = U8TO32_LE(mp+8);
	t3 = U8TO32_LE(mp+12);

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
	h0 += b * 5;

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

	f0 = ((h0      ) | (h1 << 26)) + (uint64_t)U8TO32_LE(&key[16]);
	f1 = ((h1 >>  6) | (h2 << 20)) + (uint64_t)U8TO32_LE(&key[20]);
	f2 = ((h2 >> 12) | (h3 << 14)) + (uint64_t)U8TO32_LE(&key[24]);
	f3 = ((h3 >> 18) | (h4 <<  8)) + (uint64_t)U8TO32_LE(&key[28]);

	U32TO8_LE(&out[ 0], (uint32_t)f0); f1 += (f0 >> 32);
	U32TO8_LE(&out[ 4], (uint32_t)f1); f2 += (f1 >> 32);
	U32TO8_LE(&out[ 8], (uint32_t)f2); f3 += (f2 >> 32);
	U32TO8_LE(&out[12], (uint32_t)f3);
}
