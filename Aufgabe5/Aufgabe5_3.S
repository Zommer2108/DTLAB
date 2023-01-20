/*
 *Aufgabe 5.3
 *
 *  Created on: 15.10.2020
 *      Author: tavin
 *
 * Aufgabe : Ein- und Ausgabe über Taster und LEDs
 */
.text /* Specify that code goes in text segment */

.equ IOPIN0, 0xE0028000 //Port 0 Pin value register address
.equ IODIR1, 0xE0028018 //Port 1 Direction register address
.equ IOSET1, 0xE0028014 //Port 1 Output set register address
.equ IOCLR1, 0xE002801C //Port 1 Output clear register

.equ BUTTON_1, 0x400	//Button 1 mask
.equ BUTTON_2, 0x800	//Button 2 mask
.equ BUTTON_3, 0x1000 	//Button 3 mask
.equ BUTTON_4, 0x2000 	//Button 4 mask

.equ LED1, 0x10000
.equ LED3, 0x40000
.equ LED5, 0x100000
.equ LED7, 0x400000
.code 32 /* Select ARM instruction set */

.global main /* Specify global symbol */
main:

//Aufgabe 5_3

// R0 Bit MUSTER
// R1 IODR1 pointer
// R2 IOSET1 Pointer
// R3 IOCLR1 Pointer
// R4 IOPIN0 Pointer
// R5 BUTTON_1 Maske Taste 1
// R6 BUTTON_2 Maske Taste 2
// R7 BUTTON_3 Maske Taste 3
// R8 BUTTON_4 Maske Taste 4
// R9 LED Pattern
// R10 Button mask register

	ldr sp, =0x40001000 		//Setting Stack-Pointer on baseadress
	ldr r1, =IODIR1 			//Declaring r1 as pointer onto the Input/Output director register
	ldr r2, =IOSET1 			//Declaring r2 as Input/Output setting register
	ldr r3, =IOCLR1				//Declaring r3 as Input/Output clearing register
	ldr r4, =IOPIN0				//Declaring r4 as pointer to port 0 input register
	ldr r5, =BUTTON_1 			//Load Button 1 mask to register r1
	ldr r6, =BUTTON_2 			//Load Button 2 mask to register r2
	ldr r7, =BUTTON_3 			//Load Button 3 mask to register r3
	ldr r8, =BUTTON_4 			//Load Button 4 mask to register r4

	ldr r0, =0x00ff0000 		//P1.16 - P1.23 are being used as the outputs for the LEDs
	str r0, [r1] 				//Saving setting onto r0 with the "pointer" r1

loop:

	bl read_button_1

	bl read_button_2

	bl read_button_3

	bl read_button_4

	b loop


read_button_1:
	stmfd sp!,{r9, r10, lr}
	ldr r9, =LED1				//Load LED1 pattern into universal LED Pattern register
	mov r10, r5					//Load Button 1 Mask into universal Button Mask register
	bl led_op
	ldmfd  sp!,{r9, r10, pc}

read_button_2:
	stmfd sp!,{r9, r10, lr}
	ldr r9, =LED3
	mov r10, r6
	bl led_op
	ldmfd  sp!,{r9, r10, pc}

read_button_3:
	stmfd sp!,{r9, r10, lr}
	ldr r9, =LED5
	mov r10, r7
	bl led_op
	ldmfd  sp!,{r9, r10, pc}

read_button_4:
	stmfd sp!,{r9, r10, lr}
	ldr r9, =LED7
	mov r10, r8
	bl led_op
	ldmfd sp!,{r9, r10, pc}

led_op:
	stmfd sp!,{r9, r10, lr}
	ldr r0, [r4] 				//Load pushbutton values to register r0 (IOPIN0)
	ands r0, r10, r0 			//Check if button 1 is pressed
	beq noled 					//Branch if not
	str r9, [r2] 				//Button pressed, turn selected pin on (IOSET1)
	mov r9, r9, lsl #1 			//Increment output value
	str r9, [r3] 				//Turn selected pin off (IOCLR1)
	b led_done

	noled: 						//Button not pressed
		str r9, [r3] 			//Turn selected pin off
		mov r9, r9, lsl #1 		//Increment output value
		str r9, [r2] 			//Turn selected pin on

	led_done:
		ldmfd sp!,{r9, r10, pc}


stop:
nop
bal stop

.end
