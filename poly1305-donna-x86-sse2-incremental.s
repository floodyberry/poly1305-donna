.text

.align 16,0x90
.globl poly1305_update
poly1305_update:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
subl $28, %esp
movl 48(%esp), %eax
movl 52(%esp), %ebx
movl 56(%esp), %ebp
lea 63(%eax), %esi
andl $-64, %esi
movl 372(%esi), %edx
cmpl $0, 368(%esi)
jne L1_25
testl %edx, %edx
jne L1_6
cmpl $32, %ebp
jbe L1_6
movl %esi, %eax
movl %ebx, %edx
call poly1305_first_block
movl 372(%esi), %edx
addl $32, %ebx
addl $-32, %ebp
jmp L1_24
L1_6:
movl %edx, %edi
addl %esi, %edx
negl %edi
addl $32, %edi
cmpl %ebp, %edi
cmovae %ebp, %edi
testl $32, %edi
je L1_8
movdqu (%ebx), %xmm0
movdqu %xmm0, 376(%edx)
movl $32, %ecx
movdqu 16(%ebx), %xmm1
movdqu %xmm1, 392(%edx)
jmp L1_9
L1_8:
xorl %ecx, %ecx
L1_9:
testl $16, %edi
je L1_11
movdqu (%ecx,%ebx), %xmm0
movdqu %xmm0, 376(%ecx,%edx)
addl $16, %ecx
L1_11:
testl $8, %edi
je L1_13
movl %ebx, 16(%esp)
movl (%ecx,%ebx), %eax
movl 4(%ecx,%ebx), %ebx
movl %ebx, 380(%ecx,%edx)
movl %eax, 376(%ecx,%edx)
addl $8, %ecx
movl 16(%esp), %ebx
L1_13:
testl $4, %edi
je L1_15
movl (%ecx,%ebx), %eax
movl %eax, 376(%ecx,%edx)
addl $4, %ecx
L1_15:
testl $2, %edi
je L1_17
movzwl (%ecx,%ebx), %eax
movw %ax, 376(%ecx,%edx)
addl $2, %ecx
L1_17:
testl $1, %edi
je L1_19
movzbl (%ecx,%ebx), %eax
movb %al, 376(%ecx,%edx)
L1_19:
movl 372(%esi), %eax
subl %edi, %ebp
addl %edi, %ebx
addl %eax, %edi
movl %edi, 372(%esi)
cmpl $32, %edi
jb L1_21
testl %ebp, %ebp
jne L1_22
L1_21:
addl $28, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret
L1_22:
movl %esi, %eax
lea 376(%esi), %edx
call poly1305_first_block
movl $0, 372(%esi)
xorl %edx, %edx
L1_24:
movl $1, 368(%esi)
L1_25:
testl %edx, %edx
je L1_43
movl %edx, %ecx
addl %esi, %edx
negl %ecx
addl $64, %ecx
cmpl %ebp, %ecx
cmovae %ebp, %ecx
testb $32, %cl
je L1_28
movdqu (%ebx), %xmm0
movdqu %xmm0, 376(%edx)
movl $32, %edi
movdqu 16(%ebx), %xmm1
movdqu %xmm1, 392(%edx)
jmp L1_29
L1_28:
xorl %edi, %edi
L1_29:
testb $16, %cl
je L1_31
movdqu (%edi,%ebx), %xmm0
movdqu %xmm0, 376(%edi,%edx)
addl $16, %edi
L1_31:
testb $8, %cl
je L1_33
movl %ecx, 16(%esp)
movl 4(%edi,%ebx), %ecx
movl (%edi,%ebx), %eax
movl %ecx, 380(%edi,%edx)
movl %eax, 376(%edi,%edx)
addl $8, %edi
movl 16(%esp), %ecx
L1_33:
testb $4, %cl
je L1_35
movl (%edi,%ebx), %eax
movl %eax, 376(%edi,%edx)
addl $4, %edi
L1_35:
testb $2, %cl
je L1_37
movzwl (%edi,%ebx), %eax
movw %ax, 376(%edi,%edx)
addl $2, %edi
L1_37:
testb $1, %cl
je L1_39
movzbl (%edi,%ebx), %eax
movb %al, 376(%edi,%edx)
L1_39:
movl 372(%esi), %eax
subl %ecx, %ebp
addl %ecx, %ebx
addl %eax, %ecx
movl %ecx, 372(%esi)
cmpl $64, %ecx
jae L1_41
addl $28, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret
L1_41:
movl %esi, %eax
lea 376(%esi), %edx
movl $64, %ecx
call poly1305_blocks
movl $0, 372(%esi)
L1_43:
cmpl $64, %ebp
jb L1_46
movl %ebp, %edi
movl %esi, %eax
andl $-64, %edi
movl %ebx, %edx
movl %edi, %ecx
call poly1305_blocks
addl %edi, %ebx
subl %edi, %ebp
L1_46:
testl %ebp, %ebp
je L1_61
movl 372(%esi), %ecx
addl %esi, %ecx
testl $32, %ebp
je L1_49
movdqu (%ebx), %xmm0
movdqu %xmm0, 376(%ecx)
movl $32, %edx
movdqu 16(%ebx), %xmm1
movdqu %xmm1, 392(%ecx)
jmp L1_50
L1_49:
xorl %edx, %edx
L1_50:
testl $16, %ebp
je L1_52
movdqu (%ebx,%edx), %xmm0
movdqu %xmm0, 376(%edx,%ecx)
addl $16, %edx
L1_52:
testl $8, %ebp
je L1_54
movl (%ebx,%edx), %eax
movl 4(%ebx,%edx), %edi
movl %eax, 376(%edx,%ecx)
movl %edi, 380(%edx,%ecx)
addl $8, %edx
L1_54:
testl $4, %ebp
je L1_56
movl (%ebx,%edx), %eax
movl %eax, 376(%edx,%ecx)
addl $4, %edx
L1_56:
testl $2, %ebp
je L1_58
movzwl (%ebx,%edx), %eax
movw %ax, 376(%edx,%ecx)
addl $2, %edx
L1_58:
testl $1, %ebp
je L1_60
movzbl (%ebx,%edx), %eax
movb %al, 376(%edx,%ecx)
L1_60:
addl %ebp, 372(%esi)
L1_61:
addl $28, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret





.align 16,0x90
poly1305_blocks:
pushl %ebp
movl %esp, 132(%eax)
andl $~63, %esp
subl $608, %esp
leal 600(%esp), %ebp
movdqa poly1305_x64_sse2_1shl128, %xmm0
cmpl $64, %ecx
movdqa %xmm0, -232(%ebp)
movdqa poly1305_x64_sse2_message_mask, %xmm6
movdqa poly1305_x64_sse2_5, %xmm4
movdqa 288(%eax), %xmm1
movdqa 304(%eax), %xmm2
movdqa 320(%eax), %xmm5
movdqa 336(%eax), %xmm0
movdqa 352(%eax), %xmm3
jb L2_5
movdqa %xmm3, -584(%ebp)
movdqa %xmm0, -568(%ebp)
movdqa %xmm2, -552(%ebp)
movdqa %xmm4, -600(%ebp)
movdqa %xmm6, -536(%ebp)
.align 16,0x90
L2_3:
movq 8(%edx), %xmm4
addl $-64, %ecx
movq (%edx), %xmm2
movhpd 24(%edx), %xmm4
movdqa -536(%ebp), %xmm6
movaps %xmm4, %xmm0
movhpd 16(%edx), %xmm2
movdqa %xmm6, %xmm3
pand %xmm2, %xmm3
movaps %xmm2, %xmm7
psrlq $52, %xmm2
psllq $12, %xmm0
psrlq $40, %xmm4
por %xmm0, %xmm2
movdqa %xmm6, %xmm0
psrlq $26, %xmm7
por -232(%ebp), %xmm4
pand %xmm2, %xmm0
psrlq $26, %xmm2
pand %xmm6, %xmm7
movaps %xmm4, -120(%ebp)
pand %xmm6, %xmm2
movq 32(%edx), %xmm4
movq 40(%edx), %xmm6
movhpd 48(%edx), %xmm4
movhpd 56(%edx), %xmm6
addl $64, %edx
movaps %xmm4, -104(%ebp)
psrlq $52, %xmm4
movaps %xmm6, -88(%ebp)
psllq $12, %xmm6
por %xmm6, %xmm4
movdqa %xmm5, %xmm6
movdqa %xmm4, -72(%ebp)
cmpl $64, %ecx
movdqa -552(%ebp), %xmm4
movdqa %xmm1, -200(%ebp)
pmuludq (%eax), %xmm1
pmuludq 128(%eax), %xmm4
pmuludq 112(%eax), %xmm6
paddq %xmm4, %xmm1
paddq %xmm6, %xmm1
movdqa -568(%ebp), %xmm6
movdqa %xmm6, %xmm4
pmuludq 96(%eax), %xmm4
paddq %xmm4, %xmm1
movdqa -584(%ebp), %xmm4
pmuludq 80(%eax), %xmm4
paddq %xmm4, %xmm1
movdqa 144(%eax), %xmm4
pmuludq %xmm3, %xmm4
paddq %xmm4, %xmm1
movdqa 272(%eax), %xmm4
pmuludq %xmm7, %xmm4
paddq %xmm4, %xmm1
movdqa 256(%eax), %xmm4
pmuludq %xmm0, %xmm4
paddq %xmm4, %xmm1
movdqa 240(%eax), %xmm4
pmuludq %xmm2, %xmm4
movaps %xmm2, -136(%ebp)
movdqa 224(%eax), %xmm2
pmuludq -120(%ebp), %xmm2
paddq %xmm4, %xmm1
movdqa -536(%ebp), %xmm4
paddq %xmm2, %xmm1
pand -104(%ebp), %xmm4
paddq %xmm4, %xmm1
movdqa %xmm1, -56(%ebp)
movdqa -200(%ebp), %xmm1
movdqa -552(%ebp), %xmm2
pmuludq 48(%eax), %xmm1
pmuludq 32(%eax), %xmm2
movdqa 16(%eax), %xmm4
movdqa %xmm5, -216(%ebp)
pmuludq %xmm4, %xmm5
paddq %xmm2, %xmm1
paddq %xmm5, %xmm1
movdqa (%eax), %xmm5
pmuludq %xmm5, %xmm6
movdqa -584(%ebp), %xmm2
paddq %xmm6, %xmm1
movdqa 128(%eax), %xmm6
pmuludq %xmm6, %xmm2
paddq %xmm2, %xmm1
movdqa 192(%eax), %xmm2
pmuludq %xmm3, %xmm2
paddq %xmm2, %xmm1
movdqa 176(%eax), %xmm2
pmuludq %xmm7, %xmm2
movdqa %xmm7, -168(%ebp)
movdqa 160(%eax), %xmm7
paddq %xmm2, %xmm1
movdqa %xmm7, %xmm2
pmuludq %xmm0, %xmm2
pmuludq %xmm3, %xmm7
paddq %xmm2, %xmm1
movdqa %xmm0, -152(%ebp)
movdqa 144(%eax), %xmm0
pmuludq -136(%ebp), %xmm0
movdqa 272(%eax), %xmm2
pmuludq -120(%ebp), %xmm2
paddq %xmm0, %xmm1
movdqa -72(%ebp), %xmm0
paddq %xmm2, %xmm1
movdqa -536(%ebp), %xmm2
psrlq $26, %xmm0
pand %xmm2, %xmm0
paddq %xmm0, %xmm1
movdqa -200(%ebp), %xmm0
movdqa %xmm1, -40(%ebp)
movdqa %xmm0, %xmm1
pmuludq %xmm4, %xmm1
movdqa -552(%ebp), %xmm4
pmuludq %xmm5, %xmm4
movdqa -216(%ebp), %xmm5
paddq %xmm4, %xmm1
movdqa %xmm5, %xmm4
pmuludq %xmm6, %xmm4
movdqa -568(%ebp), %xmm6
paddq %xmm4, %xmm1
movdqa %xmm6, %xmm4
pmuludq 112(%eax), %xmm4
pmuludq 16(%eax), %xmm6
paddq %xmm4, %xmm1
movdqa -584(%ebp), %xmm4
pmuludq 96(%eax), %xmm4
paddq %xmm4, %xmm1
movdqa 144(%eax), %xmm4
pmuludq -168(%ebp), %xmm4
paddq %xmm7, %xmm1
movdqa 272(%eax), %xmm7
pmuludq -152(%ebp), %xmm7
paddq %xmm4, %xmm1
movdqa 256(%eax), %xmm4
pmuludq -136(%ebp), %xmm4
paddq %xmm7, %xmm1
movdqa 240(%eax), %xmm7
paddq %xmm4, %xmm1
movaps -120(%ebp), %xmm4
pmuludq %xmm4, %xmm7
paddq %xmm7, %xmm1
movaps -104(%ebp), %xmm7
psrlq $26, %xmm7
pand %xmm2, %xmm7
movdqa -56(%ebp), %xmm2
paddq %xmm7, %xmm1
psrlq $26, %xmm2
movdqa -552(%ebp), %xmm7
paddq %xmm2, %xmm1
movdqa %xmm1, -24(%ebp)
movdqa %xmm0, %xmm2
movdqa %xmm7, %xmm1
pmuludq 64(%eax), %xmm2
pmuludq 48(%eax), %xmm1
pmuludq 16(%eax), %xmm7
paddq %xmm1, %xmm2
movdqa 32(%eax), %xmm1
pmuludq %xmm1, %xmm5
pmuludq %xmm1, %xmm0
paddq %xmm5, %xmm2
paddq %xmm7, %xmm0
paddq %xmm6, %xmm2
movdqa -584(%ebp), %xmm5
movdqa (%eax), %xmm6
pmuludq %xmm6, %xmm5
paddq %xmm5, %xmm2
movdqa 208(%eax), %xmm5
pmuludq %xmm3, %xmm5
movdqa %xmm3, -184(%ebp)
movdqa 192(%eax), %xmm3
pmuludq -168(%ebp), %xmm3
paddq %xmm5, %xmm2
movdqa 176(%eax), %xmm5
pmuludq -152(%ebp), %xmm5
paddq %xmm3, %xmm2
movdqa 160(%eax), %xmm3
pmuludq -136(%ebp), %xmm3
paddq %xmm5, %xmm2
movdqa 144(%eax), %xmm5
paddq %xmm3, %xmm2
movdqa %xmm5, %xmm3
pmuludq %xmm4, %xmm3
pmuludq 256(%eax), %xmm4
paddq %xmm3, %xmm2
movdqa -216(%ebp), %xmm1
movaps -88(%ebp), %xmm3
pmuludq %xmm6, %xmm1
psrlq $40, %xmm3
movdqa -568(%ebp), %xmm7
por -232(%ebp), %xmm3
pmuludq 128(%eax), %xmm7
paddq %xmm3, %xmm2
paddq %xmm1, %xmm0
movdqa -40(%ebp), %xmm3
movdqa -584(%ebp), %xmm6
psrlq $26, %xmm3
pmuludq 112(%eax), %xmm6
paddq %xmm3, %xmm2
paddq %xmm7, %xmm0
movdqa -184(%ebp), %xmm3
pmuludq 176(%eax), %xmm3
paddq %xmm6, %xmm0
movdqa -168(%ebp), %xmm1
pmuludq 160(%eax), %xmm1
paddq %xmm3, %xmm0
movdqa -152(%ebp), %xmm7
movdqa %xmm2, %xmm3
pmuludq %xmm5, %xmm7
psrlq $26, %xmm3
pmuludq -600(%ebp), %xmm3
paddq %xmm1, %xmm0
movaps -136(%ebp), %xmm5
pmuludq 272(%eax), %xmm5
paddq %xmm7, %xmm0
paddq %xmm5, %xmm0
movdqa -536(%ebp), %xmm7
paddq %xmm4, %xmm0
movdqa -72(%ebp), %xmm4
movdqa %xmm7, %xmm1
pand %xmm7, %xmm4
pand %xmm7, %xmm2
paddq %xmm4, %xmm0
movdqa -24(%ebp), %xmm4
movdqa %xmm4, %xmm5
pand %xmm7, %xmm4
psrlq $26, %xmm5
paddq %xmm0, %xmm5
movdqa -56(%ebp), %xmm0
movdqa %xmm5, %xmm6
pand %xmm7, %xmm0
psrlq $26, %xmm6
paddq %xmm3, %xmm0
movdqa -40(%ebp), %xmm3
pand %xmm0, %xmm1
pand %xmm7, %xmm3
psrlq $26, %xmm0
paddq %xmm6, %xmm3
paddq %xmm0, %xmm4
movdqa %xmm7, %xmm0
pand %xmm7, %xmm5
pand %xmm3, %xmm0
psrlq $26, %xmm3
paddq %xmm3, %xmm2
movdqa %xmm4, -552(%ebp)
movdqa %xmm0, -568(%ebp)
movdqa %xmm2, -584(%ebp)
jae L2_3
movdqa -584(%ebp), %xmm3
movdqa -568(%ebp), %xmm0
movdqa -552(%ebp), %xmm2
L2_5:
movdqa %xmm1, 288(%eax)
movdqa %xmm2, 304(%eax)
movdqa %xmm5, 320(%eax)
movdqa %xmm0, 336(%eax)
movdqa %xmm3, 352(%eax)
movl 132(%eax), %esp
popl %ebp
ret


.align 16,0x90
poly1305_first_block:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
subl $124, %esp
movl %edx, (%esp)
movl 196(%eax), %edx
movl %edx, 28(%esp)
movl 204(%eax), %edx
movl %edx, 32(%esp)
movl 212(%eax), %edx
movl 148(%eax), %ecx
movl %edx, 36(%esp)
movl %eax, 4(%esp)
movl 156(%eax), %esi
movl 164(%eax), %edi
movl 172(%eax), %ebx
movl 180(%eax), %ebp
movl 220(%eax), %edx
movl %ecx, %eax
movl %edx, 40(%esp)
mull %ecx
movl %ebx, 20(%esp)
lea (%ebx,%ebx,4), %ebx
movl %ebx, 44(%esp)
movl %edx, %ebx
movl %edi, 16(%esp)
addl %edi, %edi
movl %ebp, 24(%esp)
addl %ebp, %ebp
movl %ebp, 48(%esp)
movl %eax, %ebp
movl 44(%esp), %eax
mull %edi
addl %eax, %ebp
lea (%esi,%esi,4), %eax
movl %esi, 12(%esp)
lea (%esi,%esi), %esi
adcl %edx, %ebx
mull 48(%esp)
addl %eax, %ebp
movl %ecx, %eax
movl %esi, 56(%esp)
adcl %edx, %ebx
mull %esi
movl %eax, %esi
movl %edx, %edi
movl 44(%esp), %eax
mull 20(%esp)
movl %ecx, 8(%esp)
addl %eax, %esi
movl 16(%esp), %ecx
adcl %edx, %edi
movl %ebp, 52(%esp)
shll $6, %ebx
lea (%ecx,%ecx,4), %eax
mull 48(%esp)
shrl $26, %ebp
orl %ebp, %ebx
addl %ebx, %eax
movl 8(%esp), %ebx
adcl $0, %edx
addl %eax, %esi
movl 12(%esp), %eax
adcl %edx, %edi
addl %ebx, %ebx
mull %eax
movl %ebx, 64(%esp)
movl %eax, %ebx
movl %ecx, %eax
movl %edx, %ebp
mull 64(%esp)
addl %eax, %ebx
movl 44(%esp), %eax
adcl %edx, %ebp
mull 48(%esp)
movl %esi, 60(%esp)
shll $6, %edi
shrl $26, %esi
orl %esi, %edi
addl %edi, %eax
movl 20(%esp), %esi
adcl $0, %edx
addl %eax, %ebx
movl 56(%esp), %eax
movl %ebx, %edi
adcl %edx, %ebp
addl %esi, %esi
mull %ecx
shll $6, %ebp
andl $67108863, %edi
shrl $26, %ebx
movl %edi, 68(%esp)
movl %eax, %edi
movl 8(%esp), %eax
orl %ebx, %ebp
movl %edx, %ebx
mull %esi
addl %eax, %edi
movl 24(%esp), %eax
adcl %edx, %ebx
movd 68(%esp), %xmm7
movdqa poly1305_x64_sse2_5, %xmm2
lea (%eax,%eax,4), %edx
mull %edx
addl %eax, %edi
movl %ecx, %eax
movdqa poly1305_x64_sse2_message_mask, %xmm3
adcl %edx, %ebx
addl %edi, %ebp
movl %ebp, %edi
adcl $0, %ebx
andl $67108863, %edi
mull %ecx
shll $6, %ebx
movl %eax, %ecx
shrl $26, %ebp
movd %edi, %xmm0
movl 12(%esp), %eax
orl %ebp, %ebx
movl %edx, %ebp
mull %esi
addl %eax, %ecx
movl 64(%esp), %eax
adcl %edx, %ebp
mull 24(%esp)
addl %eax, %ecx
movl 52(%esp), %esi
adcl %edx, %ebp
addl %ecx, %ebx
movl %ebx, %eax
adcl $0, %ebp
andl $67108863, %esi
shll $6, %ebp
andl $67108863, %eax
shrl $26, %ebx
orl %ebx, %ebp
movl %eax, 76(%esp)
movl %edi, 72(%esp)
lea (%eax,%eax), %edx
movl %edx, 88(%esp)
lea (%edi,%edi,4), %edi
movl %edi, 84(%esp)
lea (%ebp,%ebp,4), %ecx
addl %ecx, %esi
movl %esi, %ebx
andl $67108863, %ebx
movl 60(%esp), %ecx
shrl $26, %esi
andl $67108863, %ecx
addl %esi, %ecx
movl 4(%esp), %ebp
movd %ebx, %xmm4
pshufd $68, %xmm4, %xmm5
movd %eax, %xmm4
movl %ebx, %eax
movd %ecx, %xmm6
mull %ebx
movdqa %xmm5, 144(%ebp)
movl %edx, %esi
pshufd $68, %xmm6, %xmm1
pshufd $68, %xmm7, %xmm5
pshufd $68, %xmm0, %xmm6
pshufd $68, %xmm4, %xmm0
movdqa %xmm1, 160(%ebp)
movdqa %xmm5, 176(%ebp)
movdqa %xmm6, 192(%ebp)
movdqa %xmm0, 208(%ebp)
pmuludq %xmm2, %xmm1
pmuludq %xmm2, %xmm5
pmuludq %xmm2, %xmm6
pmuludq %xmm2, %xmm0
movl 68(%esp), %edi
movdqa %xmm1, 224(%ebp)
movdqa %xmm5, 240(%ebp)
movdqa %xmm6, 256(%ebp)
addl %edi, %edi
movdqa %xmm0, 272(%ebp)
movl %eax, %ebp
movl 84(%esp), %eax
mull %edi
addl %eax, %ebp
lea (%ecx,%ecx,4), %eax
movl %ecx, 60(%esp)
lea (%ecx,%ecx), %ecx
adcl %edx, %esi
mull 88(%esp)
addl %eax, %ebp
movl %ebx, %eax
movl %ecx, 96(%esp)
adcl %edx, %esi
mull %ecx
movl %eax, %ecx
movl 84(%esp), %eax
movl %ebx, 80(%esp)
movl %edx, %ebx
mull 72(%esp)
movl 68(%esp), %edi
addl %eax, %ecx
movl %ebp, 92(%esp)
adcl %edx, %ebx
shll $6, %esi
lea (%edi,%edi,4), %eax
mull 88(%esp)
shrl $26, %ebp
orl %ebp, %esi
addl %esi, %eax
movl 80(%esp), %esi
adcl $0, %edx
addl %eax, %ecx
movl 60(%esp), %eax
adcl %edx, %ebx
lea (%esi,%esi), %ebp
mull %eax
movl %ebp, 104(%esp)
movl %eax, %ebp
movl %edi, %eax
movl %edx, %esi
mull 104(%esp)
addl %eax, %ebp
movl 84(%esp), %eax
adcl %edx, %esi
mull 88(%esp)
movl %ecx, 100(%esp)
shll $6, %ebx
shrl $26, %ecx
orl %ecx, %ebx
addl %ebx, %eax
movl 72(%esp), %ebx
adcl $0, %edx
addl %eax, %ebp
movl 96(%esp), %eax
adcl %edx, %esi
addl %ebx, %ebx
mull %edi
movl %ebp, 108(%esp)
movl %edx, %ecx
shll $6, %esi
shrl $26, %ebp
orl %ebp, %esi
movl %eax, %ebp
movl 80(%esp), %eax
mull %ebx
addl %eax, %ebp
movl 76(%esp), %eax
adcl %edx, %ecx
lea (%eax,%eax,4), %edx
mull %edx
addl %eax, %ebp
movl %edi, %eax
adcl %edx, %ecx
addl %ebp, %esi
movl %esi, %ebp
adcl $0, %ecx
andl $67108863, %esi
mull %edi
shll $6, %ecx
movl %edx, %edi
shrl $26, %ebp
movd %esi, %xmm4
orl %ebp, %ecx
movl %eax, %ebp
movl 60(%esp), %eax
mull %ebx
addl %eax, %ebp
movl 104(%esp), %eax
adcl %edx, %edi
mull 76(%esp)
addl %eax, %ebp
movl 92(%esp), %ebx
adcl %edx, %edi
addl %ebp, %ecx
movl %ecx, %ebp
adcl $0, %edi
andl $67108863, %ebx
shll $6, %edi
andl $67108863, %ecx
shrl $26, %ebp
orl %ebp, %edi
movl 100(%esp), %ebp
andl $67108863, %ebp
movd %ecx, %xmm5
movl 8(%esp), %edx
movl 12(%esp), %ecx
lea (%edi,%edi,4), %edi
addl %edi, %ebx
movl %ebx, %eax
shrl $26, %ebx
andl $67108863, %eax
addl %ebp, %ebx
movl 20(%esp), %ebp
movl 24(%esp), %esi
movd %eax, %xmm1
movd %ebx, %xmm0
movl 108(%esp), %ebx
andl $67108863, %ebx
movl 4(%esp), %eax
pshufd $68, %xmm1, %xmm7
pshufd $68, %xmm0, %xmm0
movd %ebx, %xmm1
pshufd $68, %xmm1, %xmm6
pshufd $68, %xmm4, %xmm1
pshufd $68, %xmm5, %xmm4
movdqa %xmm0, 16(%eax)
movdqa %xmm6, 32(%eax)
movdqa %xmm1, 48(%eax)
movdqa %xmm4, 64(%eax)
pmuludq %xmm2, %xmm0
pmuludq %xmm2, %xmm6
pmuludq %xmm2, %xmm1
pmuludq %xmm2, %xmm4
movl 16(%esp), %ebx
movdqa %xmm3, %xmm2
movl %ebp, 172(%eax)
movl (%esp), %ebp
movl %edx, 148(%eax)
movl %ecx, 156(%eax)
movl %ebx, 164(%eax)
movl 28(%esp), %edi
movl 32(%esp), %edx
movl 36(%esp), %ecx
movl 40(%esp), %ebx
movdqa %xmm7, (%eax)
movdqa %xmm0, 80(%eax)
movdqa %xmm6, 96(%eax)
movdqa %xmm1, 112(%eax)
movdqa %xmm4, 128(%eax)
movdqa %xmm3, %xmm4
movl %esi, 180(%eax)
movl %edi, 196(%eax)
movl %edx, 204(%eax)
movl %ecx, 212(%eax)
movl %ebx, 220(%eax)
movq 8(%ebp), %xmm6
movq (%ebp), %xmm5
movhpd 24(%ebp), %xmm6
movhpd 16(%ebp), %xmm5
movaps %xmm6, %xmm1
pand %xmm5, %xmm2
movaps %xmm5, %xmm0
psrlq $52, %xmm5
psllq $12, %xmm1
por %xmm1, %xmm5
psrlq $40, %xmm6
psrlq $26, %xmm0
pand %xmm5, %xmm4
psrlq $26, %xmm5
pand %xmm3, %xmm0
por poly1305_x64_sse2_1shl128, %xmm6
pand %xmm5, %xmm3
movdqa %xmm2, 288(%eax)
movdqa %xmm0, 304(%eax)
movdqa %xmm4, 320(%eax)
movdqa %xmm3, 336(%eax)
movdqa %xmm6, 352(%eax)
addl $124, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret



.align 16,0x90
.globl poly1305_finish
poly1305_finish:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
subl $108, %esp
movl 128(%esp), %eax
lea 63(%eax), %eax
andl $-64, %eax
movl %eax, 48(%esp)
movl 372(%eax), %edx
lea 376(%eax), %ecx
movl %edx, 92(%esp)
movl %ecx, 88(%esp)
cmpl $0, 368(%eax)
je L4_4
movl %ecx, %edx
movl 92(%esp), %ecx
call poly1305_combine
movl 48(%esp), %edx
subl %eax, 92(%esp)
lea 376(%eax,%edx), %eax
movl %eax, 88(%esp)
L4_4:
movl 48(%esp), %edi
cmpl $16, 92(%esp)
movl 148(%edi), %esi
movl 300(%edi), %ebp
movl 296(%edi), %ebx
movl %esi, 80(%esp)
movl %ebp, 60(%esp)
movl 156(%edi), %esi
movl 164(%edi), %ebp
movl %ebx, 56(%esp)
movl 172(%edi), %ebx
movl 180(%edi), %ecx
movl 292(%edi), %eax
movl %eax, 52(%esp)
movl 288(%edi), %edx
movl 304(%edi), %eax
lea (%esi,%esi,4), %edi
movl %edi, 76(%esp)
lea (%ebp,%ebp,4), %edi
movl %ecx, 84(%esp)
lea (%ecx,%ecx,4), %ecx
movl %edi, 72(%esp)
lea (%ebx,%ebx,4), %edi
movl %edi, 68(%esp)
movl %ecx, 64(%esp)
jb L4_6
movl %eax, 44(%esp)
movl %edx, 40(%esp)
movl %ebx, 16(%esp)
movl %ebp, 20(%esp)
movl %esi, 24(%esp)
jmp L4_18
L4_6:
movl %ebx, 16(%esp)
movl %ebp, 20(%esp)
movl %esi, 24(%esp)
movl 92(%esp), %ecx
L4_7:
testl %ecx, %ecx
je L4_20
movl 88(%esp), %ebx
lea 1(%ecx), %ebp
movb $1, (%ecx,%ebx)
lea 1(%ebx,%ecx), %ebx
movl %ebp, %ecx
negl %ecx
testb $8, %cl
je L4_10
movl 88(%esp), %edi
xorl %esi, %esi
addl $8, %ebx
movl %esi, (%ebp,%edi)
movl %esi, 4(%ebp,%edi)
L4_10:
testb $4, %cl
je L4_12
movl $0, (%ebx)
addl $4, %ebx
L4_12:
testb $2, %cl
je L4_14
xorl %ebp, %ebp
movw %bp, (%ebx)
addl $2, %ebx
L4_14:
testb $1, %cl
je L4_16
movb $0, (%ebx)
L4_16:
movl 88(%esp), %ebx
movl (%ebx), %esi
movl 4(%ebx), %edi
movl 8(%ebx), %ebp
movl 12(%ebx), %ecx
movl %esi, %ebx
andl $67108863, %ebx
addl %ebx, %edx
movl %edi, %ebx
shll $6, %ebx
shrl $26, %esi
orl %esi, %ebx
movl %ebp, %esi
shll $12, %esi
andl $67108863, %ebx
shrl $20, %edi
orl %edi, %esi
movl %ecx, %edi
shll $18, %edi
andl $67108863, %esi
shrl $14, %ebp
orl %ebp, %edi
shrl $8, %ecx
andl $67108863, %edi
addl 52(%esp), %ebx
addl %ecx, %eax
addl 56(%esp), %esi
movl $16, %ecx
addl 60(%esp), %edi
movl %ecx, 92(%esp)
movl %eax, 44(%esp)
movl %edi, 36(%esp)
movl %esi, 32(%esp)
movl %ebx, 28(%esp)
movl %edx, 40(%esp)
L4_17:
movl 80(%esp), %eax
movl 40(%esp), %edi
mull %edi
movl %eax, %esi
movl %edx, %ecx
movl 28(%esp), %eax
mull 64(%esp)
addl %eax, %esi
movl 32(%esp), %eax
adcl %edx, %ecx
mull 68(%esp)
addl %eax, %esi
movl 36(%esp), %eax
adcl %edx, %ecx
mull 72(%esp)
movl %eax, %ebp
movl %edx, %ebx
movl 44(%esp), %eax
mull 76(%esp)
addl %eax, %ebp
movl %edi, %eax
adcl %edx, %ebx
addl %ebp, %esi
movl %esi, 96(%esp)
adcl %ebx, %ecx
mull 24(%esp)
movl %ecx, %ebp
shll $6, %ebp
shrl $26, %esi
orl %esi, %ebp
shrl $26, %ecx
addl %eax, %ebp
movl 80(%esp), %eax
adcl %edx, %ecx
mull 28(%esp)
movl %eax, %ebx
movl %edx, %esi
movl 64(%esp), %eax
mull 32(%esp)
addl %eax, %ebx
movl 68(%esp), %eax
adcl %edx, %esi
addl %ebx, %ebp
adcl %esi, %ecx
mull 36(%esp)
movl %eax, %ebx
movl %edx, %esi
movl 72(%esp), %eax
mull 44(%esp)
addl %eax, %ebx
movl %edi, %eax
adcl %edx, %esi
addl %ebx, %ebp
movl %ebp, %ebx
adcl %esi, %ecx
andl $67108863, %ebx
mull 20(%esp)
movl %eax, %edi
movl 28(%esp), %eax
movl %ebx, 52(%esp)
movl %edx, %ebx
mull 24(%esp)
addl %eax, %edi
movl 80(%esp), %eax
adcl %edx, %ebx
mull 32(%esp)
addl %eax, %edi
movl 64(%esp), %eax
adcl %edx, %ebx
mull 36(%esp)
shll $6, %ecx
movl %eax, %esi
movl 68(%esp), %eax
shrl $26, %ebp
orl %ebp, %ecx
movl %edx, %ebp
mull 44(%esp)
addl %eax, %esi
movl 40(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
adcl %ebp, %ebx
addl %edi, %ecx
movl %ecx, %edi
adcl $0, %ebx
andl $67108863, %edi
mull 16(%esp)
movl %edi, 56(%esp)
movl %eax, %edi
shll $6, %ebx
shrl $26, %ecx
movl 28(%esp), %eax
orl %ecx, %ebx
movl %edx, %ecx
mull 20(%esp)
addl %eax, %edi
movl 32(%esp), %eax
adcl %edx, %ecx
mull 24(%esp)
addl %eax, %edi
movl 80(%esp), %eax
adcl %edx, %ecx
mull 36(%esp)
movl %eax, %esi
movl %edx, %ebp
movl 64(%esp), %eax
mull 44(%esp)
addl %eax, %esi
movl 40(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
adcl %ebp, %ecx
addl %edi, %ebx
movl %ebx, %ebp
adcl $0, %ecx
andl $67108863, %ebp
mull 84(%esp)
shll $6, %ecx
movl %eax, %edi
movl 28(%esp), %eax
shrl $26, %ebx
orl %ebx, %ecx
movl %edx, %ebx
mull 16(%esp)
addl %eax, %edi
movl 32(%esp), %eax
adcl %edx, %ebx
mull 20(%esp)
addl %eax, %edi
movl 36(%esp), %eax
adcl %edx, %ebx
mull 24(%esp)
movl %eax, %esi
movl 80(%esp), %eax
movl %ebp, 60(%esp)
movl %edx, %ebp
mull 44(%esp)
addl %eax, %esi
movl 88(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
movl 92(%esp), %edx
adcl %ebp, %ebx
addl %edi, %ecx
movl %ecx, %esi
adcl $0, %ebx
addl $-16, %edx
shll $6, %ebx
andl $67108863, %esi
shrl $26, %ecx
addl $16, %eax
orl %ecx, %ebx
movl 96(%esp), %edi
andl $67108863, %edi
movl %esi, 44(%esp)
movl %eax, 88(%esp)
lea (%ebx,%ebx,4), %ecx
addl %edi, %ecx
movl %ecx, 40(%esp)
cmpl $16, %edx
movl %edx, 92(%esp)
jb L4_19
L4_18:
movl 88(%esp), %ebx
movl 8(%ebx), %edx
movl (%ebx), %esi
movl %esi, %ebp
movl 4(%ebx), %ecx
movl %ecx, %edi
movl 12(%ebx), %eax
movl %edx, %ebx
shll $12, %ebx
andl $67108863, %ebp
shrl $20, %ecx
orl %ecx, %ebx
movl %eax, %ecx
shll $6, %edi
andl $67108863, %ebx
shrl $26, %esi
shll $18, %ecx
orl %esi, %edi
shrl $14, %edx
andl $67108863, %edi
orl %edx, %ecx
shrl $8, %eax
andl $67108863, %ecx
addl 52(%esp), %edi
orl $16777216, %eax
addl 56(%esp), %ebx
addl 60(%esp), %ecx
addl %ebp, 40(%esp)
addl %eax, 44(%esp)
movl %edi, 28(%esp)
movl %ebx, 32(%esp)
movl %ecx, 36(%esp)
jmp L4_17
L4_19:
movl %edx, %ecx
movl %esi, %eax
movl 40(%esp), %edx
jmp L4_7
L4_20:
movl %edx, %ebx
andl $67108863, %edx
shrl $26, %ebx
movl 52(%esp), %ebp
addl %ebx, %ebp
movl %ebp, %ebx
shrl $26, %ebp
andl $67108863, %ebx
movl 56(%esp), %ecx
addl %ebp, %ecx
movl %ecx, %esi
shrl $26, %ecx
andl $67108863, %esi
movl 60(%esp), %edi
addl %ecx, %edi
movl %edi, %ebp
shrl $26, %edi
andl $67108863, %ebp
addl %edi, %eax
movl %eax, %ecx
shrl $26, %eax
andl $67108863, %ecx
movl %ecx, 16(%esp)
lea (%eax,%eax,4), %edi
lea (%edx,%edi), %eax
movl %eax, 20(%esp)
lea 5(%edi,%edx), %eax
movl %eax, 24(%esp)
shrl $26, %eax
addl %ebx, %eax
movl %eax, %edi
andl $67108863, %eax
shrl $26, %edi
addl %esi, %edi
movl %edi, %edx
andl $67108863, %edi
shrl $26, %edx
addl %ebp, %edx
movl %edx, 28(%esp)
shrl $26, %edx
lea -67108864(%edx,%ecx), %ecx
movl %ecx, 32(%esp)
shrl $31, %ecx
decl %ecx
movl %ecx, %edx
andl %ecx, %edi
notl %edx
andl %ecx, %eax
andl %edx, %esi
andl %edx, %ebx
orl %edi, %esi
orl %eax, %ebx
movl 28(%esp), %edi
andl %edx, %ebp
andl $67108863, %edi
movl 24(%esp), %eax
andl %ecx, %edi
andl $67108863, %eax
orl %edi, %ebp
movl 20(%esp), %edi
andl %ecx, %eax
andl %edx, %edi
movl %ecx, 36(%esp)
movl %ebx, %ecx
orl %eax, %edi
movl 48(%esp), %eax
shll $26, %ecx
orl %ecx, %edi
xorl %ecx, %ecx
addl 196(%eax), %edi
movl %edi, 20(%esp)
movl %ecx, %edi
adcl $0, %edi
movl %edi, 40(%esp)
movl %esi, %edi
shrl $6, %ebx
shll $20, %edi
orl %edi, %ebx
xorl %edi, %edi
addl 204(%eax), %ebx
adcl $0, %edi
movl %edi, 44(%esp)
movl %ebp, %edi
shrl $12, %esi
shll $14, %edi
orl %edi, %esi
movl 32(%esp), %edi
andl 16(%esp), %edx
andl 36(%esp), %edi
orl %edi, %edx
addl 212(%eax), %esi
movl 132(%esp), %edi
adcl $0, %ecx
shrl $18, %ebp
shll $8, %edx
orl %edx, %ebp
addl 40(%esp), %ebx
movl 44(%esp), %edx
adcl $0, %edx
addl %edx, %esi
adcl $0, %ecx
addl 220(%eax), %ebp
movl 20(%esp), %eax
addl %ecx, %ebp
movl %eax, (%edi)
movl %ebx, 4(%edi)
movl %esi, 8(%edi)
movl %ebp, 12(%edi)
addl $108, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret


.align 16,0x90
poly1305_combine:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
movl %esp, 132(%eax)
andl $~63, %esp
subl $256, %esp
movdqa poly1305_x64_sse2_message_mask, %xmm0
cmpl $32, %ecx
movdqa poly1305_x64_sse2_1shl128, %xmm1
movdqa poly1305_x64_sse2_5, %xmm2
movdqa 304(%eax), %xmm3
movdqa %xmm0, 144(%esp)
movdqa %xmm1, 224(%esp)
movdqa %xmm2, 128(%esp)
movdqa 288(%eax), %xmm0
movdqa 320(%eax), %xmm6
movdqa 336(%eax), %xmm1
movdqa 352(%eax), %xmm4
movdqa %xmm3, 160(%esp)
jb L5_3
movdqa 208(%eax), %xmm5
pmuludq %xmm0, %xmm5
movdqa 224(%eax), %xmm2
movq (%edx), %xmm3
movdqa %xmm4, 208(%esp)
pmuludq %xmm4, %xmm2
movhpd 16(%edx), %xmm3
movq 8(%edx), %xmm4
movaps %xmm3, %xmm7
movhpd 24(%edx), %xmm4
psrlq $52, %xmm7
movdqa %xmm5, 16(%esp)
movl $32, %edx
movaps %xmm4, 48(%esp)
psllq $12, %xmm4
movdqa 160(%esp), %xmm5
por %xmm4, %xmm7
movdqa %xmm7, 64(%esp)
movdqa %xmm0, %xmm4
movdqa %xmm5, %xmm7
pmuludq 144(%eax), %xmm4
pmuludq 272(%eax), %xmm7
paddq %xmm7, %xmm4
movdqa %xmm6, %xmm7
pmuludq 256(%eax), %xmm7
paddq %xmm7, %xmm4
movdqa %xmm1, %xmm7
pmuludq 240(%eax), %xmm7
paddq %xmm7, %xmm4
paddq %xmm2, %xmm4
movdqa 144(%esp), %xmm2
movdqa %xmm2, %xmm7
pand %xmm3, %xmm7
movaps %xmm3, 32(%esp)
movdqa %xmm5, %xmm3
paddq %xmm7, %xmm4
pmuludq 176(%eax), %xmm3
movdqa %xmm0, %xmm7
pmuludq 192(%eax), %xmm7
paddq %xmm3, %xmm7
movdqa 160(%eax), %xmm3
movdqa %xmm6, 192(%esp)
pmuludq %xmm3, %xmm6
paddq %xmm6, %xmm7
movdqa 144(%eax), %xmm6
movdqa %xmm1, (%esp)
pmuludq %xmm6, %xmm1
movdqa %xmm4, 80(%esp)
paddq %xmm1, %xmm7
movdqa 208(%esp), %xmm1
movdqa 272(%eax), %xmm4
pmuludq %xmm4, %xmm1
paddq %xmm1, %xmm7
movdqa 64(%esp), %xmm1
psrlq $26, %xmm1
pand %xmm2, %xmm1
paddq %xmm1, %xmm7
movdqa %xmm7, 96(%esp)
movdqa %xmm5, %xmm7
movdqa %xmm0, 176(%esp)
pmuludq %xmm3, %xmm0
pmuludq %xmm6, %xmm7
paddq %xmm7, %xmm0
movdqa 192(%esp), %xmm7
movdqa %xmm7, %xmm6
movdqa (%esp), %xmm1
pmuludq %xmm4, %xmm6
movdqa %xmm1, %xmm4
pmuludq 256(%eax), %xmm4
paddq %xmm6, %xmm0
paddq %xmm4, %xmm0
movdqa 240(%eax), %xmm4
movdqa 208(%esp), %xmm6
pmuludq %xmm6, %xmm4
paddq %xmm4, %xmm0
movaps 32(%esp), %xmm4
psrlq $26, %xmm4
pand %xmm2, %xmm4
movdqa 80(%esp), %xmm2
paddq %xmm4, %xmm0
psrlq $26, %xmm2
paddq %xmm2, %xmm0
movdqa %xmm0, 112(%esp)
movdqa 192(%eax), %xmm0
pmuludq %xmm5, %xmm0
pmuludq %xmm3, %xmm5
movdqa 16(%esp), %xmm4
paddq %xmm0, %xmm4
movdqa 176(%eax), %xmm2
movdqa %xmm7, %xmm0
pmuludq %xmm2, %xmm0
paddq %xmm0, %xmm4
movdqa %xmm1, %xmm0
pmuludq %xmm3, %xmm0
pmuludq 272(%eax), %xmm1
paddq %xmm0, %xmm4
movdqa %xmm6, %xmm0
movdqa 144(%eax), %xmm6
pmuludq %xmm6, %xmm0
pmuludq %xmm6, %xmm7
paddq %xmm0, %xmm4
movaps 48(%esp), %xmm0
psrlq $40, %xmm0
por 224(%esp), %xmm0
paddq %xmm0, %xmm4
movdqa 96(%esp), %xmm0
psrlq $26, %xmm0
paddq %xmm0, %xmm4
movdqa 176(%esp), %xmm0
pmuludq %xmm2, %xmm0
movdqa %xmm4, %xmm2
paddq %xmm5, %xmm0
movdqa 208(%esp), %xmm3
psrlq $26, %xmm2
pmuludq 256(%eax), %xmm3
pmuludq 128(%esp), %xmm2
paddq %xmm7, %xmm0
paddq %xmm1, %xmm0
movdqa 64(%esp), %xmm5
paddq %xmm3, %xmm0
movdqa 144(%esp), %xmm3
movdqa 112(%esp), %xmm7
pand %xmm3, %xmm5
movdqa %xmm7, %xmm6
pand %xmm3, %xmm7
paddq %xmm5, %xmm0
psrlq $26, %xmm6
pand %xmm3, %xmm4
paddq %xmm0, %xmm6
movdqa 80(%esp), %xmm1
movdqa %xmm6, %xmm0
movdqa 96(%esp), %xmm5
pand %xmm3, %xmm1
pand %xmm3, %xmm5
psrlq $26, %xmm0
paddq %xmm2, %xmm1
paddq %xmm0, %xmm5
movdqa %xmm3, %xmm0
pand %xmm3, %xmm6
pand %xmm1, %xmm0
psrlq $26, %xmm1
paddq %xmm1, %xmm7
movdqa %xmm3, %xmm1
pand %xmm5, %xmm1
psrlq $26, %xmm5
movdqa %xmm7, 160(%esp)
paddq %xmm5, %xmm4
jmp L5_4
L5_3:
xorl %edx, %edx
L5_4:
movl 180(%eax), %ecx
movdqa %xmm0, %xmm7
movl %ecx, 216(%eax)
movdqa 208(%eax), %xmm3
pmuludq %xmm0, %xmm3
lea (%ecx,%ecx,4), %ecx
movl %edx, 64(%esp)
movl 148(%eax), %edx
movdqa %xmm3, (%esp)
movl %edx, 152(%eax)
movdqa 160(%esp), %xmm3
movl %ecx, 280(%eax)
movdqa %xmm3, %xmm2
movdqa 144(%eax), %xmm5
pmuludq %xmm5, %xmm7
pmuludq 272(%eax), %xmm2
movl 172(%eax), %edi
movl %edi, 200(%eax)
paddq %xmm2, %xmm7
movdqa %xmm6, %xmm2
lea (%edi,%edi,4), %edi
movl %edi, 264(%eax)
pmuludq 256(%eax), %xmm2
movl 164(%eax), %esi
paddq %xmm2, %xmm7
movdqa %xmm1, %xmm2
lea (%esi,%esi,4), %edx
movl %edx, 248(%eax)
pmuludq 240(%eax), %xmm2
movl 156(%eax), %ebx
paddq %xmm2, %xmm7
movl %esi, 184(%eax)
lea (%ebx,%ebx,4), %ebp
movl %ebp, 232(%eax)
movdqa 224(%eax), %xmm2
pmuludq %xmm4, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm7, 16(%esp)
movdqa %xmm0, %xmm7
movdqa %xmm3, %xmm2
pmuludq 192(%eax), %xmm7
pmuludq 176(%eax), %xmm2
movl %ebx, 168(%eax)
paddq %xmm2, %xmm7
movdqa 160(%eax), %xmm2
movdqa %xmm6, 192(%esp)
pmuludq %xmm2, %xmm6
paddq %xmm6, %xmm7
movdqa %xmm1, %xmm6
pmuludq %xmm5, %xmm6
paddq %xmm6, %xmm7
movdqa 272(%eax), %xmm6
movdqa %xmm4, 208(%esp)
pmuludq %xmm6, %xmm4
paddq %xmm4, %xmm7
movdqa %xmm7, 32(%esp)
movdqa %xmm3, %xmm7
movdqa %xmm0, 176(%esp)
pmuludq %xmm2, %xmm0
pmuludq %xmm5, %xmm7
movdqa 192(%esp), %xmm4
paddq %xmm7, %xmm0
movdqa %xmm4, %xmm7
pmuludq %xmm6, %xmm7
movdqa %xmm1, %xmm6
pmuludq 256(%eax), %xmm6
paddq %xmm7, %xmm0
paddq %xmm6, %xmm0
movdqa 240(%eax), %xmm6
movdqa 208(%esp), %xmm7
pmuludq %xmm7, %xmm6
paddq %xmm6, %xmm0
movdqa 16(%esp), %xmm6
psrlq $26, %xmm6
paddq %xmm6, %xmm0
movdqa %xmm0, 48(%esp)
movdqa 192(%eax), %xmm0
pmuludq %xmm3, %xmm0
pmuludq %xmm2, %xmm3
movdqa (%esp), %xmm6
paddq %xmm0, %xmm6
movdqa %xmm4, %xmm0
movdqa 176(%eax), %xmm4
pmuludq %xmm4, %xmm0
paddq %xmm0, %xmm6
movdqa %xmm1, %xmm0
pmuludq %xmm2, %xmm0
pmuludq 272(%eax), %xmm1
paddq %xmm0, %xmm6
movdqa %xmm7, %xmm0
pmuludq %xmm5, %xmm0
pmuludq 256(%eax), %xmm7
paddq %xmm0, %xmm6
movdqa 32(%esp), %xmm0
psrlq $26, %xmm0
paddq %xmm0, %xmm6
movdqa 176(%esp), %xmm0
pmuludq %xmm4, %xmm0
paddq %xmm3, %xmm0
movdqa 192(%esp), %xmm3
pmuludq %xmm5, %xmm3
paddq %xmm3, %xmm0
movdqa %xmm6, %xmm3
psrlq $26, %xmm3
pmuludq 128(%esp), %xmm3
paddq %xmm1, %xmm0
movdqa 16(%esp), %xmm4
paddq %xmm7, %xmm0
movdqa 144(%esp), %xmm7
pand %xmm7, %xmm4
movdqa %xmm7, %xmm2
paddq %xmm3, %xmm4
movdqa 48(%esp), %xmm1
pand %xmm4, %xmm2
movdqa %xmm1, %xmm5
pand %xmm7, %xmm1
psrlq $26, %xmm4
psrlq $26, %xmm5
paddq %xmm4, %xmm1
paddq %xmm5, %xmm0
movdqa %xmm2, %xmm4
movdqa %xmm7, %xmm3
psrldq $8, %xmm4
pand %xmm0, %xmm3
paddq %xmm4, %xmm2
movd %xmm2, %esi
movdqa %xmm1, %xmm2
psrldq $8, %xmm2
psrlq $26, %xmm0
movdqa 32(%esp), %xmm5
pand %xmm7, %xmm6
paddq %xmm2, %xmm1
pand %xmm7, %xmm5
movl %esi, %edx
paddq %xmm0, %xmm5
movd %xmm1, %ebp
movdqa %xmm3, %xmm1
movdqa %xmm7, %xmm0
psrldq $8, %xmm1
pand %xmm5, %xmm0
paddq %xmm1, %xmm3
movdqa %xmm0, %xmm2
psrlq $26, %xmm5
shrl $26, %edx
andl $67108863, %esi
psrldq $8, %xmm2
addl %edx, %ebp
movd %xmm3, %ebx
movl %ebp, %edi
paddq %xmm5, %xmm6
paddq %xmm2, %xmm0
shrl $26, %edi
andl $67108863, %ebp
movd %xmm0, %ecx
movdqa %xmm6, %xmm0
psrldq $8, %xmm0
paddq %xmm0, %xmm6
addl %edi, %ebx
movl %ebx, %edx
andl $67108863, %ebx
shrl $26, %edx
addl %edx, %ecx
movd %xmm6, %edx
movl %ecx, %edi
shrl $26, %edi
andl $67108863, %ecx
addl %edi, %edx
movl %edx, %edi
andl $67108863, %edx
shrl $26, %edi
movl %ebp, 292(%eax)
movl %ebx, 296(%eax)
movl %ecx, 300(%eax)
movl %edx, 304(%eax)
lea (%edi,%edi,4), %edi
addl %edi, %esi
movl %esi, 288(%eax)
movl 132(%eax), %edx
movl 64(%esp), %eax
movl %edx, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret


.align 16,0x90
.globl poly1305_auth
poly1305_auth:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
subl $620, %esp
movl 652(%esp), %edi
lea 79(%esp), %ebp
andl $-64, %ebp
pxor %xmm0, %xmm0
movl (%edi), %eax
movl %eax, %esi
movl 4(%edi), %edx
andl $67108863, %esi
movl %esi, 148(%ebp)
movl %edx, %esi
shrl $26, %eax
shll $6, %esi
orl %esi, %eax
movl 8(%edi), %ecx
andl $67108611, %eax
movl %eax, 156(%ebp)
movl %ecx, %eax
shrl $20, %edx
shll $12, %eax
orl %eax, %edx
movl 12(%edi), %ebx
andl $67092735, %edx
movl %edx, 164(%ebp)
movl %ebx, %edx
shrl $14, %ecx
shll $18, %edx
shrl $8, %ebx
orl %edx, %ecx
andl $66076671, %ecx
andl $1048575, %ebx
movl %ecx, 172(%ebp)
movl %ebx, 180(%ebp)
movl 16(%edi), %ecx
movl 20(%edi), %ebx
movl 24(%edi), %eax
movl 28(%edi), %edi
movl %eax, 212(%ebp)
xorl %eax, %eax
movl %ecx, 196(%ebp)
movl %ebx, 204(%ebp)
movl %edi, 220(%ebp)
movdqa %xmm0, 288(%ebp)
movdqa %xmm0, 304(%ebp)
movdqa %xmm0, 320(%ebp)
movdqa %xmm0, 336(%ebp)
movdqa %xmm0, 352(%ebp)
movl %eax, 368(%ebp)
movl %eax, 372(%ebp)
movl 648(%esp), %eax
cmpl $32, %eax
jbe L6_5
movl %ebp, %eax
movl 644(%esp), %edx
call poly1305_first_block
movl 644(%esp), %esi
lea 376(%ebp), %ecx
movl 648(%esp), %edx
movl %ecx, 536(%esp)
lea 32(%esi), %eax
movl %eax, 532(%esp)
lea -32(%edx), %esi
jmp L6_23
L6_5:
movl $32, %eax
movl 648(%esp), %edx
cmova %eax, %edx
testb $32, %dl
je L6_7
movl 644(%esp), %ecx
movdqu (%ecx), %xmm0
movdqu 16(%ecx), %xmm1
movdqu %xmm0, 376(%ebp)
movdqu %xmm1, 392(%ebp)
jmp L6_8
L6_7:
xorl %eax, %eax
L6_8:
testb $16, %dl
je L6_10
movl 644(%esp), %ecx
movdqu (%eax,%ecx), %xmm0
movdqu %xmm0, 376(%eax,%ebp)
addl $16, %eax
L6_10:
testb $8, %dl
je L6_12
movl 644(%esp), %ecx
movl (%eax,%ecx), %ebx
movl 4(%eax,%ecx), %esi
movl %ebx, 376(%eax,%ebp)
movl %esi, 380(%eax,%ebp)
addl $8, %eax
L6_12:
testb $4, %dl
je L6_14
movl 644(%esp), %ecx
movl (%eax,%ecx), %ebx
movl %ebx, 376(%eax,%ebp)
addl $4, %eax
L6_14:
testb $2, %dl
je L6_16
movl 644(%esp), %ecx
movzwl (%eax,%ecx), %ebx
movw %bx, 376(%eax,%ebp)
addl $2, %eax
L6_16:
testb $1, %dl
je L6_18
movl 644(%esp), %esi
movzbl (%eax,%esi), %ecx
movb %cl, 376(%eax,%ebp)
L6_18:
movl 644(%esp), %eax
movl 372(%ebp), %ebx
addl %edx, %ebx
movl 648(%esp), %esi
lea (%eax,%edx), %ecx
subl %edx, %esi
movl %ecx, 532(%esp)
cmpl $32, %ebx
movl %ebx, 372(%ebp)
jae L6_20
lea 376(%ebp), %eax
movl %eax, 536(%esp)
jmp L6_59
L6_20:
testl %esi, %esi
lea 376(%ebp), %eax
movl %eax, 536(%esp)
je L6_59
movl %ebp, %eax
movl 536(%esp), %edx
call poly1305_first_block
movl $0, 372(%ebp)
L6_23:
movl 372(%ebp), %ebx
testl %ebx, %ebx
movl $1, 368(%ebp)
je L6_41
movl %ebx, %ecx
addl %ebp, %ebx
negl %ecx
addl $64, %ecx
cmpl %esi, %ecx
cmovae %esi, %ecx
testb $32, %cl
je L6_26
movl 532(%esp), %eax
movl $32, %edx
movdqu (%eax), %xmm0
movdqu 16(%eax), %xmm1
movdqu %xmm0, 376(%ebx)
movdqu %xmm1, 392(%ebx)
jmp L6_27
L6_26:
xorl %edx, %edx
L6_27:
testb $16, %cl
je L6_29
movl 532(%esp), %eax
movdqu (%edx,%eax), %xmm0
movdqu %xmm0, 376(%edx,%ebx)
addl $16, %edx
L6_29:
testb $8, %cl
je L6_31
movl 532(%esp), %eax
movl %ecx, 528(%esp)
movl (%edx,%eax), %ecx
movl 4(%edx,%eax), %edi
movl %ecx, 376(%edx,%ebx)
movl %edi, 380(%edx,%ebx)
addl $8, %edx
movl 528(%esp), %ecx
L6_31:
testb $4, %cl
je L6_33
movl 532(%esp), %eax
movl (%edx,%eax), %edi
movl %edi, 376(%edx,%ebx)
addl $4, %edx
L6_33:
testb $2, %cl
je L6_35
movl 532(%esp), %eax
movzwl (%edx,%eax), %edi
movw %di, 376(%edx,%ebx)
addl $2, %edx
L6_35:
testb $1, %cl
je L6_37
movl 532(%esp), %edi
movzbl (%edx,%edi), %eax
movb %al, 376(%edx,%ebx)
L6_37:
movl 372(%ebp), %ebx
subl %ecx, %esi
addl %ecx, %ebx
addl %ecx, 532(%esp)
movl %ebx, 372(%ebp)
cmpl $64, %ebx
jb L6_59
movl %ebp, %eax
movl $64, %ecx
movl 536(%esp), %edx
call poly1305_blocks
movl $0, 372(%ebp)
xorl %ebx, %ebx
L6_41:
cmpl $64, %esi
jb L6_44
movl %esi, %ebx
movl %ebp, %eax
andl $-64, %ebx
movl %ebx, %ecx
movl 532(%esp), %edx
call poly1305_blocks
addl %ebx, 532(%esp)
subl %ebx, %esi
movl 372(%ebp), %ebx
L6_44:
testl %esi, %esi
je L6_59
addl %ebp, %ebx
testl $32, %esi
je L6_47
movl 532(%esp), %eax
movl $32, %edx
movdqu (%eax), %xmm0
movdqu 16(%eax), %xmm1
movdqu %xmm0, 376(%ebx)
movdqu %xmm1, 392(%ebx)
jmp L6_48
L6_47:
xorl %edx, %edx
L6_48:
testl $16, %esi
je L6_50
movl 532(%esp), %eax
movdqu (%eax,%edx), %xmm0
movdqu %xmm0, 376(%edx,%ebx)
addl $16, %edx
L6_50:
testl $8, %esi
je L6_52
movl 532(%esp), %eax
movl (%eax,%edx), %ecx
movl 4(%eax,%edx), %edi
movl %ecx, 376(%edx,%ebx)
movl %edi, 380(%edx,%ebx)
addl $8, %edx
L6_52:
testl $4, %esi
je L6_54
movl 532(%esp), %eax
movl (%eax,%edx), %ecx
movl %ecx, 376(%edx,%ebx)
addl $4, %edx
L6_54:
testl $2, %esi
je L6_56
movl 532(%esp), %eax
movzwl (%eax,%edx), %ecx
movw %cx, 376(%edx,%ebx)
addl $2, %edx
L6_56:
testl $1, %esi
je L6_58
movl 532(%esp), %ecx
movzbl (%ecx,%edx), %eax
movb %al, 376(%edx,%ebx)
L6_58:
movl %esi, %ebx
addl 372(%ebp), %ebx
movl %ebx, 372(%ebp)
L6_59:
cmpl $0, 368(%ebp)
je L6_62
movl %ebp, %eax
movl %ebx, %ecx
movl 536(%esp), %edx
call poly1305_combine
addl %eax, 536(%esp)
subl %eax, %ebx
L6_62:
movl 292(%ebp), %edi
cmpl $16, %ebx
movl 300(%ebp), %eax
movl %edi, 564(%esp)
movl 296(%ebp), %ecx
movl 304(%ebp), %esi
movl 148(%ebp), %edi
movl %eax, 572(%esp)
movl %ecx, 568(%esp)
movl %esi, 556(%esp)
movl %edi, 580(%esp)
movl 172(%ebp), %eax
movl 156(%ebp), %edi
movl 164(%ebp), %esi
movl 180(%ebp), %ecx
movl %eax, 604(%esp)
lea (%eax,%eax,4), %eax
movl %edi, 592(%esp)
lea (%edi,%edi,4), %edi
movl %esi, 600(%esp)
lea (%esi,%esi,4), %esi
movl %ecx, 596(%esp)
lea (%ecx,%ecx,4), %ecx
movl %eax, 576(%esp)
movl 288(%ebp), %edx
movl %edi, 584(%esp)
movl %esi, 588(%esp)
movl %ecx, 560(%esp)
movl 556(%esp), %eax
jb L6_64
movl %eax, 556(%esp)
movl %edx, 552(%esp)
movl %ebx, 532(%esp)
movl %ebp, 528(%esp)
jmp L6_76
L6_64:
movl %ebp, 528(%esp)
L6_65:
testl %ebx, %ebx
je L6_78
movl 536(%esp), %ecx
lea 1(%ebx), %ebp
movb $1, (%ebx,%ecx)
lea 1(%ecx,%ebx), %ebx
movl %ebp, %ecx
negl %ecx
testb $8, %cl
je L6_68
movl 536(%esp), %edi
xorl %esi, %esi
addl $8, %ebx
movl %esi, (%ebp,%edi)
movl %esi, 4(%ebp,%edi)
L6_68:
testb $4, %cl
je L6_70
movl $0, (%ebx)
addl $4, %ebx
L6_70:
testb $2, %cl
je L6_72
xorl %ebp, %ebp
movw %bp, (%ebx)
addl $2, %ebx
L6_72:
testb $1, %cl
je L6_74
movb $0, (%ebx)
L6_74:
movl 536(%esp), %ebp
movl (%ebp), %ecx
movl 4(%ebp), %esi
movl 8(%ebp), %edi
movl 12(%ebp), %ebx
movl %ecx, %ebp
andl $67108863, %ebp
addl %ebp, %edx
movl %esi, %ebp
shll $6, %ebp
shrl $26, %ecx
orl %ecx, %ebp
movl %edi, %ecx
shll $12, %ecx
andl $67108863, %ebp
shrl $20, %esi
orl %esi, %ecx
movl %ebx, %esi
shll $18, %esi
andl $67108863, %ecx
shrl $14, %edi
orl %edi, %esi
shrl $8, %ebx
andl $67108863, %esi
addl 564(%esp), %ebp
addl %ebx, %eax
addl 568(%esp), %ecx
movl $16, %ebx
addl 572(%esp), %esi
movl %eax, 556(%esp)
movl %esi, 548(%esp)
movl %ecx, 544(%esp)
movl %ebp, 540(%esp)
movl %edx, 552(%esp)
movl %ebx, 532(%esp)
L6_75:
movl 580(%esp), %eax
movl 552(%esp), %edi
mull %edi
movl %eax, %esi
movl %edx, %ecx
movl 540(%esp), %eax
mull 560(%esp)
addl %eax, %esi
movl 544(%esp), %eax
adcl %edx, %ecx
mull 576(%esp)
addl %eax, %esi
movl 548(%esp), %eax
adcl %edx, %ecx
mull 588(%esp)
movl %eax, %ebp
movl %edx, %ebx
movl 556(%esp), %eax
mull 584(%esp)
addl %eax, %ebp
movl %edi, %eax
adcl %edx, %ebx
addl %ebp, %esi
movl %esi, 608(%esp)
adcl %ebx, %ecx
mull 592(%esp)
movl %ecx, %ebp
shll $6, %ebp
shrl $26, %esi
orl %esi, %ebp
shrl $26, %ecx
addl %eax, %ebp
movl 580(%esp), %eax
adcl %edx, %ecx
mull 540(%esp)
movl %eax, %ebx
movl %edx, %esi
movl 560(%esp), %eax
mull 544(%esp)
addl %eax, %ebx
movl 576(%esp), %eax
adcl %edx, %esi
addl %ebx, %ebp
adcl %esi, %ecx
mull 548(%esp)
movl %eax, %ebx
movl %edx, %esi
movl 588(%esp), %eax
mull 556(%esp)
addl %eax, %ebx
movl %edi, %eax
adcl %edx, %esi
addl %ebx, %ebp
movl %ebp, %ebx
adcl %esi, %ecx
andl $67108863, %ebx
mull 600(%esp)
movl %eax, %edi
movl 540(%esp), %eax
movl %ebx, 564(%esp)
movl %edx, %ebx
mull 592(%esp)
addl %eax, %edi
movl 580(%esp), %eax
adcl %edx, %ebx
mull 544(%esp)
addl %eax, %edi
movl 560(%esp), %eax
adcl %edx, %ebx
mull 548(%esp)
shll $6, %ecx
movl %eax, %esi
movl 576(%esp), %eax
shrl $26, %ebp
orl %ebp, %ecx
movl %edx, %ebp
mull 556(%esp)
addl %eax, %esi
movl 552(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
adcl %ebp, %ebx
addl %edi, %ecx
movl %ecx, %edi
adcl $0, %ebx
andl $67108863, %edi
mull 604(%esp)
movl %edi, 568(%esp)
movl %eax, %edi
shll $6, %ebx
shrl $26, %ecx
movl 540(%esp), %eax
orl %ecx, %ebx
movl %edx, %ecx
mull 600(%esp)
addl %eax, %edi
movl 544(%esp), %eax
adcl %edx, %ecx
mull 592(%esp)
addl %eax, %edi
movl 580(%esp), %eax
adcl %edx, %ecx
mull 548(%esp)
movl %eax, %esi
movl %edx, %ebp
movl 560(%esp), %eax
mull 556(%esp)
addl %eax, %esi
movl 552(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
adcl %ebp, %ecx
addl %edi, %ebx
movl %ebx, %ebp
adcl $0, %ecx
andl $67108863, %ebp
mull 596(%esp)
shll $6, %ecx
movl %eax, %edi
movl 540(%esp), %eax
shrl $26, %ebx
orl %ebx, %ecx
movl %edx, %ebx
mull 604(%esp)
addl %eax, %edi
movl 544(%esp), %eax
adcl %edx, %ebx
mull 600(%esp)
addl %eax, %edi
movl 548(%esp), %eax
adcl %edx, %ebx
mull 592(%esp)
movl %eax, %esi
movl 580(%esp), %eax
movl %ebp, 572(%esp)
movl %edx, %ebp
mull 556(%esp)
addl %eax, %esi
movl 536(%esp), %eax
adcl %edx, %ebp
addl %esi, %edi
movl 532(%esp), %edx
adcl %ebp, %ebx
addl %edi, %ecx
movl %ecx, %esi
adcl $0, %ebx
addl $-16, %edx
shll $6, %ebx
andl $67108863, %esi
shrl $26, %ecx
addl $16, %eax
orl %ecx, %ebx
movl 608(%esp), %edi
andl $67108863, %edi
movl %esi, 556(%esp)
movl %eax, 536(%esp)
lea (%ebx,%ebx,4), %ecx
addl %edi, %ecx
movl %ecx, 552(%esp)
cmpl $16, %edx
movl %edx, 532(%esp)
jb L6_77
L6_76:
movl 536(%esp), %ebx
movl 8(%ebx), %edx
movl (%ebx), %esi
movl %esi, %ebp
movl 4(%ebx), %ecx
movl %ecx, %edi
movl 12(%ebx), %eax
movl %edx, %ebx
shll $12, %ebx
andl $67108863, %ebp
shrl $20, %ecx
orl %ecx, %ebx
movl %eax, %ecx
shll $6, %edi
andl $67108863, %ebx
shrl $26, %esi
shll $18, %ecx
orl %esi, %edi
shrl $14, %edx
andl $67108863, %edi
orl %edx, %ecx
shrl $8, %eax
andl $67108863, %ecx
addl 564(%esp), %edi
orl $16777216, %eax
addl 568(%esp), %ebx
addl 572(%esp), %ecx
addl %ebp, 552(%esp)
addl %eax, 556(%esp)
movl %edi, 540(%esp)
movl %ebx, 544(%esp)
movl %ecx, 548(%esp)
jmp L6_75
L6_77:
movl %esi, %eax
movl %ecx, %edx
movl 532(%esp), %ebx
jmp L6_65
L6_78:
movl %edx, %ebx
andl $67108863, %edx
shrl $26, %ebx
movl 564(%esp), %ebp
addl %ebx, %ebp
movl %ebp, %ebx
shrl $26, %ebp
andl $67108863, %ebx
movl 568(%esp), %ecx
addl %ebp, %ecx
movl %ecx, %esi
shrl $26, %ecx
andl $67108863, %esi
movl 572(%esp), %edi
addl %ecx, %edi
movl %edi, %ebp
shrl $26, %edi
andl $67108863, %ebp
addl %edi, %eax
movl %eax, %ecx
shrl $26, %eax
andl $67108863, %ecx
movl %ecx, 532(%esp)
lea (%eax,%eax,4), %edi
lea (%edx,%edi), %eax
movl %eax, 536(%esp)
lea 5(%edi,%edx), %eax
movl %eax, 540(%esp)
shrl $26, %eax
addl %ebx, %eax
movl %eax, %edi
andl $67108863, %eax
shrl $26, %edi
addl %esi, %edi
movl %edi, %edx
andl $67108863, %edi
shrl $26, %edx
addl %ebp, %edx
movl %edx, 544(%esp)
shrl $26, %edx
lea -67108864(%edx,%ecx), %ecx
movl %ecx, 548(%esp)
shrl $31, %ecx
decl %ecx
movl %ecx, %edx
andl %ecx, %edi
notl %edx
andl %ecx, %eax
andl %edx, %esi
andl %edx, %ebx
orl %edi, %esi
orl %eax, %ebx
movl 544(%esp), %edi
andl %edx, %ebp
andl $67108863, %edi
movl 540(%esp), %eax
andl %ecx, %edi
andl $67108863, %eax
orl %edi, %ebp
movl 536(%esp), %edi
andl %ecx, %eax
andl %edx, %edi
movl %ecx, 552(%esp)
movl %ebx, %ecx
orl %eax, %edi
movl 528(%esp), %eax
shll $26, %ecx
orl %ecx, %edi
xorl %ecx, %ecx
addl 196(%eax), %edi
movl %edi, 536(%esp)
movl %ecx, %edi
adcl $0, %edi
movl %edi, 556(%esp)
movl %esi, %edi
shrl $6, %ebx
shll $20, %edi
orl %edi, %ebx
xorl %edi, %edi
addl 204(%eax), %ebx
adcl $0, %edi
movl %edi, 560(%esp)
movl %ebp, %edi
shrl $12, %esi
shll $14, %edi
orl %edi, %esi
movl 548(%esp), %edi
andl 532(%esp), %edx
andl 552(%esp), %edi
orl %edi, %edx
addl 212(%eax), %esi
movl 640(%esp), %edi
adcl $0, %ecx
shrl $18, %ebp
shll $8, %edx
orl %edx, %ebp
addl 556(%esp), %ebx
movl 560(%esp), %edx
adcl $0, %edx
addl %edx, %esi
movl %ebx, 4(%edi)
adcl $0, %ecx
addl 220(%eax), %ebp
movl 536(%esp), %eax
addl %ecx, %ebp
movl %eax, (%edi)
movl %esi, 8(%edi)
movl %ebp, 12(%edi)
addl $620, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret




.align 16,0x90
.globl poly1305_init
poly1305_init:
pushl %esi
pushl %edi
pushl %ebx
pushl %ebp
subl $12, %esp
movl 36(%esp), %eax
pxor %xmm0, %xmm0
movl 32(%esp), %ecx
movl 4(%eax), %ebx
movl %ebx, %edi
shll $6, %edi
lea 63(%ecx), %esi
movl (%eax), %ecx
movl %ecx, %edx
shrl $26, %ecx
andl $-64, %esi
movl 8(%eax), %ebp
orl %edi, %ecx
movl %ebp, %edi
andl $67108863, %edx
shrl $20, %ebx
andl $67108611, %ecx
shll $12, %edi
movl 12(%eax), %eax
orl %edi, %ebx
movl %eax, %edi
andl $67092735, %ebx
shrl $8, %eax
shrl $14, %ebp
andl $1048575, %eax
shll $18, %edi
movl %eax, 180(%esi)
orl %edi, %ebp
movl 36(%esp), %eax
andl $66076671, %ebp
movl %edx, 148(%esi)
movl %ecx, 156(%esi)
xorl %ecx, %ecx
movl %ebx, 164(%esi)
movl %ebp, 172(%esi)
movl 16(%eax), %edx
movl %edx, 196(%esi)
movl 20(%eax), %ebx
movl %ebx, 204(%esi)
movl 24(%eax), %ebp
movl %ebp, 212(%esi)
movl 28(%eax), %edx
movl %edx, 220(%esi)
movdqa %xmm0, 288(%esi)
movdqa %xmm0, 304(%esi)
movdqa %xmm0, 320(%esi)
movdqa %xmm0, 336(%esi)
movdqa %xmm0, 352(%esi)
movl %ecx, 368(%esi)
movl %ecx, 372(%esi)
addl $12, %esp
popl %ebp
popl %ebx
popl %edi
popl %esi
ret



.data
.section .rodata, "a"
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

