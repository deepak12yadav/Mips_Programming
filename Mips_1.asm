	.data
print_msg: 			.asciiz 	"Enter the value of k:"
print_msg1: 		.asciiz 	"Enter the count of elements to be read:"
print_msg2: 		.asciiz 	"Enter the element number "
print_msg3: 		.asciiz 	":"
print_msg4: 		.asciiz 	" ,"
print_msg5: 		.asciiz 	"The kth largest number among the elements [ "
print_msg6: 		.asciiz 	"] : "
print_msg7: 		.asciiz 	"\n"
print_msg8: 		.asciiz 	"Sorry value of k should be <= n.\n"

	.text
main:
	move $fp,$sp 						#	frame pointer 
	sub $sp,$sp,8						#	(SP)
	la $a0,print_msg
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,0($sp)						#	storing value of k
	li $t7,4
	mul $t0,$t7,$v0
	sub $sp,$sp,$t0						#	(SP) allocating space to array 
	la $a0,print_msg1
	li $v0,4
	syscall
	li $v0,5
	syscall
	sw $v0,-4($fp)						#	storing value of n
	lw $t8,-8($fp)
	blt $v0,$t8,Error
	move $t6,$v0						# 	n
	addi $t6,$t6,1						#	n++
	move $a0,$sp 						#	starting of array
	move $a1,$sp 						#	array present size loaded
	sub $a2,$fp,8						#	storing the end of array
	li $a3,1							#	count=1
	sub $sp,$sp,8						#	(SP)
	sw $fp ,4($sp)
	sw $ra,0($sp)

	jal fun

	la $a0,print_msg6
	li $v0,4
	syscall
	lw $t7,-12($fp)						#	loading the kth largest no
	move $a0,$t7						#	printing the kth largest no
	li $v0,1
	syscall
	la $a0,print_msg7
	li $v0,4
	syscall

	lw $fp ,4($sp)						#	restoring
	lw $ra,0($sp)
	move $sp,$fp						#	(SP)
	jr $ra

fun:
	beq $t6,$a3,ftom					#	end of the recursive calls
	move $t5,$sp
	sub $sp,$sp,24						#	(SP)
	sw $a0,-4($t5)
	sw $a1,-8($t5)
	sw $a2,-12($t5)
	sw $a3,-16($t5)
	sw $fp,4($sp)
	sw $ra,0($sp)
	move $fp,$t5

	la $a0,print_msg2					#	printing promt
	li $v0,4
	syscall
	move $a0,$a3
	li $v0,1
	syscall
	la $a0,print_msg3
	li $v0,4
	syscall

	li $v0,5							#	reading the integer
	syscall
	move $t0,$v0
	sub $sp,$sp,4						#	(SP)	space for storing no
	sw $t0,0($sp)						#	storing the number read for later use 
	lw $t1,-4($fp)						#	loop variable to search in array

whiloop1:	#	checking the array
	beq $t1,$a1,check1					#	to check if i==end of array size 
	lw $t3,0($t1)						#	load no at arrayindex
	bge	$t0,$t3,whiloop2	#	check if the no is >= then already present in array
	addi $t1,$t1,4						#	i++
	j whiloop1

whiloop2:
	beq $t1,$a1,check1					#	$to check if i==end_array_s
	lw $t3,0($t1)						#	load no at arrayindex
	sw $t0,0($t1)						#	placing the temp content to array
	move $t0,$t3						#	updating temp 
	addi $t1,$t1,4						#	i++	
	j whiloop2

check1:
	beq	$t1,$a2,funend					# end of array
	sw $t0,0($t1)						#	adding integer to array
	addi $a1,$a1,4						#	increading the end of array
	j funend

funend:
	addi $a3,$a3,1						#	count++
	lw $a0,-4($fp)						# 	loading the start of the array
	jal fun 							#	recursive call to fun()

	lw $t0,0($sp)
	move $a0,$t0						#priting the "no ,"
	li $v0,1
	syscall
	la $a0,print_msg4
	li $v0,4
	syscall

	lw $a0,-4($fp)						#	restoring 
	lw $a1,-8($fp)
	lw $a2,-12($fp)
	lw $a3,-16($fp)
	lw $fp,8($sp)
	lw $ra,4($sp)
	addi $sp,$sp,28						#	(SP)
	jr $ra 								# return 
	
ftom:
	la $a0,print_msg5
	li $v0,4
	syscall
	jr $ra 								#return 
Error:
	la $a0,print_msg8
	li $v0,4
	syscall
	jr $ra