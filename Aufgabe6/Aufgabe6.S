/*
 *Aufgabe 6.1
 *
 *  Created on: 15.10.2020
 *      Author: tavin
 *
 * Aufgabe : Serielle Kommunikation
 */
.text /* Specify that code goes in text segment */


.equ PINSEL0, 0xE0002C000




.equ USART_0_TXD_FUNCTION,	0x01
.equ USART_0_RXD_FUNCTION,	(0x01 << 2)


.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:


send:




stop:
nop
bal stop

.end

