#########################################################################################################
#Include the following in this section.  						 		#
#Add a label after the .globl directive so that instructions in the main file can refer to this file	#
#Include the following functionalities in this file:							#
#	Read argument(s), if any, passed in from the main file. 					#
#	In a loop, test to see if user entered a palidrome.						#
#		Load user via lb and compare the first character with the last character.		#
#	Place the return value (if any) into one of the v registers.					#
#########################################################################################################
.text
.globl	paliChecker
paliChecker:
	#Value Initialization
	li $t4, 0  			#initializes counter for bit detection
	move $t1,$a0 			#moves address of input to $t1
	move $t7,$a1			#moves langeth value to $t7
	sub $t7,$t7,1			#skips nullptr ender	
	move $t0,$a1			#moves langeth value to $s0
	div $t0,$t0,2			#length /2
	li $t9, 0			#initializes couter to zero
	move $t1,$a0			#moves address of input to $t1
	move $t2,$a0			#moves address of input to $t2
	add $t2,$t2,$t7			#sets $t2 to last bit address
	
	#Loop Entry Lable
	xorcLoop:
	bge $t9,$t0 , tpass		#loop couter check 
	lb $t5,0($t1)			#loads bite to $t5
	lb $t6,0($t2)			#loads bite to $t6
	xor  $t8,$t5,$t6		#Xor comparison of $t5 & $t6 returns result to $t8
	bgtz $t8,exorcLoop		#condition check (skip loop if $t8 == 1)
	addiu $t1,$t1,1			#will >> the address
	subiu $t2,$t2,1			#will << the address
	add $t9,$t9,1			#increment counter
				
	j xorcLoop      		#return to loop entry lable
	
	
	#Pass Test
	tpass:
	li $v1 ,1
	j pass
	
	#Fail Test	
	exorcLoop:
	li $v1,0
	pass:

	jr $ra					#Returns to root program/ End of stringLen Function
