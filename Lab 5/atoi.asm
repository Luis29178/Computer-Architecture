#########################################################################################################
#			Recives values from Main							#
#	$a0 will contain the string									#
#	$a1 will contain the length of string								#
#########################################################################################################
.data
.text
.globl atoi
atoi:
		
		move $t0,$a0 
		move $t9,$a1 
		move $t8 , $zero   	 #initialises int container
		li $t7 , 1		 #tracks index on char for conversion
		
#will place $t7 as the final int exmpl: 42 will move to index 4[2] 		
	add $t5, $t5 ,1
Indexer:
	add $t5, $t5 ,1
	mul $t7, $t7, 10
	blt $t5,$t9,Indexer
			#########################################################################################################
			#						asciiLooper						#
			#				$t1 = to the cahr value when lb						#
			#		 		$t7 = Bit index * 10							#
			#						Math:							#
			#				$t8 == (t1 @ t7) * 10^t7						#
			#########################################################################################################		
		
asciiLooper:	
		
		lb $t1, 0($t0)	 	 #stores the byte inputed by the user in adress stored in $t0 + its incremnt from the loop
		beq $t1 ,10 , Error2, 	 #ends loop onece ascii char == 10 a delimeterr to deterin the end of the strin
		add $t1, $t1, -48	 #converts to bites int value
		bgt $t1, 9, Error1       #checks if char @ t1 > 9 inn int value
		bltz $t1, Error1	 #checks if char @ t1 < 0 inn int value

		mul $t1,$t1,$t7    	 #multiplyes t1 and t7 giving its n'th int value (t1 @ t7)
		add $t8,$t8,$t1		 #adds curent chars int value to ($t8)
		div $t7,$t7,10		 #increases index for conversion (10^t7)
		addiu $t0,$t0,1		 #will >> the address of input
		j asciiLooper
		

Error1:		
		li $v0, 1			#Sets type<T> to Error	
		li $v1, 1			#Sets return value to error 1 {INVALID INT}					
		j ErrorSkip				
						
								
Error2:	
		blt $t8, 65536, ErrorSkip 	#checks int to be less <= 16bit MAX_INT_VALUE == 65535
		li $v0, 1			#Sets type<T> to Error	
		li $v1, 2			#Sets return value to error 2 {OUTSIDE PERAMETERS}																	
		#Returns to root
		jr $ra


ErrorSkip:	
		#prints the int Converted from string												
		li $v0 ,1 
		move $a0,$t8
		syscall	
		
		li $v0, 0		#resets $v0 for Main pass error check
		li $v1, 0		#resets $v0 for Main pass error check									
		#Returns to root
		jr $ra
