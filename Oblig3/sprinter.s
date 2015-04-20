

	.globl sprinter

sprinter:
	push	%ebp		# Standard
	movl	%esp, %ebp 	# Standard

switch:
	movl	12(%ebp), %edx	# Move format-pointer to %EDX
	movl 	8(%ebp), %ebx   # Move result-pointer to %EBX

	movb	(%edx), %al 	# Move first byte to %AL
	cmpb	$37, %al 		# Compare with ASCII '%'
	je		format 			# If '%' is found, jump to format

	cmpb	$0, %al 		# Compare with ASCII '\0'
	je		finished		# If '\0', jump to finished

	movb	%al, (%ebx)		# Move byte from format-pointer to result-pointer

	incl	12(%ebp)		# Increment format-pointer
	incl	8(%ebp)			# Increment result-pointer

	jmp 	switch

format:
	movb 	$63, (%ebx)

	incl	12(%ebp)		# Increment format-pointer
	incl	8(%ebp)			# Increment result-pointer

	jmp 	switch

finished:
	movb	$0, (%ebx)

	pop 	%ebp
	ret
