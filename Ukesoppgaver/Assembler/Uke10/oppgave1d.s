	.globl f4

# f4(int a, int b) = (a^2 + b^2)/2

f4:
	push	%ebp
	movl 	%esp, %ebp

	movl 	8(%ebp), %eax
	mull	%eax
	movl	%eax, %ebx
	movl	12(%ebp), %eax
	mull	%eax
	addl	%ebx, %eax
	movl 	$2, %ebx
	divl	%ebx

	pop 	%ebp
	ret
