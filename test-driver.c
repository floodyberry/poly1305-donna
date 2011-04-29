#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include "poly1305-defines.h"

#if defined(CPU_64BITS)
	#define test_suffix "-m64"
#else
	#define test_suffix "-m32"
#endif

#define build_suffix  test_suffix " " test_suffix

const char *buildstrings[] = {
#if defined(CPU_X86)
	"gcc test-poly1305.c poly1305-x86.s -Dpoly1305_auth=poly1305_x86_auth -O3 -o test-poly1305" build_suffix,
#endif
#if defined(CPU_X86_64)
	"gcc test-poly1305.c poly1305-amd64.s -Dpoly1305_auth=poly1305_amd64_auth -O3 -o test-poly1305" build_suffix,
#endif
#if defined(CPU_64BITS)
	"gcc test-poly1305.c poly1305-donna-c64.c -Dpoly1305_auth=poly1305_donna_c64_auth -O3 -o test-poly1305" build_suffix,
	"gcc test-poly1305.c poly1305-donna-c64-unrolled.c -Dpoly1305_auth=poly1305_donna_c64_unrolled_auth -O3 -o test-poly1305" build_suffix,
#endif
	"gcc test-poly1305.c poly1305-donna.c -Dpoly1305_auth=poly1305_donna_auth -O3 -o test-poly1305" build_suffix,
	"gcc test-poly1305.c poly1305-donna-unrolled.c -Dpoly1305_auth=poly1305_donna_unrolled_auth -O3 -o test-poly1305" build_suffix,
	NULL
};


int main(int argc, const char *argv[]) {
	uint32_t limit, valid;
	const char **build;
	char cmd[512], out[64], expected[32];

	FILE *f;

	for (limit = 1; limit < (1 << 31); limit <<= 1) {
		printf("\n%u passes\n", limit);
		
		for (build = buildstrings; *build; build++) {
			if (system(*build))
				continue;
			memset(out, 0, sizeof(out));
			sprintf(cmd, "./test-poly1305%s %u | openssl md5", test_suffix, limit);
			f = popen(cmd, "r");
			valid = (f != NULL);
			valid = (valid && (fgets(out, sizeof(out) - 1, f) != NULL));
			out[32] = 0;
			printf("%s [%s]\n", (valid) ? out : "error", *build);
			if (f) pclose(f);
		}
	}
	return 0;
}