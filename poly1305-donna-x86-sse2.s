.text
.align 16,0x90
.globl poly1305_auth
poly1305_auth:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
movl %esp, %ebp
andl $~64, %esp
subl $2364, %esp
movl 20(%ebp), %eax
movl 24(%ebp), %ebx
movl 28(%ebp), %ecx
movl 32(%ebp), %edx
movl %eax, 2320(%esp)
movl %ebx, 2324(%esp)
movl %ecx, 2328(%esp)
movl %edx, 2332(%esp)
movl %ebp, 2336(%esp)
movl 2332(%esp), %eax
movl 2324(%esp), %ebx
movl %ebx, 2132(%esp)
movl 4(%eax), %ebp
movl %ebp, %esi
movl (%eax), %edx
movl %edx, %edi
shrl $26, %edx
andl $67108863, %edi
shll $6, %esi
movl 8(%eax), %ecx
orl %esi, %edx
movl 12(%eax), %eax
movl %eax, %esi
movl %edi, 2284(%esp)
movl %ecx, %edi
shrl $20, %ebp
andl $67108611, %edx
shll $12, %edi
shrl $14, %ecx
orl %edi, %ebp
shll $18, %esi
andl $67092735, %ebp
shrl $8, %eax
orl %esi, %ecx
andl $66076671, %ecx
andl $1048575, %eax
movl 2328(%esp), %ebx
cmpl $16, %ebx
movl %edx, 2280(%esp)
lea (%edx,%edx,4), %edx
movl %ebp, 2276(%esp)
lea (%ebp,%ebp,4), %ebp
movl %ecx, 2272(%esp)
lea (%ecx,%ecx,4), %ecx
movl %eax, 2268(%esp)
lea (%eax,%eax,4), %eax
movl %ebx, 2136(%esp)
movdqa poly1305_x86_sse2_message_mask, %xmm4
movdqa poly1305_x86_sse2_5, %xmm1
movdqa poly1305_x86_sse2_1shl128, %xmm5
movl %edx, 2264(%esp)
movl %ebp, 2260(%esp)
movl %ecx, 2256(%esp)
movl %eax, 2140(%esp)
jb ..B1.18

..B1.2:
cmpl $32, 2136(%esp)
jb ..B1.17

..B1.3:
movl %ebx, %ecx
movl $-1431655765, %eax
addl $-32, %ecx
movdqa %xmm4, %xmm3
mull %ecx
movl 2132(%esp), %ebx
lea (%esp), %ebp
shrl $9, %edx
incl %edx
movq 16(%ebx), %xmm0
movq (%ebx), %xmm6
pslldq $8, %xmm0
movq 24(%ebx), %xmm2
por %xmm0, %xmm6
movq 8(%ebx), %xmm0
addl $32, %ebx
cmpl $13, %edx
pand %xmm6, %xmm3
movl 2280(%esp), %edi
movdqa %xmm6, %xmm7
movl %ebx, 2132(%esp)
movl $13, %ebx
movl %edi, 1924(%esp)
cmovb %edx, %ebx
movl 2276(%esp), %edi
psrlq $52, %xmm6
movl %edi, 1920(%esp)
movl %ebx, %edx
movl 2272(%esp), %edi
psrlq $26, %xmm7
pslldq $8, %xmm2
lea (%ebx,%ebx,8), %eax
movl %edi, 1916(%esp)
por %xmm2, %xmm0
movl 2268(%esp), %edi
movdqa %xmm0, %xmm2
movl %edi, 1912(%esp)
psllq $12, %xmm2
movl 2264(%esp), %edi
por %xmm2, %xmm6
shll $4, %eax
movdqa %xmm4, %xmm2
movl %edi, 1892(%esp)
pand %xmm6, %xmm2
movl 2260(%esp), %edi
psrlq $26, %xmm6
movl %edi, 1908(%esp)
psrlq $40, %xmm0
movl 2256(%esp), %edi
lea -144(%esp,%eax), %esi
movl %edi, 1904(%esp)
pand %xmm4, %xmm7
movl 2140(%esp), %edi
pand %xmm4, %xmm6
shll $5, %edx
por %xmm5, %xmm0
movl %ecx, 2136(%esp)
testl %ebx, %ebx
movdqa %xmm3, 2160(%esp)
movdqa %xmm7, 1872(%esp)
movl %esi, 1956(%esp)
movl 2284(%esp), %ecx
movl %edi, 1900(%esp)
jbe ..B1.10

..B1.4:
movl %eax, 1952(%esp)
movl %ebp, 2128(%esp)
movl $0, 1968(%esp)
movdqa %xmm5, 2176(%esp)
movdqa %xmm4, 2144(%esp)
movl %edx, 1888(%esp)
movl %esi, 1964(%esp)
movl %ecx, 1896(%esp)
movl %ebx, 1960(%esp)
movl 1908(%esp), %eax
movl 1892(%esp), %ebp

..B1.5:
movl 1912(%esp), %esi
movl %eax, 1908(%esp)
lea (%esi,%esi), %edi
movl 1896(%esp), %esi
movl %esi, %eax
mull %esi
movl %eax, %ecx
movl %edi, %eax
movl %edx, %ebx
mull %ebp
movl 1920(%esp), %ebp
addl %eax, %ecx
movl %ebp, 1936(%esp)
adcl %edx, %ebx
movl %edi, 1892(%esp)
lea (%ebp,%ebp), %eax
mull 1904(%esp)
addl %eax, %ecx
movl %esi, %eax
movl 1916(%esp), %ebp
adcl %edx, %ebx
movl 1924(%esp), %edx
movl %ecx, 1928(%esp)
addl %ebp, %ebp
movl %ebp, 1940(%esp)
lea (%esi,%esi), %ebp
movl %ebp, 1944(%esp)
addl %edx, %edx
movl %edx, 1932(%esp)
mull %edx
movl %eax, %ebp
movl %edi, %eax
movl %edx, %esi
mull 1908(%esp)
addl %eax, %ebp
movl 1916(%esp), %eax
movl 1904(%esp), %edi
adcl %edx, %esi
mull %edi
shll $6, %ebx
shrl $26, %ecx
orl %ecx, %ebx
addl %ebx, %eax
adcl $0, %edx
addl %eax, %ebp
movl 1924(%esp), %eax
adcl %edx, %esi
mull %eax
movl %eax, %ecx
movl %edx, %ebx
movl 1936(%esp), %eax
mull 1944(%esp)
addl %eax, %ecx
movl 1892(%esp), %eax
adcl %edx, %ebx
mull %edi
movl %ebp, 1948(%esp)
shll $6, %esi
shrl $26, %ebp
orl %ebp, %esi
addl %esi, %eax
movl 1936(%esp), %esi
adcl $0, %edx
addl %eax, %ecx
movl 1932(%esp), %eax
movl %ecx, %edi
adcl %edx, %ebx
andl $67108863, %edi
mull %esi
shll $6, %ebx
movl %eax, %ebp
shrl $26, %ecx
movl 1896(%esp), %eax
orl %ecx, %ebx
movl 1940(%esp), %ecx
movl %edi, 1920(%esp)
movl %edx, %edi
mull %ecx
addl %eax, %ebp
movl 1912(%esp), %eax
adcl %edx, %edi
mull 1900(%esp)
addl %eax, %ebp
movl %esi, %eax
movd 1920(%esp), %xmm4
adcl %edx, %edi
addl %ebp, %ebx
movl %ebx, %ebp
adcl $0, %edi
andl $67108863, %ebp
mull %esi
shll $6, %edi
movl %edx, %esi
shrl $26, %ebx
orl %ebx, %edi
movl %eax, %ebx
movl %ecx, %eax
mull 1924(%esp)
addl %eax, %ebx
movl 1944(%esp), %eax
adcl %edx, %esi
mull 1912(%esp)
addl %eax, %ebx
movl 1928(%esp), %ecx
adcl %edx, %esi
movl $5, %eax
addl %ebx, %edi
movl %edi, %ebx
adcl $0, %esi
andl $67108863, %ecx
shll $6, %esi
andl $67108863, %ebx
shrl $26, %edi
orl %edi, %esi
mull %esi
addl %eax, %ecx
movl 1948(%esp), %esi
movl %ecx, %edx
shrl $26, %ecx
andl $67108863, %esi
andl $67108863, %edx
movl %edx, 1896(%esp)
movl %ebx, 1912(%esp)
movl %ebp, 1916(%esp)
addl %esi, %ecx
movd %edx, %xmm3
movl 1964(%esp), %edx
pshufd $68, %xmm3, %xmm7
movd %ebp, %xmm3
movd %ecx, %xmm5
movdqa %xmm7, (%edx)
pshufd $68, %xmm5, %xmm7
pshufd $68, %xmm4, %xmm5
pshufd $68, %xmm3, %xmm4
movd %ebx, %xmm3
pshufd $68, %xmm3, %xmm3
movdqa %xmm7, 16(%edx)
movdqa %xmm5, 32(%edx)
movdqa %xmm4, 48(%edx)
movdqa %xmm3, 64(%edx)
pmuludq %xmm1, %xmm7
pmuludq %xmm1, %xmm5
pmuludq %xmm1, %xmm4
pmuludq %xmm1, %xmm3
movd %xmm7, %ebp
movd %xmm5, %eax
movdqa %xmm7, 80(%edx)
movdqa %xmm5, 96(%edx)
movl 1968(%esp), %ebx
incl %ebx
movl %ecx, 1924(%esp)
movl %edx, %ecx
movdqa %xmm4, 112(%edx)
movdqa %xmm3, 128(%edx)
addl $-144, %edx
movd %xmm4, 1904(%esp)
movd %xmm3, 1900(%esp)
movl %ebx, 1968(%esp)
movl %edx, 1964(%esp)
cmpl 1960(%esp), %ebx
jae ..B1.9

..B1.6:
cmpl $2, 1968(%esp)
jb ..B1.5

..B1.8:
movl 1956(%esp), %edx
movl %edx, %esi
movl %esi, %edi
movl (%edx), %eax
mull (%ecx)
movl %eax, %ebp
movl %edx, %ebx
movl 16(%esi), %eax
mull 128(%ecx)
addl %eax, %ebp
movl 32(%edi), %eax
adcl %edx, %ebx
mull 112(%ecx)
addl %eax, %ebp
movl 48(%esi), %eax
adcl %edx, %ebx
mull 96(%ecx)
movl %edx, %esi
movl %eax, %edi
movl 1956(%esp), %edx
movl 80(%ecx), %eax
movl %ecx, 1892(%esp)
mull 64(%edx)
addl %eax, %edi
movl 64(%ecx), %eax
adcl %edx, %esi
addl %edi, %ebp
movl %ebp, 1896(%esp)
movl 1956(%esp), %ebp
adcl %esi, %ebx
movl %ebx, 1900(%esp)
movl %ebp, %ebx
movl %ebx, %esi
mull (%ebp)
movl %eax, %ebp
movl %edx, %edi
movl (%ecx), %eax
mull 64(%ebx)
addl %eax, %ebp
movl 48(%ebx), %eax
adcl %edx, %edi
mull 16(%ecx)
addl %eax, %ebp
movl 32(%esi), %eax
adcl %edx, %edi
mull 32(%ecx)
movl %eax, %ebx
movl %edx, %esi
movl 1956(%esp), %eax
movl 16(%eax), %eax
mull 48(%ecx)
addl %eax, %ebx
movl (%ecx), %eax
adcl %edx, %esi
addl %ebx, %ebp
movl %ebp, 1904(%esp)
movl 1956(%esp), %ebp
adcl %esi, %edi
movl %edi, 1908(%esp)
movl %ebp, %ebx
mull 16(%ebp)
movl %eax, %esi
movl %edx, %edi
movl 128(%ecx), %eax
mull 32(%ebp)
addl %eax, %esi
movl 112(%ecx), %eax
adcl %edx, %edi
mull 48(%ebx)
movl %eax, %ebp
movl %edx, %ebx
movl 96(%ecx), %eax
movl 1956(%esp), %ecx
mull 64(%ecx)
addl %eax, %ebp
movl (%ecx), %eax
adcl %edx, %ebx
addl %ebp, %esi
movl 1892(%esp), %ebp
movl 1900(%esp), %ecx
adcl %ebx, %edi
movl 1896(%esp), %ebx
mull 16(%ebp)
shll $6, %ecx
shrl $26, %ebx
orl %ebx, %ecx
addl %ecx, %eax
movl 1956(%esp), %ecx
adcl $0, %edx
addl %eax, %esi
movl %esi, 1912(%esp)
movl %ebp, %esi
adcl %edx, %edi
movl %edi, 1916(%esp)
movl %ebp, %edi
movl (%esi), %eax
mull 32(%ecx)
movl %eax, %esi
movl %edx, %ebx
.byte 15
.byte 31
.byte 64
.byte 0
movl 128(%edi), %eax
mull 48(%ecx)
addl %eax, %esi
movl 112(%ebp), %eax
adcl %edx, %ebx
mull 64(%ecx)
movl %edx, %ebp
movl %eax, %edi
movl 1892(%esp), %edx
movl 16(%ecx), %eax
mull 16(%edx)
addl %eax, %edi
movl (%ecx), %eax
movl 1892(%esp), %ecx
adcl %edx, %ebp
addl %edi, %esi
.byte 102
.byte 144
movl 1916(%esp), %edi
adcl %ebp, %ebx
mull 32(%ecx)
movl 1912(%esp), %ebp
shll $6, %edi
shrl $26, %ebp
orl %ebp, %edi
addl %edi, %eax
movl %ecx, %ebp
movl %ebp, %edi
adcl $0, %edx
addl %eax, %esi
movl %esi, 1920(%esp)
adcl %edx, %ebx
movl %ebx, 1924(%esp)
movl %ecx, %ebx
movl 1956(%esp), %esi
movl (%ebx), %eax
mull 48(%esi)
movl %eax, %ecx
movl %edx, %ebx
movl 128(%ebp), %eax
.byte 15
.byte 31
.byte 0
mull 64(%esi)
addl %eax, %ecx
movl 32(%esi), %eax
adcl %edx, %ebx
mull 16(%edi)
movl %edx, %ebp
movl %eax, %edi
movl 1892(%esp), %edx
movl 16(%esi), %eax
mull 32(%edx)
addl %eax, %edi
movl (%esi), %eax
movl 1892(%esp), %esi
adcl %edx, %ebp
addl %edi, %ecx
movl 1924(%esp), %edi
adcl %ebp, %ebx
mull 48(%esi)
movl 1920(%esp), %esi
movl %esi, %ebp
shll $6, %edi
andl $67108863, %esi
shrl $26, %ebp
orl %ebp, %edi
addl %edi, %eax
movl 1896(%esp), %edi
movd %esi, %xmm3
adcl $0, %edx
addl %eax, %ecx
movl %ecx, %ebp
adcl %edx, %ebx
movl $5, %eax
andl $67108863, %edi
shll $6, %ebx
andl $67108863, %ecx
shrl $26, %ebp
orl %ebp, %ebx
addl 1904(%esp), %ebx
movl 1908(%esp), %edx
movl %ebx, %ebp
adcl $0, %edx
andl $67108863, %ebx
shll $6, %edx
shrl $26, %ebp
orl %ebp, %edx
mull %edx
addl %eax, %edi
movl %edi, %ebp
andl $67108863, %ebp
movl 1912(%esp), %edx
shrl $26, %edi
andl $67108863, %edx
addl %edx, %edi
movd %ebp, %xmm7
movl 1964(%esp), %ebp
pshufd $68, %xmm7, %xmm5
movd %ecx, %xmm7
movd %edi, %xmm4
movl %ebp, %ecx
movdqa %xmm5, (%ebp)
pshufd $68, %xmm4, %xmm5
pshufd $68, %xmm3, %xmm4
pshufd $68, %xmm7, %xmm3
movd %ebx, %xmm7
pshufd $68, %xmm7, %xmm7
movdqa %xmm5, 16(%ebp)
movdqa %xmm4, 32(%ebp)
movdqa %xmm3, 48(%ebp)
movdqa %xmm7, 64(%ebp)
pmuludq %xmm1, %xmm5
pmuludq %xmm1, %xmm4
pmuludq %xmm1, %xmm3
pmuludq %xmm1, %xmm7
movl 1968(%esp), %ebx
incl %ebx
movdqa %xmm5, 80(%ebp)
movdqa %xmm4, 96(%ebp)
movdqa %xmm3, 112(%ebp)
movdqa %xmm7, 128(%ebp)
addl $-144, %ebp
movl %ebx, 1968(%esp)
.byte 144
movl %ebp, 1964(%esp)
cmpl 1960(%esp), %ebx
jb ..B1.8

..B1.9:
movdqa 2176(%esp), %xmm5
movdqa 2144(%esp), %xmm4
movl 1888(%esp), %edx
movl 1952(%esp), %eax
movl 2128(%esp), %ebp
movl 1960(%esp), %ebx

..B1.10:
cmpl $32, 2136(%esp)
jb ..B1.39

..B1.11:
movdqa 16(%esp), %xmm7
movdqa %xmm7, 2064(%esp)
movdqa 128(%esp), %xmm7
movdqa %xmm7, 2048(%esp)
movdqa 112(%esp), %xmm7
movdqa %xmm7, 2032(%esp)
movdqa 96(%esp), %xmm7
movdqa %xmm7, 2016(%esp)
movdqa 80(%esp), %xmm7
movdqa %xmm7, 2000(%esp)
movdqa 32(%esp), %xmm7
movdqa %xmm7, 1920(%esp)
movdqa 48(%esp), %xmm7
movdqa %xmm7, 1904(%esp)
movdqa (%esp), %xmm3
movdqa 64(%esp), %xmm7
movdqa %xmm2, 1968(%esp)
movdqa %xmm1, 1936(%esp)
movl %eax, 1952(%esp)
movdqa %xmm7, 1888(%esp)
movdqa %xmm3, 2080(%esp)
movdqa %xmm6, 1984(%esp)
movdqa %xmm5, 2176(%esp)
movdqa %xmm4, 2144(%esp)
movdqa 2160(%esp), %xmm2
movdqa 1872(%esp), %xmm1
movl 2132(%esp), %ecx
movl 2136(%esp), %eax

..B1.12:
movdqa 2080(%esp), %xmm5
movdqa %xmm2, %xmm6
movdqa %xmm1, %xmm4
movl %ebp, %edi
pmuludq 2048(%esp), %xmm4
cmpl $1, %ebx
pmuludq %xmm5, %xmm6
paddq %xmm4, %xmm6
movdqa 1968(%esp), %xmm4
movdqa %xmm4, %xmm7
pmuludq 2032(%esp), %xmm7
movdqa 2016(%esp), %xmm3
paddq %xmm7, %xmm6
movdqa 1984(%esp), %xmm7
pmuludq %xmm3, %xmm7
paddq %xmm7, %xmm6
movdqa %xmm0, %xmm7
pmuludq 2000(%esp), %xmm7
paddq %xmm7, %xmm6
movdqa %xmm6, 2240(%esp)
movdqa %xmm2, %xmm7
movdqa %xmm1, %xmm6
pmuludq 2064(%esp), %xmm7
pmuludq %xmm5, %xmm6
movdqa %xmm4, %xmm5
pmuludq 2048(%esp), %xmm5
pmuludq 2080(%esp), %xmm4
paddq %xmm6, %xmm7
movdqa 1984(%esp), %xmm6
paddq %xmm5, %xmm7
movdqa 2032(%esp), %xmm5
pmuludq %xmm5, %xmm6
paddq %xmm6, %xmm7
movdqa %xmm0, %xmm6
pmuludq %xmm3, %xmm6
movdqa %xmm2, %xmm3
paddq %xmm6, %xmm7
movdqa 1920(%esp), %xmm6
movdqa %xmm7, 2224(%esp)
movdqa %xmm1, %xmm7
pmuludq %xmm6, %xmm3
pmuludq 2064(%esp), %xmm7
paddq %xmm7, %xmm3
movdqa 2048(%esp), %xmm7
paddq %xmm4, %xmm3
movdqa 1984(%esp), %xmm4
pmuludq %xmm7, %xmm4
paddq %xmm4, %xmm3
movdqa %xmm0, %xmm4
pmuludq %xmm5, %xmm4
paddq %xmm4, %xmm3
movdqa 1904(%esp), %xmm5
movdqa %xmm2, %xmm4
movdqa %xmm3, 2208(%esp)
movdqa %xmm1, %xmm3
pmuludq %xmm5, %xmm4
pmuludq %xmm6, %xmm3
pmuludq 1888(%esp), %xmm2
pmuludq %xmm5, %xmm1
paddq %xmm3, %xmm4
paddq %xmm1, %xmm2
movdqa 1968(%esp), %xmm6
pmuludq 2064(%esp), %xmm6
movdqa 1984(%esp), %xmm3
paddq %xmm6, %xmm4
movdqa 2080(%esp), %xmm6
pmuludq %xmm6, %xmm3
paddq %xmm3, %xmm4
movdqa %xmm0, %xmm3
pmuludq %xmm7, %xmm3
pmuludq %xmm6, %xmm0
paddq %xmm3, %xmm4
movdqa 1968(%esp), %xmm1
pmuludq 1920(%esp), %xmm1
movdqa 1984(%esp), %xmm3
pmuludq 2064(%esp), %xmm3
paddq %xmm1, %xmm2
paddq %xmm3, %xmm2
movdqa 2240(%esp), %xmm6
movdqa 2224(%esp), %xmm5
movdqa 2208(%esp), %xmm7
paddq %xmm0, %xmm2
jbe ..B1.16

..B1.13:
movdqa %xmm4, 2192(%esp)
movl $1, %esi
movdqa %xmm7, 2208(%esp)
movdqa %xmm5, 2224(%esp)
movdqa %xmm6, 2240(%esp)
movl %ebp, 2128(%esp)

..B1.14:
movq 16(%ecx), %xmm6
addl $144, %edi
movq (%ecx), %xmm4
incl %esi
movq 24(%ecx), %xmm0
pslldq $8, %xmm6
pslldq $8, %xmm0
por %xmm6, %xmm4
movq 8(%ecx), %xmm6
movdqa %xmm4, %xmm1
movdqa 2144(%esp), %xmm5
por %xmm0, %xmm6
movdqa %xmm5, %xmm0
movdqa %xmm6, %xmm3
pand %xmm4, %xmm0
psrlq $52, %xmm4
psllq $12, %xmm3
psrlq $26, %xmm1
por %xmm3, %xmm4
movdqa %xmm5, %xmm3
pand %xmm4, %xmm3
psrlq $26, %xmm4
pand %xmm5, %xmm1
pand %xmm5, %xmm4
movdqa (%edi), %xmm5
psrlq $40, %xmm6
movdqa %xmm2, 2160(%esp)
movdqa %xmm5, %xmm2
pmuludq %xmm0, %xmm2
addl $32, %ecx
movdqa 2240(%esp), %xmm7
cmpl %ebx, %esi
paddq %xmm2, %xmm7
movdqa 128(%edi), %xmm2
pmuludq %xmm1, %xmm2
paddq %xmm2, %xmm7
movdqa 112(%edi), %xmm2
pmuludq %xmm3, %xmm2
paddq %xmm2, %xmm7
movdqa 96(%edi), %xmm2
pmuludq %xmm4, %xmm2
por 2176(%esp), %xmm6
paddq %xmm2, %xmm7
movdqa 80(%edi), %xmm2
pmuludq %xmm6, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm7, 2240(%esp)
movdqa 16(%edi), %xmm7
pmuludq %xmm0, %xmm7
movdqa 2224(%esp), %xmm2
paddq %xmm7, %xmm2
movdqa %xmm5, %xmm7
pmuludq %xmm1, %xmm7
paddq %xmm7, %xmm2
movdqa 128(%edi), %xmm7
pmuludq %xmm3, %xmm7
paddq %xmm7, %xmm2
movdqa 112(%edi), %xmm7
pmuludq %xmm4, %xmm7
paddq %xmm7, %xmm2
movdqa 96(%edi), %xmm7
pmuludq %xmm6, %xmm7
paddq %xmm7, %xmm2
movdqa %xmm2, 2224(%esp)
movdqa 32(%edi), %xmm2
pmuludq %xmm0, %xmm2
movdqa 2208(%esp), %xmm7
paddq %xmm2, %xmm7
movdqa 16(%edi), %xmm2
pmuludq %xmm1, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm5, %xmm2
pmuludq %xmm3, %xmm2
paddq %xmm2, %xmm7
movdqa 128(%edi), %xmm2
pmuludq %xmm4, %xmm2
paddq %xmm2, %xmm7
movdqa 112(%edi), %xmm2
pmuludq %xmm6, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm7, 2208(%esp)
movdqa 48(%edi), %xmm7
pmuludq %xmm0, %xmm7
pmuludq 64(%edi), %xmm0
movdqa 2192(%esp), %xmm2
paddq %xmm7, %xmm2
movdqa 32(%edi), %xmm7
pmuludq %xmm1, %xmm7
pmuludq 48(%edi), %xmm1
paddq %xmm7, %xmm2
movdqa 16(%edi), %xmm7
pmuludq %xmm3, %xmm7
pmuludq 32(%edi), %xmm3
paddq %xmm7, %xmm2
movdqa %xmm5, %xmm7
pmuludq %xmm4, %xmm7
pmuludq 16(%edi), %xmm4
paddq %xmm7, %xmm2
movdqa 128(%edi), %xmm7
pmuludq %xmm6, %xmm7
pmuludq %xmm5, %xmm6
paddq %xmm7, %xmm2
movdqa %xmm2, 2192(%esp)
movdqa 2160(%esp), %xmm2
paddq %xmm0, %xmm2
paddq %xmm1, %xmm2
paddq %xmm3, %xmm2
paddq %xmm4, %xmm2
paddq %xmm6, %xmm2
jb ..B1.14

..B1.15:
movdqa 2192(%esp), %xmm4
movdqa 2208(%esp), %xmm7
movdqa 2224(%esp), %xmm5
movdqa 2240(%esp), %xmm6
movl 2128(%esp), %ebp

..B1.16:
movdqa %xmm6, %xmm1
movdqa %xmm4, %xmm0
psrlq $26, %xmm1
psrlq $26, %xmm0
paddq %xmm1, %xmm5
paddq %xmm2, %xmm0
movdqa %xmm5, %xmm2
subl %edx, %eax
psrlq $26, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm0, 2096(%esp)
psrlq $26, %xmm0
movdqa 2144(%esp), %xmm3
movdqa %xmm7, %xmm1
pmuludq 1936(%esp), %xmm0
pand %xmm3, %xmm4
psrlq $26, %xmm1
pand %xmm3, %xmm6
paddq %xmm1, %xmm4
paddq %xmm0, %xmm6
movdqa %xmm4, 2192(%esp)
pand %xmm3, %xmm5
movq 16(%ecx), %xmm4
pand %xmm3, %xmm7
movq (%ecx), %xmm1
movq 24(%ecx), %xmm0
pslldq $8, %xmm4
movq 8(%ecx), %xmm2
por %xmm4, %xmm1
pslldq $8, %xmm0
movdqa %xmm3, %xmm4
por %xmm0, %xmm2
movdqa %xmm1, %xmm0
movdqa %xmm2, 2112(%esp)
psrlq $52, %xmm0
psllq $12, %xmm2
pand %xmm1, %xmm4
por %xmm2, %xmm0
movdqa %xmm3, %xmm2
pand %xmm6, %xmm2
psrlq $26, %xmm6
psrlq $26, %xmm1
addl $32, %ecx
paddq %xmm6, %xmm5
paddq %xmm4, %xmm2
pand %xmm3, %xmm1
movdqa %xmm3, %xmm6
paddq %xmm5, %xmm1
movdqa %xmm3, %xmm5
cmpl %edx, %eax
pand %xmm0, %xmm5
psrlq $26, %xmm0
paddq %xmm7, %xmm5
movdqa 2192(%esp), %xmm7
pand %xmm3, %xmm0
pand %xmm7, %xmm6
psrlq $26, %xmm7
paddq %xmm0, %xmm6
movdqa 2096(%esp), %xmm0
pand %xmm3, %xmm0
movdqa 2112(%esp), %xmm3
psrlq $40, %xmm3
paddq %xmm7, %xmm0
por 2176(%esp), %xmm3
movdqa %xmm5, 1968(%esp)
movdqa %xmm6, 1984(%esp)
paddq %xmm3, %xmm0
jb ..B1.36
jmp ..B1.12

..B1.17:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edi, %edi
xorl %eax, %eax
xorl %edx, %edx

..B1.49:
movl %edx, 48(%esp)
movl %ecx, 44(%esp)
movl %ebx, 32(%esp)
movl %edi, 36(%esp)
movl %eax, 40(%esp)
jmp ..B1.34

..B1.18:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edi, %edi
xorl %eax, %eax
xorl %edx, %edx

..B1.48:
movl %eax, 40(%esp)
movl %ebx, 32(%esp)
movl %edi, 36(%esp)
movl 2136(%esp), %eax

..B1.19:
testl %eax, %eax
je ..B1.44

..B1.20:
ja ..B1.22

..B1.21:
xorl %eax, %eax
xorl %ebp, %ebp
jmp ..B1.25

..B1.22:
xorl %ebx, %ebx
movl 2132(%esp), %esi
xorl %ebp, %ebp

..B1.23:
movzbl (%ebp,%esi), %ebx
movb %bl, 16(%esp,%ebp)
incl %ebp
cmpl %eax, %ebp
jb ..B1.23

..B1.25:
movb $1, 16(%esp,%ebp)
lea 1(%ebp), %edi
cmpl $16, %edi
jae ..B1.32

..B1.26:
negl %edi
addl $16, %edi
movl %edi, %esi
shrl $31, %esi
addl %edi, %esi
sarl $1, %esi
testl %esi, %esi
jbe ..B1.43

..B1.27:
xorl %ebx, %ebx
lea 17(%esp,%ebp), %eax
movl %ebp, (%esp)
movl %eax, %ebp
xorl %eax, %eax

..B1.28:
movb %al, (%ebp,%ebx,2)
movb %al, 1(%ebp,%ebx,2)
incl %ebx
cmpl %esi, %ebx
jb ..B1.28

..B1.29:
movl (%esp), %ebp
lea 1(%ebx,%ebx), %eax

..B1.30:
lea -1(%eax), %esi
cmpl %esi, %edi
jbe ..B1.32

..B1.31:
lea 17(%esp,%ebp), %ebx
movb $0, -1(%eax,%ebx)

..B1.32:
movl 16(%esp), %ebp
movl %ebp, %ebx
andl $67108863, %ebx
movl 20(%esp), %esi
addl %ebx, %ecx
movl %esi, %ebx
shll $6, %ebx
shrl $26, %ebp
movl 24(%esp), %edi
orl %ebp, %ebx
movl %edi, %ebp
andl $67108863, %ebx
shll $12, %ebp
shrl $20, %esi
movl 28(%esp), %eax
orl %esi, %ebp
movl %eax, %esi
andl $67108863, %ebp
shll $18, %esi
shrl $14, %edi
orl %edi, %esi
shrl $8, %eax
andl $67108863, %esi
addl 32(%esp), %ebx
addl %eax, %edx
addl 36(%esp), %ebp
xorl %eax, %eax
addl 40(%esp), %esi
movl %edx, 48(%esp)
movl %esi, 4(%esp)
movl %ebp, 8(%esp)
movl %ebx, 12(%esp)
movl %ecx, 44(%esp)
movl %eax, 2136(%esp)

..B1.33:
movl 44(%esp), %esi
movl %esi, %eax
mull 2284(%esp)
movl %eax, %edi
movl %edx, %ecx
movl 12(%esp), %eax
mull 2140(%esp)
addl %eax, %edi
movl 8(%esp), %eax
adcl %edx, %ecx
mull 2256(%esp)
addl %eax, %edi
movl 4(%esp), %eax
adcl %edx, %ecx
mull 2260(%esp)
movl %eax, %ebp
movl %edx, %ebx
movl 48(%esp), %eax
mull 2264(%esp)
addl %eax, %ebp
movl %esi, %eax
adcl %edx, %ebx
addl %ebp, %edi
movl %edi, 52(%esp)
adcl %ebx, %ecx
mull 2280(%esp)
movl %ecx, %ebp
shll $6, %ebp
shrl $26, %edi
orl %edi, %ebp
shrl $26, %ecx
addl %eax, %ebp
movl 2284(%esp), %eax
adcl %edx, %ecx
mull 12(%esp)
movl %eax, %ebx
movl %edx, %edi
movl 2140(%esp), %eax
mull 8(%esp)
addl %eax, %ebx
movl 2256(%esp), %eax
adcl %edx, %edi
addl %ebx, %ebp
adcl %edi, %ecx
mull 4(%esp)
movl %eax, %ebx
movl %edx, %edi
movl 2260(%esp), %eax
mull 48(%esp)
addl %eax, %ebx
movl %esi, %eax
adcl %edx, %edi
addl %ebx, %ebp
movl %ebp, %ebx
adcl %edi, %ecx
andl $67108863, %ebx
mull 2276(%esp)
movl %eax, %esi
movl 2280(%esp), %eax
movl %ebx, 32(%esp)
movl %edx, %ebx
mull 12(%esp)
addl %eax, %esi
movl 2284(%esp), %eax
adcl %edx, %ebx
mull 8(%esp)
addl %eax, %esi
movl 2140(%esp), %eax
adcl %edx, %ebx
mull 4(%esp)
shll $6, %ecx
movl %eax, %edi
movl 2256(%esp), %eax
shrl $26, %ebp
orl %ebp, %ecx
movl %edx, %ebp
mull 48(%esp)
addl %eax, %edi
movl 44(%esp), %eax
adcl %edx, %ebp
addl %edi, %esi
adcl %ebp, %ebx
addl %esi, %ecx
movl %ecx, %esi
adcl $0, %ebx
andl $67108863, %esi
mull 2272(%esp)
movl %esi, 36(%esp)
movl %eax, %esi
shll $6, %ebx
shrl $26, %ecx
movl 2276(%esp), %eax
orl %ecx, %ebx
movl %edx, %ecx
mull 12(%esp)
addl %eax, %esi
movl 2280(%esp), %eax
adcl %edx, %ecx
mull 8(%esp)
addl %eax, %esi
movl 2284(%esp), %eax
adcl %edx, %ecx
mull 4(%esp)
movl %eax, %edi
movl %edx, %ebp
movl 2140(%esp), %eax
mull 48(%esp)
addl %eax, %edi
movl 2268(%esp), %eax
adcl %edx, %ebp
addl %edi, %esi
adcl %ebp, %ecx
addl %esi, %ebx
movl %ebx, %ebp
adcl $0, %ecx
andl $67108863, %ebp
mull 44(%esp)
shll $6, %ecx
movl %eax, %esi
movl 2272(%esp), %eax
shrl $26, %ebx
orl %ebx, %ecx
movl %edx, %ebx
mull 12(%esp)
addl %eax, %esi
movl 2276(%esp), %eax
adcl %edx, %ebx
mull 8(%esp)
addl %eax, %esi
movl 2280(%esp), %eax
adcl %edx, %ebx
mull 4(%esp)
movl %eax, %edi
movl 2284(%esp), %eax
movl %ebp, 40(%esp)
movl %edx, %ebp
mull 48(%esp)
addl %eax, %edi
adcl %edx, %ebp
addl %edi, %esi
movl 52(%esp), %edi
adcl %ebp, %ebx
addl %esi, %ecx
movl %ecx, %esi
adcl $0, %ebx
andl $67108863, %edi
shll $6, %ebx
andl $67108863, %esi
shrl $26, %ecx
orl %ecx, %ebx
movl %esi, 48(%esp)
lea (%ebx,%ebx,4), %ecx
addl %edi, %ecx
movl %ecx, 44(%esp)
cmpl $16, 2136(%esp)
jb ..B1.35

..B1.34:
movl 2132(%esp), %eax
movl 2136(%esp), %esi
addl $-16, %esi
movl 4(%eax), %edx
movl %esi, 2136(%esp)
movl %edx, %esi
movl (%eax), %ebp
movl %ebp, %edi
shll $6, %esi
andl $67108863, %edi
shrl $26, %ebp
movl 8(%eax), %ebx
orl %ebp, %esi
movl %ebx, %ebp
andl $67108863, %esi
shll $12, %ebp
shrl $20, %edx
movl 12(%eax), %ecx
orl %edx, %ebp
movl %ecx, %edx
andl $67108863, %ebp
shll $18, %edx
addl $16, %eax
shrl $14, %ebx
orl %ebx, %edx
shrl $8, %ecx
andl $67108863, %edx
addl 32(%esp), %esi
orl $16777216, %ecx
addl 36(%esp), %ebp
addl 40(%esp), %edx
addl %edi, 44(%esp)
addl %ecx, 48(%esp)
movl %esi, 12(%esp)
movl %ebp, 8(%esp)
movl %edx, 4(%esp)
movl %eax, 2132(%esp)
jmp ..B1.33

..B1.35:
.byte 15
.byte 31
.byte 68
.byte 0
.byte 0
movl %esi, %edx
movl 2136(%esp), %eax
jmp ..B1.19

..B1.36:
cmpl $32, %eax
jb ..B1.38

..B1.37:
movl %eax, %ebx
shrl $5, %ebx
movl 1956(%esp), %ebp
movl %ebx, %edx
shll $5, %edx
lea (%ebx,%ebx,8), %esi
shll $4, %esi
subl %esi, %ebp
addl $144, %ebp
movl %esi, 1952(%esp)
movdqa (%ebp), %xmm3
movdqa 16(%ebp), %xmm4
movdqa 128(%ebp), %xmm5
movdqa 112(%ebp), %xmm6
movdqa %xmm3, 2080(%esp)
movdqa %xmm4, 2064(%esp)
movdqa %xmm5, 2048(%esp)
movdqa %xmm6, 2032(%esp)
movdqa 96(%ebp), %xmm7
movdqa 80(%ebp), %xmm3
movdqa 32(%ebp), %xmm4
movdqa 48(%ebp), %xmm5
movdqa 64(%ebp), %xmm6
movdqa %xmm7, 2016(%esp)
movdqa %xmm3, 2000(%esp)
movdqa %xmm4, 1920(%esp)
movdqa %xmm5, 1904(%esp)
movdqa %xmm6, 1888(%esp)
jmp ..B1.12

..B1.38:
movdqa %xmm2, 2160(%esp)
movdqa %xmm1, 1872(%esp)
movl %eax, 2136(%esp)
movl %ecx, 2132(%esp)
movdqa 1984(%esp), %xmm6
movdqa 1968(%esp), %xmm2
movdqa 1936(%esp), %xmm1
movdqa 2144(%esp), %xmm4
movl 1952(%esp), %eax

..B1.39:
movl 2280(%esp), %edi
xorl %ecx, %ecx
movl %edi, -120(%eax,%ebp)
movdqa %xmm6, %xmm7
movl 2284(%esp), %ebx
movl 2264(%esp), %edi
movdqa %xmm1, 1936(%esp)
movl %ebx, -136(%eax,%ebp)
movl %ecx, -132(%eax,%ebp)
movl %edi, -56(%eax,%ebp)
movl %ecx, -52(%eax,%ebp)
movdqa 2160(%esp), %xmm1
movdqa %xmm4, 2144(%esp)
movdqa %xmm1, %xmm3
movdqa -64(%eax,%ebp), %xmm4
movdqa -144(%eax,%ebp), %xmm5
pmuludq %xmm0, %xmm4
pmuludq %xmm5, %xmm3
movl 2276(%esp), %edx
movl %edx, -104(%eax,%ebp)
movl 2260(%esp), %edx
movl 2272(%esp), %esi
movl %edx, -40(%eax,%ebp)
movl %ecx, -36(%eax,%ebp)
movl %esi, -88(%eax,%ebp)
movl 2256(%esp), %esi
pmuludq -48(%eax,%ebp), %xmm7
paddq %xmm4, %xmm3
movl %esi, -24(%eax,%ebp)
movdqa %xmm2, %xmm4
movl %ecx, -20(%eax,%ebp)
pmuludq -32(%eax,%ebp), %xmm4
paddq %xmm7, %xmm3
movl 2268(%esp), %ebx
movl %ebx, -72(%eax,%ebp)
movl 2140(%esp), %ebx
movdqa 1872(%esp), %xmm7
movl %ebx, -8(%eax,%ebp)
movl %ecx, -4(%eax,%ebp)
paddq %xmm4, %xmm3
movdqa %xmm7, %xmm4
pmuludq -16(%eax,%ebp), %xmm4
paddq %xmm4, %xmm3
movl %ecx, -116(%eax,%ebp)
movdqa %xmm6, %xmm4
movdqa %xmm3, 1888(%esp)
movdqa -128(%eax,%ebp), %xmm3
movdqa %xmm2, 1968(%esp)
pmuludq %xmm5, %xmm4
pmuludq %xmm3, %xmm2
movl %ecx, -100(%eax,%ebp)
paddq %xmm2, %xmm4
movdqa %xmm7, %xmm2
pmuludq -112(%eax,%ebp), %xmm2
pmuludq %xmm5, %xmm7
paddq %xmm2, %xmm4
movl %ecx, -84(%eax,%ebp)
movdqa %xmm1, %xmm2
pmuludq -96(%eax,%ebp), %xmm2
paddq %xmm2, %xmm4
movdqa %xmm0, %xmm2
pmuludq -16(%eax,%ebp), %xmm2
paddq %xmm2, %xmm4
movl %ecx, -68(%eax,%ebp)
movdqa %xmm4, 1904(%esp)
movdqa -80(%eax,%ebp), %xmm4
pmuludq %xmm1, %xmm4
pmuludq %xmm3, %xmm1
movdqa -48(%eax,%ebp), %xmm2
pmuludq %xmm0, %xmm2
paddq %xmm1, %xmm7
movdqa %xmm6, %xmm1
pmuludq -32(%eax,%ebp), %xmm1
paddq %xmm2, %xmm7
paddq %xmm1, %xmm7
movdqa 1968(%esp), %xmm1
movdqa %xmm1, %xmm2
pmuludq -16(%eax,%ebp), %xmm2
paddq %xmm2, %xmm7
movdqa 1888(%esp), %xmm2
psrlq $26, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm0, %xmm2
movdqa %xmm6, 1984(%esp)
pmuludq %xmm5, %xmm2
pmuludq %xmm3, %xmm6
pmuludq -32(%eax,%ebp), %xmm0
paddq %xmm6, %xmm2
movdqa %xmm7, 1920(%esp)
movdqa %xmm1, %xmm7
movdqa -112(%eax,%ebp), %xmm6
pmuludq %xmm6, %xmm7
pmuludq %xmm5, %xmm1
paddq %xmm7, %xmm2
movdqa -96(%eax,%ebp), %xmm7
paddq %xmm4, %xmm2
movdqa 1872(%esp), %xmm4
pmuludq %xmm4, %xmm7
pmuludq %xmm3, %xmm4
paddq %xmm7, %xmm2
paddq %xmm4, %xmm1
movdqa 2160(%esp), %xmm5
pmuludq %xmm6, %xmm5
paddq %xmm5, %xmm1
paddq %xmm0, %xmm1
movdqa 1984(%esp), %xmm0
movdqa 1904(%esp), %xmm7
pmuludq -16(%eax,%ebp), %xmm0
psrlq $26, %xmm7
paddq %xmm7, %xmm2
paddq %xmm0, %xmm1
movdqa %xmm2, %xmm4
psrlq $26, %xmm4
movdqa 1920(%esp), %xmm0
pmuludq 1936(%esp), %xmm4
movdqa %xmm0, %xmm3
psrlq $26, %xmm3
movdqa 2144(%esp), %xmm5
movdqa 1888(%esp), %xmm7
pand %xmm5, %xmm0
paddq %xmm3, %xmm1
movdqa 1904(%esp), %xmm6
movdqa %xmm5, %xmm3
pand %xmm5, %xmm7
pand %xmm1, %xmm3
pand %xmm5, %xmm6
psrlq $26, %xmm1
paddq %xmm4, %xmm7
paddq %xmm1, %xmm6
movdqa %xmm5, %xmm4
movdqa %xmm5, %xmm1
pand %xmm7, %xmm4
psrlq $26, %xmm7
pand %xmm6, %xmm1
pand %xmm5, %xmm2
psrlq $26, %xmm6
movdqa %xmm3, %xmm5
paddq %xmm7, %xmm0
paddq %xmm6, %xmm2
movdqa %xmm4, %xmm6
movdqa %xmm0, %xmm7
psrldq $8, %xmm6
paddq %xmm6, %xmm4
psrldq $8, %xmm7
paddq %xmm7, %xmm0
movd %xmm4, %ecx
movd %xmm0, %ebp
movdqa %xmm1, %xmm0
psrldq $8, %xmm5
psrldq $8, %xmm0
movl %ecx, %eax
andl $67108863, %ecx
paddq %xmm5, %xmm3
paddq %xmm0, %xmm1
shrl $26, %eax
addl %eax, %ebp
movd %xmm3, %eax
movl %ebp, %ebx
movd %xmm1, %edx
movdqa %xmm2, %xmm1
psrldq $8, %xmm1
paddq %xmm1, %xmm2
shrl $26, %ebp
andl $67108863, %ebx
addl %ebp, %eax
movl %eax, %edi
shrl $26, %eax
andl $67108863, %edi
movd %xmm2, %esi
addl %eax, %edx
movl %edx, %eax
shrl $26, %edx
andl $67108863, %eax
addl %edx, %esi
movl %esi, %edx
shrl $26, %esi
andl $67108863, %edx
lea (%esi,%esi,4), %ebp
addl %ebp, %ecx
cmpl $16, 2136(%esp)
jb ..B1.48
jmp ..B1.49

..B1.43:
movl $1, %eax
jmp ..B1.30

..B1.44:
movl %ecx, %ebp
andl $67108863, %ecx
shrl $26, %ebp
movl 32(%esp), %ebx
addl %ebp, %ebx
movl %ebx, %esi
shrl $26, %ebx
andl $67108863, %esi
movl 36(%esp), %edi
addl %ebx, %edi
movl %edi, %ebp
shrl $26, %edi
andl $67108863, %ebp
movl 40(%esp), %eax
addl %edi, %eax
movl %eax, %ebx
shrl $26, %eax
andl $67108863, %ebx
addl %eax, %edx
movl %edx, %eax
shrl $26, %edx
andl $67108863, %eax
movl %eax, (%esp)
lea (%edx,%edx,4), %edi
lea (%ecx,%edi), %edx
movl %edx, 4(%esp)
lea 5(%edi,%ecx), %edi
movl %edi, 8(%esp)
shrl $26, %edi
addl %esi, %edi
movl %edi, %ecx
andl $67108863, %edi
shrl $26, %ecx
addl %ebp, %ecx
movl %ecx, %edx
andl $67108863, %ecx
shrl $26, %edx
addl %ebx, %edx
movl %edx, 12(%esp)
shrl $26, %edx
lea -67108864(%edx,%eax), %eax
movl %eax, 16(%esp)
shrl $31, %eax
decl %eax
movl %eax, %edx
andl %eax, %ecx
notl %edx
andl %eax, %edi
andl %edx, %ebp
andl %edx, %esi
orl %ecx, %ebp
orl %edi, %esi
movl 12(%esp), %ecx
andl %edx, %ebx
andl $67108863, %ecx
movl 8(%esp), %edi
andl %eax, %ecx
andl $67108863, %edi
orl %ecx, %ebx
movl 4(%esp), %ecx
andl %eax, %edi
andl %edx, %ecx
movl %eax, 20(%esp)
movl %esi, %eax
orl %edi, %ecx
movl 2332(%esp), %edi
shll $26, %eax
orl %eax, %ecx
xorl %eax, %eax
addl 16(%edi), %ecx
movl %ecx, 4(%esp)
movl $0, %ecx
adcl $0, %eax
movl %eax, 24(%esp)
movl %ebp, %eax
shrl $6, %esi
shll $20, %eax
orl %eax, %esi
xorl %eax, %eax
addl 20(%edi), %esi
adcl $0, %eax
movl %eax, 28(%esp)
movl %ebx, %eax
shrl $12, %ebp
shll $14, %eax
orl %eax, %ebp
movl 16(%esp), %eax
addl 24(%edi), %ebp
adcl $0, %ecx
andl (%esp), %edx
andl 20(%esp), %eax
orl %eax, %edx
addl 24(%esp), %esi
movl 28(%esp), %eax
adcl $0, %eax
shrl $18, %ebx
addl %eax, %ebp
adcl $0, %ecx
shll $8, %edx
orl %edx, %ebx
addl 28(%edi), %ebx
movl 2320(%esp), %edi
addl %ecx, %ebx
movl 4(%esp), %edx
movl %edx, (%edi)
movl %esi, 4(%edi)
movl %ebp, 8(%edi)
movl %ebx, 12(%edi)
movl 2336(%esp), %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret

.section .rodata, "a"
.align 16
poly1305_x86_sse2_message_mask:
.long	67108863
.long	0
.long	67108863
.long	0
.align 16
poly1305_x86_sse2_5:
.long	5
.long	0
.long	5
.long	0
.align 16
poly1305_x86_sse2_1shl128:
.long	16777216
.long	0
.long	16777216
.long	0
