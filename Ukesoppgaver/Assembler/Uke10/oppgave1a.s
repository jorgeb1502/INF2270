	.globl f1

# f1(int x) = (x + 1)*4

f1:		pushl	%ebp
		movl	%esp, %ebp

		movl 	$1, %eax
		addl	8(%ebp), %eax
		movl	$4, %ebx
		mull	%ebx

		pop %ebp
		ret
