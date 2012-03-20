.include "../src/std/const.asm"
.section .text

############################
##  zeromem(txt, length)  ##
############################

.type 	zeromem, @function
zeromem:
pushl	%ebp
movl	%esp, %ebp
subl	$4, %esp

movl	8(%ebp), %eax
movl	12(%ebp), %ecx
movl	%ecx, %esi

zeromem_loop:
decl	%esi
movb	$0, (%eax, %esi, 1)
loop	zeromem_loop

movl 	%ebp, %esp
popl 	%ebp
ret


