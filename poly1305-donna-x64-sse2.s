.text
.align 16,0x90
.globl poly1305_auth_x64_sse2
poly1305_auth_x64_sse2:
 pushq %r12
 pushq %r13
 pushq %r14
 pushq %r15
 pushq %rbx
 pushq %rbp
 subq $2168, %rsp
 movq %rsi, %r12
 movq 8(%rcx), %r9
 movq $0xffc0fffffff, %rsi
 movq %r9, %r10
 movq $0xfffffc0ffff, %r11
 movq (%rcx), %rbx
 andq %rbx, %rsi
 shrq $44, %rbx
 movq $0xffffffc0f, %rbp
 shlq $20, %r10
 xorl %r14d, %r14d
 shrq $24, %r9
 orq %r10, %rbx
 andq %r11, %rbx
 andq %rbp, %r9
 movq %rdx, %r8
 xorl %r15d, %r15d
 movdqa poly1305_x64_sse2_message_mask(%rip), %xmm8
 movdqa poly1305_x64_sse2_5(%rip), %xmm9
 movdqa poly1305_x64_sse2_1shl128(%rip), %xmm6
 lea (%rbx,%rbx,4), %rbp
 shlq $2, %rbp
 lea (%r9,%r9,4), %r13
 shlq $2, %r13
 movq %rbp, 2096(%rsp)
 xorl %ebp, %ebp
 cmpq $16, %r8
 jb ..B1.41
..B1.2:
 cmpq $32, %r8
 jb ..B1.42
..B1.3:
 addq $-32, %r8
 movq $0xaaaaaaaaaaaaaaab, %rbp
 movq %r8, %rax
 movdqa %xmm8, %xmm7
 mulq %rbp
 movq 16(%r12), %xmm0
 movq (%r12), %xmm1
 movq 24(%r12), %xmm3
 pslldq $8, %xmm0
 pslldq $8, %xmm3
 por %xmm0, %xmm1
 movq 8(%r12), %xmm0
 pand %xmm1, %xmm7
 por %xmm3, %xmm0
 movdqa %xmm1, %xmm3
 movdqa %xmm0, %xmm2
 psrlq $52, %xmm1
 psllq $12, %xmm2
 psrlq $26, %xmm3
 shrq $9, %rdx
 por %xmm2, %xmm1
 movdqa %xmm8, %xmm2
 incq %rdx
 pand %xmm1, %xmm2
 psrlq $26, %xmm1
 psrlq $40, %xmm0
 addq $32, %r12
 pand %xmm8, %xmm3
 pand %xmm8, %xmm1
 por %xmm6, %xmm0
 cmpq $13, %rdx
 jae ..B1.5
..B1.4:
 movq %r8, %rax
 mulq %rbp
 shrq $9, %rdx
 incq %rdx
 movq %rdx, 1968(%rsp)
 jmp ..B1.6
..B1.5:
 movq $13, 1968(%rsp)
..B1.6:
 movq %r8, 1880(%rsp)
 movq %rsi, %rax
 movq 1968(%rsp), %r8
 movq %r8, %r10
 shlq $5, %r10
 movq %r10, 1904(%rsp)
 lea (%r8,%r8,8), %r11
 shlq $4, %r11
 lea (%rsp), %r10
 movq %r13, 1896(%rsp)
 movq %r12, 1888(%rsp)
 lea (%r10,%r11), %r14
 movq %r14, 1912(%rsp)
 mulq %rsi
 lea -144(%r10,%r11), %r10
 movq %rdx, %r14
 movq %rax, %rbp
 lea (%rbx,%rbx), %rax
 mulq %r13
 addq %rax, %rbp
 adcq %rdx, %r14
 movq %r9, %rax
 mulq %r13
 movq %rdx, %r13
 movq %rax, %r12
 lea (%rsi,%rsi), %rax
 mulq %rbx
 addq %rax, %r12
 adcq %rdx, %r13
 movq %rbx, %rax
 mulq %rbx
 movq %rdx, %r15
 movq %rax, %r11
 lea (%r9,%r9), %rax
 mulq %rsi
 addq %rax, %r11
 adcq %rdx, %r15
 movq %rbp, %rax
 movq $0xfffffffffff, %rdx
 andq %rdx, %rax
 shrdq $44, %r14, %rbp
 addq %rbp, %r12
 adcq $0, %r13
 movq %r12, %rbp
 andq %rdx, %rbp
 shrdq $44, %r13, %r12
 addq %r12, %r11
 adcq $0, %r15
 movq $0x3ffffffffff, %r12
 movq %r11, %r13
 andq %r12, %r13
 movq %r13, 1984(%rsp)
 shrdq $42, %r15, %r11
 lea (%r11,%r11,4), %r14
 addq %rax, %r14
 andq %r14, %rdx
 shrq $44, %r14
 movq %rdx, %r11
 addq %rbp, %r14
 lea (%r13,%r13,4), %rbp
 shlq $2, %rbp
 movq %r14, %rax
 movq %rbp, 1920(%rsp)
 movl %edx, %ebp
 andl $67108863, %ebp
 movq %rdx, 1944(%rsp)
 lea (%r14,%r14,4), %r15
 shrq $26, %rdx
 shrq $34, %rax
 movd %ebp, %xmm4
 movq %r14, %rbp
 shlq $18, %rbp
 orq %rbp, %rdx
 movq %r14, %rbp
 shrq $8, %rbp
 andl $67108863, %edx
 andl $67108863, %ebp
 movq %r13, 1936(%rsp)
 pshufd $68, %xmm4, %xmm5
 movd %edx, %xmm10
 movd %ebp, %xmm11
 movq %r13, %rbp
 shlq $10, %rbp
 orq %rbp, %rax
 lea -144(%r10), %rbp
 shrq $16, %r13
 andl $67108863, %eax
 movdqa %xmm5, (%r10)
 pshufd $68, %xmm10, %xmm14
 pshufd $68, %xmm11, %xmm15
 movd %eax, %xmm12
 movd %r13d, %xmm13
 pshufd $68, %xmm12, %xmm4
 lea (%rsp), %rax
 pshufd $68, %xmm13, %xmm5
 movdqa %xmm14, 16(%r10)
 movdqa %xmm15, 32(%r10)
 movdqa %xmm4, 48(%r10)
 movdqa %xmm5, 64(%r10)
 pmuludq %xmm9, %xmm14
 pmuludq %xmm9, %xmm15
 pmuludq %xmm9, %xmm4
 pmuludq %xmm9, %xmm5
 shlq $2, %r15
 movq %r14, 1928(%rsp)
 cmpq $1, %r8
 movq %r15, 1976(%rsp)
 movl $1, %r15d
 movdqa %xmm14, 80(%r10)
 movdqa %xmm15, 96(%r10)
 movdqa %xmm4, 112(%r10)
 movdqa %xmm5, 128(%r10)
 movq 1880(%rsp), %r8
 movq 1888(%rsp), %r12
 movq 1896(%rsp), %r13
 jbe ..B1.8
..B1.7:
 movq 1944(%rsp), %r11
 movq %r13, 1896(%rsp)
 movq %rax, 1872(%rsp)
 movq %r11, %rax
 movq %r12, 1888(%rsp)
 movq %r8, 1880(%rsp)
 mulq %r11
 movq 1928(%rsp), %r13
 movq %rdx, %r14
 movq %rax, %rbp
 movq 1920(%rsp), %r12
 lea (%r13,%r13), %rax
 mulq %r12
 addq %rax, %rbp
 adcq %rdx, %r14
 movq 1984(%rsp), %rax
 mulq %r12
 movq %rdx, %r8
 movq %rax, %r12
 lea (%r11,%r11), %rax
 mulq %r13
 addq %rax, %r12
 adcq %rdx, %r8
 movq %r13, %rax
 mulq %r13
 movq %rax, %r15
 movq %rdx, %r13
 movq 1984(%rsp), %rax
 addq %rax, %rax
 mulq %r11
 movq $0xfffffffffff, %r11
 addq %rax, %r15
 adcq %rdx, %r13
 movq %r11, %rax
 andq %rbp, %rax
 shrdq $44, %r14, %rbp
 addq %rbp, %r12
 adcq $0, %r8
 movq %r11, %rbp
 andq %r12, %rbp
 shrdq $44, %r8, %r12
 movq $0x3ffffffffff, %r8
 addq %r12, %r15
 adcq $0, %r13
 andq %r15, %r8
 movq %r8, %r12
 movq %r8, 1936(%rsp)
 shrdq $42, %r13, %r15
 lea (%r15,%r15,4), %r14
 addq %rax, %r14
 andq %r14, %r11
 shrq $44, %r14
 movq %r11, %r15
 addq %rbp, %r14
 movl %r11d, %ebp
 andl $67108863, %ebp
 movq %r14, %r13
 shrq $26, %r15
 shlq $18, %r13
 orq %r13, %r15
 movq %r14, %r13
 shrq $34, %r13
 movd %ebp, %xmm4
 shlq $10, %r12
 movq %r14, %rbp
 shrq $8, %rbp
 orq %r12, %r13
 shrq $16, %r8
 andl $67108863, %r15d
 andl $67108863, %ebp
 andl $67108863, %r13d
 pshufd $68, %xmm4, %xmm5
 movdqa %xmm5, -144(%r10)
 movd %r15d, %xmm10
 movd %ebp, %xmm11
 movd %r13d, %xmm12
 movd %r8d, %xmm13
 pshufd $68, %xmm10, %xmm14
 lea -288(%r10), %rbp
 pshufd $68, %xmm11, %xmm15
 movl $2, %r15d
 pshufd $68, %xmm12, %xmm4
 pshufd $68, %xmm13, %xmm5
 movdqa %xmm14, -128(%r10)
 movdqa %xmm15, -112(%r10)
 movdqa %xmm4, -96(%r10)
 movdqa %xmm5, -80(%r10)
 pmuludq %xmm9, %xmm14
 pmuludq %xmm9, %xmm15
 pmuludq %xmm9, %xmm4
 pmuludq %xmm9, %xmm5
 movdqa %xmm14, -64(%r10)
 movdqa %xmm15, -48(%r10)
 movdqa %xmm4, -32(%r10)
 movdqa %xmm5, -16(%r10)
 movq 1880(%rsp), %r8
 movq 1888(%rsp), %r12
 movq 1872(%rsp), %rax
 movq 1896(%rsp), %r13
..B1.8:
 cmpq 1968(%rsp), %r15
 jae ..B1.12
..B1.9:
 movq %r8, 1880(%rsp)
 movq %r12, 1888(%rsp)
 movq %r9, 2008(%rsp)
 movq %rax, 1872(%rsp)
 movq %r13, 1896(%rsp)
 movq %rbx, 1992(%rsp)
 movq %rsi, 2000(%rsp)
 movq %rdi, 1952(%rsp)
 movq %rcx, 1960(%rsp)
 movq 1936(%rsp), %r8
 movq 1920(%rsp), %r9
 movq 1928(%rsp), %r10
 movq 1944(%rsp), %r12
..B1.10:
 movq %r11, %rax
 incq %r15
 mulq %r12
 movq %rdx, %rcx
 movq %rax, %rbx
 movq %r14, %rax
 mulq %r9
 addq %rax, %rbx
 adcq %rdx, %rcx
 movq %r8, %rax
 movq 1976(%rsp), %rsi
 mulq %rsi
 addq %rax, %rbx
 adcq %rdx, %rcx
 movq %r11, %rax
 mulq %r10
 movq %rdx, %rsi
 movq %rax, %rdi
 movq %r14, %rax
 mulq %r12
 addq %rax, %rdi
 adcq %rdx, %rsi
 movq %r8, %rax
 mulq %r9
 addq %rax, %rdi
 adcq %rdx, %rsi
 movq %r11, %rax
 movq 1984(%rsp), %r11
 mulq %r11
 movq %rdx, %r13
 movq %rax, %r11
 movq %r14, %rax
 mulq %r10
 addq %rax, %r11
 adcq %rdx, %r13
 movq %r8, %rax
 movq $0x3ffffffffff, %r8
 mulq %r12
 addq %rax, %r11
 adcq %rdx, %r13
 movq $0xfffffffffff, %rax
 movq %rax, %rdx
 andq %rbx, %rdx
 shrdq $44, %rcx, %rbx
 movq %rax, %rcx
 addq %rbx, %rdi
 adcq $0, %rsi
 andq %rdi, %rcx
 shrdq $44, %rsi, %rdi
 addq %rdi, %r11
 adcq $0, %r13
 andq %r11, %r8
 movq %r8, %rsi
 shrdq $42, %r13, %r11
 lea (%r11,%r11,4), %r14
 addq %rdx, %r14
 movq %rax, %r11
 andq %r14, %r11
 shrq $44, %r14
 movl %r11d, %ebx
 addq %rcx, %r14
 movq %r11, %rcx
 movq %r14, %rdi
 andl $67108863, %ebx
 shrq $26, %rcx
 movq %r14, %r13
 shlq $18, %rdi
 orq %rdi, %rcx
 movd %ebx, %xmm4
 andl $67108863, %ecx
 movq %r14, %rbx
 shrq $34, %r13
 shlq $10, %rsi
 shrq $8, %rbx
 orq %rsi, %r13
 movd %ecx, %xmm10
 movq %r8, %rcx
 shrq $16, %rcx
 andl $67108863, %ebx
 andl $67108863, %r13d
 pshufd $68, %xmm4, %xmm5
 movdqa %xmm5, (%rbp)
 movd %ebx, %xmm11
 movd %r13d, %xmm12
 movd %ecx, %xmm13
 pshufd $68, %xmm10, %xmm14
 pshufd $68, %xmm11, %xmm15
 pshufd $68, %xmm12, %xmm4
 pshufd $68, %xmm13, %xmm5
 movdqa %xmm14, 16(%rbp)
 movdqa %xmm15, 32(%rbp)
 movdqa %xmm4, 48(%rbp)
 movdqa %xmm5, 64(%rbp)
 pmuludq %xmm9, %xmm14
 pmuludq %xmm9, %xmm15
 pmuludq %xmm9, %xmm4
 pmuludq %xmm9, %xmm5
 movdqa %xmm14, 80(%rbp)
 movdqa %xmm15, 96(%rbp)
 movdqa %xmm4, 112(%rbp)
 movdqa %xmm5, 128(%rbp)
 addq $-144, %rbp
 cmpq 1968(%rsp), %r15
 jb ..B1.10
..B1.11:
 movq 1880(%rsp), %r8
 movq 1888(%rsp), %r12
 movq 1872(%rsp), %rax
 movq 1896(%rsp), %r13
 movq 2008(%rsp), %r9
 movq 1992(%rsp), %rbx
 movq 2000(%rsp), %rsi
 movq 1952(%rsp), %rdi
 movq 1960(%rsp), %rcx
..B1.12:
 cmpq $32, %r8
 jb ..B1.35
..B1.13:
 movdqa 80(%rsp), %xmm10
 movdqa 112(%rsp), %xmm5
 movdqa 96(%rsp), %xmm4
 movdqa 48(%rsp), %xmm15
 movdqa 64(%rsp), %xmm14
 movdqa %xmm10, 2016(%rsp)
 movdqa (%rsp), %xmm12
 movdqa 16(%rsp), %xmm10
 movdqa 32(%rsp), %xmm13
 movq 1904(%rsp), %r11
 movq 1912(%rsp), %r14
 movq 1968(%rsp), %r15
 movdqa 128(%rsp), %xmm11
 movdqa %xmm14, 2080(%rsp)
 movdqa %xmm15, 2064(%rsp)
 movdqa %xmm4, 2048(%rsp)
 movdqa %xmm5, 2032(%rsp)
 movdqa %xmm6, 2112(%rsp)
 movdqa %xmm9, 1936(%rsp)
..B1.14:
 movdqa %xmm7, %xmm9
 movdqa %xmm3, %xmm6
 pmuludq %xmm12, %xmm9
 movdqa %xmm2, %xmm15
 pmuludq %xmm11, %xmm6
 movdqa 2032(%rsp), %xmm4
 movdqa %xmm0, %xmm14
 pmuludq %xmm4, %xmm15
 movq %rax, %r10
 pmuludq 2016(%rsp), %xmm14
 paddq %xmm6, %xmm9
 movdqa 2048(%rsp), %xmm5
 movdqa %xmm1, %xmm6
 pmuludq %xmm5, %xmm6
 movl $1, %ebp
 paddq %xmm15, %xmm9
 paddq %xmm6, %xmm9
 movdqa %xmm7, %xmm6
 movdqa %xmm3, %xmm15
 pmuludq %xmm10, %xmm6
 cmpq $1, %r15
 pmuludq %xmm12, %xmm15
 paddq %xmm14, %xmm9
 paddq %xmm15, %xmm6
 movdqa %xmm2, %xmm14
 movdqa %xmm1, %xmm15
 pmuludq %xmm11, %xmm14
 pmuludq %xmm4, %xmm15
 paddq %xmm14, %xmm6
 movdqa %xmm0, %xmm14
 pmuludq %xmm5, %xmm14
 movdqa %xmm7, %xmm5
 pmuludq %xmm13, %xmm5
 paddq %xmm15, %xmm6
 movdqa %xmm3, %xmm15
 pmuludq %xmm10, %xmm15
 paddq %xmm14, %xmm6
 paddq %xmm15, %xmm5
 movdqa %xmm2, %xmm14
 movdqa %xmm1, %xmm15
 pmuludq %xmm12, %xmm14
 pmuludq %xmm11, %xmm15
 paddq %xmm14, %xmm5
 movdqa %xmm0, %xmm14
 pmuludq %xmm4, %xmm14
 movdqa %xmm7, %xmm4
 pmuludq 2080(%rsp), %xmm7
 paddq %xmm15, %xmm5
 paddq %xmm14, %xmm5
 movdqa 2064(%rsp), %xmm14
 movdqa %xmm3, %xmm15
 pmuludq %xmm14, %xmm4
 pmuludq %xmm13, %xmm15
 pmuludq %xmm14, %xmm3
 paddq %xmm15, %xmm4
 paddq %xmm3, %xmm7
 movdqa %xmm2, %xmm15
 pmuludq %xmm10, %xmm15
 pmuludq %xmm13, %xmm2
 paddq %xmm15, %xmm4
 paddq %xmm2, %xmm7
 movdqa %xmm1, %xmm15
 pmuludq %xmm12, %xmm15
 pmuludq %xmm10, %xmm1
 paddq %xmm15, %xmm4
 paddq %xmm1, %xmm7
 movdqa %xmm0, %xmm15
 pmuludq %xmm11, %xmm15
 pmuludq %xmm12, %xmm0
 paddq %xmm15, %xmm4
 paddq %xmm0, %xmm7
 jbe ..B1.18
..B1.15:
 movdqa %xmm9, 2144(%rsp)
 movdqa %xmm13, 1920(%rsp)
 movdqa %xmm10, 1904(%rsp)
 movdqa %xmm11, 1888(%rsp)
 movdqa %xmm12, 1872(%rsp)
 movdqa %xmm8, 2128(%rsp)
..B1.16:
 movq 16(%r12), %xmm12
 addq $144, %r10
 movq (%r12), %xmm10
 incq %rbp
 movq 24(%r12), %xmm2
 pslldq $8, %xmm12
 pslldq $8, %xmm2
 por %xmm12, %xmm10
 movq 8(%r12), %xmm12
 addq $32, %r12
 movdqa 2128(%rsp), %xmm1
 por %xmm2, %xmm12
 movdqa %xmm1, %xmm13
 movdqa %xmm12, %xmm8
 pand %xmm10, %xmm13
 movdqa %xmm10, %xmm2
 psrlq $52, %xmm10
 psllq $12, %xmm8
 por %xmm8, %xmm10
 movdqa %xmm1, %xmm8
 psrlq $26, %xmm2
 pand %xmm10, %xmm8
 psrlq $26, %xmm10
 pand %xmm1, %xmm2
 movdqa (%r10), %xmm11
 pand %xmm1, %xmm10
 movdqa 128(%r10), %xmm1
 movdqa %xmm11, %xmm9
 movdqa %xmm1, %xmm3
 psrlq $40, %xmm12
 movdqa 112(%r10), %xmm0
 cmpq %r15, %rbp
 pmuludq %xmm13, %xmm9
 movdqa %xmm0, %xmm15
 pmuludq %xmm2, %xmm3
 pmuludq %xmm8, %xmm15
 paddq %xmm3, %xmm9
 movdqa 96(%r10), %xmm14
 movdqa %xmm14, %xmm3
 pmuludq %xmm10, %xmm3
 paddq %xmm15, %xmm9
 movdqa 80(%r10), %xmm15
 por 2112(%rsp), %xmm12
 pmuludq %xmm12, %xmm15
 pmuludq %xmm12, %xmm14
 paddq %xmm3, %xmm9
 paddq %xmm15, %xmm9
 movdqa 2144(%rsp), %xmm3
 movdqa %xmm11, %xmm15
 paddq %xmm9, %xmm3
 pmuludq %xmm2, %xmm15
 movdqa 16(%r10), %xmm9
 movdqa %xmm3, 2144(%rsp)
 movdqa %xmm9, %xmm3
 pmuludq %xmm13, %xmm3
 paddq %xmm15, %xmm3
 movdqa %xmm1, %xmm15
 pmuludq %xmm8, %xmm15
 paddq %xmm15, %xmm3
 movdqa %xmm0, %xmm15
 pmuludq %xmm10, %xmm15
 pmuludq %xmm12, %xmm0
 paddq %xmm15, %xmm3
 paddq %xmm14, %xmm3
 paddq %xmm3, %xmm6
 movdqa 32(%r10), %xmm3
 movdqa %xmm9, %xmm15
 movdqa %xmm3, %xmm14
 pmuludq %xmm13, %xmm14
 pmuludq %xmm2, %xmm15
 paddq %xmm15, %xmm14
 movdqa %xmm11, %xmm15
 pmuludq %xmm8, %xmm15
 paddq %xmm15, %xmm14
 movdqa %xmm1, %xmm15
 pmuludq %xmm10, %xmm15
 pmuludq %xmm12, %xmm1
 pmuludq %xmm11, %xmm12
 paddq %xmm15, %xmm14
 paddq %xmm0, %xmm14
 paddq %xmm14, %xmm5
 movdqa 48(%r10), %xmm14
 movdqa %xmm3, %xmm0
 movdqa %xmm14, %xmm15
 pmuludq %xmm13, %xmm15
 pmuludq %xmm2, %xmm0
 pmuludq 64(%r10), %xmm13
 pmuludq %xmm14, %xmm2
 paddq %xmm0, %xmm15
 paddq %xmm2, %xmm13
 movdqa %xmm9, %xmm0
 pmuludq %xmm8, %xmm0
 pmuludq %xmm3, %xmm8
 paddq %xmm0, %xmm15
 paddq %xmm8, %xmm13
 movdqa %xmm11, %xmm0
 pmuludq %xmm10, %xmm0
 pmuludq %xmm9, %xmm10
 paddq %xmm0, %xmm15
 paddq %xmm10, %xmm13
 paddq %xmm1, %xmm15
 paddq %xmm12, %xmm13
 paddq %xmm15, %xmm4
 paddq %xmm13, %xmm7
 jb ..B1.16
..B1.17:
 movdqa 2144(%rsp), %xmm9
 movdqa 1920(%rsp), %xmm13
 movdqa 1904(%rsp), %xmm10
 movdqa 1888(%rsp), %xmm11
 movdqa 1872(%rsp), %xmm12
 movdqa 2128(%rsp), %xmm8
..B1.18:
 movdqa %xmm9, %xmm0
 pand %xmm8, %xmm9
 psrlq $26, %xmm0
 subq %r11, %r8
 paddq %xmm0, %xmm6
 movdqa %xmm4, %xmm0
 movdqa %xmm6, %xmm3
 psrlq $26, %xmm0
 psrlq $26, %xmm3
 paddq %xmm7, %xmm0
 paddq %xmm3, %xmm5
 movdqa %xmm0, %xmm7
 movdqa %xmm5, %xmm1
 psrlq $26, %xmm7
 pand %xmm8, %xmm4
 pmuludq 1936(%rsp), %xmm7
 psrlq $26, %xmm1
 paddq %xmm1, %xmm4
 paddq %xmm7, %xmm9
 movq 16(%r12), %xmm2
 movdqa %xmm8, %xmm1
 movq 24(%r12), %xmm14
 pand %xmm8, %xmm6
 movq (%r12), %xmm3
 pand %xmm8, %xmm0
 movq 8(%r12), %xmm15
 pand %xmm8, %xmm5
 pslldq $8, %xmm2
 addq $32, %r12
 pslldq $8, %xmm14
 por %xmm2, %xmm3
 por %xmm14, %xmm15
 movdqa %xmm3, %xmm14
 movdqa %xmm15, %xmm7
 psrlq $52, %xmm14
 psllq $12, %xmm7
 pand %xmm3, %xmm1
 por %xmm7, %xmm14
 movdqa %xmm8, %xmm7
 pand %xmm9, %xmm7
 movdqa %xmm8, %xmm2
 paddq %xmm1, %xmm7
 movdqa %xmm8, %xmm1
 psrlq $26, %xmm9
 pand %xmm4, %xmm1
 psrlq $26, %xmm4
 psrlq $26, %xmm3
 pand %xmm14, %xmm2
 psrlq $26, %xmm14
 psrlq $40, %xmm15
 paddq %xmm9, %xmm6
 paddq %xmm4, %xmm0
 paddq %xmm5, %xmm2
 por 2112(%rsp), %xmm15
 pand %xmm8, %xmm3
 pand %xmm8, %xmm14
 cmpq %r11, %r8
 paddq %xmm6, %xmm3
 paddq %xmm14, %xmm1
 paddq %xmm15, %xmm0
 jb ..B1.32
 jmp ..B1.14
..B1.42:
 movq %r9, 2008(%rsp)
 movq %rdi, 1952(%rsp)
 movq %rcx, 1960(%rsp)
 jmp ..B1.30
..B1.41:
 movq %r9, 2008(%rsp)
 movq %rbx, 1992(%rsp)
 movq $0xfffffffffff, %rbx
 movq %rsi, 2000(%rsp)
 movq %rdi, 1952(%rsp)
 movq %rcx, 1960(%rsp)
..B1.21:
 testq %r8, %r8
 je ..B1.38
..B1.22:
 movl $0, %ecx
 jbe ..B1.26
..B1.23:
 xorl %ecx, %ecx
..B1.24:
 movzbl (%rcx,%r12), %esi
 movb %sil, (%rsp,%rcx)
 incq %rcx
 cmpq %r8, %rcx
 jb ..B1.24
..B1.25:
 movq %r8, %rcx
..B1.26:
 lea 1(%rcx), %rdx
 cmpq $16, %rdx
 movb $1, (%rsp,%rcx)
 jae ..B1.28
..B1.27:
 negq %rdx
 lea 1(%rsp,%rcx), %rdi
 lea 16(%rdx), %rcx
 xorq %rax, %rax
 rep stosb
..B1.28:
 movq (%rsp), %rsi
 movq %rbx, %rcx
 movq 8(%rsp), %rdi
 andq %rsi, %rcx
 shrdq $44, %rdi, %rsi
 movl $16, %r8d
 shrq $24, %rdi
 andq %rbx, %rsi
 movq 1992(%rsp), %rbx
 addq %rcx, %r14
 addq %rsi, %r15
 addq %rdi, %rbp
 movq 2000(%rsp), %rsi

..B1.29:
 movq %r14, %rax
 addq $-16, %r8
 mulq %rsi
 addq $16, %r12
 movq %rdx, %rcx
 movq %rax, %rdi
 movq %r15, %rax
 mulq %r13
 addq %rax, %rdi
 adcq %rdx, %rcx
 movq %rbp, %rax
 movq 2096(%rsp), %r9
 mulq %r9
 addq %rax, %rdi
 adcq %rdx, %rcx
 movq %r14, %rax
 mulq %rbx
 movq %rdx, %r9
 movq %rax, %r10
 movq %r15, %rax
 mulq %rsi
 addq %rax, %r10
 adcq %rdx, %r9
 movq %rbp, %rax
 mulq %r13
 addq %rax, %r10
 adcq %rdx, %r9
 movq %r14, %rax
 movq 2008(%rsp), %r11
 mulq %r11
 movq %rdx, %r14
 movq %rax, %r11
 movq %r15, %rax
 movq $0xfffffffffff, %r15
 mulq %rbx
 addq %rax, %r11
 adcq %rdx, %r14
 movq %rbp, %rax
 movq $0x3ffffffffff, %rbp
 mulq %rsi
 addq %rax, %r11
 adcq %rdx, %r14
 movq %r15, %rax
 andq %rdi, %rax
 shrdq $44, %rcx, %rdi
 addq %rdi, %r10
 adcq $0, %r9
 andq %r10, %r15
 shrdq $44, %r9, %r10
 addq %r10, %r11
 adcq $0, %r14
 andq %r11, %rbp
 shrdq $42, %r14, %r11
 lea (%r11,%r11,4), %r14
 addq %rax, %r14
 cmpq $16, %r8
 jb ..B1.31

..B1.30:
 movq $0xfffffffffff, %rdi
 movq (%r12), %r9
 movq %rdi, %rcx
 movq 8(%r12), %r10
 andq %r9, %rcx
 shrdq $44, %r10, %r9
 addq %rcx, %r14
 shrq $24, %r10
 andq %rdi, %r9
 btsq $40, %r10
 addq %r9, %r15
 addq %r10, %rbp
 jmp ..B1.29

..B1.31:
 movq %rbx, 1992(%rsp)
 movq $0xfffffffffff, %rbx
 movq %rsi, 2000(%rsp)
 jmp ..B1.21

..B1.32:
 cmpq $32, %r8
 jb ..B1.34

..B1.33:
 movq %r8, %r15
 shrq $5, %r15
 imulq $-144, %r15, %rbp
 movq %r15, %r11
 lea -144(%rbp,%r14), %rax
 addq $144, %rax
 shlq $5, %r11
 movdqa 112(%rax), %xmm10
 movdqa 96(%rax), %xmm13
 movdqa 80(%rax), %xmm4
 movdqa 48(%rax), %xmm5
 movdqa 64(%rax), %xmm6
 movdqa %xmm10, 2032(%rsp)
 movdqa %xmm13, 2048(%rsp)
 movdqa (%rax), %xmm12
 movdqa 16(%rax), %xmm10
 movdqa 32(%rax), %xmm13
 movdqa 128(%rax), %xmm11
 movdqa %xmm4, 2016(%rsp)
 movdqa %xmm5, 2064(%rsp)
 movdqa %xmm6, 2080(%rsp)
 jmp ..B1.14

..B1.34:
 movq %r15, 1968(%rsp)
 movdqa 1936(%rsp), %xmm9

..B1.35:
 movq 1968(%rsp), %rbp
 movq %rsi, %r10
 shrq $26, %r10
 movq %rbx, %r15
 movq %r9, %r14
 movdqa %xmm7, %xmm10
 shrq $34, %r15
 lea (%rbp,%rbp,8), %r11
 shlq $4, %r11
 movdqa %xmm3, %xmm4
 movl %esi, %ebp
 movdqa %xmm2, %xmm12
 andq $67108863, %rbp
 movdqa %xmm1, %xmm13
 shlq $10, %r14
 movdqa %xmm3, %xmm5
 movq %rbp, -136(%rax,%r11)
 movq %rbx, %rbp
 shlq $18, %rbp
 orq %r14, %r15
 orq %rbp, %r10
 movq %rbx, %rbp
 shrq $8, %rbp
 movq %r9, %r14
 movl %ebp, %ebp
 movq $0xfffffffffff, %rdx
 movl %r15d, %r15d
 andq $67108863, %rbp
 andq $67108863, %r15
 shrq $16, %r14
 movq %rbp, -104(%rax,%r11)
 movdqa %xmm8, 2128(%rsp)
 lea (%rbp,%rbp,4), %rbp
 movq %rbp, -40(%rax,%r11)
 lea (%r15,%r15,4), %rbp
 movq %rbp, -24(%rax,%r11)
 lea (%r14,%r14,4), %rbp
 movq %rbp, -8(%rax,%r11)
 movl %r10d, %r10d
 movdqa -144(%rax,%r11), %xmm6
 andq $67108863, %r10
 movdqa -16(%rax,%r11), %xmm8
 pmuludq %xmm6, %xmm10
 pmuludq %xmm8, %xmm4
 movdqa %xmm9, 1936(%rsp)
 movdqa -32(%rax,%r11), %xmm9
 pmuludq %xmm9, %xmm12
 paddq %xmm4, %xmm10
 movdqa -48(%rax,%r11), %xmm15
 movdqa %xmm2, %xmm4
 movq %r10, -120(%rax,%r11)
 lea (%r10,%r10,4), %r10
 movq %r10, -56(%rax,%r11)
 pmuludq %xmm15, %xmm13
 pmuludq %xmm0, %xmm15
 paddq %xmm12, %xmm10
 movdqa -64(%rax,%r11), %xmm11
 movdqa %xmm7, %xmm12
 pmuludq %xmm0, %xmm11
 paddq %xmm13, %xmm10
 movq %r15, -88(%rax,%r11)
 movdqa %xmm1, %xmm13
 paddq %xmm11, %xmm10
 pmuludq %xmm6, %xmm13
 movdqa -112(%rax,%r11), %xmm11
 movdqa -96(%rax,%r11), %xmm14
 pmuludq %xmm14, %xmm12
 pmuludq %xmm11, %xmm5
 pmuludq %xmm3, %xmm14
 paddq %xmm5, %xmm12
 movdqa -128(%rax,%r11), %xmm5
 pmuludq %xmm5, %xmm4
 paddq %xmm4, %xmm12
 movdqa %xmm0, %xmm4
 pmuludq %xmm8, %xmm4
 paddq %xmm13, %xmm12
 movq %r14, -72(%rax,%r11)
 movdqa %xmm3, %xmm13
 paddq %xmm4, %xmm12
 pmuludq %xmm6, %xmm13
 pmuludq %xmm5, %xmm3
 movdqa -80(%rax,%r11), %xmm4
 movdqa %xmm7, 1872(%rsp)
 pmuludq %xmm7, %xmm4
 pmuludq %xmm5, %xmm7
 paddq %xmm14, %xmm4
 paddq %xmm13, %xmm7
 movdqa %xmm2, %xmm13
 movdqa %xmm2, %xmm14
 pmuludq %xmm8, %xmm13
 pmuludq %xmm11, %xmm14
 pmuludq %xmm6, %xmm2
 paddq %xmm13, %xmm7
 paddq %xmm14, %xmm4
 movdqa %xmm1, %xmm13
 pmuludq %xmm9, %xmm13
 paddq %xmm13, %xmm7
 paddq %xmm15, %xmm7
 movdqa %xmm10, %xmm15
 movdqa %xmm1, %xmm13
 psrlq $26, %xmm15
 pmuludq %xmm5, %xmm13
 pmuludq %xmm8, %xmm1
 paddq %xmm15, %xmm7
 paddq %xmm13, %xmm4
 movdqa %xmm0, %xmm15
 movdqa %xmm12, %xmm13
 pmuludq %xmm6, %xmm15
 psrlq $26, %xmm13
 pmuludq %xmm9, %xmm0
 paddq %xmm15, %xmm4
 paddq %xmm13, %xmm4
 movdqa 1872(%rsp), %xmm13
 pmuludq %xmm11, %xmm13
 paddq %xmm3, %xmm13
 paddq %xmm2, %xmm13
 paddq %xmm1, %xmm13
 movdqa %xmm4, %xmm1
 psrlq $26, %xmm1
 pmuludq 1936(%rsp), %xmm1
 paddq %xmm0, %xmm13
 movdqa 2128(%rsp), %xmm2
 movdqa %xmm7, %xmm0
 pand %xmm2, %xmm10
 psrlq $26, %xmm0
 paddq %xmm1, %xmm10
 paddq %xmm0, %xmm13
 movdqa %xmm2, %xmm0
 pand %xmm2, %xmm7
 pand %xmm10, %xmm0
 psrlq $26, %xmm10
 paddq %xmm10, %xmm7
 movdqa %xmm0, %xmm3
 movdqa %xmm2, %xmm1
 psrldq $8, %xmm3
 pand %xmm2, %xmm12
 movdqa %xmm2, %xmm5
 pand %xmm2, %xmm4
 movdqa %xmm7, %xmm2
 pand %xmm13, %xmm1
 paddq %xmm3, %xmm0
 psrldq $8, %xmm2
 psrlq $26, %xmm13
 paddq %xmm2, %xmm7
 paddq %xmm13, %xmm12
 movd %xmm0, %r14d
 movd %xmm7, %r15d
 movdqa %xmm1, %xmm7
 psrldq $8, %xmm7
 pand %xmm12, %xmm5
 psrlq $26, %xmm12
 movslq %r14d, %r14
 paddq %xmm7, %xmm1
 paddq %xmm12, %xmm4
 movd %xmm1, %eax
 movdqa %xmm5, %xmm12
 movdqa %xmm4, %xmm6
 psrldq $8, %xmm12
 movq %r14, %rbp
 andq $67108863, %r14
 movslq %r15d, %r15
 shrq $26, %rbp
 addq %rbp, %r15
 paddq %xmm12, %xmm5
 movq %r15, %rbp
 andq $67108863, %r15
 psrldq $8, %xmm6
 movslq %eax, %rax
 shrq $26, %rbp
 movd %xmm5, %r11d
 addq %rbp, %rax
 paddq %xmm6, %xmm4
 movq %rax, %rbp
 andq $67108863, %rax
 movd %xmm4, %r10d
 movslq %r11d, %r11
 shrq $26, %rbp
 addq %rbp, %r11
 movslq %r10d, %r10
 movq %r11, %rbp
 shrq $26, %r11
 andq $67108863, %rbp
 addq %r11, %r10
 movq %r10, %r11
 shrq $26, %r11
 shlq $8, %rax
 shlq $16, %r10
 lea (%r11,%r11,4), %r11
 addq %r11, %r14
 movq %r14, %r11
 andq $67108863, %r14
 shrq $26, %r11
 addq %r11, %r15
 movq %r15, %r11
 shlq $26, %r11
 shrq $18, %r15
 orq %r11, %r14
 movq %rbp, %r11
 orq %rax, %r15
 shlq $34, %r11
 andq %rdx, %r14
 shrq $10, %rbp
 orq %r11, %r15
 orq %r10, %rbp
 movq $0x3ffffffffff, %r10
 andq %rdx, %r15
 andq %r10, %rbp
 cmpq $16, %r8
 jb ..B1.41
 jmp ..B1.42

..B1.38:
 movq %r14, %r12
 movq $0xfffffffffff, %rbx
 shrq $44, %r12
 movq %rbx, %r11
 addq %r15, %r12
 movq $0x3ffffffffff, %r10
 andq %r12, %r11
 andq %rbx, %r14
 shrq $44, %r12
 movq $0xfffffc0000000000, %r13
 addq %r12, %rbp
 movq %rbx, %r15
 andq %rbp, %r10
 shrq $42, %rbp
 movq 1960(%rsp), %rcx
 movq 1952(%rsp), %rdi
 lea (%rbp,%rbp,4), %rbp
 lea (%r14,%rbp), %r9
 lea 5(%r14,%rbp), %r14
 movq 16(%rcx), %rbp
 movq %r14, %rax
 andq %rbx, %r14
 shrq $44, %rax
 andq %rbp, %r15
 addq %r11, %rax
 movq %rax, %r8
 andq %rbx, %rax
 shrq $44, %r8
 addq %r10, %r8
 addq %r13, %r8
 movq %r8, %rdx
 shrq $63, %rdx
 decq %rdx
 movq %rdx, %rsi
 andq %rdx, %r14
 notq %rsi
 andq %rdx, %rax
 andq %rsi, %r9
 andq %rsi, %r11
 orq %r14, %r9
 orq %rax, %r11
 movq 24(%rcx), %rcx
 addq %r15, %r9
 shrdq $44, %rcx, %rbp
 movq %r9, %r12
 shrq $44, %r12
 andq %rbx, %rbp
 addq %rbp, %r12
 andq %r10, %rsi
 addq %r11, %r12
 movq %rbx, %r11
 shrq $24, %rcx
 andq %r12, %r11
 shrq $44, %r12
 andq %rdx, %r8
 addq %rcx, %r12
 orq %r8, %rsi
 movq %r11, %rax
 addq %rsi, %r12
 shlq $44, %rax
 andq %rbx, %r9
 shrq $20, %r11
 orq %rax, %r9
 shlq $24, %r12
 orq %r12, %r11
 movq %r9, (%rdi)
 movq %r11, 8(%rdi)
 addq $2168, %rsp
 popq %rbp
 popq %rbx
 popq %r15
 popq %r14
 popq %r13
 popq %r12
 ret

.section .rodata, "a"
.align 16
poly1305_x64_sse2_message_mask:
.long	67108863
.long	0
.long	67108863
.long	0
.align 16
poly1305_x64_sse2_5:
.long	5
.long	0
.long	5
.long	0
poly1305_x64_sse2_1shl128:
.long	16777216
.long	0
.long	16777216
.long	0
