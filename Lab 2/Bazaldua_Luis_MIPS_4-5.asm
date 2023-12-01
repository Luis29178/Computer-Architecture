	.data

	.text
	
	
	
	li $t1, 0 # int Accumilator
	li $t2, 0 # int J
	li $t3, 0 # int I
	li $t4, 5 # int to compare with J
	li $t5, 3 # int to compare with I
	li $t6, 1 # int 1
	li $t7, 2 # int 2
	
#start of J for loop
	 	
forj:	add $t0, $t1, $t6 # accu += 1
	move  $t1, $t0
	move $t0,$zero
#start of I for loop
forI:	blt $t5,$t3 , passI# Skips I loop if I < 3		
	add $t0, $t1, $t7 # accu += 2
	move $t1, $t0
	move $t0, $zero
#end of I loop
	add $t0, $t3, $t6 # Incrament I by 1 and clears $t0 for other operations
	move $t3, $t0
	move $t0, $zero
	li $v0, 1
	move $a0, $t3
	syscall
	blt $t3, $t5, forI# returns it to start of I if I < 3	
#end of J loop
passI:	add $t0, $t2, $t6# Incrament J by 1 and clears $t0 for other operations
	move $t2, $t0
	move $t0, $zero
	
	move $t3, $zero# clears I for next J loop
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	blt $t2, $t4, forj# returns it to start of J if J < 5
	
	
	li $v0, 10
	syscall
