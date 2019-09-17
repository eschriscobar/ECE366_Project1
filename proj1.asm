# Var A = $9 (1-100)
# Var B = $8 = 0xFA19E366
# addr = $10
# loopCount = $11
# Var C = $12
# temp1 = $14
# temp2 = $15
# temp3 = $16
# Var Ax = $17
# MultFoldCount = $13

lui $8, 0xFA19
ori $8, $8, 0xE366


addi $9, $0, 1
ori $10, $0, 0x2020
addi $11, $0, 100
addi $13, $0, 5


loop_100:

sb $9, 0($10)

addi $17, $9, 0

	loop_MF:
	multu $17, $8
	mfhi $15
	mflo $14
	xor $17, $15, $14
	addi $13, $13, -1
	bne $13, $0, loop_MF

addi $16, $17, 0	# $16 = Ax
srl $16, $16, 16	# A5[31:16]
sll $17, $17, 16
srl $17, $17, 16	# A5[15:0]
xor $12, $16, $17	# C = A5[31:16] XOR A5[15:0]

addi $16, $12, 0	# $16 = C
srl $16, $16, 8		# C[15:8]
sll $12, $12, 24
srl $12, $12, 24	# C[7:0]
xor $12, $16, $12	# C = C[15:8] XOR C[7:0]

sb $12, 0($10)		# Store C in memory

addi $13, $0, 5		# reset MF loop counter
addi $9, $9, 1		# increment A
addi $10, $10, 1	# increment address
addi $11, $11, -1	# increment 100 loop counter

bne $11, $0, loop_100



