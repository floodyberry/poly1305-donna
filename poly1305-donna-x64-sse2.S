.text
.globl _poly1305_auth
.globl poly1305_auth

#if defined(_WIN64)
.p2align 4,,15
_poly1305_auth:
poly1305_auth:
subq $56, %rsp
movdqa %xmm6, 0(%rsp)
movdqa %xmm7, 16(%rsp)
movq %rdi, 32(%rsp)
movq %rsi, 40(%rsp)
movq %rcx, %rdi
movq %rdx, %rsi
movq %r8, %rdx
movq %r9, %rcx
call poly1305_auth_thunk
movdqa 0(%rsp), %xmm6
movdqa 16(%rsp), %xmm7
movq 32(%rsp), %rdi
movq 40(%rsp), %rsi
addq $56, %rsp
ret
#endif

.p2align 4,,15
#if !defined(_WIN64)
_poly1305_auth:
poly1305_auth:
#else
poly1305_auth_thunk:
#endif
pushq %rbp
movq %rsi, %r8
movq %rsp, %rbp
pushq %r15
movq %rdx, %r15
pushq %r14
pushq %r13
pushq %r12
pushq %rbx
andq $-64, %rsp
subq $840, %rsp
movq (%rcx), %rdx
movq 8(%rcx), %rax
movq %rcx, -32(%rsp)
movabsq $17575274610687, %rcx
movq %rdi, -48(%rsp)
movdqa poly1305_x64_sse2_message_mask(%rip), %xmm11
andq %rdx, %rcx
shrq $44, %rdx
movq $0, 776(%rsp)
movq %rcx, 40(%rsp)
movq %rax, %rcx
shrq $24, %rax
movq %rax, 48(%rsp)
movabsq $68719475727, %rax
andq %rax, 48(%rsp)
movq 48(%rsp), %rsi
salq $20, %rcx
movq $0, 784(%rsp)
orq %rdx, %rcx
movabsq $17592181915647, %rdx
andq %rdx, %rcx
leaq (%rsi,%rsi,4), %rax
movq %rcx, 104(%rsp)
salq $2, %rax
cmpq $15, %r15
movq %rax, -40(%rsp)
jbe poly1305_auth_x64_sse2_18
cmpq $31, %r15
ja poly1305_auth_x64_sse2_3
xorl %ecx, %ecx
xorl %edi, %edi
xorl %eax, %eax
poly1305_auth_x64_sse2_4:
movq (%r8), %r9
movq 8(%r8), %rbx
movabsq $17592186044415, %rsi
addq $16, %r8
subq $16, %r15
movq %r9, %rdx
andq %rsi, %rdx
leaq (%rdx,%rax), %r13
movq %r9, %rax
shrdq $44, %rbx, %rax
shrq $24, %rbx
andq %rsi, %rax
leaq (%rax,%rdi), %rsi
movabsq $1099511627776, %rax
orq %rax, %rbx
addq %rcx, %rbx
poly1305_auth_x64_sse2_12:
movq -40(%rsp), %rax
movq 104(%rsp), %r9
movabsq $17592186044415, %rdi
movq $0, -64(%rsp)
movq $0, -80(%rsp)
mulq %rsi
leaq (%r9,%r9,4), %rcx
salq $2, %rcx
movq %rax, %r9
movq 40(%rsp), %rax
movq %rdx, %r10
mulq %r13
addq %rax, %r9
movq %rbx, %rax
adcq %rdx, %r10
mulq %rcx
movabsq $4398046511103, %rcx
addq %rax, %r9
movq 40(%rsp), %rax
adcq %rdx, %r10
movq %r9, %r14
andq %rdi, %r14
mulq %rsi
movq %rax, %r11
movq 104(%rsp), %rax
movq %rdx, %r12
mulq %r13
addq %rax, %r11
movq -40(%rsp), %rax
adcq %rdx, %r12
mulq %rbx
addq %rax, %r11
movq %r9, %rax
adcq %rdx, %r12
shrdq $44, %r10, %rax
movq %rax, -72(%rsp)
movq 104(%rsp), %rax
addq -72(%rsp), %r11
adcq -64(%rsp), %r12
mulq %rsi
andq %r11, %rdi
movq %rax, %r9
movq 48(%rsp), %rax
movq %rdx, %r10
mulq %r13
addq %rax, %r9
movq 40(%rsp), %rax
adcq %rdx, %r10
mulq %rbx
addq %rax, %r9
movq %r11, %rax
adcq %rdx, %r10
shrdq $44, %r12, %rax
movq %rax, -88(%rsp)
addq -88(%rsp), %r9
adcq -80(%rsp), %r10
movq %r9, %rax
andq %r9, %rcx
shrdq $42, %r10, %rax
leaq (%rax,%rax,4), %rax
addq %r14, %rax
testq %r15, %r15
je poly1305_auth_x64_sse2_13
poly1305_auth_x64_sse2_27:
xorl %edx, %edx
testb $8, %r15b
movl $4, %esi
je poly1305_auth_x64_sse2_14
movq (%r8), %rdx
movb $12, %sil
movq %rdx, 776(%rsp)
movl $8, %edx
poly1305_auth_x64_sse2_14:
testb $4, %r15b
je poly1305_auth_x64_sse2_15
movl (%r8,%rdx), %r9d
movl %r9d, 776(%rsp,%rdx)
movq %rsi, %rdx
poly1305_auth_x64_sse2_15:
testb $2, %r15b
je poly1305_auth_x64_sse2_16
movzwl (%r8,%rdx), %esi
movw %si, 776(%rsp,%rdx)
addq $2, %rdx
poly1305_auth_x64_sse2_16:
andl $1, %r15d
je poly1305_auth_x64_sse2_17
movzbl (%r8,%rdx), %esi
movb %sil, 776(%rsp,%rdx)
addq $1, %rdx
poly1305_auth_x64_sse2_17:
movb $1, 776(%rsp,%rdx)
movq 776(%rsp), %rdx
movabsq $17592186044415, %rsi
movq 784(%rsp), %rbx
xorl %r15d, %r15d
movq %rdx, %r9
movq %rdx, -104(%rsp)
andq %rsi, %r9
movq %rbx, -96(%rsp)
movq -96(%rsp), %rdx
leaq (%rax,%r9), %r13
movq -104(%rsp), %rax
shrq $24, %rbx
addq %rcx, %rbx
shrdq $44, %rdx, %rax
andq %rsi, %rax
leaq (%rdi,%rax), %rsi
jmp poly1305_auth_x64_sse2_12
poly1305_auth_x64_sse2_18:
xorl %ecx, %ecx
xorl %edi, %edi
xorl %eax, %eax
poly1305_auth_x64_sse2_2:
testq %r15, %r15
jne poly1305_auth_x64_sse2_27
poly1305_auth_x64_sse2_13:
movq %rax, %r8
shrq $44, %rax
movabsq $17592186044415, %rdx
addq %rax, %rdi
movabsq $4398046511103, %r10
andq %rdx, %r8
movq %rdi, %rsi
shrq $44, %rdi
addq %rdi, %rcx
andq %rdx, %rsi
andq %rcx, %r10
shrq $42, %rcx
leaq (%r8,%rcx,4), %rax
movabsq $-4398046511104, %r8
addq %r10, %r8
leaq (%rax,%rcx), %rdi
leaq 5(%rdi), %r9
movq %r9, %r11
andq %rdx, %r9
shrq $44, %r11
addq %rsi, %r11
movq %r11, %rax
andq %rdx, %r11
shrq $44, %rax
addq %rax, %r8
movq %r8, %rax
shrq $63, %rax
subq $1, %rax
movq %rax, %rcx
andq %rax, %r9
andq %rax, %r11
notq %rcx
andq %r8, %rax
andq %rcx, %rdi
andq %rcx, %rsi
andq %r10, %rcx
orq %r9, %rdi
movq -32(%rsp), %r9
orq %r11, %rsi
orq %rax, %rcx
movq 16(%r9), %r13
movq 24(%r9), %rbx
movq %r13, %r9
andq %rdx, %r9
addq %r9, %rdi
movq %r13, %r9
shrdq $44, %rbx, %r9
andq %rdx, %r9
addq %r9, %rsi
movq %rdi, %r9
shrq $44, %r9
leaq (%rsi,%r9), %r10
movq %r10, %r9
andq %rdx, %r9
shrq $24, %rbx
shrq $44, %r10
leaq (%rcx,%rbx), %rax
movq %r9, %rsi
andq %rdi, %rdx
movq -48(%rsp), %rdi
salq $44, %rsi
shrq $20, %r9
addq %r10, %rax
orq %rdx, %rsi
salq $24, %rax
orq %r9, %rax
movq %rsi, (%rdi)
movq %rax, 8(%rdi)
leaq -40(%rbp), %rsp
popq %rbx
popq %r12
popq %r13
popq %r14
popq %r15
popq %rbp
ret
poly1305_auth_x64_sse2_3:
subq $32, %r15
movabsq $-6148914691236517205, %rdx
movl $4, %esi
movq %r15, %rax
movq 16(%r8), %xmm0
mulq %rdx
leaq 200(%rsp), %rcx
movq 104(%rsp), %r9
movq (%r8), %xmm7
movabsq $17592186044415, %r13
movq 40(%rsp), %r11
movdqa %xmm11, %xmm3
punpcklqdq %xmm0, %xmm7
shrq $9, %rdx
movq 24(%r8), %xmm0
addq $1, %rdx
movdqa %xmm11, %xmm8
movq 8(%r8), %xmm6
addq $32, %r8
cmpq $4, %rdx
movdqa %xmm7, %xmm9
cmovbe %rdx, %rsi
addq %r9, %r9
leaq -9(%rsi,%rsi,8), %rax
punpcklqdq %xmm0, %xmm6
psrlq $26, %xmm9
pand %xmm7, %xmm3
psrlq $52, %xmm7
salq $4, %rax
movdqa poly1305_x64_sse2_5(%rip), %xmm15
addq %rax, %rcx
movq -40(%rsp), %rax
movq %rcx, 112(%rsp)
movq 48(%rsp), %rcx
movdqa %xmm6, %xmm0
pand %xmm11, %xmm9
psrlq $40, %xmm6
mulq %r9
por poly1305_x64_sse2_1shl128(%rip), %xmm6
psllq $12, %xmm0
movdqa %xmm15, -8(%rsp)
por %xmm0, %xmm7
movq %rax, %r9
movq %rdx, %r10
movq 40(%rsp), %rax
pand %xmm7, %xmm8
psrlq $26, %xmm7
pand %xmm11, %xmm7
mulq %rax
addq %rax, %r9
movq 104(%rsp), %rax
adcq %rdx, %r10
addq %r11, %r11
movq %r9, %rdi
addq %rcx, %rcx
andq %r13, %rdi
mulq %r11
movq %rax, %r11
movq %rdx, %r12
movq -40(%rsp), %rax
mulq 48(%rsp)
addq %rax, %r11
movq 40(%rsp), %rax
adcq %rdx, %r12
xorl %edx, %edx
shrdq $44, %r10, %r9
addq %r9, %r11
adcq %rdx, %r12
movq %r11, %rbx
mulq %rcx
andq %r13, %rbx
movq %rax, %r9
movq 104(%rsp), %rax
movq %rdx, %r10
mulq %rax
addq %rax, %r9
adcq %rdx, %r10
xorl %edx, %edx
shrdq $44, %r12, %r11
addq %r11, %r9
movabsq $4398046511103, %r11
adcq %rdx, %r10
movq %r9, %rax
movq %r9, %rcx
shrdq $42, %r10, %rax
andq %r11, %rcx
movq 112(%rsp), %r9
leaq (%rax,%rax,4), %rax
movq %rcx, 88(%rsp)
shrq $16, %rcx
movl %ecx, 136(%rsp)
addq %rdi, %rax
movq %rax, %r10
shrq $44, %rax
addq %rbx, %rax
andq %r13, %r10
movq %rax, 120(%rsp)
movl 120(%rsp), %eax
movq %r10, %rdx
shrq $26, %rdx
movl %r10d, %edi
andl $67108863, %edi
sall $18, %eax
movd %edi, %xmm0
orl %edx, %eax
movq 120(%rsp), %rdx
andl $67108863, %eax
pshufd $68, %xmm0, %xmm0
movd %eax, %xmm4
movq 120(%rsp), %rax
shrq $34, %rdx
movdqa %xmm0, (%r9)
shrq $8, %rax
movd %ecx, %xmm0
andl $67108863, %eax
pshufd $68, %xmm4, %xmm4
movd %eax, %xmm2
pshufd $68, %xmm0, %xmm0
movl 88(%rsp), %eax
pshufd $68, %xmm2, %xmm2
movdqa %xmm4, 16(%r9)
pmuludq %xmm15, %xmm4
sall $10, %eax
orl %edx, %eax
andl $67108863, %eax
cmpq $1, %rsi
movd %eax, %xmm1
movdqa %xmm2, 32(%r9)
pmuludq %xmm15, %xmm2
pshufd $68, %xmm1, %xmm1
movdqa %xmm0, 64(%r9)
pmuludq %xmm15, %xmm0
movdqa %xmm1, 48(%r9)
pmuludq %xmm15, %xmm1
movdqa %xmm4, 80(%r9)
movdqa %xmm2, 96(%r9)
movdqa %xmm1, 112(%r9)
movdqa %xmm0, 128(%r9)
je poly1305_auth_x64_sse2_5
movq 88(%rsp), %rdi
movq %r9, %rcx
movq 120(%rsp), %r9
movdqa %xmm15, %xmm0
movq %r8, 24(%rsp)
movq %r15, 8(%rsp)
subq $144, %rcx
movq %rsi, 72(%rsp)
leaq (%rdi,%rdi,4), %rax
movq %rdi, %rbx
movq %r10, %r15
movq %r10, %rdi
salq $2, %rax
movq %rax, 136(%rsp)
leaq (%r9,%r9,4), %rax
salq $2, %rax
movq %rax, 56(%rsp)
movl $1, %eax
movq %rax, %r8
poly1305_auth_x64_sse2_6:
movq 136(%rsp), %rax
movabsq $17592186044415, %rsi
movq $0, 192(%rsp)
movq $0, 176(%rsp)
mulq %r9
movq %rax, %r13
movq %rdi, %rax
movq %rdx, %r14
mulq %r15
addq %rax, %r13
movq 56(%rsp), %rax
adcq %rdx, %r14
mulq %rbx
addq %rax, %r13
movq %r9, %rax
adcq %rdx, %r14
andq %r13, %rsi
mulq %r15
movq %rsi, 152(%rsp)
movabsq $17592186044415, %rsi
movq %rax, %r11
movq 120(%rsp), %rax
movq %rdx, %r12
mulq %rdi
addq %rax, %r11
movq 136(%rsp), %rax
adcq %rdx, %r12
mulq %rbx
addq %rax, %r11
movq %r13, %rax
adcq %rdx, %r12
shrdq $44, %r14, %rax
movq %rax, 184(%rsp)
movq 120(%rsp), %rax
addq 184(%rsp), %r11
adcq 192(%rsp), %r12
mulq %r9
andq %r11, %rsi
movq %rax, %r9
movq 88(%rsp), %rax
movq %rdx, %r10
mulq %rdi
movabsq $17592186044415, %rdi
addq %rax, %r9
movq %rbx, %rax
movabsq $4398046511103, %rbx
adcq %rdx, %r10
mulq %r15
addq %rax, %r9
movq %r11, %rax
adcq %rdx, %r10
shrdq $44, %r12, %rax
movq %rax, 168(%rsp)
addq 168(%rsp), %r9
adcq 176(%rsp), %r10
addq $1, %r8
movq %r9, %rax
andq %r9, %rbx
shrdq $42, %r10, %rax
leaq (%rax,%rax,4), %r9
addq 152(%rsp), %r9
andq %r9, %rdi
shrq $44, %r9
movl %edi, %edx
addq %rsi, %r9
movq %rbx, %rsi
andl $67108863, %edx
movl %r9d, %eax
shrq $16, %rsi
movd %edx, %xmm1
movq %rdi, %rdx
sall $18, %eax
shrq $26, %rdx
movl %esi, 152(%rsp)
orl %edx, %eax
movq %r9, %rdx
andl $67108863, %eax
pshufd $68, %xmm1, %xmm1
movd %eax, %xmm5
movq %r9, %rax
shrq $34, %rdx
shrq $8, %rax
andl $67108863, %eax
pshufd $68, %xmm5, %xmm5
movd %eax, %xmm4
movl %ebx, %eax
sall $10, %eax
orl %edx, %eax
pshufd $68, %xmm4, %xmm4
andl $67108863, %eax
movdqa %xmm1, (%rcx)
movd %eax, %xmm2
movd %esi, %xmm1
movdqa %xmm5, 16(%rcx)
pmuludq %xmm0, %xmm5
pshufd $68, %xmm2, %xmm2
pshufd $68, %xmm1, %xmm1
movdqa %xmm4, 32(%rcx)
pmuludq %xmm0, %xmm4
movdqa %xmm2, 48(%rcx)
pmuludq %xmm0, %xmm2
movdqa %xmm1, 64(%rcx)
pmuludq %xmm0, %xmm1
movdqa %xmm5, 80(%rcx)
movdqa %xmm4, 96(%rcx)
movdqa %xmm2, 112(%rcx)
movdqa %xmm1, 128(%rcx)
subq $144, %rcx
cmpq 72(%rsp), %r8
jne poly1305_auth_x64_sse2_6
movq 72(%rsp), %rsi
movq 24(%rsp), %r8
movq 8(%rsp), %r15
poly1305_auth_x64_sse2_5:
cmpq $31, %r15
jbe poly1305_auth_x64_sse2_7
movdqa 200(%rsp), %xmm0
movq %rsi, %r9
leaq 200(%rsp), %rdi
movdqa %xmm3, %xmm4
movdqa 216(%rsp), %xmm5
salq $5, %r9
movdqa 328(%rsp), %xmm15
movdqa %xmm0, 120(%rsp)
movdqa %xmm5, 136(%rsp)
movdqa %xmm15, 152(%rsp)
movdqa 312(%rsp), %xmm0
movdqa 296(%rsp), %xmm5
movdqa 280(%rsp), %xmm15
movdqa %xmm0, 88(%rsp)
movdqa %xmm5, 72(%rsp)
movdqa %xmm15, 56(%rsp)
movdqa 232(%rsp), %xmm0
movdqa 248(%rsp), %xmm5
movdqa 264(%rsp), %xmm15
movdqa %xmm0, 24(%rsp)
movdqa %xmm5, 8(%rsp)
movdqa %xmm15, -24(%rsp)
.p2align 4,,10
.p2align 3
poly1305_auth_x64_sse2_24:
movdqa 120(%rsp), %xmm10
cmpq $1, %rsi
movdqa %xmm4, %xmm1
movdqa 152(%rsp), %xmm12
movdqa %xmm9, %xmm0
pmuludq %xmm10, %xmm1
movdqa %xmm4, %xmm5
movdqa 136(%rsp), %xmm3
pmuludq %xmm12, %xmm0
paddq %xmm0, %xmm1
movdqa %xmm9, %xmm0
movdqa %xmm9, %xmm15
movdqa 88(%rsp), %xmm14
pmuludq %xmm3, %xmm5
pmuludq %xmm10, %xmm0
paddq %xmm0, %xmm5
movdqa %xmm8, %xmm0
movdqa 72(%rsp), %xmm2
pmuludq %xmm3, %xmm15
pmuludq %xmm14, %xmm0
paddq %xmm0, %xmm1
movdqa %xmm8, %xmm0
movdqa 24(%rsp), %xmm13
pmuludq %xmm12, %xmm0
paddq %xmm0, %xmm5
movdqa %xmm7, %xmm0
pmuludq %xmm2, %xmm0
paddq %xmm0, %xmm1
movdqa %xmm7, %xmm0
pmuludq %xmm6, %xmm2
pmuludq %xmm14, %xmm0
paddq %xmm0, %xmm5
movdqa 56(%rsp), %xmm0
paddq %xmm2, %xmm5
movdqa %xmm4, %xmm2
pmuludq %xmm6, %xmm14
pmuludq %xmm6, %xmm0
paddq %xmm0, %xmm1
movdqa 8(%rsp), %xmm0
pmuludq %xmm13, %xmm2
paddq %xmm15, %xmm2
movdqa %xmm9, %xmm15
movdqa %xmm0, 184(%rsp)
pmuludq %xmm4, %xmm0
pmuludq -24(%rsp), %xmm4
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm8, %xmm15
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm8, %xmm15
pmuludq 184(%rsp), %xmm9
pmuludq %xmm13, %xmm8
paddq %xmm9, %xmm4
pmuludq %xmm3, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm7, %xmm15
paddq %xmm8, %xmm4
pmuludq %xmm12, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm7, %xmm15
pmuludq %xmm6, %xmm12
pmuludq %xmm3, %xmm7
paddq %xmm14, %xmm2
pmuludq %xmm10, %xmm15
paddq %xmm7, %xmm4
paddq %xmm15, %xmm0
pmuludq %xmm6, %xmm10
paddq %xmm12, %xmm0
paddq %xmm10, %xmm4
je poly1305_auth_x64_sse2_9
leaq 144(%rdi), %rax
movq %r8, %rdx
movl $1, %ecx
jmp poly1305_auth_x64_sse2_10
.p2align 6,,63
poly1305_auth_x64_sse2_10:
movq 16(%rdx), %xmm3
addq $1, %rcx
movdqa %xmm11, %xmm10
movq (%rdx), %xmm7
movdqa %xmm11, %xmm8
punpcklqdq %xmm3, %xmm7
movq 8(%rdx), %xmm6
movq 24(%rdx), %xmm3
addq $32, %rdx
pand %xmm7, %xmm10
punpcklqdq %xmm3, %xmm6
movdqa %xmm7, %xmm9
psrlq $52, %xmm7
movdqa %xmm10, %xmm12
psrlq $26, %xmm9
movdqa %xmm6, %xmm3
pand %xmm11, %xmm9
psrlq $40, %xmm6
movdqa %xmm10, %xmm13
psllq $12, %xmm3
por %xmm3, %xmm7
movdqa (%rax), %xmm3
movdqa %xmm9, %xmm14
pmuludq %xmm3, %xmm12
paddq %xmm12, %xmm1
movdqa 16(%rax), %xmm12
pand %xmm7, %xmm8
psrlq $26, %xmm7
pmuludq %xmm12, %xmm13
paddq %xmm13, %xmm5
movdqa 128(%rax), %xmm13
pand %xmm11, %xmm7
pmuludq %xmm13, %xmm14
paddq %xmm14, %xmm1
movdqa %xmm9, %xmm14
movdqa %xmm8, %xmm15
por poly1305_x64_sse2_1shl128(%rip), %xmm6
pmuludq %xmm3, %xmm14
paddq %xmm14, %xmm5
movdqa 112(%rax), %xmm14
pmuludq %xmm14, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm8, %xmm15
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm5
movdqa 96(%rax), %xmm15
pmuludq %xmm7, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm7, %xmm15
pmuludq %xmm14, %xmm15
paddq %xmm15, %xmm5
movdqa %xmm6, %xmm15
pmuludq %xmm6, %xmm14
pmuludq 80(%rax), %xmm15
paddq %xmm15, %xmm1
movdqa 96(%rax), %xmm15
pmuludq %xmm6, %xmm15
paddq %xmm15, %xmm5
movdqa 32(%rax), %xmm15
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm2
movdqa 48(%rax), %xmm15
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm9, %xmm15
pmuludq 64(%rax), %xmm10
paddq %xmm10, %xmm4
pmuludq %xmm12, %xmm15
paddq %xmm15, %xmm2
movdqa 32(%rax), %xmm15
pmuludq %xmm9, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm8, %xmm15
pmuludq 48(%rax), %xmm9
paddq %xmm9, %xmm4
pmuludq %xmm3, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm8, %xmm15
pmuludq 32(%rax), %xmm8
addq $144, %rax
cmpq %rsi, %rcx
pmuludq %xmm12, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm7, %xmm15
paddq %xmm8, %xmm4
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm2
movdqa %xmm7, %xmm15
pmuludq %xmm6, %xmm13
pmuludq %xmm12, %xmm7
paddq %xmm14, %xmm2
pmuludq %xmm3, %xmm15
paddq %xmm7, %xmm4
paddq %xmm15, %xmm0
pmuludq %xmm6, %xmm3
paddq %xmm13, %xmm0
paddq %xmm3, %xmm4
jne poly1305_auth_x64_sse2_10
leaq -1(%rsi), %rax
salq $5, %rax
addq %rax, %r8
poly1305_auth_x64_sse2_9:
movdqa %xmm1, %xmm9
movq %rsi, %rax
movdqa %xmm0, %xmm6
salq $5, %rax
movdqa %xmm0, %xmm7
psrlq $26, %xmm9
paddq %xmm5, %xmm9
pand %xmm11, %xmm1
movdqa %xmm9, %xmm8
psrlq $26, %xmm6
paddq %xmm4, %xmm6
movdqa %xmm6, %xmm0
subq %rax, %r15
pand %xmm11, %xmm7
psrlq $26, %xmm8
paddq %xmm2, %xmm8
pand %xmm11, %xmm9
movdqa %xmm8, %xmm2
psrlq $26, %xmm0
pmuludq -8(%rsp), %xmm0
paddq %xmm0, %xmm1
movdqa %xmm1, %xmm0
pand %xmm11, %xmm6
psrlq $26, %xmm2
paddq %xmm2, %xmm7
psrlq $26, %xmm0
paddq %xmm0, %xmm9
movdqa %xmm7, %xmm0
movdqa %xmm1, %xmm4
movq 16(%r8), %xmm1
psrlq $26, %xmm0
paddq %xmm0, %xmm6
movdqa %xmm11, %xmm3
movq (%r8), %xmm0
pslldq $8, %xmm1
pand %xmm11, %xmm8
pand %xmm11, %xmm4
por %xmm1, %xmm0
movq 8(%r8), %xmm2
pand %xmm11, %xmm7
movq 24(%r8), %xmm1
addq $32, %r8
cmpq %r15, %r9
pand %xmm0, %xmm3
pslldq $8, %xmm1
por %xmm1, %xmm2
movdqa %xmm0, %xmm1
psrlq $52, %xmm0
psrlq $26, %xmm1
pand %xmm11, %xmm1
paddq %xmm3, %xmm4
movdqa %xmm2, %xmm5
psrlq $40, %xmm2
por poly1305_x64_sse2_1shl128(%rip), %xmm2
psllq $12, %xmm5
por %xmm5, %xmm0
paddq %xmm1, %xmm9
movdqa %xmm11, %xmm5
pand %xmm0, %xmm5
psrlq $26, %xmm0
paddq %xmm2, %xmm6
pand %xmm11, %xmm0
paddq %xmm5, %xmm8
paddq %xmm0, %xmm7
jbe poly1305_auth_x64_sse2_24
cmpq $31, %r15
jbe poly1305_auth_x64_sse2_25
movq %r15, %rsi
movq 112(%rsp), %rcx
shrq $5, %rsi
movq %rsi, %rax
movq %rsi, %r9
negq %rax
salq $5, %r9
salq $3, %rax
subq %rsi, %rax
salq $4, %rax
leaq 144(%rcx,%rax), %rdi
movdqa (%rdi), %xmm0
movdqa 16(%rdi), %xmm5
movdqa 128(%rdi), %xmm15
movdqa %xmm0, 120(%rsp)
movdqa %xmm5, 136(%rsp)
movdqa %xmm15, 152(%rsp)
movdqa 112(%rdi), %xmm0
movdqa 96(%rdi), %xmm5
movdqa 80(%rdi), %xmm15
movdqa %xmm0, 88(%rsp)
movdqa %xmm5, 72(%rsp)
movdqa %xmm15, 56(%rsp)
movdqa 32(%rdi), %xmm0
movdqa 48(%rdi), %xmm5
movdqa 64(%rdi), %xmm15
movdqa %xmm0, 24(%rsp)
movdqa %xmm5, 8(%rsp)
movdqa %xmm15, -24(%rsp)
jmp poly1305_auth_x64_sse2_24
poly1305_auth_x64_sse2_25:
movdqa %xmm4, %xmm3
poly1305_auth_x64_sse2_7:
movq 40(%rsp), %rax
movq 112(%rsp), %rcx
movl 104(%rsp), %esi
movq 112(%rsp), %rdi
movq 104(%rsp), %rdx
movdqa %xmm3, %xmm10
andl $67108863, %eax
movdqa %xmm6, %xmm1
movq %rax, 8(%rcx)
movq 40(%rsp), %rax
sall $18, %esi
movdqa (%rdi), %xmm0
shrq $34, %rdx
movdqa %xmm9, %xmm4
shrq $26, %rax
pmuludq %xmm0, %xmm10
movdqa %xmm3, %xmm2
orl %eax, %esi
movq 104(%rsp), %rax
pmuludq %xmm0, %xmm4
andl $67108611, %esi
movdqa %xmm7, %xmm5
movq %rsi, 24(%rcx)
leaq (%rsi,%rsi,4), %rsi
shrq $8, %rax
movdqa %xmm9, %xmm14
andl $67092735, %eax
movq %rsi, 88(%rdi)
movq %rax, 40(%rcx)
movl 48(%rsp), %ecx
leaq (%rax,%rax,4), %rax
pmuludq 80(%rdi), %xmm1
paddq %xmm1, %xmm10
movdqa 16(%rdi), %xmm1
movq %rax, 104(%rdi)
sall $10, %ecx
pmuludq %xmm1, %xmm2
paddq %xmm2, %xmm4
orl %edx, %ecx
movq 48(%rsp), %rdx
pmuludq %xmm1, %xmm14
andl $66076671, %ecx
movdqa 96(%rdi), %xmm2
leaq (%rcx,%rcx,4), %rax
movq %rcx, 56(%rdi)
shrq $16, %rdx
pmuludq %xmm2, %xmm5
pmuludq %xmm6, %xmm2
movq %rax, 120(%rdi)
paddq %xmm2, %xmm4
movdqa %xmm8, %xmm2
movdqa 112(%rdi), %xmm13
leaq (%rdx,%rdx,4), %rax
paddq %xmm5, %xmm10
movdqa %xmm7, %xmm5
movq %rdx, 72(%rdi)
pmuludq %xmm13, %xmm2
paddq %xmm2, %xmm10
movdqa %xmm7, %xmm2
movq %rax, 136(%rdi)
pmuludq %xmm0, %xmm5
movdqa 128(%rdi), %xmm12
pmuludq %xmm13, %xmm2
paddq %xmm2, %xmm4
movdqa %xmm9, %xmm2
pmuludq %xmm6, %xmm13
movdqa 32(%rdi), %xmm15
pmuludq %xmm12, %xmm2
paddq %xmm2, %xmm10
movdqa %xmm8, %xmm2
pmuludq %xmm12, %xmm2
paddq %xmm2, %xmm4
movdqa %xmm8, %xmm2
pmuludq %xmm0, %xmm2
paddq %xmm14, %xmm2
movdqa %xmm8, %xmm14
pmuludq %xmm15, %xmm8
pmuludq %xmm1, %xmm14
paddq %xmm14, %xmm5
movdqa %xmm3, %xmm14
pmuludq %xmm15, %xmm14
paddq %xmm14, %xmm2
movdqa %xmm9, %xmm14
paddq %xmm13, %xmm2
movdqa 48(%rdi), %xmm13
pmuludq %xmm15, %xmm14
paddq %xmm14, %xmm5
movdqa %xmm3, %xmm14
pmuludq %xmm13, %xmm9
pmuludq 64(%rdi), %xmm3
pmuludq %xmm13, %xmm14
paddq %xmm14, %xmm5
movdqa %xmm7, %xmm14
pmuludq %xmm1, %xmm7
movdqa %xmm10, %xmm1
pand %xmm11, %xmm10
pmuludq %xmm12, %xmm14
pmuludq %xmm6, %xmm12
pmuludq %xmm0, %xmm6
paddq %xmm12, %xmm5
movdqa %xmm5, %xmm0
psrlq $26, %xmm1
paddq %xmm7, %xmm6
paddq %xmm1, %xmm4
paddq %xmm8, %xmm6
psrlq $26, %xmm0
movdqa %xmm4, %xmm1
paddq %xmm3, %xmm6
paddq %xmm9, %xmm6
paddq %xmm0, %xmm6
movdqa %xmm6, %xmm0
pand %xmm11, %xmm5
psrlq $26, %xmm1
paddq %xmm14, %xmm2
pand %xmm11, %xmm4
paddq %xmm1, %xmm2
psrlq $26, %xmm0
movdqa %xmm2, %xmm1
pmuludq -8(%rsp), %xmm0
paddq %xmm0, %xmm10
movdqa %xmm10, %xmm0
pand %xmm11, %xmm6
pand %xmm11, %xmm10
psrlq $26, %xmm1
paddq %xmm1, %xmm5
psrlq $26, %xmm0
paddq %xmm0, %xmm4
movdqa %xmm5, %xmm0
pand %xmm11, %xmm2
psrlq $26, %xmm0
paddq %xmm0, %xmm6
movdqa %xmm10, %xmm0
pand %xmm11, %xmm5
psrldq $8, %xmm0
paddq %xmm0, %xmm10
movdqa %xmm4, %xmm0
movd %xmm10, 184(%rsp)
movslq 184(%rsp), %rdx
psrldq $8, %xmm0
paddq %xmm0, %xmm4
movd %xmm4, 184(%rsp)
movslq 184(%rsp), %rax
movdqa %xmm2, %xmm0
movdqa %xmm5, %xmm11
movq %rdx, %rdi
shrq $26, %rdx
psrldq $8, %xmm0
paddq %xmm0, %xmm2
movd %xmm2, 184(%rsp)
psrldq $8, %xmm11
addq %rax, %rdx
movslq 184(%rsp), %rax
paddq %xmm11, %xmm5
movq %rdx, %r11
shrq $26, %rdx
movd %xmm5, 184(%rsp)
movdqa %xmm6, %xmm0
andl $67108863, %edi
andl $67108863, %r11d
addq %rax, %rdx
movslq 184(%rsp), %rax
psrldq $8, %xmm0
movq %rdx, %rcx
paddq %xmm0, %xmm6
movd %xmm6, 184(%rsp)
shrq $26, %rcx
andl $67108863, %edx
addq %rax, %rcx
movslq 184(%rsp), %rax
movq %rcx, %r10
shrq $26, %rcx
andl $67108863, %r10d
addq %rax, %rcx
movq %rcx, %rax
shrq $26, %rax
leaq (%rax,%rax,4), %rsi
addq %rdi, %rsi
movq %r10, %rdi
movq %rsi, %r9
andl $67108863, %esi
salq $34, %rdi
shrq $26, %r9
addq %r11, %r9
movq %r9, %rax
salq $26, %rax
orq %rsi, %rax
movabsq $17592186044415, %rsi
andq %rsi, %rax
salq $8, %rdx
shrq $18, %r9
orq %rdx, %rdi
andl $67108863, %ecx
movq %r10, %rdx
orq %r9, %rdi
salq $16, %rcx
shrq $10, %rdx
andq %rsi, %rdi
orq %rdx, %rcx
cmpq $15, %r15
jbe poly1305_auth_x64_sse2_2
jmp poly1305_auth_x64_sse2_4

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
