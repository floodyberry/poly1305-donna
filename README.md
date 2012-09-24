"A state-of-the-art message-authentication code"

# ABOUT

See: [http://cr.yp.to/mac.html](http://cr.yp.to/mac.html) and [http://cr.yp.to/mac/poly1305-20050329.pdf](http://cr.yp.to/mac/poly1305-20050329.pdf)

These are portable, and in the case of the 64 bit & SSE2 versions, fairly performant, versions of poly1305.

# PERFORMANCE (on an E5200 2.5ghz)

16 and 256 bytes are reported in raw cycles, 8192 bytes is cycles/byte. Sorted by long message speed.

<table>
<thead><tr><th>Implemenation</th><th>16 bytes</th><th>256 bytes</th><th>8192 bytes</th></tr></thead>
<tbody>
<tr> <td>donna 64bit SSE2 asm</td> <td>125</td> <td>750</td> <td>1.75</td> </tr>
<tr> <td>donna 32bit SSE2 asm</td> <td>238</td> <td>975</td> <td>1.97</td> </tr>
<tr> <td>donna 64bit (gcc/icc)</td> <td>150</td> <td>888</td> <td>3.07</td> </tr>
<tr> <td>djb 64bit fp</td> <td>212</td> <td>1000</td> <td>3.33</td> </tr>
<tr> <td>djb 32bit fp</td> <td>212</td> <td>1012</td> <td>3.35</td> </tr>
<tr> <td>donna 32bit (icc)</td> <td>238</td> <td>1850</td> <td>6.79</td> </tr>
<tr> <td>donna 32bit (clang)</td> <td>287</td> <td>2150</td> <td>7.74</td> </tr>
<tr> <td>donna 32bit (gcc)</td> <td>337</td> <td>3025</td> <td>11.24</td> </tr>
</tbody>
</table>

# BUILDING

    gcc [poly1305 version] -O3 -o poly1305.o

where "poly1305 version" is one of

 * -m64 poly1305-donna-c64-unrolled.c
 * -m64 poly1305-donna-x64-sse2.s
 * -m32 poly1305-donna-unrolled.c
 * -m32 poly1305-donna-x86-sse2.s

and link against poly1305.o

The .c source for the SSE2 versions is for inspection only. Compilers are not guaranteed to generate
decent code, so I included .s versions compiled with icc for the best performance.

# USAGE

See: [http://nacl.cace-project.eu/onetimeauth.html](http://nacl.cace-project.eu/onetimeauth.html), in specific, slightly plagiarized:

The poly1305_auth function, viewed as a function of the message for a uniform random key, is 
designed to meet the standard notion of unforgeability after a single message. After the sender 
authenticates one message, an attacker cannot find authenticators for any other messages.

The sender MUST NOT use poly1305_auth to authenticate more than one message under the same key.
Authenticators for two messages under the same key should be expected to reveal enough information 
to allow forgeries of authenticators on other messages. 


# TESTING

test-poly1305.c tests a specific poly1305 version for the specified repetitions. Run the output 
through "openssl md5" to create a fingerprint for the test which can be checked against known 
working versions. djb's poly1305-x86.s and poly1305-amd64.s are included to validate against.

test-driver.c (gcc only, requires openssl to be installed) automates testing of all available 
versions. The fingerprints for 2^0 to 2^24 trials are included in test-driver.c and are checked 
against automatically.


LICENSE
=======

[MIT](http://www.opensource.org/licenses/mit-license.php) or PUBLIC DOMAIN


NAMESAKE
========

I borrowed the idea for these from Adam Langley's [curve25519-donna](http://github.com/agl/curve25519-donna), hence
the name.