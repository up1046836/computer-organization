.data
i: .word 0
k: .word 20
save: .word 20 20 20 14

.text
.globl main
main:
	lui $s1, 0x1001
	lw $s3, 0($s1)			# $s3 = i
	lw $s5, 4($s1)			# $s5 = k
	addi $s6, $s1, 8		# base of save[]: s6 = 0x1001008
loop:   
	sll $t0, $s3, 2     		# i = i*4
	add $t0, $t0, $s6   		# $t0 = i*4 + base = address of save[i]
	lw $t0, 0($t0)      		# $t0 = save[i]
	bne $t0, $s5, exit
	addi $s3, $s3, 1   		# i = i + i
	j loop
exit: 
	ori $v0, $zero, 10
	syscall