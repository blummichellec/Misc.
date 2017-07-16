# © 2017 MICHELLE BLUM ALL RIGHTS RESERVED

/********************************************************************************
 * This program demonstrates the ability to count the E's in a string
 *
 * It performs the following:
 * 	1. converts a string into ASCII values
 * 	2. isolates each letter and checks if it is an E
 *  3. display the number of E's in the string on a red LED
 ********************************************************************************/



.text									/* executable code follows */
	.global	_start
_start:

	movia		r10, 0x10000000		/* red LED base address */
	movia		r11, STRING		    /* string address */
	movi		r2, 0x65            /* storing the ASCII value of the letter E into r2 */
	movi		r15, 1              /* storing the hex value 1 into r15 */
	movi		r16, 2              /* storing the hex value 2 into r16 */
	movi		r17, 3              /* storing the hex value 3 into r17 */

BEGIN:
	ldw			r12, 0(r11)         /* load the ASCII values of the string into r12 (they appear backwards) */

COUNT1:
	slli		r7, r12, 0x18       /* slide the value left by 24 bits and back right by 24 bits in order to isolate the first ASCII letter code */
	srli		r7, r7, 0x18
	addi		r18, r18, 1         /* add 1 to a counter used to control the process */
	beq			r7, r2, ADD         /* if the letter selected is an E, go to ADD label */

COUNT2:
	slli		r8, r12, 0x10       /* slide the value left by 16 bits and back right by 24 bits in order to isolate the second ASCII letter code */
	srli		r8, r8, 0x18
	addi		r18, r18, 1         /* add 1 to a counter used to control the process */
	beq			r8, r2, ADD         /* if the letter selected is an E, go to ADD label */

COUNT3:
	slli		r9, r12, 0x8        /* slide the value left by 8 bits and back right by 24 bits in order to isolate the third ASCII letter code */
	srli		r9, r9, 0x18
	addi		r18, r18, 1         /* add 1 to a counter used to control the process */
	beq			r9, r2, ADD         /* if the letter selected is an E, go to ADD label */

COUNT4:
	srli		r13, r12, 0x18      /* slide the value right by 24 bits in order to isolate the fourth ASCII letter code */
	addi		r18, r18, 0x1       /* add 1 to a counter used to control the process */
	bne			r13, r2, DISPLAY    /* if the letter selected is not an E, go to DISPLAY label */

ADD:
	addi		r14, r14, 0x1       /* add 1 to a counter used to count the E's in a word */
	beq			r18, r15, COUNT2    /* if the program control counter is equal to 1, go to COUNT2 */
	beq			r18, r16, COUNT3    /* if the program control counter is equal to 2, go to COUNT3 */
	beq			r18, r17, COUNT4    /* if the program control counter is equal to 3, go to COUNT4 */

DISPLAY:
	stwio		r14,0(r10)          /* display the value of the E's counter */

/********************************************************************************/
	.data									/* data follows */

STRING:
	.ascii "here"   /* the word used in the E's counter program */
