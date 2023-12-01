		.data
plainText:	.space 10		#allocates 10 bytes of data


prompt0:	.asciiz "Please enter # of cordinate:"
prompt1:	.asciiz "Please enter a cordinate:"
prompt2:	.asciiz "Please enter a key:"





		.text
		la $t1, plainText
		#Prompt for # of byte
		li $v0,4 		#loads instruction to print string
		la $a0, prompt0 	#loads the Adress of prompt
		syscall			#calls the command
		
		#ReadCordinate
		li $v0,5		#loads instruction to read an int
		syscall			#calls the command and will load the users input in $v0
		
		#Storing user input == Number of cordinates in $t0 for loop
		sb   $v0, plainText
		move $t0, $v0
		move $t5, $v0
		
		
		
UserInputLoop:	#Prompt for # of byte
		li $v0,4 		#loads instruction to print string
		la $a0, prompt1 	#loads the Adress of prompt
		syscall			#calls the command
			
		#ReadCordinate
		li $v0,5		#loads instruction to read an int
		syscall			#calls the command and will load the users input in $v0
		
		#Storing user input in datain
		sb $v0, 0($t1)  	#stores the byte inputed by the user in adress stored in $t1 + its incremnt from the loop 
		addi $t1,$t1,1		#will >> the address
		sub $t0,$t0,1		#will decrament the loop counter
		
				
		#Loop Check
		bgtz $t0, UserInputLoop	#check if loop need to execute again
		
		
		#Prompt for key
		li $v0,4 		#loads instruction to print string
		la $a0, prompt2 	#loads the Adress of prompt
		syscall			#calls the command		
		
		#ReadKey
		li $v0,5		#loads instruction to read an int
		syscall			#calls the command and will load the users input in $v0
	
		move  $t4 , $v0   	#stores key in $t4
		
		la $t1, plainText	#loads the adress of the cordinates
		
		#Adding key		
getCord:	blez $t5 , egetCord	
		
		lb $t3, 0($t1)		#loads byte to $t3 from Adress in $t1 +loopiter
		add $t3, $t3, $t4	#adds key to $t3
		sb $t3, 0($t1)		#saves byte back into adress
		addi $t1,$t1,1		#will >> shift the adress
		sub $t5,$t5,1		#decraments loop iterator
		
		#Prints ModedInt
		li $v0, 1
		la $a0, ($t3)
		syscall

		bgtz $t5 , getCord
egetCord:		


		
		#Exit Call
		li $v0, 10
		syscall
		
	
