#if defined(_WIN32)
	#define LOAD_GOT_REG(name, reg)
	#define REF_GOT_VAR(var, reg) var
	#define CALL_PLT(function) call function
#else
	#define LOAD_GOT_REG(name, reg) \
		call name##_got; \
		name##_got:; \
		popl reg; \
		leal _GLOBAL_OFFSET_TABLE_ + 1(reg), reg;
	#define REF_GOT_VAR(var, reg) var##@GOTOFF(reg)
	#define CALL_PLT(function) call function@PLT
#endif


.text
.p2align 4,,15
.globl poly1305_auth
.globl _poly1305_auth
poly1305_auth:
_poly1305_auth:
pushl %ebp
movl %esp, %ebp
andl $~63, %esp
subl $1008, %esp
LOAD_GOT_REG(poly1305_x86_sse2, %ecx)
movl 12(%ebp), %eax
movl 16(%ebp), %edx
movl %edi, -964(%ebp)
movl %eax, -636(%ebp)
xorl %eax, %eax
movdqa REF_GOT_VAR(poly1305_x86_sse2_message_mask, %ecx), %xmm0
movdqa REF_GOT_VAR(poly1305_x86_sse2_5, %ecx), %xmm1
movdqa REF_GOT_VAR(poly1305_x86_sse2_1shl128, %ecx), %xmm2
movl %ebx, -960(%ebp)
movl %esi, -956(%ebp)
movl %edx, -8(%ebp)
movdqa %xmm0, -712(%ebp)
movdqa %xmm1, -776(%ebp)
movdqa %xmm2, -840(%ebp)
pxor %xmm3, %xmm3
movdqa %xmm3, -24(%ebp)
movl 20(%ebp), %esi
movl 4(%esi), %ebx
movl (%esi), %edx
movl %edx, %edi
movl 8(%esi), %ecx
andl $67108863, %edi
movl 12(%esi), %eax
movl %ebx, %esi
shrl $26, %edx
shll $6, %esi
movl %edi, -640(%ebp)
orl %esi, %edx
movl %ecx, %edi
movl %eax, %esi
shrl $20, %ebx
andl $67108611, %edx
shll $12, %edi
shrl $14, %ecx
orl %edi, %ebx
shll $18, %esi
andl $67092735, %ebx
shrl $8, %eax
orl %esi, %ecx
andl $66076671, %ecx
andl $1048575, %eax
movl %edx, -644(%ebp)
lea (%edx,%edx,4), %edx
movl %ebx, -684(%ebp)
lea (%ebx,%ebx,4), %ebx
movl %ecx, -692(%ebp)
movl %eax, -880(%ebp)
lea (%ecx,%ecx,4), %ecx
movl %edx, -876(%ebp)
lea (%eax,%eax,4), %eax
movl %ebx, -696(%ebp)
movl %ecx, -688(%ebp)
movl %eax, -648(%ebp)
cmpl $16, -8(%ebp)
jae poly1305_auth_x86_sse2_4
poly1305_auth_x86_sse2_3:
xorl %edi, %edi
xorl %ecx, %ecx
movl %edi, -920(%ebp)
movl %ecx, -916(%ebp)
movl %ecx, -912(%ebp)
jmp poly1305_auth_x86_sse2_33
poly1305_auth_x86_sse2_4:
cmpl $32, -8(%ebp)
jb poly1305_auth_x86_sse2_29
poly1305_auth_x86_sse2_5:
movl -8(%ebp), %ecx
movl $-1431655765, %eax
addl $-32, %ecx
lea -600(%ebp), %edi
mull %ecx
shrl $9, %edx
movl $4, %eax
incl %edx
cmpl $4, %edx
movl -636(%ebp), %ebx
cmovb %edx, %eax
movdqa -712(%ebp), %xmm4
movl %eax, %esi
movq 16(%ebx), %xmm6
movq (%ebx), %xmm2
pslldq $8, %xmm6
movq 24(%ebx), %xmm0
por %xmm6, %xmm2
movq 8(%ebx), %xmm6
addl $32, %ebx
movl %ebx, -636(%ebp)
lea (%eax,%eax,8), %ebx
pslldq $8, %xmm0
movdqa %xmm2, %xmm1
shll $4, %ebx
por %xmm0, %xmm6
movdqa %xmm4, %xmm0
movdqa %xmm6, %xmm3
movl -640(%ebp), %edx
pand %xmm2, %xmm0
psrlq $52, %xmm2
psllq $12, %xmm3
shll $5, %esi
lea -144(%edi,%ebx), %ebx
movl %ecx, -8(%ebp)
por %xmm3, %xmm2
movl %esi, -884(%ebp)
movdqa %xmm4, %xmm3
movl %edi, -888(%ebp)
pand %xmm2, %xmm3
movl %edx, -940(%ebp)
psrlq $26, %xmm2
movl -644(%ebp), %ecx
psrlq $26, %xmm1
movl -684(%ebp), %esi
psrlq $40, %xmm6
movl -692(%ebp), %edi
pand %xmm4, %xmm2
movl -880(%ebp), %edx
pand %xmm4, %xmm1
movl %ecx, -928(%ebp)
testl %eax, %eax
movl %esi, -944(%ebp)
movl %edi, -992(%ebp)
movl %edx, -924(%ebp)
movl -876(%ebp), %ecx
movl -696(%ebp), %esi
movl -688(%ebp), %edi
movl -648(%ebp), %edx
por -840(%ebp), %xmm6
movdqa %xmm2, -616(%ebp)
movl %ebx, -920(%ebp)
movl %ecx, -984(%ebp)
movl %esi, -988(%ebp)
movl %edi, -936(%ebp)
movl %edx, -996(%ebp)
movl $0, -916(%ebp)
jbe poly1305_auth_x86_sse2_12
poly1305_auth_x86_sse2_7:
cmpl $2, -916(%ebp)
jae poly1305_auth_x86_sse2_12
poly1305_auth_x86_sse2_8:
movl -924(%ebp), %edx
movl -940(%ebp), %esi
movl %eax, -932(%ebp)
movl %esi, %eax
movl %ebx, -912(%ebp)
lea (%edx,%edx), %ecx
mull %esi
movl %eax, %edi
movl %ecx, %eax
movl %edx, %ebx
mull -984(%ebp)
movl %ecx, -980(%ebp)
addl %eax, %edi
movl -944(%ebp), %ecx
adcl %edx, %ebx
movl %ecx, -972(%ebp)
movdqa %xmm0, -632(%ebp)
lea (%ecx,%ecx), %eax
mull -936(%ebp)
addl %eax, %edi
movl -992(%ebp), %ecx
movl %edi, -976(%ebp)
adcl %edx, %ebx
movl -928(%ebp), %edi
lea (%esi,%esi), %edx
movl %edx, -952(%ebp)
lea (%ecx,%ecx), %eax
movl %eax, -968(%ebp)
movl %esi, %eax
shll $6, %ebx
addl %edi, %edi
mull %edi
movl %eax, %esi
movl -980(%ebp), %eax
movl %edi, -1000(%ebp)
movl %edx, %edi
mull -988(%ebp)
addl %eax, %esi
movl %ecx, %eax
movl -936(%ebp), %ecx
adcl %edx, %edi
mull %ecx
addl %eax, %esi
movl -976(%ebp), %eax
adcl %edx, %edi
shrl $26, %eax
orl %eax, %ebx
movl -928(%ebp), %eax
addl %ebx, %esi
movl %esi, -948(%ebp)
adcl $0, %edi
mull %eax
movl %eax, %esi
movl %edx, %ebx
movl -972(%ebp), %eax
mull -952(%ebp)
addl %eax, %esi
movl -980(%ebp), %eax
adcl %edx, %ebx
mull %ecx
movl -948(%ebp), %ecx
addl %eax, %esi
movl -1000(%ebp), %eax
adcl %edx, %ebx
shll $6, %edi
shrl $26, %ecx
orl %ecx, %edi
addl %edi, %esi
movl %esi, %edi
adcl $0, %ebx
andl $67108863, %edi
movl %edi, -944(%ebp)
movl -972(%ebp), %edi
mull %edi
shll $6, %ebx
movl %edx, %ecx
shrl $26, %esi
orl %esi, %ebx
movl %eax, %esi
movl -940(%ebp), %eax
mull -968(%ebp)
addl %eax, %esi
movl -924(%ebp), %eax
adcl %edx, %ecx
mull -996(%ebp)
addl %eax, %esi
movl %edi, %eax
movd -944(%ebp), %xmm4
adcl %edx, %ecx
addl %esi, %ebx
movl %ebx, %esi
adcl $0, %ecx
andl $67108863, %esi
mull %edi
shll $6, %ecx
movl %edx, %edi
shrl $26, %ebx
orl %ebx, %ecx
movl %eax, %ebx
movl -968(%ebp), %eax
mull -928(%ebp)
addl %eax, %ebx
movl -952(%ebp), %eax
adcl %edx, %edi
mull -924(%ebp)
addl %eax, %ebx
movl -976(%ebp), %eax
adcl %edx, %edi
addl %ebx, %ecx
movl %ecx, %ebx
adcl $0, %edi
andl $67108863, %eax
shll $6, %edi
andl $67108863, %ebx
shrl $26, %ecx
orl %ecx, %edi
movl -948(%ebp), %ecx
andl $67108863, %ecx
movl -920(%ebp), %edx
pshufd $68, %xmm4, %xmm4
lea (%edi,%edi,4), %edi
addl %edi, %eax
movl %eax, %edi
shrl $26, %eax
andl $67108863, %edi
movdqa %xmm4, 32(%edx)
movl %ebx, -924(%ebp)
movl %edi, -940(%ebp)
movd %edi, %xmm7
addl %ecx, %eax
pshufd $68, %xmm7, %xmm0
movd %esi, %xmm7
movdqa %xmm0, (%edx)
movd %ebx, %xmm0
pshufd $68, %xmm0, %xmm0
movl %edx, %edi
movd %eax, %xmm2
pshufd $68, %xmm2, %xmm5
pshufd $68, %xmm7, %xmm2
movdqa -776(%ebp), %xmm7
movdqa %xmm0, 64(%edx)
pmuludq %xmm7, %xmm0
pmuludq %xmm7, %xmm4
movdqa %xmm5, 16(%edx)
movdqa %xmm2, 48(%edx)
pmuludq %xmm7, %xmm5
pmuludq %xmm7, %xmm2
movl -916(%ebp), %ebx
incl %ebx
movl %eax, -928(%ebp)
movdqa %xmm5, 80(%edx)
movdqa %xmm4, 96(%edx)
movdqa %xmm2, 112(%edx)
movdqa %xmm0, 128(%edx)
addl $-144, %edx
movl -932(%ebp), %eax
cmpl %eax, %ebx
movd %xmm0, -996(%ebp)
movl %ebx, -916(%ebp)
movl %esi, -992(%ebp)
movd %xmm5, -984(%ebp)
movd %xmm4, -988(%ebp)
movd %xmm2, -936(%ebp)
movl %edx, -920(%ebp)
movl -912(%ebp), %ebx
movdqa -632(%ebp), %xmm0
jb poly1305_auth_x86_sse2_7
poly1305_auth_x86_sse2_12:
cmpl -916(%ebp), %eax
jbe poly1305_auth_x86_sse2_16
poly1305_auth_x86_sse2_14:
movl %eax, -932(%ebp)
movl (%ebx), %eax
mull (%edi)
movl %eax, %ecx
movl %edx, %esi
movl 16(%ebx), %eax
mull 128(%edi)
addl %eax, %ecx
movl 32(%ebx), %eax
adcl %edx, %esi
mull 112(%edi)
addl %eax, %ecx
movl 48(%ebx), %eax
adcl %edx, %esi
mull 96(%edi)
movl %eax, -980(%ebp)
movl 80(%edi), %eax
movl %edx, -976(%ebp)
mull 64(%ebx)
addl %eax, -980(%ebp)
movl %edi, -948(%ebp)
adcl %edx, -976(%ebp)
addl -980(%ebp), %ecx
adcl -976(%ebp), %esi
movl %ebx, -912(%ebp)
movl %edi, %ebx
movl %esi, -1000(%ebp)
movl -912(%ebp), %esi
movl 64(%edi), %eax
movl %esi, %edi
mull (%esi)
movl %eax, %esi
movl (%ebx), %eax
movl %edi, %ebx
movl %ecx, -972(%ebp)
movl %edx, %ecx
mull 64(%edi)
movl -948(%ebp), %edi
addl %eax, %esi
movl 48(%ebx), %eax
adcl %edx, %ecx
mull 16(%edi)
addl %eax, %esi
movl 32(%ebx), %eax
adcl %edx, %ecx
mull 32(%edi)
movl %eax, %ebx
movl %edx, %edi
movl -912(%ebp), %eax
movl -948(%ebp), %edx
movdqa %xmm0, -632(%ebp)
movl 16(%eax), %eax
mull 48(%edx)
addl %eax, %ebx
adcl %edx, %edi
addl %ebx, %esi
movl %esi, -996(%ebp)
adcl %edi, %ecx
movl %ecx, -992(%ebp)
movl -948(%ebp), %ecx
movl %ecx, %ebx
movl -912(%ebp), %edi
movl (%ecx), %eax
mull 16(%edi)
movl %edi, %ecx
movl %eax, %edi
movl 128(%ebx), %eax
movl %edx, %esi
mull 32(%ecx)
addl %eax, %edi
movl 112(%ebx), %eax
adcl %edx, %esi
mull 48(%ecx)
movl %eax, %ebx
movl %edx, %ecx
movl -948(%ebp), %eax
movl -912(%ebp), %edx
movl 96(%eax), %eax
mull 64(%edx)
addl %eax, %ebx
adcl %edx, %ecx
addl %ebx, %edi
movl -912(%ebp), %ebx
adcl %ecx, %esi
movl -948(%ebp), %ecx
movl (%ebx), %eax
movl -972(%ebp), %ebx
mull 16(%ecx)
movl -1000(%ebp), %ecx
shll $6, %ecx
shrl $26, %ebx
orl %ebx, %ecx
addl %ecx, %eax
movl -912(%ebp), %ecx
adcl $0, %edx
addl %eax, %edi
movl %edi, -968(%ebp)
adcl %edx, %esi
movl %esi, -988(%ebp)
movl -948(%ebp), %esi
movl %ecx, %edi
movl (%esi), %eax
mull 32(%edi)
movl %eax, %edi
movl %edx, %ebx
movl 128(%esi), %eax
mull 48(%ecx)
addl %eax, %edi
movl 112(%esi), %eax
adcl %edx, %ebx
mull 64(%ecx)
movl %eax, %esi
movl %edx, %ecx
movl -912(%ebp), %eax
movl -948(%ebp), %edx
movl 16(%eax), %eax
mull 16(%edx)
addl %eax, %esi
adcl %edx, %ecx
addl %esi, %edi
movl -912(%ebp), %esi
adcl %ecx, %ebx
movl -948(%ebp), %ecx
movl (%esi), %eax
movl -968(%ebp), %esi
mull 32(%ecx)
movl -988(%ebp), %ecx
shll $6, %ecx
shrl $26, %esi
orl %esi, %ecx
addl %ecx, %eax
movl -948(%ebp), %esi
adcl $0, %edx
addl %eax, %edi
movl %edi, -952(%ebp)
adcl %edx, %ebx
movl %ebx, -984(%ebp)
movl %esi, %ebx
movl -912(%ebp), %edi
movl %edi, %ecx
movl (%ebx), %eax
mull 48(%edi)
movl %eax, %edi
movl %edx, %ebx
movl 128(%esi), %eax
movl %ecx, %esi
mull 64(%ecx)
movl -948(%ebp), %ecx
addl %eax, %edi
movl 32(%esi), %eax
adcl %edx, %ebx
mull 16(%ecx)
movl %eax, %esi
movl %edx, %ecx
movl -912(%ebp), %eax
movl -948(%ebp), %edx
movl 16(%eax), %eax
mull 32(%edx)
addl %eax, %esi
adcl %edx, %ecx
addl %esi, %edi
movl -912(%ebp), %esi
adcl %ecx, %ebx
movl -948(%ebp), %ecx
movl (%esi), %eax
movl -952(%ebp), %esi
mull 48(%ecx)
movl -984(%ebp), %ecx
shll $6, %ecx
shrl $26, %esi
orl %esi, %ecx
addl %ecx, %eax
movl -972(%ebp), %ecx
adcl $0, %edx
addl %eax, %edi
movl %edi, %esi
adcl %edx, %ebx
andl $67108863, %ecx
shll $6, %ebx
andl $67108863, %edi
shrl $26, %esi
orl %esi, %ebx
addl -996(%ebp), %ebx
movl -992(%ebp), %eax
movl %ebx, %esi
adcl $0, %eax
andl $67108863, %ebx
shll $6, %eax
movd %edi, %xmm0
shrl $26, %esi
orl %esi, %eax
movl -968(%ebp), %edx
andl $67108863, %edx
pshufd $68, %xmm0, %xmm0
lea (%eax,%eax,4), %esi
movl -932(%ebp), %eax
addl %esi, %ecx
movl %ecx, %esi
shrl $26, %ecx
andl $67108863, %esi
addl %edx, %ecx
movd %esi, %xmm5
movd %ecx, %xmm4
movl -952(%ebp), %ecx
andl $67108863, %ecx
movl -920(%ebp), %esi
movl %esi, %edi
pshufd $68, %xmm5, %xmm7
movd %ebx, %xmm5
pshufd $68, %xmm4, %xmm4
movd %ecx, %xmm2
movdqa %xmm7, (%esi)
pshufd $68, %xmm2, %xmm2
pshufd $68, %xmm5, %xmm5
movdqa -776(%ebp), %xmm7
movdqa %xmm4, 16(%esi)
movdqa %xmm2, 32(%esi)
movdqa %xmm0, 48(%esi)
movdqa %xmm5, 64(%esi)
pmuludq %xmm7, %xmm4
pmuludq %xmm7, %xmm2
pmuludq %xmm7, %xmm0
pmuludq %xmm7, %xmm5
movl -916(%ebp), %ebx
incl %ebx
movdqa %xmm4, 80(%esi)
movdqa %xmm2, 96(%esi)
movdqa %xmm0, 112(%esi)
movdqa %xmm5, 128(%esi)
addl $-144, %esi
movl %ebx, -916(%ebp)
cmpl %eax, %ebx
movl %esi, -920(%ebp)
movl -912(%ebp), %ebx
movdqa -632(%ebp), %xmm0
jb poly1305_auth_x86_sse2_14
poly1305_auth_x86_sse2_16:
cmpl $32, -8(%ebp)
jb poly1305_auth_x86_sse2_26
poly1305_auth_x86_sse2_17:
movdqa -600(%ebp), %xmm2
movdqa %xmm2, -728(%ebp)
movdqa -584(%ebp), %xmm4
movdqa -472(%ebp), %xmm5
movdqa -488(%ebp), %xmm7
movdqa -504(%ebp), %xmm2
movdqa %xmm4, -680(%ebp)
movdqa %xmm5, -744(%ebp)
movdqa %xmm7, -856(%ebp)
movdqa %xmm2, -904(%ebp)
movdqa -520(%ebp), %xmm4
movdqa -568(%ebp), %xmm5
movdqa -552(%ebp), %xmm7
movdqa -536(%ebp), %xmm2
movdqa %xmm4, -936(%ebp)
movdqa %xmm5, -872(%ebp)
movdqa %xmm7, -920(%ebp)
movdqa %xmm2, -952(%ebp)
poly1305_auth_x86_sse2_18:
movdqa -728(%ebp), %xmm4
movdqa %xmm0, %xmm7
movdqa %xmm1, %xmm2
movdqa %xmm3, %xmm5
pmuludq -744(%ebp), %xmm2
cmpl $1, %eax
pmuludq %xmm4, %xmm7
pmuludq -856(%ebp), %xmm5
paddq %xmm2, %xmm7
movdqa -904(%ebp), %xmm2
paddq %xmm5, %xmm7
movdqa -616(%ebp), %xmm5
pmuludq %xmm2, %xmm5
paddq %xmm5, %xmm7
movdqa %xmm6, %xmm5
pmuludq -936(%ebp), %xmm5
paddq %xmm5, %xmm7
movdqa %xmm7, -792(%ebp)
movdqa %xmm0, %xmm5
movdqa %xmm1, %xmm7
pmuludq -680(%ebp), %xmm5
pmuludq %xmm4, %xmm7
movdqa %xmm3, %xmm4
pmuludq -744(%ebp), %xmm4
paddq %xmm7, %xmm5
movdqa -616(%ebp), %xmm7
paddq %xmm4, %xmm5
movdqa -856(%ebp), %xmm4
pmuludq %xmm4, %xmm7
paddq %xmm7, %xmm5
movdqa %xmm6, %xmm7
pmuludq %xmm2, %xmm7
movdqa %xmm1, %xmm2
pmuludq -680(%ebp), %xmm2
paddq %xmm7, %xmm5
movdqa %xmm5, -824(%ebp)
movdqa %xmm0, %xmm7
movdqa -872(%ebp), %xmm5
pmuludq %xmm5, %xmm7
movdqa %xmm3, -760(%ebp)
pmuludq -728(%ebp), %xmm3
paddq %xmm2, %xmm7
movdqa -616(%ebp), %xmm2
paddq %xmm3, %xmm7
movdqa -744(%ebp), %xmm3
pmuludq %xmm3, %xmm2
paddq %xmm2, %xmm7
movdqa %xmm6, %xmm2
pmuludq %xmm4, %xmm2
movdqa %xmm0, %xmm4
pmuludq -952(%ebp), %xmm0
paddq %xmm2, %xmm7
movdqa -920(%ebp), %xmm2
movdqa %xmm7, -808(%ebp)
movdqa %xmm1, %xmm7
pmuludq %xmm2, %xmm4
pmuludq %xmm5, %xmm7
pmuludq %xmm2, %xmm1
paddq %xmm7, %xmm4
paddq %xmm1, %xmm0
movdqa -760(%ebp), %xmm5
pmuludq -680(%ebp), %xmm5
movdqa -728(%ebp), %xmm7
paddq %xmm5, %xmm4
movdqa -616(%ebp), %xmm5
pmuludq %xmm7, %xmm5
movdqa -760(%ebp), %xmm1
pmuludq -872(%ebp), %xmm1
paddq %xmm5, %xmm4
paddq %xmm1, %xmm0
movdqa -616(%ebp), %xmm2
movdqa %xmm6, %xmm5
pmuludq -680(%ebp), %xmm2
pmuludq %xmm3, %xmm5
pmuludq %xmm7, %xmm6
paddq %xmm2, %xmm0
paddq %xmm5, %xmm4
paddq %xmm6, %xmm0
movl -888(%ebp), %esi
movdqa -792(%ebp), %xmm2
movdqa %xmm4, -664(%ebp)
jbe poly1305_auth_x86_sse2_22
poly1305_auth_x86_sse2_19:
movl $1, %ecx
jmp poly1305_auth_x86_sse2_20
.p2align 6,,63
poly1305_auth_x86_sse2_20:
movl -636(%ebp), %edx
addl $144, %esi
movdqa -712(%ebp), %xmm6
incl %ecx
movdqa %xmm0, -632(%ebp)
movq 16(%edx), %xmm7
movq (%edx), %xmm5
movq 24(%edx), %xmm1
pslldq $8, %xmm7
pslldq $8, %xmm1
por %xmm7, %xmm5
movq 8(%edx), %xmm7
movdqa %xmm5, %xmm3
por %xmm1, %xmm7
movdqa %xmm6, %xmm1
movdqa %xmm7, %xmm4
pand %xmm5, %xmm1
psrlq $52, %xmm5
psllq $12, %xmm4
por %xmm4, %xmm5
movdqa %xmm6, %xmm4
psrlq $26, %xmm3
pand %xmm5, %xmm4
psrlq $26, %xmm5
pand %xmm6, %xmm3
pand %xmm6, %xmm5
psrlq $40, %xmm7
movdqa (%esi), %xmm6
addl $32, %edx
movdqa %xmm6, %xmm0
cmpl %eax, %ecx
pmuludq %xmm1, %xmm0
paddq %xmm0, %xmm2
movdqa 128(%esi), %xmm0
pmuludq %xmm3, %xmm0
paddq %xmm0, %xmm2
movdqa 112(%esi), %xmm0
pmuludq %xmm4, %xmm0
paddq %xmm0, %xmm2
movdqa 96(%esi), %xmm0
pmuludq %xmm5, %xmm0
por -840(%ebp), %xmm7
paddq %xmm0, %xmm2
movdqa 80(%esi), %xmm0
pmuludq %xmm7, %xmm0
paddq %xmm0, %xmm2
movdqa 16(%esi), %xmm0
pmuludq %xmm1, %xmm0
movdqa %xmm2, -792(%ebp)
movdqa -824(%ebp), %xmm2
paddq %xmm0, %xmm2
movdqa %xmm6, %xmm0
pmuludq %xmm3, %xmm0
paddq %xmm0, %xmm2
movdqa 128(%esi), %xmm0
pmuludq %xmm4, %xmm0
paddq %xmm0, %xmm2
movdqa 112(%esi), %xmm0
pmuludq %xmm5, %xmm0
paddq %xmm0, %xmm2
movdqa 96(%esi), %xmm0
pmuludq %xmm7, %xmm0
paddq %xmm0, %xmm2
movdqa %xmm2, -824(%ebp)
movdqa 32(%esi), %xmm2
pmuludq %xmm1, %xmm2
movdqa -808(%ebp), %xmm0
paddq %xmm2, %xmm0
movdqa 16(%esi), %xmm2
pmuludq %xmm3, %xmm2
paddq %xmm2, %xmm0
movdqa %xmm6, %xmm2
pmuludq %xmm4, %xmm2
paddq %xmm2, %xmm0
movdqa 128(%esi), %xmm2
pmuludq %xmm5, %xmm2
paddq %xmm2, %xmm0
movdqa 112(%esi), %xmm2
pmuludq %xmm7, %xmm2
paddq %xmm2, %xmm0
movdqa %xmm0, -808(%ebp)
movdqa 48(%esi), %xmm0
pmuludq %xmm1, %xmm0
pmuludq 64(%esi), %xmm1
movdqa -664(%ebp), %xmm2
paddq %xmm0, %xmm2
movdqa 32(%esi), %xmm0
pmuludq %xmm3, %xmm0
pmuludq 48(%esi), %xmm3
paddq %xmm0, %xmm2
movdqa 16(%esi), %xmm0
pmuludq %xmm4, %xmm0
pmuludq 32(%esi), %xmm4
paddq %xmm0, %xmm2
movdqa %xmm6, %xmm0
pmuludq %xmm5, %xmm0
pmuludq 16(%esi), %xmm5
paddq %xmm0, %xmm2
movdqa 128(%esi), %xmm0
pmuludq %xmm7, %xmm0
pmuludq %xmm6, %xmm7
paddq %xmm0, %xmm2
movdqa -632(%ebp), %xmm0
paddq %xmm1, %xmm0
paddq %xmm3, %xmm0
paddq %xmm4, %xmm0
paddq %xmm5, %xmm0
movdqa %xmm2, -664(%ebp)
paddq %xmm7, %xmm0
movl %edx, -636(%ebp)
movdqa -792(%ebp), %xmm2
jb poly1305_auth_x86_sse2_20
poly1305_auth_x86_sse2_22:
movdqa %xmm2, %xmm7
movdqa -664(%ebp), %xmm1
psrlq $26, %xmm7
movdqa -824(%ebp), %xmm3
movdqa %xmm1, %xmm5
paddq %xmm7, %xmm3
psrlq $26, %xmm5
paddq %xmm0, %xmm5
movdqa %xmm3, %xmm0
movdqa -808(%ebp), %xmm6
psrlq $26, %xmm0
movdqa %xmm5, -1000(%ebp)
psrlq $26, %xmm5
paddq %xmm0, %xmm6
pmuludq -776(%ebp), %xmm5
movl -636(%ebp), %edx
movdqa %xmm6, %xmm7
movdqa -712(%ebp), %xmm4
psrlq $26, %xmm7
pand %xmm4, %xmm1
pand %xmm4, %xmm2
paddq %xmm7, %xmm1
paddq %xmm5, %xmm2
movq 16(%edx), %xmm0
pand %xmm4, %xmm3
movdqa %xmm1, -664(%ebp)
pand %xmm4, %xmm6
movq (%edx), %xmm1
movq 24(%edx), %xmm5
pslldq $8, %xmm0
movq 8(%edx), %xmm7
por %xmm0, %xmm1
pslldq $8, %xmm5
movdqa %xmm4, %xmm0
por %xmm5, %xmm7
movdqa %xmm1, %xmm5
movdqa %xmm7, -984(%ebp)
psrlq $52, %xmm5
psllq $12, %xmm7
pand %xmm2, %xmm0
por %xmm7, %xmm5
movdqa %xmm4, %xmm7
psrlq $26, %xmm2
pand %xmm1, %xmm7
psrlq $26, %xmm1
addl $32, %edx
paddq %xmm2, %xmm3
paddq %xmm7, %xmm0
pand %xmm4, %xmm1
movdqa %xmm4, %xmm2
paddq %xmm3, %xmm1
movdqa %xmm4, %xmm3
pand %xmm5, %xmm3
psrlq $26, %xmm5
paddq %xmm6, %xmm3
movdqa -1000(%ebp), %xmm6
pand %xmm4, %xmm5
movdqa -664(%ebp), %xmm7
pand %xmm4, %xmm6
movdqa -984(%ebp), %xmm4
pand %xmm7, %xmm2
psrlq $26, %xmm7
psrlq $40, %xmm4
paddq %xmm7, %xmm6
paddq %xmm5, %xmm2
movl -884(%ebp), %esi
movl -8(%ebp), %ecx
subl %esi, %ecx
por -840(%ebp), %xmm4
cmpl %esi, %ecx
movl %ecx, -8(%ebp)
movdqa %xmm2, -616(%ebp)
paddq %xmm4, %xmm6
movl %edx, -636(%ebp)
jae poly1305_auth_x86_sse2_18
poly1305_auth_x86_sse2_23:
cmpl $32, -8(%ebp)
jb poly1305_auth_x86_sse2_26
poly1305_auth_x86_sse2_24:
movl %ecx, %eax
shrl $5, %eax
imull $-144, %eax, %ecx
movl %eax, %edx
shll $5, %edx
lea 144(%ebx,%ecx), %esi
movdqa (%esi), %xmm2
movdqa %xmm2, -728(%ebp)
movdqa 16(%esi), %xmm4
movdqa 128(%esi), %xmm5
movdqa 112(%esi), %xmm7
movdqa 96(%esi), %xmm2
movdqa %xmm4, -680(%ebp)
movdqa %xmm5, -744(%ebp)
movdqa %xmm7, -856(%ebp)
movdqa %xmm2, -904(%ebp)
movdqa 80(%esi), %xmm4
movdqa 32(%esi), %xmm5
movdqa 48(%esi), %xmm7
movdqa 64(%esi), %xmm2
movl %edx, -884(%ebp)
movl %esi, -888(%ebp)
movdqa %xmm4, -936(%ebp)
movdqa %xmm5, -872(%ebp)
movdqa %xmm7, -920(%ebp)
movdqa %xmm2, -952(%ebp)
jmp poly1305_auth_x86_sse2_18
poly1305_auth_x86_sse2_26:
movl -640(%ebp), %edi
xorl %edx, %edx
movl -684(%ebp), %eax
movdqa %xmm0, %xmm5
movl %edi, 8(%ebx)
movl -876(%ebp), %edi
movl %eax, 40(%ebx)
movl %edx, 12(%ebx)
movl %edi, 88(%ebx)
movl %edx, 92(%ebx)
movdqa (%ebx), %xmm4
movdqa 80(%ebx), %xmm2
pmuludq %xmm6, %xmm2
pmuludq %xmm4, %xmm5
movl -644(%ebp), %ecx
movl %ecx, 24(%ebx)
movl -696(%ebp), %ecx
paddq %xmm2, %xmm5
movdqa -616(%ebp), %xmm2
movl %ecx, 104(%ebx)
movdqa %xmm2, %xmm7
movl %edx, 108(%ebx)
pmuludq 96(%ebx), %xmm7
movl %edx, 28(%ebx)
movl %edx, 44(%ebx)
movl -692(%ebp), %edx
movl %edx, 56(%ebx)
movl -688(%ebp), %edx
movl %edx, 120(%ebx)
movl $0, 124(%ebx)
paddq %xmm7, %xmm5
movdqa %xmm3, %xmm7
pmuludq 112(%ebx), %xmm7
movl -880(%ebp), %esi
movl %esi, 72(%ebx)
movl -648(%ebp), %esi
movl %esi, 136(%ebx)
movl $0, 140(%ebx)
paddq %xmm7, %xmm5
movdqa %xmm1, %xmm7
pmuludq 128(%ebx), %xmm7
paddq %xmm7, %xmm5
movdqa %xmm5, -952(%ebp)
movdqa %xmm2, %xmm7
movdqa 16(%ebx), %xmm5
movdqa %xmm3, -760(%ebp)
pmuludq %xmm4, %xmm7
pmuludq %xmm5, %xmm3
paddq %xmm3, %xmm7
movdqa %xmm1, %xmm3
pmuludq 32(%ebx), %xmm3
movl $0, 60(%ebx)
paddq %xmm3, %xmm7
movdqa %xmm0, %xmm3
pmuludq 48(%ebx), %xmm3
paddq %xmm3, %xmm7
movdqa %xmm6, %xmm3
pmuludq 128(%ebx), %xmm3
movl $0, 76(%ebx)
paddq %xmm3, %xmm7
movdqa 64(%ebx), %xmm3
movdqa %xmm1, -1000(%ebp)
movdqa %xmm0, -632(%ebp)
pmuludq %xmm0, %xmm3
pmuludq %xmm4, %xmm1
pmuludq %xmm5, %xmm0
movdqa %xmm7, -936(%ebp)
movdqa 96(%ebx), %xmm7
pmuludq %xmm6, %xmm7
paddq %xmm0, %xmm1
movdqa %xmm2, %xmm0
pmuludq 112(%ebx), %xmm0
pmuludq %xmm5, %xmm2
paddq %xmm7, %xmm1
paddq %xmm0, %xmm1
movdqa -760(%ebp), %xmm0
movdqa %xmm0, %xmm7
pmuludq 128(%ebx), %xmm7
paddq %xmm7, %xmm1
movdqa -952(%ebp), %xmm7
psrlq $26, %xmm7
paddq %xmm7, %xmm1
movdqa %xmm1, -984(%ebp)
movdqa %xmm6, %xmm1
pmuludq %xmm4, %xmm1
pmuludq 112(%ebx), %xmm6
paddq %xmm2, %xmm1
movdqa 32(%ebx), %xmm7
movdqa %xmm0, %xmm2
pmuludq %xmm7, %xmm2
pmuludq %xmm4, %xmm0
paddq %xmm2, %xmm1
movdqa 48(%ebx), %xmm2
paddq %xmm3, %xmm1
movdqa -1000(%ebp), %xmm3
pmuludq %xmm3, %xmm2
pmuludq %xmm5, %xmm3
paddq %xmm2, %xmm1
paddq %xmm3, %xmm0
movdqa -632(%ebp), %xmm4
pmuludq %xmm7, %xmm4
paddq %xmm4, %xmm0
movdqa -936(%ebp), %xmm2
paddq %xmm6, %xmm0
movdqa -616(%ebp), %xmm6
psrlq $26, %xmm2
paddq %xmm2, %xmm1
pmuludq 128(%ebx), %xmm6
movdqa %xmm1, %xmm3
psrlq $26, %xmm3
pmuludq -776(%ebp), %xmm3
paddq %xmm6, %xmm0
movdqa -984(%ebp), %xmm6
movdqa %xmm6, %xmm5
movdqa -712(%ebp), %xmm4
psrlq $26, %xmm5
movdqa -952(%ebp), %xmm2
pand %xmm4, %xmm6
pand %xmm4, %xmm2
pand %xmm4, %xmm1
paddq %xmm5, %xmm0
paddq %xmm3, %xmm2
movdqa -936(%ebp), %xmm7
movdqa %xmm4, %xmm5
movdqa %xmm4, %xmm3
pand %xmm0, %xmm5
pand %xmm4, %xmm7
psrlq $26, %xmm0
pand %xmm2, %xmm3
psrlq $26, %xmm2
paddq %xmm0, %xmm7
paddq %xmm2, %xmm6
movdqa %xmm4, %xmm0
movdqa %xmm3, %xmm2
psrldq $8, %xmm2
pand %xmm7, %xmm0
psrlq $26, %xmm7
movdqa %xmm5, %xmm4
paddq %xmm7, %xmm1
paddq %xmm2, %xmm3
movdqa %xmm6, %xmm7
movdqa %xmm0, %xmm2
psrldq $8, %xmm7
movd %xmm3, %edi
paddq %xmm7, %xmm6
movd %xmm6, %edx
movl %edi, %ebx
psrldq $8, %xmm4
paddq %xmm4, %xmm5
shrl $26, %ebx
andl $67108863, %edi
addl %ebx, %edx
movl %edx, %eax
psrldq $8, %xmm2
andl $67108863, %eax
movl %eax, -920(%ebp)
movd %xmm5, %eax
paddq %xmm2, %xmm0
shrl $26, %edx
addl %edx, %eax
movd %xmm0, %edx
movdqa %xmm1, %xmm0
psrldq $8, %xmm0
paddq %xmm0, %xmm1
movl %eax, %esi
shrl $26, %eax
andl $67108863, %esi
movd %xmm1, %ebx
addl %eax, %edx
movl %edx, %eax
shrl $26, %edx
andl $67108863, %eax
addl %edx, %ebx
movl %ebx, %ecx
shrl $26, %ebx
andl $67108863, %ecx
movl %eax, -912(%ebp)
movl %esi, -916(%ebp)
lea (%ebx,%ebx,4), %eax
addl %eax, %edi
cmpl $16, -8(%ebp)
jb poly1305_auth_x86_sse2_33
jmp poly1305_auth_x86_sse2_30
poly1305_auth_x86_sse2_29:
xorl %edi, %edi
xorl %ecx, %ecx
movl %edi, -920(%ebp)
movl %ecx, -916(%ebp)
movl %ecx, -912(%ebp)
poly1305_auth_x86_sse2_30:
movl -636(%ebp), %eax
movl %ecx, -1000(%ebp)
addl $-16, -8(%ebp)
movl (%eax), %esi
movl %esi, %ecx
andl $67108863, %ecx
movl 8(%eax), %ebx
addl %edi, %ecx
movl %ecx, -936(%ebp)
movl %ebx, %ecx
movl 4(%eax), %edx
movl %edx, %edi
shll $12, %ecx
shrl $20, %edx
movl 12(%eax), %eax
orl %edx, %ecx
movl %eax, %edx
andl $67108863, %ecx
shll $6, %edi
shrl $26, %esi
shll $18, %edx
orl %esi, %edi
shrl $14, %ebx
andl $67108863, %edi
shrl $8, %eax
orl %ebx, %edx
andl $67108863, %edx
orl $16777216, %eax
addl -920(%ebp), %edi
addl -916(%ebp), %ecx
addl -912(%ebp), %edx
addl -1000(%ebp), %eax
addl $16, -636(%ebp)
movl %edi, -924(%ebp)
movl %ecx, -928(%ebp)
movl %edx, -932(%ebp)
movl %eax, -908(%ebp)
poly1305_auth_x86_sse2_31:
movl -936(%ebp), %eax
xorl %ecx, %ecx
mull -640(%ebp)
movl %eax, %ebx
movl %edx, %edi
movl -924(%ebp), %eax
xorl %esi, %esi
imull %eax, %ecx
mull -648(%ebp)
addl %ecx, %edx
addl %eax, %ebx
movl -928(%ebp), %eax
adcl %edx, %edi
imull %eax, %esi
mull -688(%ebp)
addl %esi, %edx
addl %eax, %ebx
movl -932(%ebp), %eax
adcl %edx, %edi
imull %eax, %ecx
mull -696(%ebp)
movl %edi, -948(%ebp)
movl %edx, %edi
movl %esi, -996(%ebp)
movl %eax, %esi
movl -908(%ebp), %eax
addl %ecx, %edi
imull %eax, %ecx
mull -876(%ebp)
addl %ecx, %edx
addl %eax, %esi
movl %ecx, -992(%ebp)
adcl %edx, %edi
addl %esi, %ebx
movl -948(%ebp), %ecx
adcl %edi, %ecx
movl %ecx, %esi
movl %ebx, -988(%ebp)
shll $6, %esi
shrl $26, %ebx
movl -936(%ebp), %eax
orl %ebx, %esi
xorl %ebx, %ebx
imull %eax, %ebx
mull -644(%ebp)
shrl $26, %ecx
addl %ebx, %edx
addl %eax, %esi
movl -640(%ebp), %eax
adcl %edx, %ecx
mull -924(%ebp)
movl %eax, %edi
movl -648(%ebp), %eax
movl %ebx, -984(%ebp)
movl %edx, %ebx
mull -928(%ebp)
addl -996(%ebp), %edx
addl %eax, %edi
movl -688(%ebp), %eax
adcl %edx, %ebx
addl %edi, %esi
adcl %ebx, %ecx
xorl %edi, %edi
movl -932(%ebp), %ebx
mull %ebx
imull %ebx, %edi
movl %edx, %ebx
movl %edi, -952(%ebp)
movl %eax, %edi
movl -696(%ebp), %eax
mull -908(%ebp)
addl -952(%ebp), %ebx
addl -992(%ebp), %edx
addl %eax, %edi
adcl %edx, %ebx
addl %edi, %esi
movl %esi, %eax
adcl %ebx, %ecx
xorl %edi, %edi
andl $67108863, %eax
movl %eax, -920(%ebp)
movl -936(%ebp), %eax
mull -684(%ebp)
shll $6, %ecx
shrl $26, %esi
movl -924(%ebp), %ebx
orl %esi, %ecx
movl %eax, %esi
movl -644(%ebp), %eax
movl %ecx, -948(%ebp)
movl %edx, %ecx
mull %ebx
imull %ebx, %edi
addl -984(%ebp), %ecx
addl %edi, %edx
addl %eax, %esi
movl -640(%ebp), %eax
adcl %edx, %ecx
mull -928(%ebp)
addl %eax, %esi
movl -648(%ebp), %eax
adcl %edx, %ecx
mull -932(%ebp)
movl %edi, -980(%ebp)
movl %ecx, -944(%ebp)
movl %eax, %ecx
movl -688(%ebp), %eax
movl %edx, %ebx
movl -908(%ebp), %edx
imull %edx, %edi
mull %edx
addl -952(%ebp), %ebx
addl %edi, %edx
addl %eax, %ecx
movl -944(%ebp), %eax
adcl %edx, %ebx
addl %ecx, %esi
movl -948(%ebp), %ecx
adcl %ebx, %eax
addl %esi, %ecx
movl %ecx, %esi
adcl $0, %eax
xorl %ebx, %ebx
andl $67108863, %esi
shll $6, %eax
shrl $26, %ecx
orl %ecx, %eax
movl %eax, -944(%ebp)
movl -936(%ebp), %eax
imull %eax, %ebx
mull -692(%ebp)
movl %eax, %ecx
movl -684(%ebp), %eax
movl %esi, -916(%ebp)
movl %edx, %esi
mull -924(%ebp)
addl -980(%ebp), %edx
addl %ebx, %esi
addl %eax, %ecx
movl %ebx, -976(%ebp)
movl -644(%ebp), %eax
adcl %edx, %esi
movl -928(%ebp), %edx
imull %edx, %ebx
mull %edx
addl %ebx, %edx
addl %eax, %ecx
movl -640(%ebp), %eax
adcl %edx, %esi
mull -932(%ebp)
movl %ebx, -972(%ebp)
movl %eax, %ebx
movl -648(%ebp), %eax
movl %esi, -940(%ebp)
movl %edx, %esi
mull -908(%ebp)
addl %edi, %edx
addl %eax, %ebx
movl -940(%ebp), %eax
adcl %edx, %esi
addl %ebx, %ecx
movl -944(%ebp), %ebx
adcl %esi, %eax
addl %ecx, %ebx
movl %ebx, %edi
adcl $0, %eax
xorl %ecx, %ecx
andl $67108863, %edi
shll $6, %eax
shrl $26, %ebx
orl %ebx, %eax
movl %eax, -940(%ebp)
movl -880(%ebp), %eax
mull -936(%ebp)
movl %edi, -912(%ebp)
movl %eax, %esi
movl -924(%ebp), %edi
movl %edx, %ebx
movl -692(%ebp), %eax
mull %edi
imull %edi, %ecx
addl -976(%ebp), %ebx
addl %ecx, %edx
addl %eax, %esi
movl -684(%ebp), %eax
adcl %edx, %ebx
mull -928(%ebp)
addl -972(%ebp), %edx
addl %eax, %esi
movl -932(%ebp), %edi
movl -644(%ebp), %eax
adcl %edx, %ebx
mull %edi
imull %edi, %ecx
movl %eax, %edi
movl -640(%ebp), %eax
movl %ecx, -968(%ebp)
movl %edx, %ecx
mull -908(%ebp)
addl -968(%ebp), %ecx
addl %eax, %edi
movl -940(%ebp), %eax
adcl %edx, %ecx
addl %edi, %esi
movl -988(%ebp), %edi
adcl %ecx, %ebx
addl %esi, %eax
movl %eax, %ecx
adcl $0, %ebx
andl $67108863, %edi
shll $6, %ebx
andl $67108863, %ecx
shrl $26, %eax
orl %eax, %ebx
lea (%ebx,%ebx,4), %esi
addl %esi, %edi
cmpl $16, -8(%ebp)
jae poly1305_auth_x86_sse2_30
poly1305_auth_x86_sse2_33:
cmpl $0, -8(%ebp)
je poly1305_auth_x86_sse2_44
poly1305_auth_x86_sse2_34:
testb $8, -8(%ebp)
jne poly1305_auth_x86_sse2_36
poly1305_auth_x86_sse2_35:
xorl %eax, %eax
jmp poly1305_auth_x86_sse2_37
poly1305_auth_x86_sse2_36:
movl -636(%ebp), %eax
movl (%eax), %edx
movl 4(%eax), %ebx
movl $8, %eax
movl %edx, -24(%ebp)
movl %ebx, -20(%ebp)
poly1305_auth_x86_sse2_37:
testb $4, -8(%ebp)
je poly1305_auth_x86_sse2_39
poly1305_auth_x86_sse2_38:
movl -636(%ebp), %edx
movl (%eax,%edx), %ebx
movl %ebx, -24(%ebp,%eax)
addl $4, %eax
poly1305_auth_x86_sse2_39:
testb $2, -8(%ebp)
je poly1305_auth_x86_sse2_41
poly1305_auth_x86_sse2_40:
movl -636(%ebp), %edx
movzwl (%eax,%edx), %ebx
movw %bx, -24(%ebp,%eax)
addl $2, %eax
poly1305_auth_x86_sse2_41:
testb $1, -8(%ebp)
je poly1305_auth_x86_sse2_43
poly1305_auth_x86_sse2_42:
movl -636(%ebp), %esi
movzbl (%eax,%esi), %edx
movb %dl, -24(%ebp,%eax)
incl %eax
poly1305_auth_x86_sse2_43:
movl $0, -8(%ebp)
movb $1, -24(%ebp,%eax)
movl -24(%ebp), %eax
movl %eax, %esi
andl $67108863, %esi
movl -20(%ebp), %ebx
addl %edi, %esi
movl %esi, -936(%ebp)
movl %ebx, %esi
shll $6, %esi
shrl $26, %eax
movl -16(%ebp), %edx
orl %eax, %esi
movl %edx, %eax
andl $67108863, %esi
shll $12, %eax
shrl $20, %ebx
orl %ebx, %eax
andl $67108863, %eax
addl -916(%ebp), %eax
movl -12(%ebp), %ebx
movl %eax, -928(%ebp)
movl %ebx, %eax
shll $18, %eax
shrl $14, %edx
orl %edx, %eax
andl $67108863, %eax
shrl $8, %ebx
addl -920(%ebp), %esi
addl %ecx, %ebx
addl -912(%ebp), %eax
movl %esi, -924(%ebp)
movl %eax, -932(%ebp)
movl %ebx, -908(%ebp)
jmp poly1305_auth_x86_sse2_31
poly1305_auth_x86_sse2_44:
movl %edi, %ebx
andl $67108863, %edi
shrl $26, %ebx
movl -920(%ebp), %edx
addl %ebx, %edx
movl %edx, %ebx
shrl $26, %edx
andl $67108863, %ebx
movl -916(%ebp), %eax
addl %edx, %eax
movl %eax, %esi
shrl $26, %eax
andl $67108863, %esi
movl -912(%ebp), %edx
addl %eax, %edx
movl %edx, %eax
shrl $26, %edx
andl $67108863, %eax
addl %edx, %ecx
movl %ecx, %edx
shrl $26, %ecx
andl $67108863, %edx
movl %edx, -952(%ebp)
movl %eax, -1000(%ebp)
lea (%ecx,%ecx,4), %ecx
lea (%edi,%ecx), %edx
movl %edx, %edi
andl $67108863, %edx
shrl $26, %edi
addl %edi, %ebx
movl %edx, -948(%ebp)
addl $5, %edx
movl %edx, -996(%ebp)
shrl $26, %edx
addl %ebx, %edx
movl %edx, %ecx
andl $67108863, %edx
shrl $26, %ecx
addl %esi, %ecx
movl %ecx, %edi
andl $67108863, %ecx
shrl $26, %edi
addl %eax, %edi
movl %edi, -992(%ebp)
shrl $26, %edi
movl -952(%ebp), %eax
lea -67108864(%edi,%eax), %eax
movl %eax, -988(%ebp)
shrl $31, %eax
decl %eax
movl %eax, %edi
andl %eax, %ecx
notl %edi
andl %eax, %edx
andl %edi, %esi
andl %edi, %ebx
orl %ecx, %esi
orl %edx, %ebx
movl -992(%ebp), %ecx
andl $67108863, %ecx
movl -1000(%ebp), %edx
andl %eax, %ecx
andl %edi, %edx
movl %edi, -984(%ebp)
orl %ecx, %edx
movl -948(%ebp), %ecx
andl %edi, %ecx
movl -996(%ebp), %edi
andl $67108863, %edi
andl %eax, %edi
orl %edi, %ecx
movl %ebx, %edi
shll $26, %edi
orl %edi, %ecx
movl 20(%ebp), %edi
shrl $6, %ebx
addl 16(%edi), %ecx
movl %ecx, -948(%ebp)
movl $0, %ecx
adcl $0, %ecx
movl %ecx, -980(%ebp)
movl %esi, %ecx
shll $20, %ecx
orl %ecx, %ebx
xorl %ecx, %ecx
addl 20(%edi), %ebx
adcl $0, %ecx
movl %ecx, -976(%ebp)
movl %edx, %ecx
shrl $12, %esi
shll $14, %ecx
orl %ecx, %esi
addl 24(%edi), %esi
movl %esi, -972(%ebp)
movl $0, %esi
adcl $0, %esi
movl %esi, -968(%ebp)
movl -984(%ebp), %esi
movl -988(%ebp), %ecx
andl -952(%ebp), %esi
andl %eax, %ecx
orl %ecx, %esi
shrl $18, %edx
shll $8, %esi
orl %esi, %edx
movl 8(%ebp), %esi
addl -980(%ebp), %ebx
movl -976(%ebp), %ecx
adcl $0, %ecx
addl 28(%edi), %edx
movl %ebx, 4(%esi)
movl -972(%ebp), %ebx
addl %ecx, %ebx
movl -948(%ebp), %eax
movl %eax, (%esi)
movl -968(%ebp), %eax
adcl $0, %eax
addl %eax, %edx
movl %ebx, 8(%esi)
movl %edx, 12(%esi)
poly1305_auth_x86_sse2_50:
movl -960(%ebp), %ebx
movl -956(%ebp), %esi
movl -964(%ebp), %edi
leave
ret

.section .rodata, "a"
.p2align 4,,15
poly1305_x86_sse2_message_mask:
.long 67108863
.long 0
.long 67108863
.long 0
.p2align 4,,15
poly1305_x86_sse2_5:
.long 5
.long 0
.long 5
.long 0
.p2align 4,,15
poly1305_x86_sse2_1shl128:
.long 16777216
.long 0
.long 16777216
.long 0
