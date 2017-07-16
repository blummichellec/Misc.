.text
.global _start
	_start:

movia r1, 0x10000020 #HEX display base address
movia r2, 0x10000040 #SW Switches base address	
movia r3, myArray #Array base address

BEGIN:
# <ADD COMMENT>
	ldwio r4, 0(r2) #Load the value of the switches into register 4
	andi  r4, r4, 0xF #Isolates 4 least significant bits

# Placing register 3 and then register 4 into the stack as parameters for the ArrayProcessor subroutine
	addi sp, sp, -8
	stw r3, 4(sp)  
	stw r4, 0(sp) 

# Call the ArrayProcessor subroutine
	call ArrayProcessor

# Display the return value on the hex display 
	stbio r8, 0(r1)

	br BEGIN	# Return to the BEGIN label

ArrayProcessor:
# Make a copy of the stack pointer using the frame pointer
	addi sp, sp, -4
	stw fp, 0(sp) 
	or fp, sp, r0

# Find the element requested by the slide switches and store this value into register 8 
	add  r8, r3, r4
	ldb  r8, 0(r8)

# Restore registers r3, r4, and the stack pointer
	ldw r3, 8(fp)
	ldw r4, 4(fp)
	ldw sp, 0(fp)

ret	# Return to the place in the code directly after the subroutine is called

.data

	myArray:	# Array used as the data for the array processor
		.byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

	# Skipping memory in the system and dedicating it to the stack
	STACKBOTTOM: .skip 0x100	
	STACKTOP:
	.end