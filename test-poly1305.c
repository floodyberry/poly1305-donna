#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "poly1305-donna.h"
#include "portable-jane.h"

#if defined(_MSC_VER)
	#define random rand
	#define srandom srand
#endif

void make_dummy_data(unsigned char *out, uint32_t len, uint32_t seed) {
	static const uint32_t cm = 0x5bd1e995, cn = 0xa1e38b93, cr = 24, ca = 0x965cd12b;
	uint32_t i, leftover = len & 3, ctr = 0, h = seed + len;
	unsigned char tmp[4], *end = out + (len - leftover);
	
	#define dummy_churn(h,ctr) \
		h ^= ctr; \
		ctr += ca; \
		h = (h ^ (h >> cr)) * cm;

	for (; out < end; out += 4) {
		dummy_churn(h,ctr)
		U32TO8_LE(out, h + ctr);
	}
	if (leftover) {
		dummy_churn(h,ctr)
		h += ctr;
		for (i = 0; i < leftover; i++, h >>= 8)
			out[i] = (h & 0xff);
	}
}

#define MAXLEN 3080
unsigned char out[16];
unsigned char mod[16];
unsigned char kr[32];
unsigned char m[MAXLEN];

int main(int argc, const char *argv[]) {
	int loop, len, i, x, y, lim = 1000;
	
	if (argc > 1) {
		lim = atoi(argv[1]);
		srandom(lim);
	}

	make_dummy_data(m, MAXLEN, 0xcafebabe ^ lim);
	make_dummy_data(kr, 32, 0xdeadbeef ^ lim);

	for (loop = 0;loop < lim;++loop) {
		len = 0;
		for (;;) {
			poly1305_auth(out,m,len,kr);
			for (i = 0;i < 16;++i) printf("%02x",(unsigned int) out[i]);
			printf("\n");
			x = random() & 15;
			y = 1 + (random() % 255);
			out[x] += y;
			poly1305_auth(mod,m,len,kr);
			if (memcmp(out,mod,16) == 0) {
				printf("poly1305 succeeded on bad input\n");
				return 1;
			}
			out[x] -= y;
			if (len >= MAXLEN) break;
			if (len % 2) for (i = 0;i < 16;++i) kr[i] ^= out[i];
			if (len % 3) for (i = 0;i < 16;++i) kr[i + 16] ^= out[i];
			m[len++] ^= out[0];
		}
	}
	return 0;
}
