.data
.text

	li $t1,1
	addiu $t1,0($t1),1
	
	li $v0,5
	move $a0, $t1
	syscall
	
	li $v0,10
	syscall