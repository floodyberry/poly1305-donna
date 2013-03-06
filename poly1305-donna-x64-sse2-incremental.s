.text
.p2align 4,,15
poly1305_blocks:
subq $176, %rsp
cmpq $63, %rdx
movdqa poly1305_x64_sse2_message_mask(%rip), %xmm5
movdqa 288(%rdi), %xmm1
movdqa 304(%rdi), %xmm9
movdqa 320(%rdi), %xmm8
movdqa 336(%rdi), %xmm7
movdqa 352(%rdi), %xmm6
jbe .L2
movdqa 64(%rdi), %xmm0
movdqa 80(%rdi), %xmm13
movdqa 256(%rdi), %xmm14
movdqa %xmm0, 40(%rsp)
movdqa %xmm13, 88(%rsp)
movdqa %xmm14, 104(%rsp)
movdqa 240(%rdi), %xmm0
movdqa 224(%rdi), %xmm13
movdqa 176(%rdi), %xmm14
movdqa %xmm0, 56(%rsp)
movdqa %xmm13, 120(%rsp)
movdqa %xmm14, 136(%rsp)
movdqa 192(%rdi), %xmm0
movdqa 208(%rdi), %xmm13
movdqa 16(%rdi), %xmm14
movdqa %xmm0, 72(%rsp)
movdqa %xmm13, 152(%rsp)
movdqa %xmm14, -120(%rsp)
movdqa 32(%rdi), %xmm0
movdqa 48(%rdi), %xmm13
movdqa 128(%rdi), %xmm14
movdqa %xmm0, -40(%rsp)
movdqa %xmm13, 8(%rsp)
movdqa %xmm14, -104(%rsp)
movdqa 112(%rdi), %xmm0
movdqa 96(%rdi), %xmm13
movdqa %xmm0, -24(%rsp)
movdqa %xmm13, 24(%rsp)
movdqa 160(%rdi), %xmm14
movdqa 272(%rdi), %xmm0
movdqa (%rdi), %xmm12
movdqa 144(%rdi), %xmm11
movdqa %xmm14, -88(%rsp)
movdqa %xmm0, -72(%rsp)
.p2align 4,,10
.p2align 3
.L3:
movdqa %xmm1, %xmm4
subq $64, %rdx
movdqa -120(%rsp), %xmm2
movdqa %xmm9, %xmm10
pmuludq %xmm12, %xmm4
movdqa -104(%rsp), %xmm13
pmuludq %xmm1, %xmm2
pmuludq %xmm12, %xmm10
paddq %xmm10, %xmm2
pmuludq %xmm9, %xmm13
movdqa -104(%rsp), %xmm10
paddq %xmm13, %xmm4
movdqa -24(%rsp), %xmm13
pmuludq %xmm8, %xmm10
paddq %xmm10, %xmm2
pmuludq %xmm8, %xmm13
movdqa -24(%rsp), %xmm10
paddq %xmm13, %xmm4
movdqa 24(%rsp), %xmm13
pmuludq %xmm7, %xmm10
paddq %xmm10, %xmm2
pmuludq %xmm7, %xmm13
movdqa 24(%rsp), %xmm10
paddq %xmm13, %xmm4
movdqa 88(%rsp), %xmm13
pmuludq %xmm6, %xmm10
paddq %xmm10, %xmm2
pmuludq %xmm6, %xmm13
movdqa -40(%rsp), %xmm0
paddq %xmm13, %xmm4
movdqa 8(%rsp), %xmm3
pmuludq %xmm1, %xmm0
movdqa -120(%rsp), %xmm13
pmuludq %xmm1, %xmm3
pmuludq 40(%rsp), %xmm1
movdqa -40(%rsp), %xmm10
pmuludq %xmm9, %xmm13
paddq %xmm13, %xmm0
movdqa %xmm8, %xmm13
pmuludq %xmm9, %xmm10
paddq %xmm10, %xmm3
movdqa -120(%rsp), %xmm10
pmuludq %xmm12, %xmm13
paddq %xmm13, %xmm0
pmuludq 8(%rsp), %xmm9
pmuludq %xmm8, %xmm10
movdqa -104(%rsp), %xmm13
paddq %xmm10, %xmm3
movdqa %xmm7, %xmm10
pmuludq -40(%rsp), %xmm8
paddq %xmm9, %xmm1
pmuludq %xmm7, %xmm13
paddq %xmm13, %xmm0
movdqa -24(%rsp), %xmm13
pmuludq %xmm12, %xmm10
paddq %xmm10, %xmm3
pmuludq -120(%rsp), %xmm7
movdqa -104(%rsp), %xmm10
pmuludq %xmm6, %xmm13
paddq %xmm8, %xmm1
paddq %xmm7, %xmm1
paddq %xmm13, %xmm0
pmuludq %xmm6, %xmm10
movq (%rsi), %xmm7
pmuludq %xmm12, %xmm6
paddq %xmm6, %xmm1
paddq %xmm10, %xmm3
movdqa %xmm5, %xmm10
movq 16(%rsi), %xmm6
punpcklqdq %xmm6, %xmm7
movq 24(%rsi), %xmm8
movq 8(%rsi), %xmm6
movdqa %xmm7, %xmm9
pand %xmm7, %xmm10
psrlq $52, %xmm7
punpcklqdq %xmm8, %xmm6
psrlq $26, %xmm9
pand %xmm5, %xmm9
movdqa -88(%rsp), %xmm13
movdqa %xmm10, %xmm14
movdqa %xmm6, %xmm8
pmuludq %xmm10, %xmm13
paddq %xmm13, %xmm2
movdqa %xmm9, %xmm13
pmuludq %xmm11, %xmm14
paddq %xmm14, %xmm4
psllq $12, %xmm8
por %xmm8, %xmm7
movdqa %xmm5, %xmm8
pmuludq %xmm11, %xmm13
paddq %xmm13, %xmm2
movdqa 104(%rsp), %xmm13
psrlq $40, %xmm6
por poly1305_x64_sse2_1shl128(%rip), %xmm6
movdqa -72(%rsp), %xmm14
pand %xmm7, %xmm8
psrlq $26, %xmm7
movdqa %xmm13, -56(%rsp)
pmuludq %xmm9, %xmm14
paddq %xmm14, %xmm4
movdqa %xmm13, %xmm14
pand %xmm5, %xmm7
pmuludq %xmm8, %xmm14
paddq %xmm14, %xmm4
movdqa -72(%rsp), %xmm13
movdqa %xmm7, %xmm15
movdqa -56(%rsp), %xmm14
pmuludq %xmm8, %xmm13
paddq %xmm13, %xmm2
pmuludq %xmm7, %xmm14
movdqa 56(%rsp), %xmm13
paddq %xmm14, %xmm2
movdqa 120(%rsp), %xmm14
pmuludq %xmm13, %xmm15
pmuludq %xmm6, %xmm13
paddq %xmm15, %xmm4
paddq %xmm13, %xmm2
movdqa %xmm10, %xmm15
movdqa 136(%rsp), %xmm13
pmuludq %xmm6, %xmm14
paddq %xmm14, %xmm4
movdqa 72(%rsp), %xmm14
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm14, -8(%rsp)
pmuludq %xmm10, %xmm14
paddq %xmm14, %xmm3
movdqa %xmm9, %xmm14
pmuludq 152(%rsp), %xmm10
paddq %xmm10, %xmm1
pmuludq %xmm13, %xmm14
paddq %xmm14, %xmm3
movdqa -88(%rsp), %xmm15
movdqa -88(%rsp), %xmm14
pmuludq %xmm9, %xmm15
paddq %xmm15, %xmm0
movdqa %xmm8, %xmm15
pmuludq -8(%rsp), %xmm9
paddq %xmm9, %xmm1
pmuludq %xmm8, %xmm14
paddq %xmm14, %xmm3
movdqa %xmm7, %xmm14
pmuludq %xmm11, %xmm15
paddq %xmm15, %xmm0
movdqa -72(%rsp), %xmm15
pmuludq %xmm11, %xmm14
paddq %xmm14, %xmm3
pmuludq %xmm13, %xmm8
pmuludq %xmm7, %xmm15
movdqa -72(%rsp), %xmm14
paddq %xmm15, %xmm0
paddq %xmm8, %xmm1
pmuludq -88(%rsp), %xmm7
paddq %xmm7, %xmm1
movdqa -56(%rsp), %xmm15
pmuludq %xmm6, %xmm14
paddq %xmm14, %xmm3
movdqa %xmm5, %xmm9
movq 48(%rsi), %xmm7
pmuludq %xmm6, %xmm15
pmuludq %xmm11, %xmm6
paddq %xmm6, %xmm1
paddq %xmm15, %xmm0
movq 32(%rsi), %xmm6
movq 56(%rsi), %xmm8
punpcklqdq %xmm7, %xmm6
movq 40(%rsi), %xmm7
addq $64, %rsi
cmpq $63, %rdx
punpcklqdq %xmm8, %xmm7
pand %xmm6, %xmm9
movdqa %xmm6, %xmm8
psrlq $52, %xmm6
movdqa %xmm7, %xmm10
psrlq $40, %xmm7
psrlq $26, %xmm8
por poly1305_x64_sse2_1shl128(%rip), %xmm7
paddq %xmm9, %xmm4
psllq $12, %xmm10
por %xmm10, %xmm6
movdqa %xmm5, %xmm10
pand %xmm5, %xmm8
pand %xmm6, %xmm10
psrlq $26, %xmm6
paddq %xmm7, %xmm1
pand %xmm5, %xmm6
movdqa %xmm4, %xmm7
paddq %xmm8, %xmm2
pand %xmm5, %xmm4
psrlq $26, %xmm7
paddq %xmm7, %xmm2
movdqa %xmm2, %xmm8
paddq %xmm6, %xmm3
movdqa %xmm3, %xmm6
movdqa %xmm2, %xmm9
pand %xmm5, %xmm3
psrlq $26, %xmm8
paddq %xmm10, %xmm0
psrlq $26, %xmm6
paddq %xmm6, %xmm1
movdqa %xmm1, %xmm7
movdqa %xmm1, %xmm6
paddq %xmm8, %xmm0
movdqa %xmm0, %xmm1
psrlq $26, %xmm7
pand %xmm5, %xmm9
pmuludq poly1305_x64_sse2_5(%rip), %xmm7
pand %xmm5, %xmm6
paddq %xmm7, %xmm4
movdqa %xmm4, %xmm2
pand %xmm5, %xmm4
psrlq $26, %xmm1
paddq %xmm1, %xmm3
movdqa %xmm0, %xmm8
movdqa %xmm3, %xmm7
psrlq $26, %xmm2
movdqa %xmm3, %xmm0
paddq %xmm2, %xmm9
pand %xmm5, %xmm8
movdqa %xmm4, %xmm1
psrlq $26, %xmm0
pand %xmm5, %xmm7
paddq %xmm0, %xmm6
ja .L3
.L2:
movdqa %xmm1, 288(%rdi)
movdqa %xmm9, 304(%rdi)
movdqa %xmm8, 320(%rdi)
movdqa %xmm7, 336(%rdi)
movdqa %xmm6, 352(%rdi)
addq $176, %rsp
ret









.p2align 4,,15
poly1305_first_block:
pushq %r15
movl 148(%rdi), %eax
movl 188(%rdi), %r8d
movl 204(%rdi), %r15d
pushq %r14
movabsq $17592186044415, %r14
movdqa poly1305_x64_sse2_message_mask(%rip), %xmm2
pushq %r13
movabsq $17592186044415, %r13
salq $32, %r8
salq $32, %r15
pushq %r12
pushq %rbp
movl 172(%rdi), %ebp
pushq %rbx
movl 156(%rdi), %ebx
salq $32, %rbp
movq %rsi, -24(%rsp)
salq $32, %rbx
orq %rax, %rbx
movl 164(%rdi), %eax
leaq (%rbx,%rbx), %rcx
orq %rax, %rbp
movl 180(%rdi), %eax
leaq (%rbp,%rbp), %r9
orq %rax, %r8
movl 196(%rdi), %eax
leaq (%r8,%r8,4), %r11
leaq (%r8,%r8), %rsi
salq $2, %r11
orq %rax, %r15
movl 220(%rdi), %eax
salq $32, %rax
movq %rax, -32(%rsp)
movl 212(%rdi), %eax
orq %rax, -32(%rsp)
movq %r11, %rax
mulq %r9
movq %rax, %r9
movq %rbx, %rax
movq %rdx, %r10
mulq %rbx
addq %rax, %r9
movq %r11, %rax
adcq %rdx, %r10
andq %r9, %r14
mulq %r8
movq %rax, %r11
movq %rcx, %rax
movq %rdx, %r12
mulq %rbp
movabsq $4398046511103, %rcx
addq %rax, %r11
movq %rsi, %rax
movabsq $17592186044415, %rsi
adcq %rdx, %r12
xorl %edx, %edx
shrdq $44, %r10, %r9
addq %r9, %r11
adcq %rdx, %r12
andq %r11, %r13
mulq %rbx
movq %rax, %r9
movq %rbp, %rax
movq %rdx, %r10
mulq %rbp
addq %rax, %r9
adcq %rdx, %r10
xorl %edx, %edx
shrdq $44, %r12, %r11
addq %r11, %r9
adcq %rdx, %r10
andq %r9, %rcx
shrdq $42, %r10, %r9
leaq (%rcx,%rcx,4), %r10
leaq (%r9,%r9,4), %r9
salq $2, %r10
addq %r14, %r9
andq %r9, %rsi
shrq $44, %r9
movl %esi, %edx
addq %r13, %r9
leaq (%rsi,%rsi), %r13
andl $67108863, %edx
movl %r9d, %eax
leaq (%r9,%r9), %r11
movd %edx, %xmm0
movq %rsi, %rdx
sall $18, %eax
shrq $26, %rdx
orl %edx, %eax
movq %r9, %rdx
andl $67108863, %eax
shrq $34, %rdx
movd %eax, %xmm5
movq %r9, %rax
shrq $8, %rax
pshufd $68, %xmm0, %xmm0
andl $67108863, %eax
pshufd $68, %xmm5, %xmm5
movd %eax, %xmm4
movl %ecx, %eax
sall $10, %eax
orl %edx, %eax
pshufd $68, %xmm4, %xmm4
andl $67108863, %eax
movd %eax, %xmm3
movq %rcx, %rax
shrq $16, %rax
movd %eax, %xmm1
movq %r11, %rax
mulq %r10
pshufd $68, %xmm3, %xmm3
pshufd $68, %xmm1, %xmm1
movdqa %xmm0, 144(%rdi)
movq %rax, %r11
movq %rsi, %rax
movq %rdx, %r12
mulq %rsi
movdqa poly1305_x64_sse2_5(%rip), %xmm0
movdqa %xmm1, 208(%rdi)
pmuludq %xmm0, %xmm1
addq %rax, %r11
movabsq $17592186044415, %rax
adcq %rdx, %r12
andq %r11, %rax
leaq (%rcx,%rcx), %rdx
movdqa %xmm1, 272(%rdi)
movq %rax, -16(%rsp)
movq %r9, %rax
movq %rdx, -40(%rsp)
mulq %r13
movdqa %xmm5, 160(%rdi)
pmuludq %xmm0, %xmm5
movdqa %xmm5, 224(%rdi)
movq %rax, %r13
movq %r10, %rax
movq %rdx, %r14
mulq %rcx
movabsq $17592186044415, %rcx
movdqa %xmm4, 176(%rdi)
pmuludq %xmm0, %xmm4
movdqa %xmm4, 240(%rdi)
addq %rax, %r13
movq %r9, %rax
adcq %rdx, %r14
xorl %edx, %edx
shrdq $44, %r12, %r11
movdqa %xmm3, 192(%rdi)
pmuludq %xmm0, %xmm3
addq %r11, %r13
adcq %rdx, %r14
andq %r13, %rcx
mulq %r9
movdqa %xmm3, 256(%rdi)
movq %rax, %r9
movq %rdx, %r10
movq -40(%rsp), %rax
mulq %rsi
movabsq $17592186044415, %rsi
addq %rax, %r9
movabsq $4398046511103, %rax
adcq %rdx, %r10
xorl %edx, %edx
shrdq $44, %r14, %r13
addq %r13, %r9
adcq %rdx, %r10
andq %r9, %rax
shrdq $42, %r10, %r9
leaq (%r9,%r9,4), %rdx
addq -16(%rsp), %rdx
andq %rdx, %rsi
shrq $44, %rdx
addq %rdx, %rcx
movl %esi, %edx
shrq $26, %rsi
andl $67108863, %edx
movd %edx, %xmm1
movl %ecx, %edx
sall $18, %edx
orl %esi, %edx
pshufd $68, %xmm1, %xmm1
andl $67108863, %edx
movd %edx, %xmm5
movq %rcx, %rdx
shrq $34, %rcx
shrq $8, %rdx
andl $67108863, %edx
pshufd $68, %xmm5, %xmm5
movd %edx, %xmm4
movl %eax, %edx
shrq $16, %rax
sall $10, %edx
orl %ecx, %edx
pshufd $68, %xmm4, %xmm4
andl $67108863, %edx
movdqa %xmm1, (%rdi)
movd %edx, %xmm3
movl %eax, -40(%rsp)
movd %eax, %xmm1
movdqa %xmm5, 16(%rdi)
pmuludq %xmm0, %xmm5
pshufd $68, %xmm1, %xmm1
pshufd $68, %xmm3, %xmm3
movdqa %xmm4, 32(%rdi)
pmuludq %xmm0, %xmm4
movl -32(%rsp), %eax
movq -24(%rsp), %rdx
movdqa %xmm3, 48(%rdi)
pmuludq %xmm0, %xmm3
pmuludq %xmm1, %xmm0
movdqa %xmm1, 64(%rdi)
movdqa %xmm5, 80(%rdi)
movdqa %xmm4, 96(%rdi)
movdqa %xmm3, 112(%rdi)
movdqa %xmm0, 128(%rdi)
movl %eax, 212(%rdi)
movq -32(%rsp), %rax
movl %ebx, 148(%rdi)
movl %ebp, 164(%rdi)
shrq $32, %rbx
movl %r8d, 180(%rdi)
movl %r15d, 196(%rdi)
shrq $32, %rbp
shrq $32, %r15
shrq $32, %r8
shrq $32, %rax
movl %ebx, 156(%rdi)
movl %ebp, 172(%rdi)
movl %r15d, 204(%rdi)
movl %r8d, 188(%rdi)
movl %eax, 220(%rdi)
movq 16(%rdx), %xmm1
popq %rbx
movq (%rdx), %xmm0
popq %rbp
movq 24(%rdx), %xmm3
punpcklqdq %xmm1, %xmm0
movq 8(%rdx), %xmm1
popq %r12
punpcklqdq %xmm3, %xmm1
movdqa %xmm2, %xmm3
popq %r13
pand %xmm0, %xmm3
popq %r14
popq %r15
movdqa %xmm3, 288(%rdi)
movdqa %xmm0, %xmm3
psrlq $52, %xmm0
psrlq $26, %xmm3
pand %xmm2, %xmm3
movdqa %xmm3, 304(%rdi)
movdqa %xmm1, %xmm3
psrlq $40, %xmm1
psllq $12, %xmm3
por %xmm3, %xmm0
por poly1305_x64_sse2_1shl128(%rip), %xmm1
movdqa %xmm2, %xmm3
pand %xmm0, %xmm3
psrlq $26, %xmm0
pand %xmm2, %xmm0
movdqa %xmm3, 320(%rdi)
movdqa %xmm0, 336(%rdi)
movdqa %xmm1, 352(%rdi)
ret







.p2align 4,,15
.globl poly1305_init
poly1305_init:
movq (%rsi), %rax
movq 8(%rsi), %rdx
movabsq $17575274610687, %rcx
addq $63, %rdi
pxor %xmm0, %xmm0
andq $-64, %rdi
andq %rax, %rcx
movq %rax, %r8
movq %rdx, %rax
shrq $44, %r8
salq $20, %rax
shrq $24, %rdx
orq %r8, %rax
movabsq $17592181915647, %r8
movl %ecx, 148(%rdi)
andq %r8, %rax
movabsq $68719475727, %r8
shrq $32, %rcx
andq %r8, %rdx
movl %eax, 164(%rdi)
shrq $32, %rax
movl %edx, 180(%rdi)
shrq $32, %rdx
movl %ecx, 156(%rdi)
movl %eax, 172(%rdi)
movl %edx, 188(%rdi)
movl 16(%rsi), %eax
movl %eax, 196(%rdi)
movl 20(%rsi), %eax
movl %eax, 204(%rdi)
movl 24(%rsi), %eax
movl %eax, 212(%rdi)
movl 28(%rsi), %eax
movdqa %xmm0, 288(%rdi)
movq $0, 368(%rdi)
movq $0, 376(%rdi)
movdqa %xmm0, 304(%rdi)
movdqa %xmm0, 320(%rdi)
movdqa %xmm0, 336(%rdi)
movdqa %xmm0, 352(%rdi)
movl %eax, 220(%rdi)
ret









.p2align 4,,15
.globl poly1305_update
poly1305_update:
movq %rbx, -32(%rsp)
leaq 63(%rdi), %rbx
movq %rbp, -24(%rsp)
movq %r12, -16(%rsp)
movq %r13, -8(%rsp)
subq $40, %rsp
andq $-64, %rbx
movq %rsi, %r12
movq %rdx, %rbp
cmpq $0, 368(%rbx)
movq 376(%rbx), %rax
jne .L10
cmpq $32, %rdx
ja .L34
.L11:
movl $32, %edx
movq %r12, %rcx
subq %rax, %rdx
leaq 384(%rbx,%rax), %rax
cmpq %rdx, %rbp
cmovbe %rbp, %rdx
subq %rax, %rcx
testb $32, %dl
jne .L35
.L13:
testb $16, %dl
jne .L36
.L14:
testb $8, %dl
je .L15
movq (%rax,%rcx), %rsi
movq %rsi, (%rax)
addq $8, %rax
.L15:
testb $4, %dl
je .L16
movl (%rax,%rcx), %esi
movl %esi, (%rax)
addq $4, %rax
.L16:
testb $2, %dl
je .L17
movzwl (%rax,%rcx), %esi
movw %si, (%rax)
addq $2, %rax
.L17:
testb $1, %dl
je .L18
movzbl (%rax,%rcx), %ecx
movb %cl, (%rax)
.L18:
movq %rdx, %rax
addq 376(%rbx), %rax
subq %rdx, %rbp
movq %rax, 376(%rbx)
jne .L37
.p2align 4,,10
.p2align 3
.L8:
movq 8(%rsp), %rbx
movq 16(%rsp), %rbp
movq 24(%rsp), %r12
movq 32(%rsp), %r13
addq $40, %rsp
ret
.p2align 4,,10
.p2align 3
.L37:
cmpq $31, %rax
jbe .L8
leaq 384(%rbx), %rsi
movq %rbx, %rdi
addq %rdx, %r12
call poly1305_first_block
movq $0, 376(%rbx)
xorl %eax, %eax
.L12:
movq $1, 368(%rbx)
.L10:
testq %rax, %rax
je .L20
movl $64, %edx
movq %r12, %rcx
subq %rax, %rdx
leaq 384(%rbx,%rax), %rax
cmpq %rbp, %rdx
cmova %rbp, %rdx
subq %rax, %rcx
testb $32, %dl
jne .L38
.L21:
testb $16, %dl
jne .L39
.L22:
testb $8, %dl
je .L23
movq (%rax,%rcx), %rsi
movq %rsi, (%rax)
addq $8, %rax
.L23:
testb $4, %dl
je .L24
movl (%rax,%rcx), %esi
movl %esi, (%rax)
addq $4, %rax
.L24:
testb $2, %dl
je .L25
movzwl (%rax,%rcx), %esi
movw %si, (%rax)
addq $2, %rax
.L25:
testb $1, %dl
je .L26
movzbl (%rax,%rcx), %ecx
movb %cl, (%rax)
.L26:
movq %rdx, %rax
addq 376(%rbx), %rax
cmpq $63, %rax
movq %rax, 376(%rbx)
jbe .L8
leaq 384(%rbx), %rsi
subq %rdx, %rbp
addq %rdx, %r12
movq %rbx, %rdi
movl $64, %edx
call poly1305_blocks
movq $0, 376(%rbx)
.L20:
cmpq $63, %rbp
ja .L40
testq %rbp, %rbp
je .L8
.L43:
movq 376(%rbx), %rax
leaq 384(%rbx,%rax), %rax
subq %rax, %r12
testb $32, %bpl
jne .L41
.L28:
testb $16, %bpl
jne .L42
.L29:
testb $8, %bpl
je .L30
movq (%rax,%r12), %rdx
movq %rdx, (%rax)
addq $8, %rax
.L30:
testb $4, %bpl
je .L31
movl (%rax,%r12), %edx
movl %edx, (%rax)
addq $4, %rax
.L31:
testb $2, %bpl
je .L32
movzwl (%rax,%r12), %edx
movw %dx, (%rax)
addq $2, %rax
.L32:
testb $1, %bpl
je .L33
movzbl (%rax,%r12), %edx
movb %dl, (%rax)
.L33:
addq %rbp, 376(%rbx)
jmp .L8
.p2align 4,,10
.p2align 3
.L40:
movq %rbp, %r13
movq %r12, %rsi
movq %rbx, %rdi
andq $-64, %r13
movq %r13, %rdx
subq %r13, %rbp
addq %r13, %r12
call poly1305_blocks
testq %rbp, %rbp
jne .L43
jmp .L8
.p2align 4,,10
.p2align 3
.L34:
testq %rax, %rax
jne .L11
movq %rbx, %rdi
addq $32, %r12
subq $32, %rbp
call poly1305_first_block
movq 376(%rbx), %rax
jmp .L12
.p2align 4,,10
.p2align 3
.L39:
movdqu (%rax,%rcx), %xmm0
movdqu %xmm0, (%rax)
addq $16, %rax
jmp .L22
.p2align 4,,10
.p2align 3
.L38:
movdqu (%rax,%rcx), %xmm0
movdqu %xmm0, (%rax)
movdqu 16(%rax,%rcx), %xmm0
movdqu %xmm0, 16(%rax)
addq $32, %rax
jmp .L21
.p2align 4,,10
.p2align 3
.L36:
movdqu (%rax,%rcx), %xmm0
movdqu %xmm0, (%rax)
addq $16, %rax
jmp .L14
.p2align 4,,10
.p2align 3
.L35:
movdqu (%rax,%rcx), %xmm0
movdqu %xmm0, (%rax)
movdqu 16(%rax,%rcx), %xmm0
movdqu %xmm0, 16(%rax)
addq $32, %rax
jmp .L13
.p2align 4,,10
.p2align 3
.L42:
movdqu (%rax,%r12), %xmm0
movdqu %xmm0, (%rax)
addq $16, %rax
jmp .L29
.p2align 4,,10
.p2align 3
.L41:
movdqu (%rax,%r12), %xmm0
movdqu %xmm0, (%rax)
movdqu 16(%rax,%r12), %xmm0
movdqu %xmm0, 16(%rax)
addq $32, %rax
jmp .L28







.p2align 4,,15
.globl poly1305_finish
poly1305_finish:
pushq %r15
addq $63, %rdi
andq $-64, %rdi
pushq %r14
pushq %r13
pushq %r12
pushq %rbp
pushq %rbx
subq $16, %rsp
cmpq $0, 368(%rdi)
movq 376(%rdi), %r11
movq %rsi, -48(%rsp)
jne .L45
movl 156(%rdi), %ebp
movl 148(%rdi), %edx
leaq 384(%rdi), %r10
movl 172(%rdi), %esi
movl 188(%rdi), %r8d
movq 288(%rdi), %rax
movq 296(%rdi), %rbx
movq 304(%rdi), %rcx
salq $32, %rbp
orq %rdx, %rbp
movl 164(%rdi), %edx
salq $32, %rsi
salq $32, %r8
orq %rdx, %rsi
movl 180(%rdi), %edx
orq %rdx, %r8
.L46:
leaq (%rsi,%rsi,4), %rdx
salq $2, %rdx
movq %rdx, -56(%rsp)
leaq (%r8,%r8,4), %rdx
salq $2, %rdx
cmpq $15, %r11
movq %rdx, -80(%rsp)
ja .L49
.L48:
testq %r11, %r11
je .L51
.L57:
movl $15, %edx
movb $1, (%r10,%r11)
leaq 1(%r10,%r11), %r9
subq %r11, %rdx
testb $8, %dl
je .L52
movq $0, (%r9)
addq $8, %r9
.L52:
testb $4, %dl
je .L53
movl $0, (%r9)
addq $4, %r9
.L53:
testb $2, %dl
je .L54
movw $0, (%r9)
addq $2, %r9
.L54:
andl $1, %edx
je .L55
movb $0, (%r9)
.L55:
movq (%r10), %r9
movq 8(%r10), %r11
movabsq $17592186044415, %r13
movq %r9, %rdx
movq %r9, -8(%rsp)
movq %r11, (%rsp)
andq %r13, %rdx
leaq (%rdx,%rax), %r15
movq -8(%rsp), %rax
movq (%rsp), %rdx
shrdq $44, %rdx, %rax
andq %r13, %rax
leaq (%rax,%rbx), %r9
movq %r11, %rax
xorl %r11d, %r11d
shrq $24, %rax
addq %rax, %rcx
jmp .L50
.p2align 4,,10
.p2align 3
.L49:
movq (%r10), %r12
movq 8(%r10), %r13
movabsq $17592186044415, %r9
subq $16, %r11
movq %r12, %rdx
movq %r12, -72(%rsp)
movq %r13, -64(%rsp)
andq %r9, %rdx
leaq (%rdx,%rax), %r15
movq -64(%rsp), %rdx
movq -72(%rsp), %rax
shrdq $44, %rdx, %rax
movabsq $1099511627776, %rdx
andq %r9, %rax
leaq (%rax,%rbx), %r9
movq %r13, %rax
shrq $24, %rax
orq %rdx, %rax
addq %rax, %rcx
.L50:
movq -80(%rsp), %rax
movabsq $17592186044415, %rbx
movq $0, -32(%rsp)
movq $0, -16(%rsp)
mulq %r9
movq %rax, %r13
movq -56(%rsp), %rax
movq %rdx, %r14
mulq %rcx
addq %rax, %r13
movq %r15, %rax
adcq %rdx, %r14
mulq %rbp
addq %rax, %r13
movq %r9, %rax
adcq %rdx, %r14
movq %r13, %r12
mulq %rbp
andq %rbx, %r12
movq %rax, -104(%rsp)
movq -80(%rsp), %rax
movq %rdx, -96(%rsp)
mulq %rcx
addq %rax, -104(%rsp)
movq %r15, %rax
adcq %rdx, -96(%rsp)
mulq %rsi
addq %rax, -104(%rsp)
movq %r13, %rax
adcq %rdx, -96(%rsp)
movq -32(%rsp), %rdx
shrdq $44, %r14, %rax
movq %rax, -40(%rsp)
movq -40(%rsp), %rax
addq %rax, -104(%rsp)
movq %r9, %rax
adcq %rdx, -96(%rsp)
andq -104(%rsp), %rbx
mulq %rsi
movq %rax, %r13
movq %rcx, %rax
movq %rdx, %r14
mulq %rbp
movabsq $4398046511103, %rcx
addq %rax, %r13
movq %r15, %rax
adcq %rdx, %r14
mulq %r8
addq %rax, %r13
movq -104(%rsp), %rax
adcq %rdx, %r14
movq -96(%rsp), %rdx
shrdq $44, %rdx, %rax
movq %rax, -24(%rsp)
addq -24(%rsp), %r13
adcq -16(%rsp), %r14
addq $16, %r10
movq %r13, %rax
andq %r13, %rcx
shrdq $42, %r14, %rax
leaq (%rax,%rax,4), %rax
addq %r12, %rax
cmpq $15, %r11
ja .L49
testq %r11, %r11
jne .L57
.L51:
movq %rax, %r9
shrq $44, %rax
movabsq $4398046511103, %rsi
addq %rax, %rbx
movabsq $17592186044415, %rdx
movabsq $-4398046511104, %r11
movq %rbx, %r8
shrq $44, %rbx
andq %rdx, %r9
addq %rbx, %rcx
andq %rdx, %r8
movl 204(%rdi), %ebp
andq %rcx, %rsi
shrq $42, %rcx
leaq (%rcx,%rcx,4), %rax
addq %rsi, %r11
addq %rax, %r9
salq $32, %rbp
leaq 5(%r9), %r10
movq %r10, %rbx
andq %rdx, %r10
shrq $44, %rbx
addq %r8, %rbx
movq %rbx, %rax
andq %rdx, %rbx
shrq $44, %rax
addq %rax, %r11
movq %r11, %rcx
shrq $63, %rcx
subq $1, %rcx
movq %rcx, %rax
andq %rcx, %r10
andq %rcx, %rbx
notq %rax
andq %rax, %r9
andq %rax, %r8
andq %rax, %rsi
movl 196(%rdi), %eax
orq %r10, %r9
orq %rbx, %r8
orq %rax, %rbp
movl 220(%rdi), %eax
movl 212(%rdi), %edi
salq $32, %rax
orq %rdi, %rax
movq %rbp, %rdi
andq %rdx, %rdi
addq %r9, %rdi
movq %rbp, %r9
shrdq $44, %rax, %r9
movq %rdi, %r10
andq %rdx, %r9
addq %r9, %r8
shrq $44, %r10
andq %r11, %rcx
addq %r10, %r8
orq %rcx, %rsi
shrq $24, %rax
movq %r8, %r10
addq %rax, %rsi
shrq $44, %r8
andq %rdx, %r10
andq %rdi, %rdx
addq %r8, %rsi
movq %r10, %rcx
salq $24, %rsi
shrq $20, %r10
salq $44, %rcx
orq %r10, %rsi
orq %rdx, %rcx
movq -48(%rsp), %rdx
movq %rcx, (%rdx)
movq %rsi, 8(%rdx)
addq $16, %rsp
popq %rbx
popq %rbp
popq %r12
popq %r13
popq %r14
popq %r15
ret
.p2align 4,,10
.p2align 3
.L45:
xorl %r14d, %r14d
cmpq $31, %r11
movdqa poly1305_x64_sse2_message_mask(%rip), %xmm0
movdqa 288(%rdi), %xmm2
movdqa 304(%rdi), %xmm9
movdqa 320(%rdi), %xmm8
movdqa 336(%rdi), %xmm7
movdqa 352(%rdi), %xmm12
jbe .L47
movdqa 176(%rdi), %xmm1
movb $32, %r14b
movdqa %xmm2, %xmm3
movdqa 192(%rdi), %xmm5
movdqa %xmm2, %xmm10
pmuludq %xmm2, %xmm1
movdqa %xmm2, %xmm4
pmuludq 208(%rdi), %xmm3
movdqa 144(%rdi), %xmm11
pmuludq %xmm2, %xmm5
movdqa %xmm9, %xmm14
movdqa %xmm9, %xmm6
movdqa 160(%rdi), %xmm13
movdqa %xmm8, %xmm15
pmuludq %xmm11, %xmm10
pmuludq %xmm11, %xmm6
movdqa 272(%rdi), %xmm2
pmuludq %xmm13, %xmm4
paddq %xmm6, %xmm4
movdqa %xmm8, %xmm6
pmuludq %xmm2, %xmm14
paddq %xmm14, %xmm10
movdqa 256(%rdi), %xmm14
pmuludq %xmm2, %xmm6
paddq %xmm6, %xmm4
movdqa %xmm7, %xmm6
pmuludq %xmm14, %xmm15
paddq %xmm15, %xmm10
movdqa 240(%rdi), %xmm15
pmuludq %xmm14, %xmm6
paddq %xmm6, %xmm4
movdqa %xmm12, %xmm6
pmuludq %xmm7, %xmm15
paddq %xmm15, %xmm10
movdqa 240(%rdi), %xmm15
pmuludq 224(%rdi), %xmm6
paddq %xmm6, %xmm10
pmuludq %xmm12, %xmm14
pmuludq %xmm12, %xmm15
movdqa 176(%rdi), %xmm6
paddq %xmm15, %xmm4
movdqa %xmm9, %xmm15
pmuludq %xmm9, %xmm6
paddq %xmm6, %xmm5
movdqa %xmm8, %xmm6
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm8, %xmm15
pmuludq %xmm13, %xmm6
paddq %xmm6, %xmm5
movdqa %xmm7, %xmm6
pmuludq %xmm11, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm7, %xmm15
pmuludq %xmm11, %xmm6
paddq %xmm6, %xmm5
movq 400(%rdi), %xmm6
pmuludq %xmm2, %xmm15
pmuludq %xmm12, %xmm2
paddq %xmm2, %xmm5
movq 384(%rdi), %xmm2
pmuludq 192(%rdi), %xmm9
pmuludq 176(%rdi), %xmm8
paddq %xmm9, %xmm3
pmuludq %xmm13, %xmm7
paddq %xmm8, %xmm3
punpcklqdq %xmm6, %xmm2
paddq %xmm7, %xmm3
pmuludq %xmm11, %xmm12
movq 408(%rdi), %xmm7
movdqa %xmm0, %xmm9
paddq %xmm12, %xmm3
paddq %xmm15, %xmm1
paddq %xmm14, %xmm1
movq 392(%rdi), %xmm6
pand %xmm2, %xmm9
punpcklqdq %xmm7, %xmm6
movdqa %xmm2, %xmm7
psrlq $52, %xmm2
psrlq $26, %xmm7
pand %xmm0, %xmm7
paddq %xmm9, %xmm10
movdqa %xmm6, %xmm8
psrlq $40, %xmm6
por poly1305_x64_sse2_1shl128(%rip), %xmm6
psllq $12, %xmm8
por %xmm8, %xmm2
paddq %xmm7, %xmm4
movdqa %xmm0, %xmm8
pand %xmm2, %xmm8
psrlq $26, %xmm2
paddq %xmm6, %xmm3
pand %xmm0, %xmm2
movdqa %xmm10, %xmm6
pand %xmm0, %xmm10
psrlq $26, %xmm6
paddq %xmm6, %xmm4
paddq %xmm8, %xmm1
paddq %xmm2, %xmm5
movdqa %xmm5, %xmm2
movdqa %xmm5, %xmm7
movdqa %xmm4, %xmm5
psrlq $26, %xmm2
paddq %xmm2, %xmm3
movdqa %xmm3, %xmm2
pand %xmm0, %xmm7
movdqa %xmm4, %xmm9
psrlq $26, %xmm5
movdqa %xmm3, %xmm12
paddq %xmm5, %xmm1
psrlq $26, %xmm2
movdqa %xmm1, %xmm4
pmuludq poly1305_x64_sse2_5(%rip), %xmm2
movdqa %xmm1, %xmm8
paddq %xmm2, %xmm10
movdqa %xmm10, %xmm2
pand %xmm0, %xmm9
psrlq $26, %xmm4
paddq %xmm4, %xmm7
pand %xmm0, %xmm12
movdqa %xmm7, %xmm1
pand %xmm0, %xmm8
pand %xmm0, %xmm2
movdqa %xmm10, %xmm3
psrlq $26, %xmm1
pand %xmm0, %xmm7
paddq %xmm1, %xmm12
psrlq $26, %xmm3
paddq %xmm3, %xmm9
.L47:
movl 156(%rdi), %ebp
movl 148(%rdi), %eax
movl 172(%rdi), %esi
movl 188(%rdi), %r8d
movdqa %xmm2, %xmm5
movdqa %xmm2, %xmm3
movdqa %xmm9, %xmm14
salq $32, %rbp
movdqa %xmm9, %xmm13
orq %rax, %rbp
movl 164(%rdi), %eax
salq $32, %rsi
salq $32, %r8
movdqa %xmm8, %xmm15
orq %rax, %rsi
movl 180(%rdi), %eax
movl %esi, %edx
movq %rsi, %r9
movq %rsi, %rcx
sall $18, %edx
shrq $34, %r9
shrq $8, %rcx
andl $67108863, %ecx
orq %rax, %r8
movl %ebp, %eax
movl %ecx, 184(%rdi)
andl $67108863, %eax
leal (%rcx,%rcx,4), %ecx
movl %eax, 152(%rdi)
movq %rbp, %rax
shrq $26, %rax
movdqa 144(%rdi), %xmm6
orl %eax, %edx
movl %r8d, %eax
movl %ecx, 248(%rdi)
sall $10, %eax
andl $67108863, %edx
pmuludq %xmm6, %xmm13
orl %r9d, %eax
movq %r8, %r9
movl %edx, 168(%rdi)
shrq $16, %r9
andl $67108863, %eax
pmuludq %xmm6, %xmm5
movl %r9d, 216(%rdi)
leal (%r9,%r9,4), %r9d
movl %eax, 200(%rdi)
leal (%rax,%rax,4), %eax
movdqa 160(%rdi), %xmm10
movl %r9d, 280(%rdi)
leal (%rdx,%rdx,4), %edx
movdqa 272(%rdi), %xmm11
pmuludq %xmm10, %xmm3
paddq %xmm13, %xmm3
movl %eax, 264(%rdi)
movl %edx, 232(%rdi)
movdqa 256(%rdi), %xmm13
pmuludq %xmm11, %xmm14
paddq %xmm14, %xmm5
movdqa %xmm8, %xmm14
pmuludq %xmm13, %xmm15
paddq %xmm15, %xmm5
movdqa 240(%rdi), %xmm15
pmuludq %xmm11, %xmm14
paddq %xmm14, %xmm3
movdqa %xmm7, %xmm14
pmuludq %xmm7, %xmm15
paddq %xmm15, %xmm5
movdqa 240(%rdi), %xmm15
pmuludq %xmm13, %xmm14
paddq %xmm14, %xmm3
movdqa %xmm12, %xmm14
pmuludq %xmm12, %xmm15
movdqa 176(%rdi), %xmm1
paddq %xmm15, %xmm3
pmuludq 224(%rdi), %xmm14
movdqa %xmm9, %xmm15
paddq %xmm14, %xmm5
movdqa 192(%rdi), %xmm4
pmuludq %xmm2, %xmm1
pmuludq %xmm12, %xmm13
pmuludq %xmm10, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm8, %xmm15
movdqa 176(%rdi), %xmm14
pmuludq %xmm2, %xmm4
pmuludq 208(%rdi), %xmm2
pmuludq %xmm6, %xmm15
paddq %xmm15, %xmm1
movdqa %xmm7, %xmm15
pmuludq %xmm9, %xmm14
paddq %xmm14, %xmm4
movdqa %xmm8, %xmm14
pmuludq %xmm11, %xmm15
pmuludq %xmm12, %xmm11
pmuludq %xmm6, %xmm12
pmuludq %xmm10, %xmm14
paddq %xmm14, %xmm4
movdqa %xmm7, %xmm14
pmuludq 192(%rdi), %xmm9
pmuludq 176(%rdi), %xmm8
pmuludq %xmm10, %xmm7
pmuludq %xmm6, %xmm14
paddq %xmm14, %xmm4
paddq %xmm11, %xmm4
movdqa %xmm4, %xmm6
paddq %xmm9, %xmm2
paddq %xmm8, %xmm2
paddq %xmm7, %xmm2
movdqa %xmm5, %xmm7
pand %xmm0, %xmm5
psrlq $26, %xmm6
paddq %xmm12, %xmm2
paddq %xmm6, %xmm2
movdqa %xmm2, %xmm6
psrlq $26, %xmm7
paddq %xmm7, %xmm3
movdqa %xmm3, %xmm7
pand %xmm0, %xmm4
paddq %xmm15, %xmm1
pand %xmm0, %xmm3
psrlq $26, %xmm6
pmuludq poly1305_x64_sse2_5(%rip), %xmm6
paddq %xmm6, %xmm5
movdqa %xmm5, %xmm6
pand %xmm0, %xmm5
psrlq $26, %xmm7
paddq %xmm13, %xmm1
paddq %xmm7, %xmm1
movdqa %xmm1, %xmm7
psrlq $26, %xmm6
paddq %xmm6, %xmm3
pand %xmm0, %xmm1
pand %xmm0, %xmm2
psrlq $26, %xmm7
paddq %xmm7, %xmm4
movdqa %xmm4, %xmm6
pand %xmm0, %xmm4
movdqa %xmm5, %xmm0
psrlq $26, %xmm6
paddq %xmm6, %xmm2
psrldq $8, %xmm0
paddq %xmm0, %xmm5
movdqa %xmm3, %xmm0
movd %xmm5, -104(%rsp)
movslq -104(%rsp), %r12
psrldq $8, %xmm0
paddq %xmm0, %xmm3
movd %xmm3, -104(%rsp)
movslq -104(%rsp), %rax
movdqa %xmm1, %xmm0
movq %r12, %r9
shrq $26, %r12
psrldq $8, %xmm0
paddq %xmm0, %xmm1
movd %xmm1, -104(%rsp)
movdqa %xmm4, %xmm0
addq %rax, %r12
movslq -104(%rsp), %rax
andl $67108863, %r9d
movq %r12, %rcx
shrq $26, %r12
psrldq $8, %xmm0
paddq %xmm0, %xmm4
movd %xmm4, -104(%rsp)
movdqa %xmm2, %xmm0
andl $67108863, %ecx
addq %rax, %r12
movslq -104(%rsp), %rax
psrldq $8, %xmm0
movq %r12, %r10
paddq %xmm0, %xmm2
movd %xmm2, -104(%rsp)
shrq $26, %r10
addq %rax, %r10
movslq -104(%rsp), %rax
movq %r10, %r13
shrq $26, %r10
andl $67108863, %r13d
movq %r13, %rbx
addq %rax, %r10
movq %r10, %rax
shrq $26, %rax
leaq (%rax,%rax,4), %rdx
addq %r9, %rdx
movq %rdx, %r9
shrq $26, %r9
addq %rcx, %r9
movabsq $17592186044415, %rcx
movq %r9, %rax
salq $26, %rax
andl $67108863, %edx
salq $34, %rbx
orq %rdx, %rax
movq %r12, %rdx
shrq $18, %r9
andl $67108863, %edx
andq %rcx, %rax
subq %r14, %r11
salq $8, %rdx
movq %rax, 288(%rdi)
orq %rdx, %rbx
movq %r13, %rdx
orq %r9, %rbx
shrq $10, %rdx
andq %rcx, %rbx
movq %r10, %rcx
leaq 384(%rdi,%r14), %r10
andl $67108863, %ecx
movq %rbx, 296(%rdi)
salq $16, %rcx
orq %rdx, %rcx
movq %rcx, 304(%rdi)
jmp .L46







.p2align 4,,15
.globl poly1305_auth
poly1305_auth:
pushq %rbx
movq %rdi, %rbx
movabsq $17575274610687, %r9
pxor %xmm0, %xmm0
subq $512, %rsp
movq (%rcx), %rdi
movq 8(%rcx), %r8
leaq 63(%rsp), %rax
andq %rdi, %r9
movq %rdi, %r10
movq %r8, %rdi
shrq $44, %r10
salq $20, %rdi
shrq $24, %r8
orq %r10, %rdi
movabsq $17592181915647, %r10
andq $-64, %rax
andq %r10, %rdi
movabsq $68719475727, %r10
movl %r9d, 148(%rax)
andq %r10, %r8
movl %edi, 164(%rax)
shrq $32, %r9
movl %r8d, 180(%rax)
shrq $32, %rdi
shrq $32, %r8
movl %r9d, 156(%rax)
movl %edi, 172(%rax)
movl %r8d, 188(%rax)
movl 16(%rcx), %edi
movl %edi, 196(%rax)
movl 20(%rcx), %edi
movl %edi, 204(%rax)
movl 24(%rcx), %edi
movl %edi, 212(%rax)
movl 28(%rcx), %ecx
movq %rsp, %rdi
movdqa %xmm0, 288(%rax)
movq $0, 368(%rax)
movq $0, 376(%rax)
movdqa %xmm0, 304(%rax)
movdqa %xmm0, 320(%rax)
movdqa %xmm0, 336(%rax)
movdqa %xmm0, 352(%rax)
movl %ecx, 220(%rax)
call poly1305_update
movq %rbx, %rsi
movq %rsp, %rdi
call poly1305_finish
addq $512, %rsp
popq %rbx
ret





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
