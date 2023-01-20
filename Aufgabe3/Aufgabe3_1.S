	/*
	 * Aufgabe 3_1.S
	 *
	 *  Created on: 03.11.2022
	 *      Author: Roman
	 *
	 * Aufgabe : Unterprogrammaufruf – Delay
	 */
	 .data
	 .global datastart
			datastart:
			.word 0x01
			.word 0x02
			.word 0x03
			.word 0x04
			.word 0x05

	.text /* Specify that code goes in text segment */

	.equ NUMVALS, 5

	.code 32 /* Select ARM instruction set */
	.global _startup /* Specify global symbol */
	_startup:
		//TODO optimise
		//same code from 2_3
		mov r3, #NUMVALS
		ldr r5, =datastart

		loop_start:
			ldr r6, [r5], #4
			adds r4, r6, r4
			bl delay
			bcc nocarry
			add r2, r2, #1

		nocarry:
			subs r3, r3, #1
			bne loop_start
			b stop

	stop:
	nop
	bal stop

	delay:
		stmfd sp!, {r7, lr}
		ldr r7, =1

		wait:
			subs r7,r7,#1

		ldmfd sp!, {r7,pc}

	.end
