.data
prompt0:	.ascii "Enter up to a 16 bit int: "
input:		.space 32
error0: 	.ascii "NOT AN INT!!! Try again"
error1: 	.ascii "OUTSIDE PERAMETERS!!! Try again"
endl:		.ascii "\n"	



.text
#########################################################################################################
#			Error will be called and reset the loop						#
#	Will use $s0 &if == 0 Defult condition {NO ERROR} will be met 					#
#	Will use $s0 &if == 1 Error0 condition {INVALID INT} will be met				#
#	Will use $s0 &if == 2 Error1 condition {OUTSIDE PERAMETERS} will be met				#
#########################################################################################################

beq $s0,0,ERRORskip
beq $s0,1,ERROR0
beq $s0,2,ERROR1


ERROR0:			
		       #Calls Error 0 prompt
		       li $v0, 4
		       la $a0, error0
		       syscall

		       #Calls Next ln
		       li $v0, 4
		       la $a0, endl
		       syscall
		       
		       #Resets $s0 value to default (0)
		       li $s0,0
		       
		       j EXitall

ERROR1:
		       #Calls Error 1 prompt
		       li $v0, 4
		       la $a0, error1
		       syscall

		       #Calls Next ln
		       li $v0, 4
		       la $a0, endl
		       syscall
		       syscall
		       #Resets $s0 value to default (0)
		       li $s0,0
		       
		       j EXitall




ERRORskip:

###########################################################################################################################################################################################
#						                                   Main Content												  #
###########################################################################################################################################################################################



			#Prints Prompt
			li $v0, 4
			la $a0, prompt0
			syscall		
			#Recive Input
			li $v0, 8
			li $a1, 10		
			la $a0, input
			syscall
			
			#Calls Next ln
		        li $v0, 4
		        la $a0, endl
		        syscall	
		        
			
			#calls function from last Lab to obtain length
			#########################################################################################################
			#						Calls StringLen						#
			#		Will return length of string from adress stored in $a0 into $v1 			#
			#########################################################################################################
			la $a0, input			#loads the input adress back into $a0			 
			jal stringLen
			move $a1,$v1			#Moves returned value into $a1  for use In atoi
				       
		       
		          
			

			#########################################################################################################
			#					       Calls atoi						#
			#		Will use values stored in $a0 as string perameter					#
			#		Will use values stored in $a1 as string length 						#
			#		Will return Error code     								#
			#		if $v0 = 1 returns error code in $v1							#
			#########################################################################################################
			la $a0, input			#loads the input adress back into $a0
			jal atoi
			beq $v1,2,ERROR1
			beq $v1,1,ERROR0
			
			
			
			
EXitall:			
			#Exit Program
			li $v0, 10
			syscall
