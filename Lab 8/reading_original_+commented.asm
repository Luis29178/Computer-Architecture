############################################################################################################
#						Part 1							   #
#	1)	What is the first two bytes of the bmp file? Info in the file "Part1_1_signature"	   #
#	2)	What is the file size? 	Info in the file "Part1_2_File Size"				   #
#	3)	What is the Bits Per Pixel value for this file? Info in file "Part1_3_BPP"		   #													   #
#													   #
#													   #							
############################################################################################################								
	.data
file:	.asciiz "pillarscipher.bmp"
fileout: .asciiz "pillarscipher.bmp"
size:	.space 54
size2:	.space 54

	.text
	#open file
	la	$a0, file	#address of file name to open	
	li	$v0, 13		#open file code
	li	$a1, 0		#0 for read-only, 1 for write-only with create, and 9 for write-only with create and append. It ignores mode.
	syscall
	move	$s0, $v0	#saving the file descriptor
	
	#read file 
	li	$v0, 14		#read from file
	move	$a0, $s0	#file descriptor	$s0 is the file descriptor
	la	$a1, size	#input buffer
	li	$a2, 54		#characters to read
	syscall
	
	#reading file size
	la	$t0, size
	addi	$t0, $t0, 6	#last byte of the four bytes of info
	li	$a0, 4		#how many times the endianness needs to loop
	jal	Endian		#s2 contains the file size
	move	$t3, $s2	#t3 now contains that info DO NOT USE T3
	
	#allocating on the heap
	li	$v0, 9
	subu	$a0, $t3, 54 	#number of bytes to allocate on heap
	syscall
	move	$s3, $v0	#s3 has the heap address
	
	#reading whole file
	move	$a1, $s3	#heap address
	li	$v0, 14		#read from file
	move	$a0, $s0	#file descriptor	$s0 is the file descriptor
	subu	$a2, $s2, 54	#characters to read
	syscall

	move	$t1, $s3	#moves heap adress to $t1
	addi	$t1, $t1, 19200 #adjusts address to location of city
							
	lb	$t2, ($t1)	#loads bite into $t2 shifted by 0 bit = 'P' 
	lb	$t3, 1($t1)	#loads bite into $t3 shifted by 1 bit = 'a'
	lb	$t4, 2($t1)	#loads bite into $t4 shifted by 2 bit = 'r'
	
	addi	$t1, $t1, 5	#shifts address by 5
	lb	$t2, ($t1)	#loads bite into $t2 shifted by 0 bit = '*'
	lb	$t3, 1($t1)	#loads bite into $t3 shifted by 1 bit = '*'
	lb	$t4, 2($t1)	#loads bite into $t4 shifted by 2 bit = '*'
	
	li	$t3, 80		#loads imidate 80
	#lb	$t3, $t1
	
	sb	$t3, ($t1)	#saves bite 'P' in address of $t1
	li	$t3, 65		#loads imidate 65
	sb	$t3, 1($t1)	#saves bite'a' in address of $t1
	li	$t3, 82		#loads imidate 82
	sb	$t3, 2($t1)	#saves bite'r' in address of $t1
	li	$t3, 73		#loads imidate 73
	sb	$t3, 3($t1)	#saves bite'i' in address of $t1
	li	$t3, 83		#loads imidate 83
	sb	$t3, 4($t1)	#saves bite's' in address of $t1
	li	$t3, 42		#loads imidate 42
	addi	$t1, $t1, 5	#shifts address by 5
	li	$t2, 3		#loads imidate 3
loop:	beq	$t2, 0, donel	#compares $t2 == 0
	sb	$t3, ($t1)	#saves bite '*' in address of $t1
	addi	$t1, $t1, 1	#shifts adress by 1
	subi	$t2, $t2, 1	#decraments counter
	j	loop		#jumps to loop
	
	#subi	$t0, $t0, 1
	#addi	$t1, $t1, 4
	#beq	$t0, $zero, donel
	#j	loop

donel:	
	
	#writing to file
	#open file
	la	$a0, fileout	#address of file name to open	
	li	$v0, 13		#open file code
	li	$a1, 1		#0 for read-only, 1 for write-only with create, and 9 for write-only with create and append. It ignores mode.
	syscall
	move	$s6, $v0	#saving the file descriptor
	
	#read file 
	#li	$v0, 14		#read from file
	#move	$a0, $s6	#file descriptor	$s0 is the file descriptor
	#la	$a1, size2	#input buffer
	#li	$a2, 54		#characters to read
	#syscall
	#write header
	move	$a0, $s6	#file descriptor
	li	$v0, 15
	la	$a1, size	#heap address
	li 	$a2, 54	#number of characters to write
	syscall
	#write to file
	move	$a0, $s6	#file descriptor
	li	$v0, 15
	move	$a1, $s3	#heap address
	subu 	$a2, $s2, 54	#number of characters to write
	syscall
	

	
	#close file 1
	li	$v0, 16
	move	$a0, $s0
	syscall

	#close file 2
	li	$v0, 16
	move	$a0, $s6
	syscall
			
	li	$v0, 10
	syscall
#conversts from edian to # of bits to read
Endian:	subi	$t0, $t0, 1
	subi	$a0, $a0, 1
	lbu	$t1, ($t0)
	or	$s2, $t1, $s2
	beq	$a0, 0, done	
	sll	$s2, $s2, 8
	j	Endian
done:	jr	$ra
