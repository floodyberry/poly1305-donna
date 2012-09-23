#ifndef POLY1305_DONNA_H
#define POLY1305_DONNA_H

#include <stddef.h>

void poly1305_auth(unsigned char mac[16], const unsigned char *m, size_t len, const unsigned char key[32]);

#endif /* POLY1305_DONNA_H */
