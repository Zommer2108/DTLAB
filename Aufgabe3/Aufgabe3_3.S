/*
 * Aufgabe3_3.S
 *
 *  Created on: 02.11.2022
 *      Author: Roman
 *
 * Aufgabe : Unterprogrammaufruf mit Übergabe mehrerer Parameter – Division
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	mov r0, #6
	mov r1, #2
	bl div32
    b stop

stop:
nop
bal stop


div32:
// R0 - dividend
// R1 - divisor
// R2 - error
// r3
// R4 - Quotient

	stmfd sp!, {r4, lr}
	mov r2, #0
	movs r1, r1
	bne division
	mov r2, #1
	b end

	division:
		mov r4, #0

		loop_start:
			add r4, r4, #1
			subs r0, r0, r1
			bcs loop_start

		b loop_end

	loop_end:
		add r0, r0, r1
		sub r4, #1
		mov r1, r4
		b end

	end:

		ldmfd sp!, {r4,pc}
.end

