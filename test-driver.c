#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include "portable-jane.h"

#define compiler "gcc"

#if defined(CPU_64BITS)
	#define test_suffix "-m64"
#else
	#define test_suffix "-m32"
#endif

#define build_suffix  test_suffix " " test_suffix


typedef struct builds_t {
	const char *type, *build_string;
} builds;

builds build_list[] = {
#if defined(CPU_X86)
	{"x86asm", compiler " test-poly1305.c poly1305-x86.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86)
	{"x86sse2", compiler " test-poly1305.c poly1305-donna-x86-sse2.S -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86)
	{"x86sse2inc", compiler " test-poly1305.c poly1305-donna-x86-sse2-incremental-source.c -msse2 -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64asm", compiler " test-poly1305.c poly1305-amd64.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64sse2", compiler " test-poly1305.c poly1305-donna-x64-sse2.S -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64sse2inc", compiler " test-poly1305.c poly1305-donna-x64-sse2-incremental-source.c -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_64BITS)
	{"64bit", compiler " test-poly1305.c poly1305-donna-c64-unrolled.c -O3 -o test-poly1305" build_suffix},
#endif
	{"32bit", compiler " test-poly1305.c poly1305-donna-unrolled.c -O3 -o test-poly1305" build_suffix},
	{NULL, NULL}
};


const char *expected_results[] = {
	"16b6ab5222d25c5f08fc13a1638cf11", // 1
	"60d520dc7f639f3bb01f295d0d9ea1e", // 2
	"b7652080ae800f24a2926f4c7928f84", // 4
	"f7217bd4f943e259b80de420e612227", // 8
	"19d614823248c38a35eb05725cfded1", // 16
	"fde4567a193176d18ca79ecf58023a0", // 32
	"0ef2739aa6cb50c81ca20e8ea47eac7", // 64
	"cb14d35e52ae9fb320acd4aecc81697", // 128
	"1b4297eb8fb23d524f9426ca898ee99", // 256
	"8e1bac6fa41637d47f6e70421bd95b4", // 512
	"7807faeae65dd9e523f529f3b51efcc", // 1024
	"d1999ee39a277785063598dc0e61ba7", // 2048
	"07d1aa451562f0f29aa70aa7873b839", // 4096
	"8e5a7ed4b5d061608c2e78e14f9987a", // 8192
	"3d9e521d0ea74d8d518a4aac0885241", // 16384
	"d94d3985ef14ca4660386ca04b79845", // 32768
	"8d5f5b148bc86183b71ac6bf936b1ea", // 65536
	"eb4b81d66be9f5b27760a94b798cd69", // 131072
	"529362340a18afa3acd6e4d3862a82f", // 262144
	"62abd039c4f18eed3d059585c7f74df", // 524288
	NULL
};

int main(int argc, const char *argv[]) {
	uint32_t limit, valid;
	builds *build;
	char cmd[512], out[33] = {0};
	const char *specific_test = (argc > 1) ? argv[1] : NULL;
	const char **expected_result = expected_results, *verdict;
	int specific_test_seen = 0;
	FILE *f;

	printf("USAGE: test-driver%s [", test_suffix);
	for (build = build_list; build->type; build++) {
		printf("%s%s", build->type, (build+1)->type ? ",":"");
		if (specific_test)
			specific_test_seen |= (strcmp(build->type, specific_test) == 0);
	}
	printf("]\n\n");

	if (specific_test && !specific_test_seen) {
		printf("  unknown type %s!\n\n", specific_test);
		return 1;
	}

	for (limit = 1; limit < (1 << 31); limit <<= 1) {
		printf("\n%u passes\n", limit);

		for (build = build_list; build->type; build++) {
			if (specific_test && (strcmp(build->type, specific_test) != 0))
				continue;
			if (system(build->build_string))
				goto finished;
			memset(out, 0, sizeof(out));
			sprintf(cmd, "./test-poly1305%s %u | md5sum", test_suffix, limit);
			f = popen(cmd, "r");
			if (!f)
				verdict = "FAIL OPEN";
			else if (!fgets(out, 32, f))
				verdict = "FAIL READ";
			else if (*expected_result && (memcmp(*expected_result, out, 32) != 0))
				verdict = "INCORRECT";
			else if (!*expected_result)
				verdict = out;
			else
				verdict = "SUCCESS  ";
			if (f)
				pclose(f);
			printf("%s [%s]\n", verdict, build->build_string);
		}

		if (*expected_result)
			expected_result++;
	}

finished:
	return 0;
}