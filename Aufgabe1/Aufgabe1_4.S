/*
 * Aufgabe_1_4.S
 *
 *  Created on: 02.10.2020
 *      Author: tavin
 *
 *	Aufgabe : Addition mit Abbruch in einer Schleife
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global _startup /* Specify global symbol */
_startup:

	//Zahl 25 wird ins zweite Register per Movebefehl geladen
	mov r0, #25
	//Zahl 25 wird ins zweite Register per Movebefehl geladen
	mov r1, #204

	/*Nach dem Additionsbefehl wird zurück zum Befehl gesprungen
	  aber dieses mal wird überprüft, ob die Carry Flag bei einem
	  Überlauf gesetzt wurde. Falls sie gesetzt ist, wird die Schleife
	  verlassen
	  */
	repeat: adds r0,r0,r1
		mov r2, r0
		bcc repeat //gilt solange die cary nicht gesetzt wurde
		b //branch wird ausgeführt kann als für Sprünge benutzt werden
	/*
		Maximal Wert:
		32bit = 2^32-1
		16bit = 2^16-1
		8bit = 2^8-1
	*/
stop:
nop
bal stop
.end
