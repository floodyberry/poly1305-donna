.text
.p2align 4,,15
.globl poly1305_auth
poly1305_auth:
pushq %r15
pushq %r14
pushq %r13
pushq %r12
pushq %rbp
movq %rdx, %rbp
pushq %rbx
subq $2096, %rsp
movq (%rcx), %rdx
movq 8(%rcx), %rax
movq %rcx, 128(%rsp)
movabsq $17575274610687, %rcx
movq %rdi, 144(%rsp)
movq %rsi, %rdi
movdqa poly1305_x64_sse2_message_mask(%rip), %xmm11
andq %rdx, %rcx
shrq $44, %rdx
movq %rcx, 120(%rsp)
movq %rax, %rcx
shrq $24, %rax
movq %rax, 40(%rsp)
movabsq $68719475727, %rax
andq %rax, 40(%rsp)
movq 40(%rsp), %rsi
salq $20, %rcx
orq %rdx, %rcx
movabsq $17592181915647, %rdx
andq %rdx, %rcx
leaq (%rsi,%rsi,4), %rax
movq %rcx, -32(%rsp)
salq $2, %rax
cmpq $15, %rbp
movq %rax, 136(%rsp)
jbe .L24
cmpq $31, %rbp
ja .L3
xorl %edx, %edx
xorl %r13d, %r13d
xorl %eax, %eax
.L4:
movq (%rdi), %r8
movabsq $17592186044415, %rsi
movq 8(%rdi), %r9
subq $16, %rbp
movq %r8, %rcx
andq %rsi, %rcx
leaq (%rcx,%rax), %r15
movq %r8, %rcx
movabsq $1099511627776, %rax
shrdq $44, %r9, %rcx
shrq $24, %r9
andq %rsi, %rcx
orq %rax, %r9
leaq (%rcx,%r13), %rsi
leaq (%r9,%rdx), %r8
jmp .L13
.L24:
xorl %edx, %edx
xorl %r13d, %r13d
xorl %eax, %eax
.L2:
testq %rbp, %rbp
je .L14
.L39:
xorl %ecx, %ecx
.L15:
movzbl (%rdi,%rcx), %esi
movb %sil, 2072(%rsp,%rcx)
addq $1, %rcx
cmpq %rcx, %rbp
ja .L15
leaq 1(%rbp), %r9
movb $1, 2072(%rsp,%rbp)
cmpq $16, %r9
je .L16
leaq 2072(%rsp), %rsi
movl $15, %r10d
movq %r9, %rcx
subq %rbp, %r10
addq %r9, %rsi
negq %rsi
andl $15, %esi
cmpq %r10, %rsi
cmova %r10, %rsi
testq %rsi, %rsi
je .L17
notq %rbp
movq %rax, %r8
.L18:
movb $0, 2072(%rsp,%rcx)
addq $1, %rcx
leaq 0(%rbp,%rcx), %rax
cmpq %rax, %rsi
ja .L18
cmpq %r10, %rsi
movq %r8, %rax
je .L16
.L17:
subq %rsi, %r10
movq %r10, %r8
shrq $4, %r8
movq %r8, %r11
salq $4, %r11
testq %r11, %r11
je .L28
addq %rsi, %r9
pxor %xmm0, %xmm0
leaq 2072(%rsp), %rsi
addq %rsi, %r9
xorl %esi, %esi
.L21:
addq $1, %rsi
movdqa %xmm0, (%r9)
addq $16, %r9
cmpq %r8, %rsi
jb .L21
addq %r11, %rcx
cmpq %r11, %r10
je .L16
.L28:
movb $0, 2072(%rsp,%rcx)
addq $1, %rcx
cmpq $15, %rcx
jbe .L28
.L16:
movq 2072(%rsp), %rcx
movq 2080(%rsp), %r8
movabsq $17592186044415, %rsi
xorl %ebp, %ebp
movq %rcx, %r9
movq %r8, 192(%rsp)
movq %rcx, 184(%rsp)
movq 192(%rsp), %rbx
movq 184(%rsp), %rcx
andq %rsi, %r9
shrq $24, %r8
leaq (%rax,%r9), %r15
addq %rdx, %r8
shrdq $44, %rbx, %rcx
andq %rsi, %rcx
leaq 0(%r13,%rcx), %rsi
.L13:
movq 136(%rsp), %rax
movq -32(%rsp), %r9
movabsq $17592186044415, %r13
movq $0, 160(%rsp)
movq $0, 176(%rsp)
mulq %rsi
leaq (%r9,%r9,4), %rcx
salq $2, %rcx
movq %rax, %r11
movq %r8, %rax
movq %rdx, %r12
mulq %rcx
addq %rax, %r11
movq 120(%rsp), %rax
adcq %rdx, %r12
mulq %r15
addq %rax, %r11
movq 120(%rsp), %rax
adcq %rdx, %r12
movq %r11, %r14
andq %r13, %r14
mulq %rsi
movq %rax, %r9
movq 136(%rsp), %rax
movq %rdx, %r10
mulq %r8
addq %rax, %r9
movq -32(%rsp), %rax
adcq %rdx, %r10
mulq %r15
addq %rax, %r9
movq %r11, %rax
adcq %rdx, %r10
shrdq $44, %r12, %rax
movq %rax, 152(%rsp)
movq -32(%rsp), %rax
addq 152(%rsp), %r9
adcq 160(%rsp), %r10
mulq %rsi
andq %r9, %r13
movq %rax, %rcx
movq 120(%rsp), %rax
movq %rdx, %rbx
mulq %r8
addq %rax, %rcx
movq 40(%rsp), %rax
adcq %rdx, %rbx
mulq %r15
addq %rax, %rcx
movq %r9, %rax
adcq %rdx, %rbx
movabsq $4398046511103, %rdx
shrdq $44, %r10, %rax
movq %rax, 168(%rsp)
addq 168(%rsp), %rcx
adcq 176(%rsp), %rbx
addq $16, %rdi
andq %rcx, %rdx
shrdq $42, %rbx, %rcx
leaq (%rcx,%rcx,4), %rax
addq %r14, %rax
testq %rbp, %rbp
jne .L39
.L14:
movq %rax, %rdi
shrq $44, %rax
movabsq $17592186044415, %rcx
addq %rax, %r13
movabsq $4398046511103, %r9
andq %rcx, %rdi
movq %r13, %rsi
shrq $44, %r13
movabsq $-4398046511104, %r11
addq %r13, %rdx
andq %rcx, %rsi
andq %rdx, %r9
shrq $42, %rdx
leaq (%rdi,%rdx,4), %rax
addq %r9, %r11
leaq (%rax,%rdx), %rdi
leaq 5(%rdi), %r8
movq %r8, %rbx
andq %rcx, %r8
shrq $44, %rbx
addq %rsi, %rbx
movq %rbx, %rax
andq %rcx, %rbx
shrq $44, %rax
addq %rax, %r11
movq %r11, %rax
shrq $63, %rax
subq $1, %rax
movq %rax, %rdx
andq %rax, %r8
andq %rax, %rbx
notq %rdx
andq %r11, %rax
andq %rdx, %rdi
andq %rdx, %rsi
andq %r9, %rdx
orq %r8, %rdi
movq 128(%rsp), %r8
orq %rbx, %rsi
orq %rax, %rdx
movq 16(%r8), %rbp
movq 24(%r8), %r8
movq %rbp, %r9
andq %rcx, %r9
addq %r9, %rdi
movq %rbp, %r9
shrdq $44, %r8, %r9
andq %rcx, %r9
addq %r9, %rsi
movq %rdi, %r9
shrq $44, %r9
leaq (%rsi,%r9), %r10
movq %r10, %r9
andq %rcx, %r9
shrq $24, %r8
shrq $44, %r10
leaq (%rdx,%r8), %rax
movq %r9, %rsi
movq 144(%rsp), %rdx
salq $44, %rsi
andq %rdi, %rcx
shrq $20, %r9
addq %r10, %rax
orq %rcx, %rsi
salq $24, %rax
movq %rsi, (%rdx)
orq %r9, %rax
movq %rax, 8(%rdx)
addq $2096, %rsp
popq %rbx
popq %rbp
popq %r12
popq %r13
popq %r14
popq %r15
ret
.L3:
subq $32, %rbp
movabsq $-6148914691236517205, %rdx
movl $13, %esi
movq %rbp, %rax
movq 16(%rdi), %xmm0
mulq %rdx
leaq 200(%rsp), %r8
movq -32(%rsp), %r9
movq (%rdi), %xmm7
movabsq $17592186044415, %r13
movabsq $4398046511103, %r14
movdqa %xmm11, %xmm3
punpcklqdq %xmm0, %xmm7
shrq $9, %rdx
movq 24(%rdi), %xmm0
addq $1, %rdx
movdqa %xmm11, %xmm8
movq 8(%rdi), %xmm5
addq $32, %rdi
cmpq $13, %rdx
movdqa %xmm7, %xmm9
cmovbe %rdx, %rsi
addq %r9, %r9
leaq -1(%rsi), %rcx
punpcklqdq %xmm0, %xmm5
psrlq $26, %xmm9
pand %xmm7, %xmm3
psrlq $52, %xmm7
leaq (%rcx,%rcx,8), %rax
movq %rcx, 24(%rsp)
movq 120(%rsp), %rcx
movdqa %xmm5, %xmm0
psrlq $40, %xmm5
salq $4, %rax
movdqa poly1305_x64_sse2_5(%rip), %xmm6
addq %rax, %r8
movq 136(%rsp), %rax
psllq $12, %xmm0
movq %r8, 48(%rsp)
movq 40(%rsp), %r8
por %xmm0, %xmm7
mulq %r9
por poly1305_x64_sse2_1shl128(%rip), %xmm5
pand %xmm7, %xmm8
psrlq $26, %xmm7
pand %xmm11, %xmm9
movq %rax, %r9
movq 120(%rsp), %rax
movq %rdx, %r10
pand %xmm11, %xmm7
mulq %rax
addq %rax, %r9
movq 136(%rsp), %rax
adcq %rdx, %r10
addq %rcx, %rcx
movq %r9, %rbx
mulq 40(%rsp)
addq %r8, %r8
andq %r13, %rbx
movq %rax, %r11
movq -32(%rsp), %rax
movq %rdx, %r12
mulq %rcx
addq %rax, %r11
movq -32(%rsp), %rax
adcq %rdx, %r12
xorl %edx, %edx
shrdq $44, %r10, %r9
addq %r9, %r11
adcq %rdx, %r12
movq %r11, %rcx
mulq %rax
andq %r13, %rcx
movq %rax, %r9
movq 120(%rsp), %rax
movq %rdx, %r10
mulq %r8
addq %rax, %r9
adcq %rdx, %r10
xorl %edx, %edx
shrdq $44, %r12, %r11
addq %r11, %r9
adcq %rdx, %r10
movq %r9, %rax
movq %r9, %r8
shrdq $42, %r10, %rax
andq %r14, %r8
leaq (%rax,%rax,4), %rax
movq %r8, -24(%rsp)
shrq $16, %r8
movl %r8d, -56(%rsp)
addq %rbx, %rax
movq %rax, %r9
shrq $44, %rax
addq %rcx, %rax
andq %r13, %r9
movq 48(%rsp), %rcx
movq %rax, -88(%rsp)
movq %r9, -72(%rsp)
andl $67108863, %r9d
movl -88(%rsp), %eax
movq -72(%rsp), %rdx
movd %r9d, %xmm0
pshufd $68, %xmm0, %xmm0
shrq $26, %rdx
sall $18, %eax
orl %edx, %eax
movq -88(%rsp), %rdx
andl $67108863, %eax
movd %eax, %xmm4
movq -88(%rsp), %rax
shrq $34, %rdx
movdqa %xmm0, (%rcx)
shrq $8, %rax
movd %r8d, %xmm0
andl $67108863, %eax
pshufd $68, %xmm4, %xmm4
movd %eax, %xmm2
pshufd $68, %xmm0, %xmm0
movl -24(%rsp), %eax
pshufd $68, %xmm2, %xmm2
movdqa %xmm4, 16(%rcx)
pmuludq %xmm6, %xmm4
sall $10, %eax
orl %edx, %eax
andl $67108863, %eax
cmpq $1, %rsi
movd %eax, %xmm1
movdqa %xmm2, 32(%rcx)
pmuludq %xmm6, %xmm2
pshufd $68, %xmm1, %xmm1
movdqa %xmm0, 64(%rcx)
pmuludq %xmm6, %xmm0
movdqa %xmm1, 48(%rcx)
pmuludq %xmm6, %xmm1
movdqa %xmm6, 56(%rsp)
movdqa %xmm4, 80(%rcx)
movdqa %xmm2, 96(%rcx)
movdqa %xmm1, 112(%rcx)
movdqa %xmm0, 128(%rcx)
je .L5
movq -24(%rsp), %r8
movq -88(%rsp), %r11
movq -72(%rsp), %r9
leaq (%r8,%r8,4), %rax
addq %r11, %r11
movq %r8, %rcx
salq $2, %rax
movq %rax, -56(%rsp)
mulq %r11
movq %rax, %r11
movq -72(%rsp), %rax
movq %rdx, %r12
mulq %rax
addq %rax, %r11
movq -88(%rsp), %rax
adcq %rdx, %r12
addq %r9, %r9
movq %r11, %r8
addq %rcx, %rcx
andq %r13, %r8
mulq %r9
movq %rax, %r9
movq %rdx, %r10
movq -56(%rsp), %rax
mulq -24(%rsp)
addq %rax, %r9
movq -88(%rsp), %rax
adcq %rdx, %r10
xorl %edx, %edx
shrdq $44, %r12, %r11
addq %r11, %r9
adcq %rdx, %r10
movq %r9, %r15
mulq %rax
andq %r13, %r15
movq %rax, %r11
movq -72(%rsp), %rax
movq %rdx, %r12
mulq %rcx
movq 48(%rsp), %rcx
addq %rax, %r11
adcq %rdx, %r12
xorl %edx, %edx
shrdq $44, %r10, %r9
addq %r9, %r11
adcq %rdx, %r12
movq %r11, %rax
movq %r11, %rbx
shrdq $42, %r12, %rax
andq %r14, %rbx
leaq (%rax,%rax,4), %rax
addq %r8, %rax
movq %rax, %r8
shrq $44, %rax
andq %r13, %r8
leaq (%rax,%r15), %r9
movl %r8d, %edx
andl $67108863, %edx
movl %r9d, %eax
movd %edx, %xmm0
movq %r8, %rdx
sall $18, %eax
shrq $26, %rdx
orl %edx, %eax
movq %r9, %rdx
andl $67108863, %eax
shrq $34, %rdx
movd %eax, %xmm4
movq %r9, %rax
shrq $8, %rax
pshufd $68, %xmm0, %xmm0
andl $67108863, %eax
pshufd $68, %xmm4, %xmm4
movd %eax, %xmm2
movl %ebx, %eax
sall $10, %eax
orl %edx, %eax
pshufd $68, %xmm2, %xmm2
andl $67108863, %eax
movd %eax, %xmm1
movq %rbx, %rax
shrq $16, %rax
cmpq $2, %rsi
movdqa %xmm0, -144(%rcx)
movd %eax, %xmm0
pshufd $68, %xmm1, %xmm1
movdqa %xmm4, -128(%rcx)
pmuludq %xmm6, %xmm4
pshufd $68, %xmm0, %xmm0
movdqa %xmm2, -112(%rcx)
pmuludq %xmm6, %xmm2
movdqa %xmm1, -96(%rcx)
pmuludq %xmm6, %xmm1
movdqa %xmm0, -80(%rcx)
pmuludq %xmm6, %xmm0
movdqa %xmm4, -64(%rcx)
movdqa %xmm2, -48(%rcx)
movdqa %xmm1, -32(%rcx)
movdqa %xmm0, -16(%rcx)
movl %eax, -8(%rsp)
je .L5
movq -88(%rsp), %rdx
movq %rdi, 72(%rsp)
subq $288, %rcx
movq -72(%rsp), %rdi
movdqa %xmm6, %xmm0
movl $2, %r15d
movq %rsi, -8(%rsp)
movq %rbp, 88(%rsp)
leaq (%rdx,%rdx,4), %rax
salq $2, %rax
movq %rax, 8(%rsp)
.L6:
movq -56(%rsp), %rax
movabsq $17592186044415, %rbp
movq $0, -96(%rsp)
movabsq $17592186044415, %rsi
movq $0, -112(%rsp)
mulq %r9
movq %rax, %r13
movq 8(%rsp), %rax
movq %rdx, %r14
mulq %rbx
addq %rax, %r13
movq %r8, %rax
adcq %rdx, %r14
mulq %rdi
addq %rax, %r13
movq %r9, %rax
adcq %rdx, %r14
andq %r13, %rbp
mulq %rdi
movq %rax, %r11
movq -56(%rsp), %rax
movq %rdx, %r12
mulq %rbx
addq %rax, %r11
movq -88(%rsp), %rax
adcq %rdx, %r12
mulq %r8
addq %rax, %r11
movq %r13, %rax
adcq %rdx, %r12
shrdq $44, %r14, %rax
movq %rax, -104(%rsp)
movq -88(%rsp), %rax
addq -104(%rsp), %r11
adcq -96(%rsp), %r12
mulq %r9
andq %r11, %rsi
movq %rax, %r9
movq %rbx, %rax
movq %rdx, %r10
mulq %rdi
movabsq $4398046511103, %rbx
addq %rax, %r9
movq -24(%rsp), %rax
adcq %rdx, %r10
mulq %r8
movabsq $17592186044415, %r8
addq %rax, %r9
movq %r11, %rax
adcq %rdx, %r10
shrdq $44, %r12, %rax
movq %rax, -120(%rsp)
addq -120(%rsp), %r9
adcq -112(%rsp), %r10
addq $1, %r15
movq %r9, %rax
andq %r9, %rbx
shrdq $42, %r10, %rax
leaq (%rax,%rax,4), %r9
addq %rbp, %r9
andq %r9, %r8
shrq $44, %r9
movl %r8d, %edx
addq %rsi, %r9
movq %rbx, %rsi
andl $67108863, %edx
movl %r9d, %eax
shrq $16, %rsi
movd %edx, %xmm1
movq %r8, %rdx
sall $18, %eax
shrq $26, %rdx
movl %esi, -72(%rsp)
orl %edx, %eax
movq %r9, %rdx
andl $67108863, %eax
pshufd $68, %xmm1, %xmm1
movd %eax, %xmm6
movq %r9, %rax
shrq $34, %rdx
shrq $8, %rax
andl $67108863, %eax
pshufd $68, %xmm6, %xmm6
movd %eax, %xmm4
movl %ebx, %eax
sall $10, %eax
orl %edx, %eax
pshufd $68, %xmm4, %xmm4
andl $67108863, %eax
movdqa %xmm1, (%rcx)
movd %eax, %xmm2
movd %esi, %xmm1
movdqa %xmm6, 16(%rcx)
pmuludq %xmm0, %xmm6
pshufd $68, %xmm2, %xmm2
pshufd $68, %xmm1, %xmm1
movdqa %xmm4, 32(%rcx)
pmuludq %xmm0, %xmm4
movdqa %xmm2, 48(%rcx)
pmuludq %xmm0, %xmm2
movdqa %xmm1, 64(%rcx)
pmuludq %xmm0, %xmm1
movdqa %xmm6, 80(%rcx)
movdqa %xmm4, 96(%rcx)
movdqa %xmm2, 112(%rcx)
movdqa %xmm1, 128(%rcx)
subq $144, %rcx
cmpq -8(%rsp), %r15
jne .L6
movq -8(%rsp), %rsi
movq 72(%rsp), %rdi
movq 88(%rsp), %rbp
.L5:
cmpq $31, %rbp
leaq 200(%rsp), %r8
jbe .L7
movdqa 200(%rsp), %xmm0
movq %rsi, %r9
movdqa %xmm3, %xmm4
salq $5, %r9
movdqa 216(%rsp), %xmm1
movdqa 232(%rsp), %xmm6
movdqa 248(%rsp), %xmm13
movdqa %xmm0, -56(%rsp)
movdqa %xmm1, -72(%rsp)
movdqa %xmm6, -24(%rsp)
movdqa %xmm13, -8(%rsp)
movdqa 264(%rsp), %xmm14
movdqa 328(%rsp), %xmm0
movdqa 312(%rsp), %xmm1
movdqa 296(%rsp), %xmm6
movdqa 280(%rsp), %xmm13
movdqa %xmm14, 8(%rsp)
movdqa %xmm0, 24(%rsp)
movdqa %xmm1, 72(%rsp)
movdqa %xmm6, 88(%rsp)
movdqa %xmm13, 104(%rsp)
.L36:
movdqa -24(%rsp), %xmm14
cmpq $1, %rsi
movdqa %xmm4, %xmm1
movdqa -56(%rsp), %xmm10
movdqa %xmm14, %xmm2
movdqa %xmm4, %xmm6
movdqa 24(%rsp), %xmm3
movdqa %xmm9, %xmm13
pmuludq %xmm10, %xmm1
movdqa %xmm8, %xmm15
pmuludq %xmm4, %xmm2
movdqa %xmm14, -104(%rsp)
pmuludq %xmm10, %xmm13
movdqa %xmm9, %xmm14
pmuludq %xmm3, %xmm14
paddq %xmm14, %xmm1
movdqa %xmm8, %xmm14
movdqa -72(%rsp), %xmm12
pmuludq %xmm3, %xmm14
pmuludq %xmm12, %xmm6
paddq %xmm13, %xmm6
paddq %xmm14, %xmm6
movdqa 88(%rsp), %xmm14
movdqa 72(%rsp), %xmm13
movdqa %xmm14, -88(%rsp)
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm14, %xmm15
movdqa %xmm7, %xmm14
pmuludq %xmm7, %xmm15
paddq %xmm15, %xmm1
pmuludq %xmm13, %xmm14
movdqa 104(%rsp), %xmm15
paddq %xmm14, %xmm6
pmuludq %xmm5, %xmm13
movdqa -88(%rsp), %xmm14
pmuludq %xmm5, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm9, %xmm15
pmuludq %xmm5, %xmm14
movdqa -8(%rsp), %xmm0
paddq %xmm14, %xmm6
pmuludq %xmm12, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm8, %xmm15
movdqa -104(%rsp), %xmm14
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm7, %xmm15
pmuludq %xmm9, %xmm14
movdqa %xmm0, -120(%rsp)
pmuludq %xmm4, %xmm0
paddq %xmm14, %xmm0
movdqa %xmm8, %xmm14
pmuludq %xmm3, %xmm15
pmuludq 8(%rsp), %xmm4
pmuludq %xmm5, %xmm3
paddq %xmm15, %xmm2
pmuludq %xmm12, %xmm14
paddq %xmm14, %xmm0
movdqa %xmm7, %xmm14
pmuludq -120(%rsp), %xmm9
pmuludq -104(%rsp), %xmm8
paddq %xmm9, %xmm4
pmuludq %xmm10, %xmm14
paddq %xmm8, %xmm4
paddq %xmm14, %xmm0
pmuludq %xmm12, %xmm7
pmuludq %xmm10, %xmm5
paddq %xmm7, %xmm4
paddq %xmm13, %xmm2
paddq %xmm3, %xmm0
paddq %xmm5, %xmm4
je .L9
leaq 144(%r8), %rax
movq %rdi, %rdx
movl $1, %ecx
.L10:
movq 16(%rdx), %xmm3
addq $1, %rcx
movdqa %xmm11, %xmm10
movq (%rdx), %xmm7
movdqa %xmm11, %xmm8
punpcklqdq %xmm3, %xmm7
movq 8(%rdx), %xmm5
movq 24(%rdx), %xmm3
addq $32, %rdx
pand %xmm7, %xmm10
punpcklqdq %xmm3, %xmm5
movdqa %xmm7, %xmm9
psrlq $52, %xmm7
movdqa 16(%rax), %xmm12
psrlq $26, %xmm9
pand %xmm11, %xmm9
movdqa %xmm10, %xmm14
movdqa %xmm5, %xmm3
psrlq $40, %xmm5
movdqa %xmm10, %xmm13
por poly1305_x64_sse2_1shl128(%rip), %xmm5
psllq $12, %xmm3
movdqa %xmm9, %xmm15
por %xmm3, %xmm7
movdqa (%rax), %xmm3
pmuludq %xmm12, %xmm13
paddq %xmm13, %xmm6
pmuludq %xmm3, %xmm14
paddq %xmm14, %xmm1
movdqa %xmm9, %xmm14
pand %xmm7, %xmm8
movdqa 128(%rax), %xmm13
psrlq $26, %xmm7
pmuludq %xmm3, %xmm14
paddq %xmm14, %xmm6
pand %xmm11, %xmm7
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm1
movdqa 112(%rax), %xmm15
movdqa %xmm8, %xmm14
pmuludq %xmm8, %xmm15
paddq %xmm15, %xmm1
movdqa 96(%rax), %xmm15
pmuludq %xmm13, %xmm14
paddq %xmm14, %xmm6
movdqa 112(%rax), %xmm14
pmuludq %xmm7, %xmm15
paddq %xmm15, %xmm1
pmuludq %xmm7, %xmm14
paddq %xmm14, %xmm6
movdqa %xmm5, %xmm14
movdqa 96(%rax), %xmm15
pmuludq 80(%rax), %xmm14
paddq %xmm14, %xmm1
movdqa 48(%rax), %xmm14
pmuludq %xmm5, %xmm15
paddq %xmm15, %xmm6
pmuludq %xmm10, %xmm14
movdqa 32(%rax), %xmm15
paddq %xmm14, %xmm0
movdqa 32(%rax), %xmm14
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm9, %xmm15
pmuludq 64(%rax), %xmm10
paddq %xmm10, %xmm4
pmuludq %xmm9, %xmm14
paddq %xmm14, %xmm0
movdqa %xmm8, %xmm14
pmuludq %xmm12, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm8, %xmm15
pmuludq %xmm12, %xmm14
paddq %xmm14, %xmm0
movdqa %xmm7, %xmm14
pmuludq %xmm3, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm7, %xmm15
pmuludq %xmm3, %xmm14
paddq %xmm14, %xmm0
movdqa 112(%rax), %xmm14
pmuludq 48(%rax), %xmm9
pmuludq 32(%rax), %xmm8
addq $144, %rax
cmpq %rsi, %rcx
pmuludq %xmm13, %xmm15
pmuludq %xmm5, %xmm14
paddq %xmm15, %xmm2
pmuludq %xmm5, %xmm13
paddq %xmm9, %xmm4
pmuludq %xmm12, %xmm7
paddq %xmm8, %xmm4
pmuludq %xmm5, %xmm3
paddq %xmm7, %xmm4
paddq %xmm14, %xmm2
paddq %xmm13, %xmm0
paddq %xmm3, %xmm4
jne .L10
leaq -1(%rsi), %rax
salq $5, %rax
addq %rax, %rdi
.L9:
movdqa %xmm1, %xmm9
movq %rsi, %rax
movdqa %xmm0, %xmm5
salq $5, %rax
movdqa %xmm0, %xmm7
psrlq $26, %xmm9
paddq %xmm6, %xmm9
pand %xmm11, %xmm1
movdqa %xmm9, %xmm8
psrlq $26, %xmm5
paddq %xmm4, %xmm5
movdqa %xmm5, %xmm0
subq %rax, %rbp
pand %xmm11, %xmm7
psrlq $26, %xmm8
paddq %xmm2, %xmm8
pand %xmm11, %xmm9
movdqa %xmm8, %xmm2
psrlq $26, %xmm0
pmuludq 56(%rsp), %xmm0
paddq %xmm0, %xmm1
movdqa %xmm1, %xmm0
pand %xmm11, %xmm5
psrlq $26, %xmm2
paddq %xmm2, %xmm7
psrlq $26, %xmm0
paddq %xmm0, %xmm9
movdqa %xmm7, %xmm0
movdqa %xmm1, %xmm4
movq 16(%rdi), %xmm1
psrlq $26, %xmm0
paddq %xmm0, %xmm5
movdqa %xmm11, %xmm3
movq (%rdi), %xmm0
pslldq $8, %xmm1
pand %xmm11, %xmm8
pand %xmm11, %xmm4
por %xmm1, %xmm0
movq 8(%rdi), %xmm2
pand %xmm11, %xmm7
movq 24(%rdi), %xmm1
addq $32, %rdi
cmpq %rbp, %r9
pand %xmm0, %xmm3
pslldq $8, %xmm1
por %xmm1, %xmm2
movdqa %xmm0, %xmm1
psrlq $52, %xmm0
psrlq $26, %xmm1
pand %xmm11, %xmm1
paddq %xmm3, %xmm4
movdqa %xmm2, %xmm6
psrlq $40, %xmm2
por poly1305_x64_sse2_1shl128(%rip), %xmm2
psllq $12, %xmm6
por %xmm6, %xmm0
paddq %xmm1, %xmm9
movdqa %xmm11, %xmm6
pand %xmm0, %xmm6
psrlq $26, %xmm0
paddq %xmm2, %xmm5
pand %xmm11, %xmm0
paddq %xmm6, %xmm8
paddq %xmm0, %xmm7
jbe .L36
cmpq $31, %rbp
jbe .L40
movq %rbp, %rsi
movq 48(%rsp), %rcx
shrq $5, %rsi
movq %rsi, %rax
movq %rsi, %r9
negq %rax
salq $5, %r9
salq $3, %rax
subq %rsi, %rax
salq $4, %rax
leaq 144(%rcx,%rax), %r8
movdqa (%r8), %xmm0
movdqa 16(%r8), %xmm1
movdqa 32(%r8), %xmm6
movdqa 48(%r8), %xmm13
movdqa %xmm0, -56(%rsp)
movdqa %xmm1, -72(%rsp)
movdqa %xmm6, -24(%rsp)
movdqa %xmm13, -8(%rsp)
movdqa 64(%r8), %xmm14
movdqa 128(%r8), %xmm0
movdqa 112(%r8), %xmm1
movdqa 96(%r8), %xmm6
movdqa 80(%r8), %xmm13
movdqa %xmm14, 8(%rsp)
movdqa %xmm0, 24(%rsp)
movdqa %xmm1, 72(%rsp)
movdqa %xmm6, 88(%rsp)
movdqa %xmm13, 104(%rsp)
jmp .L36
.L40:
subq $1, %rsi
movdqa %xmm4, %xmm3
movq %rsi, 24(%rsp)
.L7:
movq 24(%rsp), %rcx
movl -32(%rsp), %esi
movq -32(%rsp), %rdx
movdqa %xmm3, %xmm4
movdqa %xmm9, %xmm13
leaq (%rcx,%rcx,8), %rax
sall $18, %esi
movl 40(%rsp), %ecx
shrq $34, %rdx
movdqa %xmm3, %xmm10
salq $4, %rax
movdqa %xmm9, %xmm14
addq %rax, %r8
movq 120(%rsp), %rax
sall $10, %ecx
orl %edx, %ecx
movq 40(%rsp), %rdx
andl $66076671, %ecx
andl $67108863, %eax
movq %rcx, 56(%r8)
movq %rax, 8(%r8)
movq 120(%rsp), %rax
shrq $16, %rdx
movdqa (%r8), %xmm12
movq %rdx, 72(%r8)
shrq $26, %rax
pmuludq %xmm12, %xmm13
pmuludq %xmm12, %xmm10
orl %eax, %esi
movq -32(%rsp), %rax
andl $67108611, %esi
movdqa 48(%r8), %xmm6
movq %rsi, 24(%r8)
leaq (%rsi,%rsi,4), %rsi
shrq $8, %rax
movdqa 16(%r8), %xmm0
andl $67092735, %eax
movq %rsi, 88(%r8)
movq %rax, 40(%r8)
leaq (%rax,%rax,4), %rax
pmuludq %xmm0, %xmm4
movdqa 32(%r8), %xmm1
paddq %xmm13, %xmm4
movq %rax, 104(%r8)
leaq (%rcx,%rcx,4), %rax
movdqa %xmm1, -104(%rsp)
movq %rax, 120(%r8)
leaq (%rdx,%rdx,4), %rax
movdqa %xmm1, %xmm2
movdqa %xmm6, -88(%rsp)
pmuludq %xmm3, %xmm6
movq %rax, 136(%r8)
pmuludq %xmm3, %xmm2
pmuludq 64(%r8), %xmm3
movdqa 112(%r8), %xmm13
movdqa 128(%r8), %xmm1
movdqa %xmm13, -120(%rsp)
pmuludq %xmm1, %xmm14
paddq %xmm14, %xmm10
movdqa %xmm13, %xmm14
movdqa %xmm8, %xmm13
pmuludq %xmm8, %xmm14
paddq %xmm14, %xmm10
movdqa %xmm7, %xmm14
pmuludq %xmm1, %xmm13
paddq %xmm13, %xmm4
movdqa -120(%rsp), %xmm13
movdqa 96(%r8), %xmm15
pmuludq %xmm7, %xmm13
paddq %xmm13, %xmm4
movdqa %xmm5, %xmm13
pmuludq %xmm15, %xmm14
paddq %xmm14, %xmm10
movdqa %xmm9, %xmm14
pmuludq 80(%r8), %xmm13
paddq %xmm13, %xmm10
movdqa -104(%rsp), %xmm13
pmuludq %xmm0, %xmm14
paddq %xmm14, %xmm2
movdqa %xmm8, %xmm14
pmuludq %xmm9, %xmm13
paddq %xmm13, %xmm6
movdqa %xmm8, %xmm13
pmuludq %xmm12, %xmm14
paddq %xmm14, %xmm2
movdqa %xmm7, %xmm14
pmuludq %xmm0, %xmm13
paddq %xmm13, %xmm6
movdqa %xmm7, %xmm13
pmuludq %xmm1, %xmm14
pmuludq %xmm0, %xmm7
pmuludq %xmm5, %xmm1
pmuludq %xmm12, %xmm13
paddq %xmm13, %xmm6
movdqa -120(%rsp), %xmm13
paddq %xmm1, %xmm6
movdqa %xmm10, %xmm1
movdqa %xmm6, %xmm0
pand %xmm11, %xmm10
pmuludq %xmm5, %xmm15
pmuludq %xmm5, %xmm13
pmuludq -88(%rsp), %xmm9
pmuludq -104(%rsp), %xmm8
psrlq $26, %xmm1
psrlq $26, %xmm0
paddq %xmm15, %xmm4
paddq %xmm9, %xmm3
paddq %xmm1, %xmm4
paddq %xmm8, %xmm3
movdqa %xmm4, %xmm1
paddq %xmm7, %xmm3
pmuludq %xmm12, %xmm5
paddq %xmm5, %xmm3
paddq %xmm0, %xmm3
movdqa %xmm3, %xmm0
psrlq $26, %xmm1
pand %xmm11, %xmm6
paddq %xmm14, %xmm2
paddq %xmm13, %xmm2
pand %xmm11, %xmm4
paddq %xmm1, %xmm2
psrlq $26, %xmm0
movdqa %xmm2, %xmm1
pmuludq 56(%rsp), %xmm0
paddq %xmm0, %xmm10
movdqa %xmm10, %xmm0
pand %xmm11, %xmm3
pand %xmm11, %xmm10
psrlq $26, %xmm1
paddq %xmm1, %xmm6
psrlq $26, %xmm0
paddq %xmm0, %xmm4
movdqa %xmm6, %xmm0
pand %xmm11, %xmm2
psrlq $26, %xmm0
paddq %xmm0, %xmm3
movdqa %xmm10, %xmm0
pand %xmm11, %xmm6
psrldq $8, %xmm0
paddq %xmm0, %xmm10
movdqa %xmm4, %xmm0
movd %xmm10, -104(%rsp)
movslq -104(%rsp), %rcx
psrldq $8, %xmm0
paddq %xmm0, %xmm4
movd %xmm4, -104(%rsp)
movslq -104(%rsp), %rax
movdqa %xmm2, %xmm0
movdqa %xmm6, %xmm11
movq %rcx, %r9
shrq $26, %rcx
psrldq $8, %xmm0
paddq %xmm0, %xmm2
movd %xmm2, -104(%rsp)
psrldq $8, %xmm11
addq %rax, %rcx
movslq -104(%rsp), %rax
paddq %xmm11, %xmm6
movq %rcx, %r10
shrq $26, %rcx
movd %xmm6, -104(%rsp)
movdqa %xmm3, %xmm0
andl $67108863, %r9d
andl $67108863, %r10d
addq %rax, %rcx
movslq -104(%rsp), %rax
psrldq $8, %xmm0
movq %rcx, %rdx
paddq %xmm0, %xmm3
movd %xmm3, -104(%rsp)
shrq $26, %rdx
addq %rax, %rdx
movslq -104(%rsp), %rax
movq %rdx, %rsi
shrq $26, %rdx
andl $67108863, %esi
movq %rsi, %r13
addq %rax, %rdx
movq %rdx, %rax
shrq $26, %rax
leaq (%rax,%rax,4), %r8
addq %r9, %r8
movq %r8, %r9
andl $67108863, %r8d
shrq $26, %r9
addq %r10, %r9
movq %r9, %rax
salq $26, %rax
orq %r8, %rax
movabsq $17592186044415, %r8
andq %r8, %rax
salq $34, %r13
andl $67108863, %ecx
salq $8, %rcx
shrq $18, %r9
andl $67108863, %edx
orq %rcx, %r13
salq $16, %rdx
shrq $10, %rsi
orq %r9, %r13
orq %rsi, %rdx
andq %r8, %r13
cmpq $15, %rbp
jbe .L2
jmp .L4

.section .rodata
.align 16
poly1305_x64_sse2_message_mask:
.long 67108863
.long 0
.long 67108863
.long 0
.align 16
poly1305_x64_sse2_5:
.long 5
.long 0
.long 5
.long 0
.align 16
poly1305_x64_sse2_1shl128:
.long 16777216
.long 0
.long 16777216
.long 0
