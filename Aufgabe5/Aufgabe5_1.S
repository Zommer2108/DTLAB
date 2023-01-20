/*
 *Aufgabe 5.1
 *
 *  Created on: 09.01.2023
 *      Author: Roman Zimmer
 *
 * Aufgabe : LED-Testmuster
 */
.text /* Specify that code goes in text segment */

.equ IOPIN0, 0xE0028000 //Port 0 Pin value register address
.equ IODIR1, 0xE0028018 //Port 1 Direction register address
.equ IOSET1, 0xE0028014 //Port 1 Output set register address
.equ IOCLR1, 0xE002801C //Port 1 Output clear register
.equ LEDS, 0x1000 		//Setting amount of LEDs for the loop
.equ DELAY, 0x0016E360 	//delaytime 1.5 Million in decimal

.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_1

// R0 Bit MUSTER
// R1 IODR pointer
// R2 IOSET1 Pointer
// R3 LED Amount
// R4 DELAY-REGISTER

	ldr r3, =LEDS 			//Setting amount of LEDs to go through the loop
	ldr sp, =0x40001000 	//Setting Stack-Pointer on baseadress
	ldr r1, =IODIR1 		//Declaring r1 as pointer onto the Input/Output director register
	ldr r0, =0x00ff0000 	//P1.16 - P1.23 are being used as the outputs for the LEDs
	str r0, [r1] 			//Saving setting onto r0 with the "pointer" r1
	ldr r0, =0x10000 		//Setting LSB (LED1) to high
	ldr r2, =IOSET1 		//Activating output set register

	while:
		str r0,[r2] 		//Activating LEDs
		mov r0, r0, lsl #1 	//Activating next LED
		subs r3, #1 		//Subtracting amount of the LEDs that need to be lit
		bl delay 			//Jump into delay subroutine
		movs r3,r3 			//Comparing if R3 is already zero
		bne while 			//If not loop repeats

stop:
nop
bal stop

delay:
	stmfd sp!,{r0, r1, r2, r3, lr}	//Storing register and link-register
	ldr r4, =DELAY					//Loading Delay Register with DELAY(Time)

	loop:
		subs r4, #1					//Subtracting Delay Register to "waste time"
		movs r4, r4					//Comparing if R4 is already zero
		bne loop					//Repeat loop when not zero

		ldmfd sp!, {r0, r1, r2, r3, pc}
.end

