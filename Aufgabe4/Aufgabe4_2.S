/*
 * Aufgabe 4_2.S
 *
 *  Created on: 27.11.2022
 *      Author: Roman
 *
 * Aufgabe : BCD-Addition
 */


  .data
 .global datastart
datastart:

.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:
	ldr sp, =0x40001000
	/*
	A = r0
	B = r1
	numA = r2
	numB = r3
	Count = r4
	Maske = r5
	BCD_cy = r6
	Result = r7
	tem1 = r8
	tem2 = r9
	*/

	//Value A
	ldr r2, =0x12345678
	//Value B
	ldr r3, =0x55555555

	bl addBCD

stop:
nop
bal stop

	/*
		Addition of BCD values

		// R0	result
		// R1	carry
		// R2	numA
		// R3	numb
		// R4	count
		// R5 	mask
		// R6 	BCD_cy
		// R7 	tempResult
		// R8	temp1
		// R9	temp2

	*/


addBCD:
	stmfd sp!, {r4,r5,r6,r7,r8,r9, lr}

		//setting count to 8
		ldr r4, =8
		//setting mask to 0x0f
		mov r5, #0x0f
		//setting result to 0
		ldr r7, =0
		//setting BCD_cy to 0
		ldr r6, =0

	while:
		and r8, r2, r5		//masking first 4-bits with numA to tem1
		and r9, r3, r5		//masking first 4-bits with numB to tem2
		add r8, r8, r9		//adding tem2 and the carry to tem1
		add r8, r6			//adding the carry to tem1
		subs r8, r8, #10 	//subtracting tem1 with 10 to get the values ranging from 0 - 9
		bcs true			//if tem1 is still larger or equal to 0 we set the BCD_cy
		add r8, r8, #10		//if tem1 is smaller than zero we add 10 back to restore the original value
		mov r6, #0			//we set the BCD_cy to 0
		b continue

		true:
			mov r6, #1
			b continue

		continue:
			add r7, r7, r8		//adding tem1 to the tempResult
			mov r2, r2, ror #4	//moving to the next 4 bits of numA
			mov r3, r3, ror #4	//moving to the next 4 bits of numB
			mov r7, r7, ror #4	//moving to the next 4 bits of tempResult
			sub r4, r4, #1		//decrementing counter
			movs r4,r4			//if counter is higher than 0 we loop again
			bne while

	mov r0, r7		//saving the final result from the tempResult
	mov r1, r6		//saving the carry from the BCD_cy
	ldmfd sp!, {r4,r5,r6,r7,r8,r9, pc}


.end
