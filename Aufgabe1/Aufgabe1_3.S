/*
 * Aufgabe_1_3.S
 *
 *  Created on: 19.10.2022
 *      Author: Roman Zimmer
 *
 *	Aufgabe : Addition vieler Zahlen in einer Schleife
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	//Zahl 25 wird ins zweite Register per Pseudobefehl geladen
	mov r0, #25
	//Zahl 204 wird ins dritte Register per Pseudobefehl geladen
	mov r1, #204

	//Nach dem Additionsbefehl wird zurück zum Befehl gesprungen
	repeat: add r0,r0,r1
	b repeat

stop:
nop
bal stop
.end
