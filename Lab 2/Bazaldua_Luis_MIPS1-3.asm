		.data 		
hello:		.asciiz "hello world"
endline: 	.asciiz "\n"
Dend:		.asciiz "\n------------------------------------------------------------\n"
Clearing: .asciiz "Reg, t0 - t5 loaded with Zero from $zero"
	
	#Prints string stored in hello
	.text
	li $v0, 4  	#imidate loads syscall code const int 4 into $v0
	la $a0, hello	#loads adress for char[]== "hello world" (ascii charecter[] because of |.asciiz|) at hello:  to $a0 
	syscall		#calls system to execute code loaded into $v0
	
	#Prints string stored in Dend
	.text
	li $v0, 4
	la $a0, Dend
	syscall
	
	#Prints string stored in endline
	.text
	li $v0, 4
	la $a0, endline
	syscall

	
	# Hello World Modified
	.text
	li $v0, 4  	#imidate loads syscall code const int 4 into $v0
	la $a0, hello	#loads adress for char[]== "hello world" (ascii charecter[] because of |.asciiz|) at hello:  to $a0 
	syscall		#calls system to execute code loaded into $v0
	
	#Prints string stored in endline
	.text
	li $v0, 4
	la $a0, endline
	syscall

	
	#Prints Dend
	.text
	li $v0, 4
	la $a0, Dend
	syscall
	
	#Prints string stored in endline
	.text
	li $v0, 4
	la $a0, endline
	syscall
	
	
	
	
	#Math
	
	#loads all necceseray integers
	li $t1, 5
	li $t2, 2
	li $t3, 10
	li $t4, -2
	
	mul $t0, $t2, $t3
	move $t5, $t0
	add $t0, $t1, $t5
	move $t5, $t0
	add $t0, $t4, $t5
	
	li $v0,1 
	move $a0, $t0 
	syscall
	
	#Prints string stored in endline
	.text
	li $v0, 4
	la $a0, endline
	syscall

	
	#Prints string stored in Dend
	.text
	li $v0, 4
	la $a0, Dend
	syscall
	
	#Prints string stored in endline
	.text
	li $v0, 4
	la $a0, endline
	syscall
	
	
	
	
	#Clearing Registers by loading 0 value from $zero reg.
	
	move $t0, $zero
	move $t1, $zero
	move $t2, $zero
	move $t3, $zero
	move $t4, $zero
	move $t5, $zero
	

	
	#Prints string stored in Clearing
	.text

	li $v0, 4
	la $a0, Clearing
	syscall

	#Prints Spacer
	.text
	li $v0, 4
	la $a0, endline
	syscall
	
	#Prints string stored in Dend
	.text
	li $v0, 4
	la $a0, Dend
	syscall
	
	#Prints Spacer
	.text
	li $v0, 4
	la $a0, endline
	syscall
	
	#Terminate Program
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
