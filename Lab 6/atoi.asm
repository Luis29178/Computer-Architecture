#########################################################################################################
#			Recives values from Main							#
#	$a0 will contain the string									#
#	$a1 will contain the length of string								#
#########################################################################################################

.data
.text
.globl atoi
atoi:
		
		move $t0,$a0 		#sets address
		move $t9,$a1 
		move $t8 , $zero   	 #initialises .xx container
		move $t6 , $zero   	 #initialises xx. container
		li $t7 , 1		 #tracks index on char for .xx
		li $s0 , 1		 #tracks index on char for xx.
		
		
	
	add $t5, $t5 ,1
	add $s5, $s5 ,1
	move $t3, $zero
	move $t2, $zero
	
Indexer: 
	lb  $t1,0($t0)		 #stores the byte inputed by the user in adress stored
	add $t5, $t5 ,1		 
	addiu $t0,$t0,1		 #will >> the address of input
	beq $t1,46,Indexer2	 #Checks the char for '.' delimeter
	add $t2,$t2,1
	j Indexer
		
		
Indexer2:
	
	lb  $t1,0($t0)		 #stores the byte inputed by the user in adress stored
	add $t5, $t5 ,1
	addiu $t0,$t0,1		 #will >> the address of input
	beq $t1,10, indexSkip
	j Indexer2
	
indexSkip:
	move $t0,$a0    	#resets address
	
	
#Int
asciipreLooper2:
		li $t4, 2
		li $s0, 1

decibase2:		
		mul $s0,$s0,10
		add $t4,$t4,1
		ble $t4,$t2,decibase2
				
asciiLooper2: 		

		lb $t1, 0($t0)	 	 #stores the byte inputed by the user in adress stored in $t0 + its incremnt from the loop
		addiu $t0,$t0,1		 #will >> the address of input
		beq $t1 ,46 ,asciipreLooper # checks for '.' 
		beq $t1,10,ErrorSkip
		add $t1, $t1, -48	 #converts to bites int value
		bgt $t1, 9, Error1       #checks if char @ t1 > 9 inn int value
		bltz $t1, Error1	 #checks if char @ t1 < 0 inn int value

		mul $t1,$t1,$s0    	 #multiplyes t1 and t7 giving its n'th int value (t1 @ t7)
		add $t6,$t6,$t1		 #adds curent chars int value to ($t8)
		div $s0,$s0,10		 #increases index for conversion (10^t7)
		
		j asciiLooper2



#Decimal

		
asciipreLooper:
		li $t4, 1
		li $s0, 1
		li $s7, 1

decibase:		
		mul $s0,$s0,10
		add $t4,$t4,1
		ble $t4,4,decibase
		mul $s1,$s0,10
		
					

asciiLooper:	
		
		lb $t1, 0($t0)	 	 #stores the byte inputed by the user in adress stored in $t0 + its incremnt from the loop		
		addiu $t0,$t0,1		 #will >> the address of input	
		beq $t1,10,ErrorSkip	 
		add $t1, $t1, -48	 #converts to bites int value
		bgt $t1, 9, Error1       #checks if char @ t1 > 9 inn int value
		bltz $t1, Error1	 #checks if char @ t1 < 0 inn int value
		mul $t1,$t1,$s0    	 #multiplyes t1 and t7 giving its n'th int value (t1 @ t7)
		add $t8,$t8,$t1		 #adds curent chars int value to ($t8)
		div $s0,$s0,10		 #increases index for conversion (10^t7)
		beqz $t1,ascLooperSS
		li $s7,1
		j asciiLooper
ascLooperSS:
		mul $s7,$s7,10
												
		j asciiLooper
	
				
						

Error1:		
		li $v0, 1			#Sets type<T> to Error	
		li $v1, 1			#Sets return value to error 1 {INVALID INT}					
		j ErrorSkip				
						
								
#Error2:	
#		blt $t8, 6553565536, ErrorSkip 	#checks int to be less <= 16bit MAX_INT_VALUE == 65535 & 16bit MAX_DECIMAL_VALUE == 65535
#		li $v0, 1			#Sets type<T> to Error	
#		li $v1, 2			#Sets return value to error 2 {OUTSIDE PERAMETERS}																	
#		#Returns to root
#		jr $ra
		


	
ErrorSkip:
													
			
		li $t4, 65536 #load 2^16 to t4		
    		
		    		    		
		#Int ($t6 * $t4) == (int *2^16)
		mul $t6,$t6,$t4 #($t6 * $t4)

		
		add $t8,$t8,$t6 #$t8 + $t6


		#prints the int Converted from string												
		li $v0 ,35 
		move $a0,$t8
		syscall
		
		#prints the int Converted from string												
		li $v0 ,11
		li $a0,10
		syscall
		
		li $v0, 0		#resets $v0 for Main pass error check
		li $v1, 0		#resets $v0 for Main pass error check									
		#Returns to root
		jr $ra
