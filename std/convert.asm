.include "../src/std/const.asm"
.section .text

###############################
##  txttouint(txt, length)   ##
##  returns uint in %eax     ##
###############################
##############################
##  txttoint(txt, length)   ##
##  returns int in %eax     ##
##############################
##############################
##   uinttotxt(uint, txt)   ##
##  returns length in %eax  ##
##############################
##############################
##    inttotxt(int, txt)    ##
##  returns length in %eax  ##
##############################

.type 	txttouint, @function
txttouint:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	$1, %eax
xorl	%ebx, %ebx
movl	12(%ebp), %ecx
decl	%ecx
movl	$BASE10, %edi
movl	%ecx, %esi

txttouint_loop:
decl	%esi
pushl	%edi
pushl	%eax

movl	8(%ebp), %edx
movb	(%edx, %esi, 1), %al
andl	$0xf, %eax

popl	%edi
mull	%edi

addl	%eax, %ebx
movl	%edi, %eax
popl	%edi
mull	%edi
loop	txttouint_loop 

movl	%ebx, %eax

movl 	%ebp, %esp
popl 	%ebp
ret

#####################################

.type	txttoint, @function
txttoint:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

xorl	%eax, %eax
xorl	%ecx, %ecx
movl	12(%ebp), %ebx
movl	8(%ebp), %edi
movb	(%edi), %al

xorl	$MINUS_CHAR, %eax
jnz	texttoint_pre_no_sign

incl	%edi
decl	%ebx
texttoint_pre_no_sign:

pushl	%eax
pushl	%ebx
pushl	%edi
call	txttouint
addl	$8, %esp

popl	%ebx
andl	%ebx, %ebx

jnz	texttoint_no_sign
not	%eax
incl	%eax
texttoint_no_sign:

movl	%ebp, %esp
popl	%ebp
ret

##############################

.type 	uinttotxt, @function
uinttotxt:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	8(%ebp), %eax
movl	$BASE10, %ebx
xorl	%ecx, %ecx
movl	12(%ebp), %edi
xorl	%esi, %esi

pre_uinttotxt_loop:
xorl	%edx, %edx
div	%ebx
pushl	%edx
incl	%ecx
cmpl	$0, %eax
jne	pre_uinttotxt_loop

movl	%ecx, %eax
incl	%eax

uinttotxt_loop:
popl	%ebx
orl	$0x30, %ebx
movb	%bl, (%edi, %esi, 1)
incl	%esi
loop 	uinttotxt_loop

movb	$NEWLINE_CHAR, (%edi, %esi, 1)

movl 	%ebp, %esp
popl 	%ebp
ret

#######################################

.type	inttotxt, @function
inttotxt:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

xorl	%ecx, %ecx
movl	8(%ebp), %eax
movl	12(%ebp), %ebx
andl	%eax, %eax

jns	pre_inttotxt_no_sign
not	%eax
incl	%eax

movb	$MINUS_CHAR, (%ebx)
incl	%ebx
incl	%ecx
pre_inttotxt_no_sign:

pushl	%ecx
pushl	%ebx
pushl	%eax
call	uinttotxt
addl	$8, %esp

popl	%ebx
andl	%ebx, %ebx
jz	inttotxt_no_sign
incl	%eax
inttotxt_no_sign:

movl	%ebp, %esp
popl	%ebp
ret

