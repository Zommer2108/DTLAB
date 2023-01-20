/*
 * Aufgabe7.c
 *
 *  Created on: 17.01.2023
 *      Author: Roman Zimmer
 *
 * Aufgabe : Bit-Manipulation
 */


#include "LPC21XX.h"
#include <stdint.h>

int main()
{
	unsigned int a = 0x12345678; 				//Basiswert (in int 305419896)
	unsigned int b = (a & 0xF00) >> 8;			//in int 6 (Erst Maske anwenden und dann um 2 Nibble nach rechts schieben)
	unsigned int c = ~a;						//in int 3989547399
	unsigned int d = a | ~0xF0;					//in int 4294967167 (Invertierte Maske damit jedes Bit zu einer 1 wird, aber das Nibble nicht)

}

void IRQ_Routine (void) {while (1) ;}
void FIQ_Routine (void) {while (1) ;}
void SWI_Routine (void) {while (1) ;}
void UNDEF_Routine (void) {while (1) ;}
