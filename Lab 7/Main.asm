.data
input:	 	.space 32
trnsy:		.space 16
trnsx:		.space 16
cordx:		.space 32
cordy:		.space 32
cordtrnsx:	.space 32
cordtrnsy:	.space 32
tab:		.asciiz "\n"
prompty: 	.asciiz "Enter Y translation: "	
promptx: 	.asciiz "Enter X translation: "
promptc:  	.asciiz "Enter the cordinates of a qadrilateral in (X,Y);(X,Y);(X,Y);(X,Y) format: "
registersx:	.asciiz "X cordinates: "
registersy:	.asciiz "Y cordinates: "
PROMPT1:	.asciiz "Invalid Input!"


.text
.globl main
main:
	#Asked the Uuser for a qudrilaterals cordinates
		
			#calls promtc
				li $v0,4
				la $a0, promptc
				syscall
			#Stores user input in :input:
				li $v0,8
				la $a0,input	
				li $a1, 25    	##Max numbeer of chars for format
				syscall
			# calls tab
				li $v0,4
				la $a0,tab
				syscall
			
			
	#Ask for X & Y translatin
		
		#X translation
		
			# calls promptx
				li $v0,4
				la $a0,promptx
				syscall
			#Stores input in :trnsx:
				li $v0,8
				la $a0,trnsx
				li $a1,4	##Sets a limit between -999 --> 9999 translation
				syscall
			# calls tab
				li $v0,4
				la $a0,tab
				syscall	
			
		#Y translation
		
			# calls prompty
				li $v0,4
				la $a0,prompty
				syscall
			#Stores input in :trnsy:
				li $v0,8
				la $a0,trnsy
				li $a1,4	##Sets a limit between -999 --> 9999 translation
				syscall
			# calls tab
				li $v0,4
				la $a0,tab
				syscall
			
		#################################################################################			
		#				Now You Hold:					#
		#			tag   :		info		: format : Langth	#
		#										#
		#			input : (X,Y);(X,Y);(X,Y);(X,Y) : string : 23		#	
		#			trnsx :	translation for x	: string :		#
		#			trnsx :	translation for x	: string :		#
		#			cordx :container for x cordinats: bianary: 32bit	#
		#			cordy :container for y cordinats: bianary: 32bit        #
		#										#
		#										#
		#################################################################################			
			
			#initialising variables needed for Cordinate translation
				la $t1, input
				la $t2, cordx		#will contain 32bit int for cordx
				la $t3, cordy		#will contain 32bit int for cordy
				move $t4,$zero
				li $t8,1
				li $t5,0
				addiu $t2,$t2,3 	#adjust adress
				addiu $t3,$t3,3		#adjust adress
			#loopa will determin were to send the bit cordinate or to skip a bit
			 loopa:
			    	lb $t4, 0($t1)		#loads bite @ $t1
			    	addiu $t1, $t1, 1 	# >> increment the adress
			    	beq $t4, 40, loopx	# if '(' go to loopx
			    	beq $t4, 44, loopy 	# if ',' go to loopy
			    	beq $t4, 10, loopaexit	# if string nullterm exit loop
			    	j loopa
			    
			#loopx will store the cordinates in :cordx:
			    loopx:

				lb $t4, 0($t1)		#loads bite @ $t1
				addiu $t1, $t1, 1 	# >> increment the adress
				sub $t4, $t4, 48		#converts to int
				
				#checks for valid int in cordinate positions
				bltz $t4, ERROR		
				bgt $t4, 9, ERROR
				
	
				#mul $t4, $t4, $t8	#Adjusts int to position in cordx
				sb $t4,0($t2)
				subiu $t2, $t2, 1	
				
				
				
				j loopa
				
			#loopx will store the cordinates in :cordy:
			    loopy:

				lb $t4, 0($t1)		#loads bite @ $t1
				addiu $t1, $t1, 1 	# >> increment the adress
				sub $t4, $t4, 48		#converts to int
				
				#checks for valid int in cordinate positions
				bltz $t4, ERROR		
				bgt $t4, 9, ERROR

				#mul $t4, $t4, $t8	#Adjusts int to position in cordy
				sb $t4,0($t3)
				subiu $t3, $t3, 1	
				
				
				
				j loopa

			  loopaexit:
			  
			  
			  	#calls print vianary on cordtrnsx
			  	li $v0,35
			  	lw $a0,cordx
			  	syscall
			  	# calls tab
				li $v0,4
				la $a0,tab
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
			  	#calls print vianary on cordtrnsx
			  	li $v0,35
			  	lw $a0,cordy
			  	syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
			
			  	la $a0,trnsx
			  	jal stringLen
			  	move $s7,$v1
			  	li $s0 ,1
			  	li $t5, 0
			  	
			 
			 
			 lengthloopx:
			 	addiu $t5,$t5,1
			  	bge $t5,$s7,lengthloopxexit
			 	mul $s0,$s0, 10
			  	j lengthloopx
			 lengthloopxexit:	
			 	 	
			 	la $t2, trnsx
			 	la $t0, cordtrnsx
			  	li $t8,0
			 looptx:
			 	lb $t4,0($t2)
			 	addiu $t2,$t2,1
			 	beq $t4,45,looptxs
			 	beq $t4,10,exitlooptx
			 looptxa:
			 	sub $t4,$t4,48
			 	mul $t4,$t4,$s0
			 	div $s0,$s0,10
			 	add $t8,$t8,$t4
				j looptx
			 looptxs:
			 	div $s0,$s0,10
			   subtxs:
			   	lb $t4, 0($t2)
			   	addiu $t2,$t2,1
			   	beq $t4,10,exitsubtxs
			   	sub $t4,$t4,48
			   	add $t8,$t8,$t4
			   	j subtxs
			   exitsubtxs:
			   	li $t5,4
			   	sublooploadxs:
			   	sb $t8,0($t0)
			   	addiu $t0,$t0,1
			   	subiu $t5,$t5,1
			   	bgtz $t5,sublooploadxs
			   	
			   	li $s4,1
			   	
			   	j EXITLOOPALLX
			   	
			   exitlooptx:
			   	li $t5,4
			   	sublooploadxa:
			   	sb $t8,0($t0)
			   	addiu $t0,$t0,1
			   	subiu $t5,$t5,1
			   	bgtz $t5,sublooploadxa
EXITLOOPALLX:			  
			  	#calls print bianary on cordtrnsx
			  	li $v0,35
			  	lw $a0,cordtrnsx
			  	syscall
			  	# calls tab
				li $v0,4
				la $a0,tab
				syscall
			  	# calls tab
				li $v0,4
				la $a0,tab
				syscall
			  	
			  	la $a0,trnsy
			  	jal stringLen
			  	move $s7,$v1
			  	li $s0 ,1
			  	li $t5, 0
			  	
			 
			 
			 lengthloopy:
			 	addiu $t5,$t5,1
			  	bge $t5,$s7,lengthloopyexit
			 	mul $s0,$s0, 10
			  	j lengthloopy
			 lengthloopyexit:	
			 	 	
			 	la $t2, trnsy
			 	la $t0, cordtrnsy
			  	li $t8,0
			 loopty:
			 	lb $t4,0($t2)
			 	addiu $t2,$t2,1
			 	beq $t4,45,looptys
			 	beq $t4,10,exitloopty
			 looptya:
			 	sub $t4,$t4,48
			 	mul $t4,$t4,$s0
			 	div $s0,$s0,10
			 	add $t8,$t8,$t4
				j loopty
			 looptys:
			 	div $s0,$s0,10
			   subtys:
			   	lb $t4, 0($t2)
			   	addiu $t2,$t2,1
			   	beq $t4,10,exitsubtys
			   	sub $t4,$t4,48
			   	add $t8,$t8,$t4
			   	j subtys
			   exitsubtys:
			   	li $t5,4
			   	sublooploadys:
			   	sb $t8,0($t0)
			   	addiu $t0,$t0,1
			   	subiu $t5,$t5,1
			   	bgtz $t5,sublooploadys
			   	
			   	li $s5,1
			   	
			   	j EXITLOOPALLY
			   	
			   exitloopty:
			   	li $t5,4
			   	sublooploadya:
			   	sb $t8,0($t0)
			   	addiu $t0,$t0,1
			   	subiu $t5,$t5,1
			   	bgtz $t5,sublooploadya
EXITLOOPALLY:
			  	#calls print bianary on cordtrnsx
			  	li $v0,35
			  	lw $a0,cordtrnsy
			  	syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
			  
			  	lw $t0,cordx
			  	lw $t1,cordy
			  	lw $t2,cordtrnsx
			  	lw $t3,cordtrnsy
			  	
			  	beq $s4,1,subtractX
			  	add $t0,$t0,$t2 	#adds the translation to the x cordinates
			  	j subtractXskip
			  	subtractX:
			  	sub $t0,$t0,$t2		#subtracts the translation to the x cordinates
			  subtractXskip:
			 	sw $t0,cordx
			  
			  	beq $s5,1,subtractY
			  	add $t1,$t1,$t3 	#adds the translation to the y cordinates
			  	j subtractYskip
			  	subtractY:
			  	sub $t1,$t1,$t3		#subtracts the translation to the y cordinates
			  subtractYskip:
			  	sw $t1,cordy
			  
			   #calls print bianary on cordx
			  	li $v0,35
			  	lw $a0,cordx
			  	syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
			   #calls print bianary on cordy
			  	li $v0,35
			  	lw $a0,cordy
			  	syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				
				
				li $v0,4
				la $a0,registersx
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				
				la $t0,cordx
				la $t1,cordy
				addiu $t0,$t0,3
				addiu $t1,$t1,3
				li $t5,0
			intxloop:
				li $v0,1
				lb $a0,0($t0)
				subiu $t0,$t0,1
				add   $t5,$t5,1
				syscall
				blt $t5,4,intxloop
				
				
				
				
				
				
				
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				
				li $v0,4
				la $a0,registersy
				syscall
				# calls tab
				li $v0,4
				la $a0,tab
				syscall
				
				li $t5,0
			intyloop:
				li $v0,1
				lb $a0,0($t1)
				subiu $t1,$t1,1
				add   $t5,$t5,1
				syscall
				blt $t5,4,intyloop	
				
				
				
				
				
				
				
				
			  
			j ERRORSKIP
			#call prompt for error
			ERROR:
			#calls PROMPT1
				li $v0,4
				la $a0, PROMPT1
				syscall
			# calls tab
				li $v0,4
				la $a0,tab
				syscall
			ERRORSKIP:
			
			li $v0,10
			syscall
			
