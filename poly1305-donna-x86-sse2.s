.text
.align 16,0x90
.globl poly1305_auth_x86_sse2
poly1305_auth_x86_sse2:
 pushl %esi
 pushl %edi
 pushl %ebx
 pushl %ebp
 movl %esp, %ebp
 andl $~15, %esp
 subl $2336, %esp
 movl 20(%ebp), %eax
 movl 24(%ebp), %ebx
 movl 28(%ebp), %ecx
 movl 32(%ebp), %edx
 movl %ebp, 2300(%esp)
 movl %eax, 2304(%esp)
 movl %ebx, 2308(%esp)
 movl %ecx, 2312(%esp)
 movl %edx, 2316(%esp)
 movl 2316(%esp), %eax
 movl 2308(%esp), %ebx
 movl %ebx, 2240(%esp)
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
 movl %edi, 2280(%esp)
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
 movl 2312(%esp), %ebx
 cmpl $16, %ebx
 movl %edx, 2276(%esp)
 lea (%edx,%edx,4), %edx
 movl %ebp, 2272(%esp)
 lea (%ebp,%ebp,4), %ebp
 movl %ecx, 2268(%esp)
 lea (%ecx,%ecx,4), %ecx
 movl %eax, 2264(%esp)
 lea (%eax,%eax,4), %eax
 movl %ebx, 2244(%esp)
 movdqa poly1305_x86_sse2_message_mask, %xmm6
 movdqa poly1305_x86_sse2_5, %xmm1
 movdqa poly1305_x86_sse2_1shl128, %xmm3
 movl %edx, 2260(%esp)
 movl %ebp, 2256(%esp)
 movl %ecx, 2252(%esp)
 movl %eax, 2248(%esp)
 jb ..B1.18

..B1.2:
 cmpl $32, 2244(%esp)
 jb ..B1.17

..B1.3:
 movl 2240(%esp), %edx
 movl $-1431655765, %eax
 movl $13, %ebp
 addl $-32, %ebx
 movq 16(%edx), %xmm5
 movq (%edx), %xmm4
 pslldq $8, %xmm5
 movq 24(%edx), %xmm0
 por %xmm5, %xmm4
 movq 8(%edx), %xmm5
 addl $32, %edx
 movl %edx, 2240(%esp)
 movdqa %xmm4, %xmm2
 mull %ebx
 shrl $9, %edx
 psrlq $26, %xmm2
 incl %edx
 pand %xmm6, %xmm2
 movl 2280(%esp), %ecx
 cmpl $13, %edx
 movl %ecx, 1928(%esp)
 movl 2276(%esp), %ecx
 cmovae %ebp, %edx
 movl %ecx, 1924(%esp)
 movl %edx, %eax
 movl 2272(%esp), %ecx
 movl %ecx, 1920(%esp)
 movl 2268(%esp), %ecx
 lea (%edx,%edx,8), %edi
 pslldq $8, %xmm0
 movl %ecx, 1916(%esp)
 por %xmm0, %xmm5
 movl 2264(%esp), %ecx
 movdqa %xmm6, %xmm0
 movl %ecx, 1912(%esp)
 movdqa %xmm5, %xmm7
 movl 2260(%esp), %ecx
 pand %xmm4, %xmm0
 shll $4, %edi
 psrlq $52, %xmm4
 movl %ecx, 1896(%esp)
 psllq $12, %xmm7
 movl 2256(%esp), %ecx
 por %xmm7, %xmm4
 movl %ecx, 1908(%esp)
 psrlq $40, %xmm5
 movl 2252(%esp), %ecx
 lea -144(%esp,%edi), %ebp
 movdqa %xmm2, 1872(%esp)
 movdqa %xmm6, %xmm2
 movl %ecx, 1904(%esp)
 pand %xmm4, %xmm2
 movl 2248(%esp), %ecx
 psrlq $26, %xmm4
 shll $5, %eax
 movl %ebp, %esi
 movdqa %xmm2, 1984(%esp)
 pand %xmm6, %xmm4
 movl %ebx, 2244(%esp)
 lea (%esp), %ebx
 movl %ecx, 1900(%esp)
 por %xmm3, %xmm5
 testl %edx, %edx
 jbe ..B1.10

..B1.4:
 movl %eax, 1888(%esp)
 movl %ebp, 1968(%esp)
 movl $0, 1972(%esp)
 movdqa %xmm3, 2144(%esp)
 movdqa %xmm6, 2128(%esp)
 movl %esi, 1960(%esp)
 movl %edi, 1956(%esp)
 movl %ebx, 1892(%esp)
 movl %edx, 1964(%esp)
 movl 1908(%esp), %eax
 movl 1896(%esp), %ebp

..B1.5:
 movl 1912(%esp), %esi
 movl %eax, 1908(%esp)
 lea (%esi,%esi), %edi
 movl 1928(%esp), %esi
 movl %esi, %eax
 mull %esi
 movl %eax, %ecx
 movl %edi, %eax
 movl %edx, %ebx
 mull %ebp
 movl 1920(%esp), %ebp
 addl %eax, %ecx
 movl %ebp, 1940(%esp)
 adcl %edx, %ebx
 movl %edi, 1896(%esp)
 lea (%ebp,%ebp), %eax
 mull 1904(%esp)
 addl %eax, %ecx
 movl 1924(%esp), %eax
 adcl %edx, %ebx
 movl 1916(%esp), %ebp
 movl %ecx, 1932(%esp)
 lea (%eax,%eax), %edx
 movl %esi, %eax
 movl %edx, 1936(%esp)
 addl %ebp, %ebp
 mull %edx
 movl %ebp, 1944(%esp)
 lea (%esi,%esi), %ebp
 movl %ebp, 1948(%esp)
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
 movl 1940(%esp), %eax
 mull 1948(%esp)
 addl %eax, %ecx
 movl 1896(%esp), %eax
 adcl %edx, %ebx
 mull %edi
 movl %ebp, 1952(%esp)
 shll $6, %esi
 shrl $26, %ebp
 orl %ebp, %esi
 addl %esi, %eax
 movl 1940(%esp), %esi
 adcl $0, %edx
 addl %eax, %ecx
 movl 1936(%esp), %eax
 movl %ecx, %edi
 adcl %edx, %ebx
 andl $67108863, %edi
 mull %esi
 shll $6, %ebx
 movl %eax, %ebp
 shrl $26, %ecx
 movl 1928(%esp), %eax
 orl %ecx, %ebx
 movl 1944(%esp), %ecx
 movl %edi, 1920(%esp)
 movl %edx, %edi
 mull %ecx
 addl %eax, %ebp
 movl 1912(%esp), %eax
 adcl %edx, %edi
 mull 1900(%esp)
 addl %eax, %ebp
 movl %esi, %eax
 movd 1920(%esp), %xmm3
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
 movl 1948(%esp), %eax
 adcl %edx, %esi
 mull 1912(%esp)
 addl %eax, %ebx
 movl 1932(%esp), %ecx
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
 movl 1952(%esp), %esi
 movl %ecx, %edx
 shrl $26, %ecx
 andl $67108863, %esi
 andl $67108863, %edx
 movl %edx, 1928(%esp)
 movl %ebx, 1912(%esp)
 movl %ebp, 1916(%esp)
 addl %esi, %ecx
 movd %edx, %xmm2
 movl 1968(%esp), %edx
 pshufd $68, %xmm2, %xmm7
 movd %ebp, %xmm2
 movd %ecx, %xmm6
 movdqa %xmm7, (%edx)
 pshufd $68, %xmm6, %xmm7
 pshufd $68, %xmm3, %xmm6
 pshufd $68, %xmm2, %xmm3
 movd %ebx, %xmm2
 pshufd $68, %xmm2, %xmm2
 movdqa %xmm7, 16(%edx)
 movdqa %xmm6, 32(%edx)
 movdqa %xmm3, 48(%edx)
 movdqa %xmm2, 64(%edx)
 pmuludq %xmm1, %xmm7
 pmuludq %xmm1, %xmm6
 pmuludq %xmm1, %xmm3
 pmuludq %xmm1, %xmm2
 movd %xmm7, %ebp
 movd %xmm6, %eax
 movdqa %xmm7, 80(%edx)
 movdqa %xmm6, 96(%edx)
 movl 1972(%esp), %ebx
 incl %ebx
 movl %ecx, 1924(%esp)
 movl %edx, %ecx
 movdqa %xmm3, 112(%edx)
 movdqa %xmm2, 128(%edx)
 addl $-144, %edx
 movd %xmm3, 1904(%esp)
 movd %xmm2, 1900(%esp)
 movl %ebx, 1972(%esp)
 movl %edx, 1968(%esp)
 cmpl 1964(%esp), %ebx
 jae ..B1.9

..B1.6:
 cmpl $2, 1972(%esp)
 jb ..B1.5

..B1.8:
 movl 1960(%esp), %edx
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
 movl 1960(%esp), %edx
 movl 80(%ecx), %eax
 movl %ecx, 1896(%esp)
 mull 64(%edx)
 addl %eax, %edi
 movl 64(%ecx), %eax
 adcl %edx, %esi
 addl %edi, %ebp
 movl %ebp, 1900(%esp)
 movl 1960(%esp), %ebp
 adcl %esi, %ebx
 movl %ebx, 1904(%esp)
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
 movl 1960(%esp), %eax
 movl 16(%eax), %eax
 mull 48(%ecx)
 addl %eax, %ebx
 movl (%ecx), %eax
 adcl %edx, %esi
 addl %ebx, %ebp
 movl %ebp, 1908(%esp)
 movl 1960(%esp), %ebp
 adcl %esi, %edi
 movl %edi, 1912(%esp)
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
 movl 1960(%esp), %ecx
 mull 64(%ecx)
 addl %eax, %ebp
 movl (%ecx), %eax
 adcl %edx, %ebx
 addl %ebp, %esi
 movl 1896(%esp), %ebp
 movl 1904(%esp), %ecx
 adcl %ebx, %edi
 movl 1900(%esp), %ebx
 mull 16(%ebp)
 shll $6, %ecx
 shrl $26, %ebx
 orl %ebx, %ecx
 addl %ecx, %eax
 movl 1960(%esp), %ebx
 adcl $0, %edx
 addl %eax, %esi
 movl %esi, 1916(%esp)
 movl %ebp, %esi
 adcl %edx, %edi
 movl %edi, 1920(%esp)
 movl %ebp, %edi
 movl (%esi), %eax
 mull 32(%ebx)
 movl %eax, %esi
 movl %edx, %ecx
 movl 128(%edi), %eax
 mull 48(%ebx)
 addl %eax, %esi
 movl 112(%ebp), %eax
 adcl %edx, %ecx
 mull 64(%ebx)
 movl %edx, %ebp
 movl %eax, %edi
 movl 1896(%esp), %edx
 movl 16(%ebx), %eax
 mull 16(%edx)
 addl %eax, %edi
 movl (%ebx), %eax
 movl 1896(%esp), %ebx
 adcl %edx, %ebp
 addl %edi, %esi
 movl 1920(%esp), %edi
 adcl %ebp, %ecx
 mull 32(%ebx)
 movl 1916(%esp), %ebp
 shll $6, %edi
 shrl $26, %ebp
 orl %ebp, %edi
 addl %edi, %eax
 movl %ebx, %ebp
 movl %ebp, %edi
 adcl $0, %edx
 addl %eax, %esi
 movl %esi, 1924(%esp)
 adcl %edx, %ecx
 movl %ecx, 1928(%esp)
 movl %ebx, %ecx
 movl 1960(%esp), %esi
 movl (%ecx), %eax
 mull 48(%esi)
 movl %eax, %ecx
 movl %edx, %ebx
 movl 128(%ebp), %eax
 mull 64(%esi)
 addl %eax, %ecx
 movl 32(%esi), %eax
 adcl %edx, %ebx
 mull 16(%edi)
 movl %edx, %ebp
 movl %eax, %edi
 movl 1896(%esp), %edx
 movl 16(%esi), %eax
 mull 32(%edx)
 addl %eax, %edi
 movl (%esi), %eax
 movl 1896(%esp), %esi
 adcl %edx, %ebp
 addl %edi, %ecx
 movl 1928(%esp), %edi
 adcl %ebp, %ebx
 mull 48(%esi)
 movl 1924(%esp), %esi
 movl %esi, %ebp
 shll $6, %edi
 andl $67108863, %esi
 shrl $26, %ebp
 orl %ebp, %edi
 addl %edi, %eax
 movl 1900(%esp), %edi
 movd %esi, %xmm2
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
 addl 1908(%esp), %ebx
 movl 1912(%esp), %edx
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
 movl 1916(%esp), %eax
 shrl $26, %edi
 andl $67108863, %eax
 addl %eax, %edi
 movd %ebp, %xmm7
 movl 1968(%esp), %ebp
 pshufd $68, %xmm7, %xmm6
 movd %ecx, %xmm7
 movd %edi, %xmm3
 movl %ebp, %ecx
 movdqa %xmm6, (%ebp)
 pshufd $68, %xmm3, %xmm6
 pshufd $68, %xmm2, %xmm3
 pshufd $68, %xmm7, %xmm2
 movd %ebx, %xmm7
 pshufd $68, %xmm7, %xmm7
 movdqa %xmm6, 16(%ebp)
 movdqa %xmm3, 32(%ebp)
 movdqa %xmm2, 48(%ebp)
 movdqa %xmm7, 64(%ebp)
 pmuludq %xmm1, %xmm6
 pmuludq %xmm1, %xmm3
 pmuludq %xmm1, %xmm2
 pmuludq %xmm1, %xmm7
 movl 1972(%esp), %ebx
 incl %ebx
 movdqa %xmm6, 80(%ebp)
 movdqa %xmm3, 96(%ebp)
 movdqa %xmm2, 112(%ebp)
 movdqa %xmm7, 128(%ebp)
 addl $-144, %ebp
 movl %ebx, 1972(%esp)
 movl %ebp, 1968(%esp)
 cmpl 1964(%esp), %ebx
 jb ..B1.8

..B1.9:
 movdqa 2144(%esp), %xmm3
 movdqa 2128(%esp), %xmm6
 movl 1888(%esp), %eax
 movl 1960(%esp), %esi
 movl 1956(%esp), %edi
 movl 1892(%esp), %ebx
 movl 1964(%esp), %edx

..B1.10:
 cmpl $32, 2244(%esp)
 jb ..B1.47

..B1.11:
 movdqa 112(%esp), %xmm7
 movdqa %xmm7, 2048(%esp)
 movdqa 96(%esp), %xmm7
 movdqa %xmm7, 2032(%esp)
 movdqa 80(%esp), %xmm7
 movdqa %xmm7, 2016(%esp)
 movdqa 16(%esp), %xmm7
 movdqa %xmm7, 2000(%esp)
 movdqa 32(%esp), %xmm7
 movdqa %xmm7, 1920(%esp)
 movdqa (%esp), %xmm2
 movdqa 48(%esp), %xmm7
 movdqa %xmm2, 2064(%esp)
 movdqa %xmm7, 1904(%esp)
 movdqa 128(%esp), %xmm2
 movdqa 64(%esp), %xmm7
 movdqa %xmm1, 1936(%esp)
 movdqa %xmm7, 1888(%esp)
 movdqa %xmm2, 2080(%esp)
 movdqa %xmm4, 2096(%esp)
 movdqa %xmm3, 2144(%esp)
 movdqa %xmm6, 2128(%esp)
 movl %esi, 1960(%esp)
 movl %edi, 1956(%esp)
 movdqa 1872(%esp), %xmm1
 movl 2240(%esp), %ebp
 movl 2244(%esp), %ecx

..B1.12:
 movdqa 2064(%esp), %xmm4
 movdqa %xmm0, %xmm6
 movdqa %xmm1, %xmm3
 movl %ebx, %edi
 pmuludq 2080(%esp), %xmm3
 cmpl $1, %edx
 pmuludq %xmm4, %xmm6
 paddq %xmm3, %xmm6
 movdqa 1984(%esp), %xmm3
 movdqa %xmm3, %xmm7
 pmuludq 2048(%esp), %xmm7
 movdqa 2032(%esp), %xmm2
 paddq %xmm7, %xmm6
 movdqa 2096(%esp), %xmm7
 pmuludq %xmm2, %xmm7
 paddq %xmm7, %xmm6
 movdqa %xmm5, %xmm7
 pmuludq 2016(%esp), %xmm7
 paddq %xmm7, %xmm6
 movdqa %xmm6, 2208(%esp)
 movdqa %xmm0, %xmm7
 movdqa %xmm1, %xmm6
 pmuludq 2000(%esp), %xmm7
 pmuludq %xmm4, %xmm6
 movdqa %xmm3, %xmm4
 pmuludq 2080(%esp), %xmm4
 pmuludq 2064(%esp), %xmm3
 paddq %xmm6, %xmm7
 movdqa 2096(%esp), %xmm6
 paddq %xmm4, %xmm7
 movdqa 2048(%esp), %xmm4
 pmuludq %xmm4, %xmm6
 paddq %xmm6, %xmm7
 movdqa %xmm5, %xmm6
 pmuludq %xmm2, %xmm6
 movdqa %xmm0, %xmm2
 paddq %xmm6, %xmm7
 movdqa 1920(%esp), %xmm6
 movdqa %xmm7, 2192(%esp)
 movdqa %xmm1, %xmm7
 pmuludq %xmm6, %xmm2
 pmuludq 2000(%esp), %xmm7
 paddq %xmm7, %xmm2
 movdqa 2080(%esp), %xmm7
 paddq %xmm3, %xmm2
 movdqa 2096(%esp), %xmm3
 pmuludq %xmm7, %xmm3
 paddq %xmm3, %xmm2
 movdqa %xmm5, %xmm3
 pmuludq %xmm4, %xmm3
 paddq %xmm3, %xmm2
 movdqa 1904(%esp), %xmm4
 movdqa %xmm0, %xmm3
 movdqa %xmm2, 2176(%esp)
 movdqa %xmm1, %xmm2
 pmuludq %xmm4, %xmm3
 pmuludq %xmm6, %xmm2
 pmuludq 1888(%esp), %xmm0
 pmuludq %xmm4, %xmm1
 paddq %xmm2, %xmm3
 paddq %xmm1, %xmm0
 movdqa 1984(%esp), %xmm6
 pmuludq 2000(%esp), %xmm6
 movdqa 2096(%esp), %xmm2
 paddq %xmm6, %xmm3
 movdqa 2064(%esp), %xmm6
 pmuludq %xmm6, %xmm2
 paddq %xmm2, %xmm3
 movdqa %xmm5, %xmm2
 pmuludq %xmm7, %xmm2
 pmuludq %xmm6, %xmm5
 paddq %xmm2, %xmm3
 movdqa 1984(%esp), %xmm1
 pmuludq 1920(%esp), %xmm1
 movdqa 2096(%esp), %xmm2
 pmuludq 2000(%esp), %xmm2
 paddq %xmm1, %xmm0
 paddq %xmm2, %xmm0
 movdqa 2208(%esp), %xmm6
 movdqa 2192(%esp), %xmm4
 movdqa 2176(%esp), %xmm7
 paddq %xmm5, %xmm0
 jbe ..B1.16

..B1.13:
 movdqa %xmm0, 2160(%esp)
 movl $1, %esi
 movdqa %xmm3, 2224(%esp)
 movdqa %xmm7, 2176(%esp)
 movdqa %xmm4, 2192(%esp)
 movdqa %xmm6, 2208(%esp)

..B1.14:
 movq 16(%ebp), %xmm6
 addl $144, %edi
 movq (%ebp), %xmm5
 incl %esi
 movq 24(%ebp), %xmm3
 pslldq $8, %xmm6
 pslldq $8, %xmm3
 por %xmm6, %xmm5
 movq 8(%ebp), %xmm6
 addl $32, %ebp
 movdqa 2128(%esp), %xmm0
 por %xmm3, %xmm6
 movdqa %xmm0, %xmm7
 movdqa %xmm6, %xmm4
 pand %xmm5, %xmm7
 movdqa %xmm5, %xmm3
 psrlq $52, %xmm5
 psllq $12, %xmm4
 por %xmm4, %xmm5
 movdqa %xmm0, %xmm4
 psrlq $26, %xmm3
 pand %xmm5, %xmm4
 psrlq $26, %xmm5
 pand %xmm0, %xmm3
 pand %xmm0, %xmm5
 psrlq $40, %xmm6
 movdqa (%edi), %xmm0
 cmpl %edx, %esi
 movdqa 128(%edi), %xmm2
 movdqa %xmm0, %xmm1
 pmuludq %xmm7, %xmm1
 pmuludq %xmm3, %xmm2
 pmuludq %xmm3, %xmm0
 paddq %xmm2, %xmm1
 movdqa 112(%edi), %xmm2
 pmuludq %xmm4, %xmm2
 paddq %xmm2, %xmm1
 movdqa 96(%edi), %xmm2
 pmuludq %xmm5, %xmm2
 por 2144(%esp), %xmm6
 paddq %xmm2, %xmm1
 movdqa 80(%edi), %xmm2
 pmuludq %xmm6, %xmm2
 paddq %xmm2, %xmm1
 movdqa 2208(%esp), %xmm2
 paddq %xmm1, %xmm2
 movdqa 16(%edi), %xmm1
 movdqa %xmm2, 2208(%esp)
 movdqa %xmm1, %xmm2
 pmuludq %xmm7, %xmm2
 pmuludq %xmm3, %xmm1
 paddq %xmm0, %xmm2
 movdqa 128(%edi), %xmm0
 pmuludq %xmm4, %xmm0
 paddq %xmm0, %xmm2
 movdqa 112(%edi), %xmm0
 pmuludq %xmm5, %xmm0
 paddq %xmm0, %xmm2
 movdqa 96(%edi), %xmm0
 pmuludq %xmm6, %xmm0
 paddq %xmm0, %xmm2
 movdqa 2192(%esp), %xmm0
 paddq %xmm2, %xmm0
 movdqa 32(%edi), %xmm2
 movdqa %xmm0, 2192(%esp)
 movdqa %xmm2, %xmm0
 pmuludq %xmm7, %xmm0
 pmuludq %xmm3, %xmm2
 paddq %xmm1, %xmm0
 movdqa (%edi), %xmm1
 pmuludq %xmm4, %xmm1
 paddq %xmm1, %xmm0
 movdqa 128(%edi), %xmm1
 pmuludq %xmm5, %xmm1
 paddq %xmm1, %xmm0
 movdqa 112(%edi), %xmm1
 pmuludq %xmm6, %xmm1
 paddq %xmm1, %xmm0
 movdqa 2176(%esp), %xmm1
 paddq %xmm0, %xmm1
 movdqa %xmm1, 2176(%esp)
 movdqa 48(%edi), %xmm1
 movdqa %xmm1, %xmm0
 pmuludq %xmm7, %xmm0
 pmuludq 64(%edi), %xmm7
 pmuludq %xmm1, %xmm3
 paddq %xmm2, %xmm0
 paddq %xmm3, %xmm7
 movdqa 16(%edi), %xmm2
 pmuludq %xmm4, %xmm2
 pmuludq 32(%edi), %xmm4
 paddq %xmm2, %xmm0
 paddq %xmm4, %xmm7
 movdqa (%edi), %xmm2
 pmuludq %xmm5, %xmm2
 pmuludq 16(%edi), %xmm5
 paddq %xmm2, %xmm0
 paddq %xmm5, %xmm7
 movdqa 128(%edi), %xmm2
 pmuludq %xmm6, %xmm2
 pmuludq (%edi), %xmm6
 paddq %xmm2, %xmm0
 paddq %xmm6, %xmm7
 movdqa 2224(%esp), %xmm2
 movdqa 2160(%esp), %xmm5
 paddq %xmm0, %xmm2
 paddq %xmm7, %xmm5
 movdqa %xmm2, 2224(%esp)
 movdqa %xmm5, 2160(%esp)
 jb ..B1.14

..B1.15:
 movdqa 2160(%esp), %xmm0
 movdqa 2224(%esp), %xmm3
 movdqa 2176(%esp), %xmm7
 movdqa 2192(%esp), %xmm4
 movdqa 2208(%esp), %xmm6

..B1.16:
 movdqa %xmm6, %xmm1
 movdqa %xmm3, %xmm5
 psrlq $26, %xmm1
 psrlq $26, %xmm5
 paddq %xmm1, %xmm4
 paddq %xmm0, %xmm5
 movdqa %xmm4, %xmm0
 subl %eax, %ecx
 psrlq $26, %xmm0
 paddq %xmm0, %xmm7
 movdqa %xmm5, 1968(%esp)
 psrlq $26, %xmm5
 movdqa 2128(%esp), %xmm2
 movdqa %xmm7, %xmm1
 pmuludq 1936(%esp), %xmm5
 pand %xmm2, %xmm3
 psrlq $26, %xmm1
 pand %xmm2, %xmm6
 paddq %xmm1, %xmm3
 paddq %xmm5, %xmm6
 movdqa %xmm3, 2224(%esp)
 pand %xmm2, %xmm4
 movq 16(%ebp), %xmm3
 pand %xmm2, %xmm7
 movq (%ebp), %xmm1
 movq 24(%ebp), %xmm5
 pslldq $8, %xmm3
 movq 8(%ebp), %xmm0
 por %xmm3, %xmm1
 pslldq $8, %xmm5
 movdqa %xmm2, %xmm3
 por %xmm5, %xmm0
 movdqa %xmm1, %xmm5
 movdqa %xmm0, 2112(%esp)
 psrlq $52, %xmm5
 psllq $12, %xmm0
 pand %xmm1, %xmm3
 por %xmm0, %xmm5
 movdqa %xmm2, %xmm0
 pand %xmm6, %xmm0
 psrlq $26, %xmm6
 psrlq $26, %xmm1
 addl $32, %ebp
 paddq %xmm6, %xmm4
 paddq %xmm3, %xmm0
 pand %xmm2, %xmm1
 movdqa %xmm2, %xmm6
 paddq %xmm4, %xmm1
 movdqa %xmm2, %xmm4
 cmpl %eax, %ecx
 pand %xmm5, %xmm4
 psrlq $26, %xmm5
 paddq %xmm7, %xmm4
 movdqa 2224(%esp), %xmm7
 pand %xmm2, %xmm5
 pand %xmm7, %xmm6
 psrlq $26, %xmm7
 paddq %xmm5, %xmm6
 movdqa 1968(%esp), %xmm5
 pand %xmm2, %xmm5
 movdqa 2112(%esp), %xmm2
 psrlq $40, %xmm2
 paddq %xmm7, %xmm5
 por 2144(%esp), %xmm2
 movdqa %xmm4, 1984(%esp)
 movdqa %xmm6, 2096(%esp)
 paddq %xmm2, %xmm5
 jb ..B1.44
 jmp ..B1.12

..B1.17:
 xorl %edx, %edx
 xorl %esi, %esi
 xorl %ecx, %ecx
 xorl %edi, %edi
 xorl %eax, %eax

..B1.57:
 movl %eax, 52(%esp)
 movl %edx, 48(%esp)
 movl %esi, 32(%esp)
 movl %ecx, 36(%esp)
 movl %edi, 40(%esp)
 jmp ..B1.42

..B1.18:
 xorl %edx, %edx
 xorl %esi, %esi
 xorl %ecx, %ecx
 xorl %edi, %edi
 xorl %eax, %eax

..B1.56:
 movl %esi, 32(%esp)
 movl %ecx, 36(%esp)
 movl %edi, 40(%esp)
 movl 2244(%esp), %esi

..B1.19:
 testl %esi, %esi
 je ..B1.52

..B1.20:
 ja ..B1.22

..B1.21:
 xorl %ebx, %ebx
 jmp ..B1.25

..B1.22:
 movl 2240(%esp), %ebp
 xorl %ebx, %ebx

..B1.23:
 movzbl (%ebx,%ebp), %ecx
 movb %cl, 16(%esp,%ebx)
 incl %ebx
 cmpl %esi, %ebx
 jb ..B1.23

..B1.25:
 movb $1, 16(%esp,%ebx)
 lea 1(%ebx), %ebp
 cmpl $16, %ebp
 jae ..B1.40

..B1.26:
 negl %ebp
 lea 17(%esp,%ebx), %edi
 addl $16, %ebp
 movl %edi, 4(%esp)
 andl $15, %edi
 je ..B1.28

..B1.27:
 movl %edi, %ecx
 negl %ecx
 lea 16(%ecx), %edi
 addl $32, %ecx
 cmpl %ecx, %ebp
 jb ..B1.51
 jmp ..B1.29

..B1.28:
 lea 16(%edi), %ecx
 cmpl %ecx, %ebp
 jb ..B1.51

..B1.29:
 movl %ebp, %esi
 subl %edi, %esi
 andl $15, %esi
 negl %esi
 addl %ebp, %esi
 testl %edi, %edi
 jbe ..B1.33

..B1.30:
 movl %ebx, (%esp)
 xorl %ecx, %ecx
 movl 4(%esp), %ebx

..B1.31:
 movb $0, (%ecx,%ebx)
 incl %ecx
 cmpl %edi, %ecx
 jb ..B1.31

..B1.32:
 movl (%esp), %ebx

..B1.33:
 lea 17(%esp,%ebx), %ecx
 pxor %xmm0, %xmm0
 pshufd $0, %xmm0, %xmm0

..B1.34:
 movdqa %xmm0, (%edi,%ecx)
 addl $16, %edi
 cmpl %esi, %edi
 jb ..B1.34

..B1.36:
 cmpl %ebp, %esi
 jae ..B1.40

..B1.37:
 movl 4(%esp), %ecx

..B1.38:
 movb $0, (%esi,%ecx)
 incl %esi
 cmpl %ebp, %esi
 jb ..B1.38

..B1.40:
 movl 16(%esp), %ebx
 movl %ebx, %ecx
 andl $67108863, %ecx
 movl 20(%esp), %ebp
 addl %ecx, %edx
 movl %ebp, %ecx
 shll $6, %ecx
 shrl $26, %ebx
 movl 24(%esp), %esi
 orl %ebx, %ecx
 movl %esi, %ebx
 andl $67108863, %ecx
 shll $12, %ebx
 shrl $20, %ebp
 movl 28(%esp), %edi
 orl %ebp, %ebx
 movl %edi, %ebp
 andl $67108863, %ebx
 shll $18, %ebp
 shrl $14, %esi
 orl %esi, %ebp
 xorl %esi, %esi
 shrl $8, %edi
 andl $67108863, %ebp
 addl 32(%esp), %ecx
 addl %edi, %eax
 addl 36(%esp), %ebx
 addl 40(%esp), %ebp
 movl %eax, 52(%esp)
 movl %ebp, 8(%esp)
 movl %ebx, 12(%esp)
 movl %ecx, 44(%esp)
 movl %edx, 48(%esp)
 movl %esi, 2244(%esp)

..B1.41:
 movl 48(%esp), %edi
 movl %edi, %eax
 mull 2280(%esp)
 movl %eax, %esi
 movl %edx, %ecx
 movl 44(%esp), %eax
 mull 2248(%esp)
 addl %eax, %esi
 movl 12(%esp), %eax
 adcl %edx, %ecx
 mull 2252(%esp)
 addl %eax, %esi
 movl 8(%esp), %eax
 adcl %edx, %ecx
 mull 2256(%esp)
 movl %eax, %ebp
 movl %edx, %ebx
 movl 52(%esp), %eax
 mull 2260(%esp)
 addl %eax, %ebp
 movl %edi, %eax
 adcl %edx, %ebx
 addl %ebp, %esi
 movl %esi, 56(%esp)
 adcl %ebx, %ecx
 mull 2276(%esp)
 movl %ecx, %ebp
 shll $6, %ebp
 shrl $26, %esi
 orl %esi, %ebp
 shrl $26, %ecx
 addl %eax, %ebp
 movl 2280(%esp), %eax
 adcl %edx, %ecx
 mull 44(%esp)
 movl %eax, %ebx
 movl %edx, %esi
 movl 2248(%esp), %eax
 mull 12(%esp)
 addl %eax, %ebx
 movl 2252(%esp), %eax
 adcl %edx, %esi
 addl %ebx, %ebp
 adcl %esi, %ecx
 mull 8(%esp)
 movl %eax, %ebx
 movl %edx, %esi
 movl 2256(%esp), %eax
 mull 52(%esp)
 addl %eax, %ebx
 movl %edi, %eax
 adcl %edx, %esi
 addl %ebx, %ebp
 movl %ebp, %ebx
 adcl %esi, %ecx
 andl $67108863, %ebx
 mull 2272(%esp)
 movl %eax, %edi
 movl 2276(%esp), %eax
 movl %ebx, 32(%esp)
 movl %edx, %ebx
 mull 44(%esp)
 addl %eax, %edi
 movl 2280(%esp), %eax
 adcl %edx, %ebx
 mull 12(%esp)
 addl %eax, %edi
 movl 2248(%esp), %eax
 adcl %edx, %ebx
 mull 8(%esp)
 shll $6, %ecx
 movl %eax, %esi
 movl 2252(%esp), %eax
 shrl $26, %ebp
 orl %ebp, %ecx
 movl %edx, %ebp
 mull 52(%esp)
 addl %eax, %esi
 movl 48(%esp), %eax
 adcl %edx, %ebp
 addl %esi, %edi
 adcl %ebp, %ebx
 addl %edi, %ecx
 movl %ecx, %edi
 adcl $0, %ebx
 andl $67108863, %edi
 mull 2268(%esp)
 movl %edi, 36(%esp)
 movl %eax, %edi
 shll $6, %ebx
 shrl $26, %ecx
 movl 2272(%esp), %eax
 orl %ecx, %ebx
 movl %edx, %ecx
 mull 44(%esp)
 addl %eax, %edi
 movl 2276(%esp), %eax
 adcl %edx, %ecx
 mull 12(%esp)
 addl %eax, %edi
 movl 2280(%esp), %eax
 adcl %edx, %ecx
 mull 8(%esp)
 movl %eax, %esi
 movl %edx, %ebp
 movl 2248(%esp), %eax
 mull 52(%esp)
 addl %eax, %esi
 movl 2264(%esp), %eax
 adcl %edx, %ebp
 addl %esi, %edi
 adcl %ebp, %ecx
 addl %edi, %ebx
 movl %ebx, %ebp
 adcl $0, %ecx
 andl $67108863, %ebp
 mull 48(%esp)
 shll $6, %ecx
 movl %eax, %edi
 movl 2268(%esp), %eax
 shrl $26, %ebx
 orl %ebx, %ecx
 movl %edx, %ebx
 mull 44(%esp)
 addl %eax, %edi
 movl 2272(%esp), %eax
 adcl %edx, %ebx
 mull 12(%esp)
 addl %eax, %edi
 movl 2276(%esp), %eax
 adcl %edx, %ebx
 mull 8(%esp)
 movl %eax, %esi
 movl 2280(%esp), %eax
 movl %ebp, 40(%esp)
 movl %edx, %ebp
 mull 52(%esp)
 addl %eax, %esi
 adcl %edx, %ebp
 addl %esi, %edi
 adcl %ebp, %ebx
 addl %edi, %ecx
 movl %ecx, %esi
 adcl $0, %ebx
 andl $67108863, %esi
 shll $6, %ebx
 shrl $26, %ecx
 orl %ecx, %ebx
 movl 56(%esp), %edi
 andl $67108863, %edi
 movl %esi, 52(%esp)
 lea (%ebx,%ebx,4), %ecx
 addl %edi, %ecx
 movl %ecx, 48(%esp)
 cmpl $16, 2244(%esp)
 jb ..B1.43

..B1.42:
 movl 2240(%esp), %eax
 movl 2244(%esp), %esi
 addl $-16, %esi
 movl 4(%eax), %edx
 movl %esi, 2244(%esp)
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
 addl %edi, 48(%esp)
 addl %ecx, 52(%esp)
 movl %esi, 44(%esp)
 movl %ebp, 12(%esp)
 movl %edx, 8(%esp)
 movl %eax, 2240(%esp)
 jmp ..B1.41

..B1.43:
 movl %esi, %eax
 movl %ecx, %edx
 movl 2244(%esp), %esi
 jmp ..B1.19

..B1.44:
 cmpl $32, %ecx
 jb ..B1.46

..B1.45:
 movl %ecx, %edx
 shrl $5, %edx
 movl 1960(%esp), %ebx
 movl %edx, %eax
 shll $5, %eax
 lea (%edx,%edx,8), %esi
 shll $4, %esi
 subl %esi, %ebx
 addl $144, %ebx
 movl %esi, 1956(%esp)
 movdqa (%ebx), %xmm2
 movdqa 128(%ebx), %xmm3
 movdqa 112(%ebx), %xmm4
 movdqa 96(%ebx), %xmm6
 movdqa %xmm2, 2064(%esp)
 movdqa %xmm3, 2080(%esp)
 movdqa %xmm4, 2048(%esp)
 movdqa %xmm6, 2032(%esp)
 movdqa 80(%ebx), %xmm7
 movdqa 16(%ebx), %xmm2
 movdqa 32(%ebx), %xmm3
 movdqa 48(%ebx), %xmm4
 movdqa 64(%ebx), %xmm6
 movdqa %xmm7, 2016(%esp)
 movdqa %xmm2, 2000(%esp)
 movdqa %xmm3, 1920(%esp)
 movdqa %xmm4, 1904(%esp)
 movdqa %xmm6, 1888(%esp)
 jmp ..B1.12

..B1.46:
 movdqa %xmm1, 1872(%esp)
 movl %ebp, 2240(%esp)
 movl %ecx, 2244(%esp)
 movdqa 2096(%esp), %xmm4
 movdqa 1936(%esp), %xmm1
 movdqa 2128(%esp), %xmm6
 movl 1956(%esp), %edi

..B1.47:
 movl 2268(%esp), %ebp
 movl 2280(%esp), %eax
 movl %ebp, -88(%ebx,%edi)
 movl %eax, -136(%ebx,%edi)
 movl $0, -132(%ebx,%edi)
 movl 2248(%esp), %ebp
 movdqa 1872(%esp), %xmm2
 movdqa %xmm6, 2128(%esp)
 movdqa %xmm2, %xmm3
 movdqa %xmm1, 1936(%esp)
 movdqa %xmm0, %xmm1
 movl %ebp, -8(%ebx,%edi)
 movl $0, -4(%ebx,%edi)
 movdqa -144(%ebx,%edi), %xmm6
 pmuludq %xmm6, %xmm1
 pmuludq -16(%ebx,%edi), %xmm3
 movl 2272(%esp), %ecx
 movl %ecx, -104(%ebx,%edi)
 movl 2252(%esp), %ecx
 movdqa 1984(%esp), %xmm7
 movl %ecx, -24(%ebx,%edi)
 movl $0, -20(%ebx,%edi)
 paddq %xmm3, %xmm1
 movdqa %xmm7, %xmm3
 pmuludq -32(%ebx,%edi), %xmm3
 movl 2276(%esp), %edx
 movl %edx, -120(%ebx,%edi)
 movl 2256(%esp), %edx
 movl %edx, -40(%ebx,%edi)
 movl $0, -36(%ebx,%edi)
 paddq %xmm3, %xmm1
 movdqa %xmm4, %xmm3
 pmuludq -48(%ebx,%edi), %xmm3
 movl 2260(%esp), %eax
 movl %eax, -56(%ebx,%edi)
 movl $0, -52(%ebx,%edi)
 paddq %xmm3, %xmm1
 movdqa -64(%ebx,%edi), %xmm3
 pmuludq %xmm5, %xmm3
 paddq %xmm3, %xmm1
 movl $0, -100(%ebx,%edi)
 movdqa %xmm2, %xmm3
 movl $0, -84(%ebx,%edi)
 movdqa %xmm1, 1888(%esp)
 movdqa %xmm0, %xmm1
 pmuludq -96(%ebx,%edi), %xmm1
 pmuludq -112(%ebx,%edi), %xmm3
 movl $0, -116(%ebx,%edi)
 paddq %xmm3, %xmm1
 movdqa -128(%ebx,%edi), %xmm3
 pmuludq %xmm3, %xmm7
 paddq %xmm7, %xmm1
 movdqa %xmm4, %xmm7
 pmuludq %xmm6, %xmm7
 paddq %xmm7, %xmm1
 movdqa -16(%ebx,%edi), %xmm7
 movdqa %xmm5, 1968(%esp)
 pmuludq %xmm7, %xmm5
 movl 2264(%esp), %esi
 paddq %xmm5, %xmm1
 movl %esi, -72(%ebx,%edi)
 movdqa %xmm2, %xmm5
 movl $0, -68(%ebx,%edi)
 movdqa %xmm1, 1904(%esp)
 movdqa -80(%ebx,%edi), %xmm1
 movdqa %xmm0, 2160(%esp)
 pmuludq %xmm0, %xmm1
 pmuludq %xmm3, %xmm0
 pmuludq %xmm6, %xmm5
 paddq %xmm5, %xmm0
 movdqa 1984(%esp), %xmm5
 movdqa %xmm5, %xmm6
 pmuludq %xmm7, %xmm6
 movdqa %xmm4, %xmm7
 pmuludq -32(%ebx,%edi), %xmm7
 paddq %xmm6, %xmm0
 paddq %xmm7, %xmm0
 movdqa -48(%ebx,%edi), %xmm7
 movdqa 1968(%esp), %xmm6
 pmuludq %xmm6, %xmm7
 paddq %xmm7, %xmm0
 movdqa 1888(%esp), %xmm7
 psrlq $26, %xmm7
 paddq %xmm7, %xmm0
 movdqa %xmm0, 1920(%esp)
 movdqa -96(%ebx,%edi), %xmm0
 pmuludq %xmm2, %xmm0
 pmuludq %xmm3, %xmm2
 paddq %xmm0, %xmm1
 movdqa -112(%ebx,%edi), %xmm7
 movdqa %xmm5, %xmm0
 pmuludq %xmm7, %xmm0
 paddq %xmm0, %xmm1
 movdqa %xmm4, %xmm0
 pmuludq %xmm3, %xmm0
 pmuludq -16(%ebx,%edi), %xmm4
 paddq %xmm0, %xmm1
 movdqa %xmm6, %xmm0
 movdqa -144(%ebx,%edi), %xmm6
 pmuludq %xmm6, %xmm0
 pmuludq %xmm6, %xmm5
 paddq %xmm0, %xmm1
 movdqa 1904(%esp), %xmm0
 psrlq $26, %xmm0
 paddq %xmm0, %xmm1
 movdqa 2160(%esp), %xmm0
 pmuludq %xmm7, %xmm0
 paddq %xmm2, %xmm0
 paddq %xmm5, %xmm0
 paddq %xmm4, %xmm0
 movdqa 1968(%esp), %xmm4
 movdqa %xmm1, %xmm5
 pmuludq -32(%ebx,%edi), %xmm4
 psrlq $26, %xmm5
 pmuludq 1936(%esp), %xmm5
 paddq %xmm4, %xmm0
 movdqa 1920(%esp), %xmm4
 movdqa 2128(%esp), %xmm3
 movdqa %xmm4, %xmm2
 movdqa 1888(%esp), %xmm6
 psrlq $26, %xmm2
 pand %xmm3, %xmm6
 movdqa %xmm3, %xmm7
 paddq %xmm2, %xmm0
 paddq %xmm5, %xmm6
 movdqa 1904(%esp), %xmm2
 movdqa %xmm3, %xmm5
 pand %xmm0, %xmm5
 pand %xmm6, %xmm7
 pand %xmm3, %xmm2
 psrlq $26, %xmm0
 paddq %xmm0, %xmm2
 pand %xmm3, %xmm4
 movdqa %xmm3, %xmm0
 pand %xmm3, %xmm1
 movdqa %xmm7, %xmm3
 psrldq $8, %xmm3
 psrlq $26, %xmm6
 paddq %xmm6, %xmm4
 paddq %xmm3, %xmm7
 pand %xmm2, %xmm0
 movdqa %xmm4, %xmm6
 movd %xmm7, %edx
 movdqa %xmm0, %xmm7
 psrldq $8, %xmm6
 psrlq $26, %xmm2
 psrldq $8, %xmm7
 paddq %xmm2, %xmm1
 paddq %xmm6, %xmm4
 paddq %xmm7, %xmm0
 movd %xmm4, %esi
 movdqa %xmm5, %xmm4
 psrldq $8, %xmm4
 movd %xmm0, %edi
 movdqa %xmm1, %xmm0
 psrldq $8, %xmm0
 paddq %xmm4, %xmm5
 paddq %xmm0, %xmm1
 movd %xmm5, %ecx
 movd %xmm1, %eax
 cmpl $16, 2244(%esp)
 jb ..B1.56
 jmp ..B1.57

..B1.51:
 xorl %esi, %esi
 jmp ..B1.36

..B1.52:
 movl %edx, %ebx
 andl $67108863, %edx
 shrl $26, %ebx
 movl 32(%esp), %esi
 addl %ebx, %esi
 movl %esi, %ebp
 shrl $26, %esi
 andl $67108863, %ebp
 movl 36(%esp), %ecx
 addl %esi, %ecx
 movl %ecx, %ebx
 shrl $26, %ecx
 andl $67108863, %ebx
 movl 40(%esp), %edi
 addl %ecx, %edi
 movl %edi, %esi
 shrl $26, %edi
 andl $67108863, %esi
 addl %edi, %eax
 movl %eax, %ecx
 shrl $26, %eax
 andl $67108863, %ecx
 movl %ecx, (%esp)
 lea (%eax,%eax,4), %eax
 lea (%edx,%eax), %edi
 movl %edi, 4(%esp)
 lea 5(%eax,%edx), %edx
 movl %edx, 8(%esp)
 shrl $26, %edx
 addl %ebp, %edx
 movl %edx, %eax
 andl $67108863, %edx
 shrl $26, %eax
 addl %ebx, %eax
 movl %eax, %edi
 andl $67108863, %eax
 shrl $26, %edi
 addl %esi, %edi
 movl %edi, 12(%esp)
 shrl $26, %edi
 lea -67108864(%edi,%ecx), %edi
 movl %edi, 16(%esp)
 shrl $31, %edi
 decl %edi
 movl %edi, %ecx
 andl %edi, %eax
 notl %ecx
 andl %edi, %edx
 andl %ecx, %ebx
 andl %ecx, %ebp
 orl %eax, %ebx
 orl %edx, %ebp
 movl 12(%esp), %eax
 andl %ecx, %esi
 andl $67108863, %eax
 movl 8(%esp), %edx
 andl %edi, %eax
 andl $67108863, %edx
 orl %eax, %esi
 movl 4(%esp), %eax
 andl %edi, %edx
 andl %ecx, %eax
 orl %edx, %eax
 movl %ebp, %edx
 shll $26, %edx
 orl %edx, %eax
 movl 2316(%esp), %edx
 shrl $6, %ebp
 andl (%esp), %ecx
 addl 16(%edx), %eax
 movl %eax, 4(%esp)
 movl $0, %eax
 adcl $0, %eax
 movl %eax, 20(%esp)
 movl %ebx, %eax
 shll $20, %eax
 orl %eax, %ebp
 xorl %eax, %eax
 addl 20(%edx), %ebp
 adcl $0, %eax
 movl %eax, 24(%esp)
 movl %esi, %eax
 shrl $12, %ebx
 shll $14, %eax
 orl %eax, %ebx
 xorl %eax, %eax
 addl 24(%edx), %ebx
 adcl $0, %eax
 movl %eax, 28(%esp)
 movl 16(%esp), %eax
 andl %edi, %eax
 orl %eax, %ecx
 shrl $18, %esi
 shll $8, %ecx
 addl 20(%esp), %ebp
 movl 24(%esp), %eax
 adcl $0, %eax
 orl %ecx, %esi
 addl 28(%edx), %esi
 addl %eax, %ebx
 movl 2304(%esp), %edx
 movl 4(%esp), %ecx
 movl %ebp, 4(%edx)
 movl 28(%esp), %ebp
 adcl $0, %ebp
 addl %ebp, %esi
 movl %ecx, (%edx)
 movl %ebx, 8(%edx)
 movl %esi, 12(%edx)
 movl 2300(%esp), %esp
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
