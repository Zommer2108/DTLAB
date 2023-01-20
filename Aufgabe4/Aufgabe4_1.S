 /*
 * Beispiel.S
 *
 *  Created on: 27.11.2022
 *      Author: Roman
 *
 * Aufgabe : Verwendung des Stacks
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */

.global _startup /* Specify global symbol */
_startup:

	//Stack-Pointer sp = r13 <- darf nicht manipuliert werden
	/*
		1. Aufruf von Unterprogramm, pc = r15 -> lr = r14 laden
			und auf Stack
		2. vor Rückkehr lr = r14 -> pc = r15

		r13, r14, r15 = Nur für die Behandlung von Subroutinen/UP
		r4 - r12 = lokale Variabeln in der Subroutine
		r0 - r3 = Parameterübergabe für Subroutinen
	*/

	ldr sp, =0x40001000
		ldr r0, =0
		ldr r1, =0
		ldr r2, =0
		ldr r3, =0
		bl sub1

stop:
	nop
	bal stop


sub1:
	stmfd sp!, {r0, lr}
	ldr r0, =1
	bl sub2
	ldmfd sp!, {r0, pc}

sub2:
	stmfd sp!, {r0, r1, lr}
	ldr r1, =2
	bl sub3
	ldmfd sp!, {r0,r1, pc}

sub3:
	stmfd sp!, {r0, r1, r2, lr}
	ldr r2, =3
	bl sub4
	ldmfd sp!, {r0, r1, r2, pc}

sub4:
	stmfd sp!, {r0, r1, r2, r3, lr}
	ldr r3, =4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r7, r3
	ldmfd sp!, {r0, r1, r2, r3, pc}

.end
