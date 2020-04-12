#include <stdio.h>
#include "poly1305-donna.h"
#include "poly1305-rfc-test-vectors.h"

int
main(void) {
	const unsigned char expected[16] = {0xdd,0xb9,0xda,0x7d,0xdd,0x5e,0x52,0x79,0x27,0x30,0xed,0x5c,0xda,0x5f,0x90,0xa4};
	unsigned char key[32];
	unsigned char mac[16];
	unsigned char msg[73];
	size_t i;
	int success = poly1305_power_on_self_test();

	printf("poly1305 self test: %s\n", success ? "successful" : "failed");
	if (!success)
		return 1;

	for (i = 0; i < sizeof(key); i++)
		key[i] = (unsigned char)(i + 221);
	for (i = 0; i < sizeof(msg); i++)
		msg[i] = (unsigned char)(i + 121);
	poly1305_auth(mac, msg, sizeof(msg), key);

	printf("sample mac is ");
	for (i = 0; i < sizeof(mac); i++)
		printf("%02x", mac[i]);
	printf(" (%s)\n", poly1305_verify(expected, mac) ? "correct" : "incorrect");

	for (i = 0; i<sizeof(rfc_test_vectors)/sizeof(rfc_test_vectors[0]); i++) {
		poly1305_auth(mac, rfc_test_vectors[i].msg, rfc_test_vectors[i].msg_length, rfc_test_vectors[i].key);
		printf("test vector %02d (%s)\n", (int)i+1, poly1305_verify(rfc_test_vectors[i].mac, mac) ? "passed" : "failed");
	}

	return 0;
}
