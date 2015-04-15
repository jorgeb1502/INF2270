	.globl f3

# f3(int a, int b, int c) = if a < 0 ? b : c

f3:	
	push 	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	addl	$0, %eax
	js		ret1
	jmp 	ret2

ret1:
	movl	12(%ebp), %eax
	pop		%ebp
	ret

ret2:
	movl	16(%ebp), %eax
	pop		%ebp
	ret
