#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(_MSC_VER)
	#define random rand
	#define srandom srand
#endif

extern void poly1305_auth(unsigned char mac[16], const unsigned char *m, size_t len, const unsigned char key[32]);

#define MAXLEN 1000
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
	
	for (i = 0; i < MAXLEN; i++)  m[i] = ((i * 0xcafebabe) ^ lim) * 0xdeadbeef;
	for (i = 0; i < 32; i++)     kr[i] = ((i * 0xdeadbeef) ^ lim) * 0xcafebabe;

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
