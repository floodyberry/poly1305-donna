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
	{"x86sse2", compiler " test-poly1305.c poly1305-donna-x86-sse2.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86)
	{"x86sse2inc", compiler " test-poly1305.c poly1305-donna-x86-sse2-incremental.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64asm", compiler " test-poly1305.c poly1305-amd64.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64sse2", compiler " test-poly1305.c poly1305-donna-x64-sse2.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_X86_64)
	{"x64sse2inc", compiler " test-poly1305.c poly1305-donna-x64-sse2-incremental.s -O3 -o test-poly1305" build_suffix},
#endif
#if defined(CPU_64BITS)
	{"64bit", compiler " test-poly1305.c poly1305-donna-c64-unrolled.c -O3 -o test-poly1305" build_suffix},
#endif
	{"32bit", compiler " test-poly1305.c poly1305-donna-unrolled.c -O3 -o test-poly1305" build_suffix},
	{NULL, NULL}
};

const char *expected_results[] = {
	"a933ab9578c96afbead50ccf469efab", // 1
	"0097ebfc35519252eb4608b85ba8b73", // 2
	"ba072acd2dbf1b749d2ca8df9926e8b", // 4
	"931e6ca162c42b53513a4f0486dd53f", // 8
	"9e92e20aa89a034fb62783d3014fb31", // 16
	"be7a854af6240daf1bf1b9f288fb79a", // 32
	"2fcaa6b7926ddb784995fdeb303a654", // 64
	"8e0ea84e3ed9e7e385d9bfdfec6c9ef", // 128
	"8136135a031d93eebf93f808752749a", // 256
	"ccd06d453540326a6c09c58fd93d940", // 512
	"10b76a178ef4b66fddaa949ac73db5e", // 1024
	"83366b86cd87608ea3d495a37870088", // 2048
	"8ae081025ff1884a2cee7b06dd7f4c3", // 4096
	"0fe0e93443f613627ffe5eca4a3315d", // 8192
	"b52aea61313b2f8a5f792a6a3602c2d", // 16384
	"a173e0a346eef4a8f02baa1829d2dc1", // 32768
	"6babfabf935f851a078222c0e90d771", // 65536
	"de808915af9f33c936f5846c5a15a4c", // 131072
	"a83e63d1285ab21078f5c4b1a0d38ec", // 262144
	"2dacc38b2020c77ab5777232eb87638", // 524288
	"5aa13384b368bf1c115aa5e3d925d0e", // 1048576
	"6402d9da3c4efa892a0f79aec8ac2b3", // 2097152
	"c8afc7a23b9dbf2e432ab6525fd5982", // 4194304
	"42ccfd25eea89c04a0da1e70406456c", // 8388608
	"2654250e00491a03c024cd4634171ea", // 16777216
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