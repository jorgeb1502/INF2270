	.globl sprinter

sprinter:
	pushl	%ebp			# Standard
	movl	%esp, %ebp 		# Standard

	movl	$0, %ecx		# %ECX = byte-counter
	
	movl	8(%ebp), %ebx	# Move result-pointer to %EBX
	movl	12(%ebp), %edx	# Move format-pointer to %EDX
	addl	$16, %ebp		# (%ebp) is now first variable argument

main_loop:
	movb	(%edx), %al 	# Move first byte to %AL
	
	cmpb	$37, %al 		# Compare with ASCII '%'
	je		format_switch 	# If '%' is found, jump to format_switch

	cmpb	$0, %al 		# Compare with ASCII '\0'
	je		finished		# If '\0', jump to finished

	movb	%al, (%ebx)		# Move byte from format-pointer to result-pointer

	jmp 	inc_pointers 	# Increment pointers, push them to stack and continue main_loop

format_switch:
	incl	%edx			# Increment format-pointer to byte after '%'
	movb	(%edx), %al 	# Move first byte to %AL
	
	cmpb	$37, %al 		# Compare with ASCII '%'
	je		format_percent  # If '%' is found, jump to format_percent

	cmpb	$99, %al 		# Compare with ASCII 'c'
	je		format_char 	# If 'c' is found, jump to format_char

	cmpb    $100, %al		# Compare with ASCII 'd'
	je		format_int 		# If 'd' is found, jump to format_int
	
	cmpb    $102, %al 		# Compare with ASCII 'f'
	je		format_float 	# If 'f' is found, jump to format_float
	
	cmpb    $115, %al 		# Compare with ASCII 's'
	je		format_string	# If 's' is found, jump to format_string
	
	cmpb    $120, %al 		# Compare with ASCII 'x'
	je		format_hex 		# If 'x' is found, jump to format_hex

	movb	$63, (%ebx) 	# No valid format, put '?' in result-pointer

	jmp 	inc_pointers 	# Increment pointers, push them to stack and continue main_loop

format_percent:
	movb	$37, (%ebx) 	# Put '%' in result-pointer

	jmp 	inc_pointers 	# Increment pointers, push them to stack and continue main_loop

format_char:
	movb	(%ebp), %al 	# Move character to %AL for writing to pointer
	movb	%al, (%ebx) 	# Write character to result-pointer

	addl	$4, %ebp		# (%ebp) now points to next argument

	jmp 	inc_pointers 	# Increment pointers, push them to stack and continue main_loop

format_string:
	movl	(%ebp), %eax 	# Move string address to %EAX 
	movb	(%eax), %al 	# Move first character of string to %AL

	cmpb	$0, %al 		# Check for end of string
	je		str_finished 	# Finished copying string

	movb 	%al, (%ebx) 	# Write character to result-pointer
	incl 	%ecx 			# Increment byte-counter
	incl 	%ebx 			# Increment result-pointer
	incl 	(%ebp) 			# Increment string pointer

	jmp 	format_string 	# Read next character of the string

str_finished:
	addl 	$4, %ebp 		# (%ebp) is now the next argument

	incl	%edx 			# Increment format-pointer

	jmp 	main_loop 		# Continue program loop

format_float:
	pushl 	%ecx 			# Push %ECX to stack before function-call 
	pushl 	%edx 			# Push %EDX to stack before function-call

	# TODO!!!

	fldl 	(%ebp) 			# Push Float to stack
	pushl	%ebx 			# Push result-pointer to stack
 
	call	my_ftoa	 		# call my_ftoa(format-pointer, 64-bit float)

	addl	$4, %esp 		# Remove result-pointer used inn call from stack
	popl 	%edx 			# Pop previous %EDX back into %EDX
	popl 	%ecx 			# Pop previous %ECX back into %ECX

inc_float_str:
	movb 	(%ebx), %al 	# Move character to %AL
	
	cmpb 	$0, %al 		# Check if character is '\0'
	je 		float_finished  # Found end of string

	incl 	%ecx 			# Increment byte-counter
	incl 	%ebx 			# Increment result-pointer 

	jmp 	inc_float_str   # Continue searching for '\0'	
	
float_finished:
	addl	$8, (%ebp) 		# (%ebp) is now the next argument 	

	incl 	%edx 			# Increment format-pointer

	jmp 	main_loop 		# Continue program loop */

format_int:

format_hex:

placeholder:
	movb	$63, (%ebx) 	# All flags not coded yet will be '?'

inc_pointers:
	incl	%ecx 			# Increment byte-counter
	incl	%edx			# Increment format-pointer
	incl	%ebx			# Increment result-pointer

	jmp 	main_loop
	
finished:
	movb	$0, (%ebx) 		# NULL-Terminates the result-pointer
	movl 	%ecx, %eax 		# Moves number of bytes written to %eax for return

	popl 	%ebp			# Pop original %ebp back into %ebp
	ret 					# Returns number of bytes written to result-pointer
 