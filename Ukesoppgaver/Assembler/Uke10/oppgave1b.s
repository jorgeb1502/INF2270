	.globl f2

# f2(int x) = x^4

f2:		push 	%ebp
		movl 	%esp, %ebp

		movl 	8(%ebp), %eax
		movl	8(%ebp), %ebx
		mull	%ebx
		movl	%eax, %ebx
		mull	%ebx

		pop 	%ebp
		ret
