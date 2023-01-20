/*
 * Aufgabe 2_1.S
 *
 *  Created on: 02.11.2022
 *      Author: Zimmer
 *
 *	Aufgabe : 64 Bit Addition
 */
.text /* Specify that code goes in text segment */


.code 32 /* Select ARM instruction set */



.global _startup /* Specify global symbol */


_startup:

	init:
	ldr r0,= 4294967295;	//A High
	ldr r1,= 4294967295;	//B Low
	ldr r2,= 2;	//C High
	ldr r3,= 1;	//D Low

 	adds r6,r1,r3;
 	bcc nocarry_low
 	mov r4,#1;
 	nocarry_low: adds r7,r0,r2;
 	bcc nocarry_high
 	mov r5,#1;
 	nocarry_high: adds r7,r4;
 	bcc stop
 	mov r5,#1;
stop:
nop
bal stop


.end


