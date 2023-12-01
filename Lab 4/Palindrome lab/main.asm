#########################################################################################
#The .data section is memory that is allocated in the data segment of memory 		#
#Include the following in this section.  						#
#Use the .space directive to allocate several things:					#
#	space for user input								#						#
#Use .asciiz directive to create several things (not limited to):			#
#	a user prompt									#
#	message alerting user if the input is a palidrome or not a palidrome		#				#
#########################################################################################
		.data	
prompt:		.asciiz "Enter the size of map. Use  format HxW: "
buffer: 	.space 256
output: 	.asciiz "container.bmp"
testpass:	.asciiz "This is a Palindrome!"
testfail: 	.asciiz "This is not a Palindrome!?"

#########################################################################################
#The .text section is executed at runtime.						#
#Include the following in this section.  						#	
#Ask user for a string input.								#
#Call the stringLen by using the jal instruction and the appropriate label.		#
#	use caller/callee convention							#
#	pass any argument(s) by placing them in the $a0-$a3 registers			#
#	#read any return values by looking in $v0-$v1 after calling the function	#
#Call the PaliChecker by using the jal instruction and the appropriate label.		#
#	use caller/callee convetion							#
#	pass any argument(s) by placing them in the $a0-$a3 registers			#
#	#read any return values by looking in $v0-$v1 after calling the function	#
#Print out the length of the user input.						#
#Print out if the user inputed a palidrome.						#
#Exit syscall										#
#########################################################################################
	.text
	.globl main
	main:
	#Print Prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#Call For User Input
	li $v0, 8		#Sets call to read String
	la $a0, buffer		#Sets Buffer ++ allows other files to access in $a0 ++
	la $a1, 256		#Sets max length of input
	syscall
	
	
	###############################################################################
	#Note: to acces functions from files with this jal method it is neccesery to  #
	#store in values in $a0?$a3 registers and return values from $v0 & $v1	      #
	#!!! aswell as in setting assemble all files in direcory must be check on !!! #
	###############################################################################
	
	jal stringLen		#Calls file by link stringLen
	move $a1, $v1 		#moves recived value to $a1 ++ allows other files to access in $a1 ++
	move $v1,$zero          #resets #v0
	jal paliChecker         #Calls file by link paliChecker
	
	
	beq  $v1, 1, PaliPass      #will call message for if the userer inputed a palindrome
	
	#prints fail message then EXITS
	li $v0,4
	la $a0,testfail
	syscall
	j EXIT

PaliPass:
	 #prints pass message then EXITS
	 li $v0,4
	 la $a0,testpass
	 syscall
EXIT:	 				
	#Exits
	li $v0,10
	syscall
	
		
	
		
		
		
		
