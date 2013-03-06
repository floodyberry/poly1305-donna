#ifndef POLY1305_DONNA_H
#define POLY1305_DONNA_H

#include <stddef.h>

typedef unsigned char poly1305_state[512];

void poly1305_init(poly1305_state *state, const unsigned char key[32]);
void poly1305_update(poly1305_state *state, const unsigned char *m, size_t bytes);
void poly1305_finish(poly1305_state *state, unsigned char mac[16]);
void poly1305_auth(unsigned char mac[16], const unsigned char *m, size_t inlen, const unsigned char key[32]);

#endif /* POLY1305_DONNA_H */

