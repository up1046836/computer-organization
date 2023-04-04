.data
var1: .word 0xffffffff
var2: .word 0xffffffff

.text
.globl main
main:	lui $t0, 0x1001
	lw $s3, 4($t0)
	lw $s2, 0($t0)
	multu $s3, $s2
	
loop:	beq $s3, $zero, exit
	andi $t0, $s3, 1	# last digit of multiplier
	beq $t0, $zero, cont	# if digit is 1 add otherwise continue
	
	nor $t0, $s5, $zero	# 2s compliment of s5: 2^32-s5-1
	addu $s5, $s5, $s2	# add s2 to lower 32 bits
	sltu $t0, $t0, $s2	# carry of addition: 1 if 2^32-s5-1 < s2 => 2^32-1 < s2+s5
	addu $s4, $t0, $s4	# add carry to upper 32 bits
	addu $s4, $s4, $s1	# add s1 to upper 23 bits
	
cont: 	srl $t0, $s2, 31	# last digit of lower 32 bit of multiplicand
	sll $s1, $s1, 1		# shift s1
	add $s1, $s1, $t0	# append last digit of s2 to s1
	sll $s2, $s2, 1		# shift s2
	srl $s3, $s3, 1		# shift s3
	j loop
	
exit:	addi $v0, $zero, 10
	syscall