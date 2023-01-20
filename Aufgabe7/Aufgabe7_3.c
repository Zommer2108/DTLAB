/*
 * Aufgabe7.c
 *
 *  Created on: 17.01.2023
 *      Author: Roman Zimmer
 *
 * Aufgabe : GPIO-Eingabe
 */


#include "LPC21XX.h"
#include <stdint.h>
#include <stdbool.h>
#define LED_MASK					(0xff << 16)
#define DELAY						0xA0000
#define BUTTON_1 			(1<<10) // Button 1 mask 0x400

int buttonPressed(unsigned int button);
void ledsOriginal();
void ledsNew();
void delay(unsigned int delayTime);

int buttonPressed(unsigned int button){

	if(button == true) {
		return 1;
	}
	return 0;
}

void ledsOriginal() {
		while(buttonPressed(BUTTON_1) == 0){
			unsigned int startLed = 0x10000;

			for(unsigned int i = 0; i < 8; i++) {
				IOSET1 = startLed;
				delay(DELAY);
				IOCLR1 = startLed;
				startLed <<= 1;
			}
		}
	}

void ledsNew() {
		while(buttonPressed(BUTTON_1) == 1){
			unsigned int startLed = ~0x10000;

			for(unsigned int i = 0; i < 8; i++) {
				IOSET1 = startLed;
				delay(DELAY);
				IOCLR1 = startLed;
				startLed >>= 1;
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

	while(1){
		while(buttonPressed(BUTTON_1) == 1) {
			ledsNew();
		}
		ledsOriginal();
	}
	return 0;

}

void IRQ_Routine (void) {while (1) ;}
void FIQ_Routine (void) {while (1) ;}
void SWI_Routine (void) {while (1) ;}
void UNDEF_Routine (void) {while (1) ;}
