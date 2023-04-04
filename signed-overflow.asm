.text
.globl main
main: 	lui $s0, 0x7ffe
	lui $s1, 0x0001

	xor $t0, $s0, $s1		# t0 < 0 for opposite signs
	slt $t1, $t0, $zero		# t1 = 1 for opposite signs
	bne $t1, $zero, no_overflow
	addu $t2, $s0, $s1
	xor $t2, $t2, $s0
	slt $t1, $t2, $zero 
	bne $t1, $zero, exit
	
no_overflow:
	add $s2, $s0, $s1		# does not produce exception
	
exit: 	addi $v0, $zero, 10
	syscall