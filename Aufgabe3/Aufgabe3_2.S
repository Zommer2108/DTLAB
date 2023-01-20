/*
 * Aufgabe3_2.S
 *
 *  Created on: 07.11.2022
 *      Author: Roman
 *
 * Aufgabe : Unterprogrammaufruf mit Parameterübergabe – Delay mit Zeitvariable
 */


.data
.global datastart
datastart:
.word 0x80000000

.text /* Specify that code goes in text segment */

.equ NUMVALS, 5

.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	mov r3, #NUMVALS
	ldr r5, =datastart
	mov r0, #5

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
	stmfd sp!, {r0, lr}

	wait:
		subs r0, r0, #1
		bne wait

	ldmfd sp!, {r0, pc}

.end

