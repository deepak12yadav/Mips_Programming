	.data
print_msg: 			.asciiz 	"Enter the order of the square matrix whose determinant is to be found :"
print_msg1: 		.asciiz 	"Enter some positive integer for the value of the seed s:"
print_msg2: 		.asciiz 	"The matrix passed on this invocation is:"
print_msg3: 		.asciiz 	"The determinant value returned in this invocation is : "
print_msg4: 		.asciiz 	"	"
print_msg5: 		.asciiz 	"\n"
print_msg6: 		.asciiz 	"DEBUG\n"
print_msg7: 		.asciiz 	"	:"

	.text
main:
	move $fp,$sp 						#	frame pointer 
	move $s7,$ra 						#	storing the return address
	sub $sp,$sp,8						#	(SP)
	la $a0,print_msg
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,-4($fp)						#	storing value of n
	la $a0,print_msg1
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,-8($fp)						#	storing value of s
	lw $s1,-4($fp)						#	$s1 load n
	lw $s2,-8($fp)						#	$s2 load s
	mul $s0,$s1,$s1						#	$s0=n*n
	mul $s0,$s0,4						#	$s0=4*n*n

	sub $sp,$sp,$s0						#	(SP)	space for A
	move $s3,$sp						#	$s3=starting index of array A
	mul $s0,$s1,$s1						#	$s0=n*n


	move $a0,$s3						#	filling A
	move $a1,$s2
	move $a2,$s0
	jal seedmat

	move $a0,$s3						#	printing A
	move $a1,$s1
	jal sqMatPrint

	move $a0,$s3						
	move $a1,$s1
	jal findDet							#	finding determinent

	move $sp,$fp
	move $ra,$s7						#	restoring the address
	jr $ra 								#	exiting the program

######################################################################	
seedmat:
	li $t0,0							#	i
	move $t1,$a1						#	x(n-1)		initially seed
	li $t2,330							#	a
	li $t3,100							#	c
	li $t4,481							#	m
	j seedloop

seedloop:
	beq $t0,$a2,r_mat				#	i==n*n
	sw $t1,0($a0)					#	A[i]=$t1
	add $a0,$a0,4 					#	incrementing array pointer
	mul $t5,$t1,$t2					# 	$t5=X[n]*a
	add $t5,$t5,$t3					#	$t5=(X[n]*a+c)
	divu $t5,$t4					# 	hi=($t5)%($t4)
	mfhi $t1						# 	X[n+1]=.....
	add $t0,$t0,1 					# 	i++
	j seedloop
######################################################################	
sqMatPrint:
	li $t0,0						#	i
	li $t1,0						#	j
	move $t4,$a0					#	$t4=$a0
	j	printloop
	
printloop:
	beq $t0,$a1,r_mat				#	i==n
	beq $t1,$a1,r_s					#	j==n
	mul $t3,$t0,$a1					#	$t3=i*n
	add $t3,$t3,$t1					#	$t3=i*n+j
	mul $t3,$t3,4					#	$t3=(i*n+j)*4
	add $t3,$t3,$t4					#	cell access
	lw $t3,0($t3)					# 	$t3=A[i][j]
	move $a0,$t3					#	printing
	li $v0,1
	syscall
	la $a0,print_msg4
	li $v0,4
	syscall
	add $t1,$t1,1					#	j++
	j printloop
	
r_s:
	li $t1,0						#	j=0
	add $t0,$t0,1					# 	i++
	la $a0,print_msg5
	li $v0,4
	syscall
	j printloop

r_mat:
	jr $ra						
	
######################################################################
getCofactor:	#a0=matrix #a1=temp_mat	#a2=i #a3=n
	sub $sp,$sp,40
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)
	sw $s7,28($sp)
	sw $ra,32($sp)
	sw $fp,36($sp)
	add $fp,$sp,40
	li $t0,0						#	i
	li $t1,0						#	j
	sub $a0,$a0,4					#	we are pointing 1 before the required location
	j d_s_2

loop2:
	beq $t0,$a3,d_mat				#	i==n
	beq $t1,$a3,d_s					#	j==n
	beq	$t1,$a2,d_s_1
	add $a0,$a0,4					#	incrementing the pointer in mat
	lw $t5,0($a0)
	sw $t5,0($a1)
	add $a1,$a1,4
	add $t1,$t1,1					#	j++
	j loop2

d_s_1:
	add $t1,$t1,1					#	j++
	add $a0,$a0,4					#	incrementing the pointer in mat
	j loop2
d_s:
	li $t1,0						#	j=0
	add $t0,$t0,1					# 	i++
	j loop2
d_s_2:
	li $t1,0						#	j=0
	add $t0,$t0,1					# 	i++
	mul $t2,$a3,4					#	$t2=4*n
	add $a0,$a0,$t2					#	incrementing the pointer in mat
	j loop2

d_mat:
	lw $ra,32($sp)
	lw $fp,36($sp)
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)
	lw $s7,28($sp)
	add $sp,$sp,40
	jr $ra	

######################################################################

findDet:	#a0=address #a1=n
	sub $sp,$sp,40			#	(SP)
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	sw $s6,24($sp)
	sw $s7,28($sp)
	sw $ra,32($sp)
	sw $fp,36($sp)
	add $fp,$sp,40

	li $s0,0				#	$s0	Ans=0
	li $s1,1				#	$s1 Sign=1
	li $s2,0
	move $s4,$a0			#	$s4=$a0
	move $s5,$a1			#	$s5=$a1

	la $a0,print_msg2		#	printing message
	li $v0,4
	syscall
	move $a0,$s5		
	li $v0,1
	syscall
	la $a0,print_msg5		#	printing message
	li $v0,4
	syscall
	move $a0,$s4
	move $a1,$s5
	jal	sqMatPrint

	beq $a1,$s1,Base
	sub $s2,$a1,1
	mul $s2,$s2,4			#	$s2=4*(n-1)
	sub $sp,$sp,$s2 		#	(SP)
	move $s6,$sp 			#	$s6 =Starting address of temporary array
	li $s3,0				#	$s3 i=0
	j loop1
loop1:
	beq $s3,$s5,Det_ret
	move $a0,$s4
	move $a1,$s6
	move $a2,$s3
	move $a3,$s5
	jal getCofactor
	mul $t1,$s3,4			#	4*i
	add $t1,$t1,$s4
	lw $t1,0($t1)			#	$t1 =mat[0][i]
	mul $t1,$t1,$s1			#	sign * $t1
	move $a0,$s6			#	address
	sub $a1,$s5,1			#	n-1
	move $s7,$t1
	jal findDet				#	Recursive call
	move $t1,$s7
	mul $t1,$t1,$v0			#   The value to be added
	add $s0,$s0,$t1
	mul $s1,$s1,-1			#	Sign=-Sign
	add $s3,$s3,1
	j loop1

Base:
	lw $s0,0($s4)
	j Det_exit

Det_ret:
	j Det_exit

Det_exit:
	la $a0,print_msg3		#	printing message
	li $v0,4
	syscall
	move $a0,$s5		
	li $v0,1
	syscall
	la $a0,print_msg7		
	li $v0,4
	syscall
	move $a0,$s0		
	li $v0,1
	syscall
	la $a0,print_msg5		
	li $v0,4
	syscall

	move $v0,$s0
	add $sp,$sp,$s2 		#	(SP)
	lw $ra,32($sp)
	lw $fp,36($sp)
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $s6,24($sp)
	lw $s7,28($sp)
	add $sp,$sp,40			#	(SP)
	jr $ra