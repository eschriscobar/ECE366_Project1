# Var A = $9 (1-100)
# Var B = $8 = 0xFA19E366
# addr = $10
# loopCount = $11
# Var C = $12
# temp1 = $14
# temp2 = $15
# MultFoldCount = $13

lui $8, 0xFA19
ori $8, $8, 0xE366


addi $9, $0, 1
ori $10, $0, 0x2020
addi $11, $0, 100
addi $13, $0, 5


loop_100:
	loop_MF:
	mult $9, $8
	mfhi $15
	mflo $14
	xor $9, $15, $14
	addi $13, $13, -1
	bne $13, $0, loop_MF


sw $9, 0($10)

addi $13, $0, 5
addi $9, $9, 1
addi $10, $10, 4
addi $11, $11, -1

bne $11, $0, loop_100
