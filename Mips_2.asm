	.data
print_msg: 			.asciiz 	"Enter three positive integer m,n,s :"
print_msg1: 		.asciiz 	"	"
print_msg2: 		.asciiz 	"\n"
print_msg3: 		.asciiz 	"Printing Array A\n"
print_msg4: 		.asciiz 	"Printing Array B\n"
print_msg5: 		.asciiz 	"DEBUG\n"

	.text
main:
	move $fp,$sp 						#	frame pointer 
	move $s7,$ra 						#	storing the return address
	sub $sp,$sp,12						#	(SP)
	la $a0,print_msg
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,-4($fp)						#	storing value of m
	li $v0,5
	syscall
	sw $v0,-8($fp)						#	storing value of n
	li $v0,5
	syscall
	sw $v0,-12($fp)						#	storing value of s
	lw $s1,-4($fp)						#	load m
	lw $s2,-8($fp)						#	load n
	mul $s0,$s1,$s2						#	$s0=m*n
	mul $s0,$s0,4						#	$s0=4*m*n

	sub $sp,$sp,$s0						#	(SP)	space for A
	move $s5,$sp						#	$s5=starting index of array A
	sub $sp,$sp,$s0						#	(SP)	space for B
	move $s6,$sp						#	$s6=starting index of array B
	mul $s0,$s1,$s2						#	$s0=m*n


	move $a0,$s5						#	filling A
	move $a1,$s0
	lw $a2,-12($fp)
	jal seedmat

	la $a0,print_msg3					#	printing A
	li $v0,4
	syscall
	move $a0,$s5
	move $a1,$s1
	move $a2,$s2
	jal matprint

	move $a0,$s5						#	taking the transpose 
	move $a1,$s6
	move $a2,$s1
	move $a3,$s2
	jal matTrans
	
	la $a0,print_msg4					#	printing B
	li $v0,4
	syscall
	move $a0,$s6
	move $a1,$s2
	move $a2,$s1
	jal matprint

	move $sp,$fp
	move $ra,$s7						#	restoring the address
	jr $ra 								#	exiting the program
	
seedmat:
	li $t0,0							#	i
	move $t1,$a2						#	x(n-1)		initially seed
	li $t2,330							#	a
	li $t3,100							#	c
	li $t4,481							#	m
	j seedloop

seedloop:
	beq $t0,$a1,r_mat				#	i==m*n
	sw $t1,0($a0)					#	A[i]=$t1
	add $a0,$a0,4 					#	incrementing array pointer
	mul $t5,$t1,$t2					# 	$t5=X[n]*a
	add $t5,$t5,$t3					#	$t5=(X[n]*a+c)
	divu $t5,$t4					# 	hi=($t5)%($t4)
	mfhi $t1						# 	X[n+1]=.....
	add $t0,$t0,1 					# 	i++
	j seedloop
	
matprint:
	li $t0,0						#	i
	li $t1,0						#	j
	move $t4,$a0					#	$t4=$a0
	j	printloop
	
printloop:
	beq $t0,$a1,r_mat				#	i==m
	beq $t1,$a2,r_s					#	j==n
	mul $t3,$t0,$a2					#	$t3=i*n
	add $t3,$t3,$t1					#	$t3=i*n+j
	mul $t3,$t3,4					#	$t3=(i*n+j)*4
	add $t3,$t3,$t4					#	cell access
	lw $t3,0($t3)					# 	$t3=A[i][j]
	move $a0,$t3					#	printing
	li $v0,1
	syscall
	la $a0,print_msg1
	li $v0,4
	syscall
	add $t1,$t1,1					#	j++
	j printloop
	
r_s:
	li $t1,0						#	j=0
	add $t0,$t0,1					# 	i++
	la $a0,print_msg2
	li $v0,4
	syscall
	j printloop

r_mat:
		jr $ra						#	return to the caller		USED by both matprint and matTrans and seedmat
	
	
matTrans:
	li $t0,0						#	i
	li $t1,0						#	j
	j mat_loop
	
mat_loop:
	beq $t0,$a2,r_mat				#	i==m
	beq $t1,$a3,m_s					#	j==n
	mul $t3,$t0,$a3					#	$t3=i*n
	add $t3,$t3,$t1					#	$t3=i*n+j
	mul $t3,$t3,4					#	$t3=(i*n+j)*4
	add $t3,$t3,$a0					#	cell access
	lw $t5,0($t3)						# $t5=A[i][j]
	mul $t4,$t1,$a2					#	$t4=j*m
	add $t4,$t4,$t0					#	$t4=j*m+i
	mul $t4,$t4,4					#	$t4=(j*m+i)*4
	add $t4,$t4,$a1					#	cell access
	sw $t5,0($t4)					#	B[j][i]=A[i][j]
	add $t1,$t1,1					#	j++
	j mat_loop
	
m_s:
	li $t1,0						#	j=0
	add $t0,$t0,1					# 	i++
	j mat_loop
