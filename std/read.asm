.include "../src/std/const.asm"
.section .text

############################
##   read(txt, length)    ## 
##  return length in %eax ##
############################

.type 	read, @function
read:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	$SYS_READ, %eax
movl	$STDIN, %ebx
movl	8(%ebp), %ecx
movl	12(%ebp), %edx
int	$LINUX_KERNEL

movl 	%ebp, %esp
popl 	%ebp
ret


