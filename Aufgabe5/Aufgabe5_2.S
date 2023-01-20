/*
 *Aufgabe 5.2
 *
 *  Created on: 15.10.2020
 *      Author: tavin
 *
 * Aufgabe : Testmuster zur Steuerung einzelner I/O (Input/Output)-Bits
 */
.text /* Specify that code goes in text segment */

.equ IOPIN0, 0xE0028000 //Port 0 Pin value register address
.equ IODIR1, 0xE0028018 //Port 1 Direction register address
.equ IOSET1, 0xE0028014 //Port 1 Output set register address
.equ IOCLR1, 0xE002801C //Port 1 Output clear register
.equ DELAY, 0x0016E360 	//delaytime 1.5 Million

.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_2

// R0 Bit MUSTER
// R1 IODR pointer
// R2 IOSET1 Pointer
// R3 IOCLR1 Pointer
// R4 LEDs

	ldr sp, =0x40001000 	//Setting Stack-Pointer on baseadress
	ldr r1, =IODIR1 		//Declaring r1 as pointer onto the Input/Output director register
	ldr r2, =IOSET1 		//Declaring r2 as Input/Output setting register
	ldr r3, =IOCLR1			//Declaring r3 as Input/Output clearing register
	ldr r0, =0x00ff0000 	//P1.16 - P1.23 are being used as the outputs for the LEDs
	str r0, [r1] 			//Saving setting onto r0 with the "pointer" r1

	begin:
		ldr r0, =0x10000 	//Setting LSB (LED1) to high

	while:
		str r0,[r2]			//Turning LEDs
		bl delay			//Wait
		str r0,[r3]			//Deactivating previous LED
		mov r0, r0, lsl #1 	//Activating next LED
		cmp r0, #0x01, 8	//Check if last LED was lit
		bcs begin			//Repeat whole sequence if last LED was lit
		b while				//Repeat loop if last LED was not lit

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
