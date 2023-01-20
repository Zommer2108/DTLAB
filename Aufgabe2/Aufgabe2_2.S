/*
 * Aufgabe2_2.S
 *
 *  Created on: 02.11.2022
 *      Author: Zimmer
 *
 *	Aufgabe : Multiplikation durch wiederholte Addition
 */
.text /* Specify that code goes in text segment */

.code 32 /* Select ARM instruction set */
variable_a: .word 0x123456   // global variable



.global _startup /* Specify global symbol */


_startup:
	init:
		mov r0, #21;	// R0 variable A
		mov r1, #21;	// R1 variable B
		mov r2, #0;	// R2 Low
		mov r3, #0;	// R3 High

	loop_start:
		movs r1,r1
		beq end
		adds r2,r2,r0;
		bcc nocarry
		add r3,r3,#1;

	nocarry: sub r1,r1,#1;
		b loop_start
	end:

stop:
nop
bal stop


.end


