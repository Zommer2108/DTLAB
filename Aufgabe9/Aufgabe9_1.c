/*
 * Aufgabe9_1.c
 *
 *  Created on: 16.10.2020
 *      Author: tavin
 *
 * Aufgabe : Analog – Digital Wandlung
 */


#include "LPC21XX.h"
#include <stdint.h>


#define CLKDIV						7
#define ADC_PIN_0					(1<<0)
#define ADC_PDN						(1<<21)
#define ADC_START_CONVERSION		(1<<24)

#define PINSEL1_P28_0_bm			(3<<22)
#define PINSEL1_AIN_0_bm			(1<<22)

#define ADC_VALU_MASK				0xFFFF



int main()
{
	uint32_t adValue = 0;

	PINSEL1 &= ~  PINSEL1_P28_0_bm;
	PINSEL1 |=   PINSEL1_AIN_0_bm;

	ADCR = ADC_START_CONVERSION | ADC_PDN |  (CLKDIV<<8) | ADC_PIN_0;

	while (1)
	{
	ADCR = ADC_START_CONVERSION | ADC_PDN |  (CLKDIV<<8) | ADC_PIN_0;

	for (int a=0; a<1000;a++);

		adValue = (ADDR & ADC_VALU_MASK) >> 5;
	}

}
