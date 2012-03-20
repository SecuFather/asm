.include "../src/std/print.asm"
.include "../src/std/read.asm"
.include "../src/std/util.asm"
.include "../src/std/convert.asm"

##########################
##         var          ##
##########################
.section .data
eax_eq:
.ascii	"eax=\n"
eax_eq_len = . - eax_eq

edx_eq:
.ascii	"edx=\n"
edx_eq_len = . - edx_eq

edi_eq:
.ascii	"edi=\n"
edi_eq_len = . - edi_eq

div_eq:
.ascii	"edx|eax div edi:\n"
div_eq_len = . - div_eq

idiv_eq:
.ascii	"edx|eax idiv edi:\n"
idiv_eq_len = . - idiv_eq

n1:
.ascii	"\0\0\0\0\0\0\0\0\0\0\0"
n1_maxlen = . - n1
n1_len:
.long 0
n1_int:
.long 0

n2:
.ascii	"\0\0\0\0\0\0\0\0\0\0\0"
n2_maxlen = . - n2
n2_len:
.long 0
n2_int:
.long 0

n3:
.ascii	"\0\0\0\0\0\0\0\0\0\0\0"
n3_maxlen = . - n3
n3_len:
.long 0
n3_int:
.long 0

##########################
##       main()         ##
##########################
.section .text
.globl _start
_start:



movl	$0, %edx
movl	$1, %eax
movl	$-1, %edi

div	%edi

pushl	$n1
pushl	%eax
call	inttotxt
addl	$8, %esp
movl	%eax, n1_len

pushl	n1_len
pushl	$n1
call	println
addl	$8, %esp

##########################
##   exit(exit_code)    ##
##########################

movl	$SYS_EXIT, %eax
xorl	$EXIT_SUCCESS, %ebx
int	$LINUX_KERNEL

