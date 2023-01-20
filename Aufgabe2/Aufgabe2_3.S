/*
 * Beispiel.S
 *
 *  Created on: 03.11.2022
 *      Author: Zimmer
 *
  *	Aufgabe : Berechnung der Summe aus fünf Zahlen an fortlaufenden Adressen
 */
.text /* Specify that code goes in text segment */

.equ NUMVALS, 5

.code 32 /* Select ARM instruction set */


.global _startup /* Specify global symbol */


_startup:
	.equ NUMVALS, 5
	mov r3, #NUMVALS;
	ldr r5, =datstart;

	loop_start:
		ldr r6, [r5], #4;
		adds r4, r6, r4;
		bcc nocarry
		add r7, r7, #1;
	nocarry:
		subs r3, r3, #1;
		bne loop_start
stop:
nop
bal stop

.global datstart
	datstart:
	.word 0x01
	.word 0x02
	.word 0x03
	.word 0x04
	.word 0x05
.end


