#################################################################################################################
#Include the following in this section.  						 			#
#Add a label after the .globl directive so that instructions in the main file can refer to this file		#
#Include the following functionalities in this file:								#
#	Read argument(s), if any, passed in from the main file.  						#
#	In a loop, load each byte of user input and keep count how many characters are in th user input string.	#
#	Place the return value (if any) into one of the v registers						#
#################################################################################################################
.text
.globl	stringLen	
stringLen:
	
	li $t6,0				#initializes counter to 0
	move $t1,$a0 				#moves the adress store in $a0 in $t1 
	
	#Loop entry lable
	UserInputLoop:	

		#Counting the users input
		lb $t0, 0($t1)  		#stores the byte inputed by the user in adress stored in $t1 + its incremnt from the loop 
		beq $t0,$zero,eUserInputLoop	#exit loop check ($v0 != nullptr/ 0($zero))
		beq $t0, 10 ,eUserInputLoop	#exit loop check ($v0 != newLine(/n)) prevents from counting a newline ascii char witch is repersented as 10 or "/n" 
		addiu $t1,$t1,1			#will >> the address
		addiu $t6,$t6,1			#will decrament the loop counter
		j UserInputLoop			#jumps to the top of the loop
		
	#Loop exit lable	
	eUserInputLoop:			
	move $v1,$t6 				#moves counter to be seen by main in $v1 from $t6
	jr $ra					#Returns to root program/ End of stringLen Function

