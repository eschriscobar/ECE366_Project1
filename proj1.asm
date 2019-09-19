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
# largest C = $18
# div4Loop = $20

#A
lui $8, 0xFA19
ori $8, $8, 0xE366


addi $9, $0, 1
ori $10, $0, 0x2020
addi $11, $0, 100
addi $13, $0, 5

loop_100:

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


# highest = $8
# 100 loop count down = $9
# addr = $10
# highest addr = $11
# 4 check loop = $15
# 4 divide result = $16
# slt = $17
# srl/sll = $18
# final addr = $19
# final addr addr = $20


#Bi

addi $9, $0, 100
addi $15, $0, 2
ori $19, $0, 0x2000
ori $20, $0, 0x2004
ori $10, $0, 0x2020
lbu $8, 0($10)
ori $10, $0, 0x2021

loop_2:
	lbu $18, 0($10)

	slt $17, $18, $8	#if new bit($18) < highest($8), then $17=1
	bne $17, $0, skip	#skips is $17 != 0

	add $8, $18, $0
	add $11, $10, $0

	skip:
	addi $9, $9, -1		# increment 100 loop counter
	addi $15, $15, 1
	addi $10, $10, 1
	bne $9, $0, loop_2

sb $8, 0($19)
sw $11, 0($20)	



#Bii

# $8 = B
# $9 = 100 loop counter
# $10 = addr looper
# $11 = 1 and check bit
# $12 = lbu loop
# $13 = mfhi temp
# $14 = ori temp
# $15 = continuous keeper
# $16 = sll/srl and bit
# $17 = loop_bit counter
# $18 = loop_bit checker
# $19 = and result
# $20 = beq 5
# $21 = 5 const
# $22
# $23 = total 11111 count



ori $10, $0, 0x2020
addi $9, $0, 100
addi $11, $0, 1
addi $13, $0, 255
addi $18, $0, 8
addi $17, $0, 0
addi $21, $0, 5

loop_bii:

	lbu $12, 0($10)
	
	loop_bit:
		addi $16, $12, 0
		
		divu $17, $18
		mfhi $13
		
		ori $14, $0, 0
		beq $13, $14, first_bit
		
		ori $14, $0, 1
		beq $13, $14, second_bit
		
		ori $14, $0, 2
		beq $13, $14, third_bit
		
		ori $14, $0, 3
		beq $13, $14, fourth_bit
		
		ori $14, $0, 4
		beq $13, $14, fifth_bit
		
		ori $14, $0, 5
		beq $13, $14, sixth_bit
		
		ori $14, $0, 6
		beq $13, $14, seventh_bit
		
		ori $14, $0, 7
		beq $13, $14, eighth_bit
				
		first_bit:
		sll $16, $16, 31	# 1
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		second_bit:
		sll $16, $16, 30	# 2
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		third_bit:
		sll $16, $16, 29	# 3
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		fourth_bit:
		sll $16, $16, 28	# 4
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		fifth_bit:
		sll $16, $16, 27	# 5
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		sixth_bit:
		sll $16, $16, 26	# 6
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		seventh_bit:
		sll $16, $16, 25	# 7
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		eighth_bit:
		sll $16, $16, 24	# 8
		srl $16, $16, 31
		and $19, $16, $11
		j end_check
		
		end_check:
		
		add $15, $15, $19
		
		beq $15, $21, oneoneone
		
		beq $19, $0, cont_reset
		
		j no_reset
		
		cont_reset:
		addi $15, $0, 0		#reset
		
		no_reset:
		
		addi $17, $17, 1
		
	bne $17, $18, loop_bit
		
	
	j after_one
	
	oneoneone:
		addi $23, $23, 1	#oneone
		
	after_one:
	
	addi $9, $9, -1		#after_one
	addi $10, $10, 1
	addi $17, $0, 0
	addi $15, $0, 0
bne $9, $0, loop_bii
	
ori $14, $0, 0x2008
sb $11, 0($14)
	
	

