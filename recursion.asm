.text
.globl main
main: 
	addi $a0, $zero, 5
	jal fact
	add $a0, $zero, $v0
	addi $v0, $zero, 1
	syscall 
	addi $v0, $zero, 10
	syscall

fact:
	slti $t0, $a0, 1
	beq $t0, $zero, l1
	addi $v0, $zero, 1
	jr $ra

l1:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	addi $a0, $a0, -1
	jal fact
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	mul $v0, $a0, $v0
	jr $ra