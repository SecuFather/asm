.include "../src/std/const.asm"
.section .text

############################
##  println(txt, length)  ##
############################
##########################
##  print(txt, length)  ##
##########################

.type 	println, @function
println:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	$SYS_WRITE, %eax
movl	$STDOUT, %ebx
movl	8(%ebp), %ecx
movl	12(%ebp), %edx
int	$LINUX_KERNEL

movl 	%ebp, %esp
popl 	%ebp
ret

############################

.type 	print, @function
print:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	$SYS_WRITE, %eax
movl	$STDOUT, %ebx
movl	8(%ebp), %ecx
movl	12(%ebp), %edx
decl	%edx
int	$LINUX_KERNEL

movl 	%ebp, %esp
popl 	%ebp
ret

