/*
 * Aufgabe 4_2.S
 *
 *  Created on: 30.11.2022
 *      Author: Roman
 *
 * Aufgabe : Arithmetik – Addition zweier 64bit-Zahlen
 */


  .data
 .global datastart
datastart:
variable_a:
.word 0x80000000
.word 0x80000001

variable_b:
.word 0x80000002
.word 0x80000003


.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:
	ldr sp,=0x40001000



	ldr r0,=variable_a	//load address of variable a to r0
	ldr r1,=variable_b	//load address of variable b to r1


	bl add64

stop:
nop
bal stop

/* add two 64Bit numbers
 *
 *	R0 		address of tem1
 *	R1		address of tem2
 *	[R0] 	value
 *	C-Flag	carry
 *	R5 		tem1
 *	R6 		tem2
 */
add64:
	stmfd sp!,{r5,r6,lr}

	ldr r5,[r0]				//load 32 low bits address of tem1
	ldr r6,[r1],#4			//load 32 low bits address of tem2 to post increment by 32 bits of address pointer
	adds r5,r5,r6			//add low bits and sets carry if needed, store in r5
	str r5,[r0]				//store low bits result address of tem1 (low bits)
	ldr r5,[r0, #4]!		//load 32 high bits address of tem1 using pre increment of 32 bits of address pointer
	ldr r6,[r1],#-4			//load 32 low bits address of tem2 to post decrement of 32 bits of address pointer
	adcs r5,r5,r6			//add high bits + carry of low bits and sets carry if needed store in r5
	str r5,[r0],#-4			//store high bits result address of tem1 (high bits) post decrement by 32 bits of address pointer of result

	ldmfd sp!,{r5,r6,pc}

.end

