/*
 * Aufgabe_1_1.S
 *
 *  Created on: 13.10.2022
 *      Author: Roman Zimmer
 *
 *	Aufgabe : Addition
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	//Zahl 25 ins zweite Register laden
	mov r1, #25
	//Zahl 204 ins dritte Register laden
	mov r2, #204
	//Das Ergebnis der Addition wird ins erste Register geladen
	add r0, r1,r2

stop:
	nop
	bal stop
.end
