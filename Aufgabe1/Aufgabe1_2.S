/*
 * Aufgabe_1_2.S
 *
 *  Created on: 19.10.2022
 *	Author: Roman Zimmer
 *
 *	Aufgabe : Addition mit Pseudobefehlen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	//Zahl 25 wird ins zweite Register per Pseudobefehl geladen
	ldr r1, =25
	//Zahl 204 wird ins dritte Register per Pseudobefehl geladen
	ldr r2, =204
	//Das Ergebnis der Addition wird ins erste Register geladen
	add r0, r1,r2

stop:
nop
bal stop
.end
