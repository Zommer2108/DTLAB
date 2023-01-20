/*
 * Aufgabe7.c
 *
 *  Created on: 17.01.2023
 *      Author: Roman Zimmer
 *
 * Aufgabe : GPIO-Ausgabe
 */


#include "LPC21XX.h"
#include <stdint.h>
#define LED_MASK					(0xff << 16)
#define DELAY						0xA0000

void leds();
void delay(unsigned int delayTime);

void leds() {
		while(1){
			unsigned int startLed = 0x10000;

			for(unsigned int i = 0; i < 8; i++) {
				IOSET1 = startLed;
				delay(DELAY);
				IOCLR1 = startLed;
				startLed <<= 1;
			}
		}
	}

void delay(unsigned int delayTime) {
	while(delayTime > 0) {
		delayTime--;
	}
}


int main()
{

	IODIR1 = LED_MASK;
	leds();

	return 0;
}

void IRQ_Routine (void) {while (1) ;}
void FIQ_Routine (void) {while (1) ;}
void SWI_Routine (void) {while (1) ;}
void UNDEF_Routine (void) {while (1) ;}
