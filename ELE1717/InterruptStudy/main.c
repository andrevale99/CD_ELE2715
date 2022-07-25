#include <avr/io.h>

#define F_CPU 16000000
#define BLINK_DELAY_MS 500

#include <util/delay.h>
#include <avr/interrupt.h>

ISR(TIMER1_OVF_vect)
{
	PORTB ^= (1<<PB5);
	TCNT1 = 62500;
}

int main (void)
{
  
  	DDRB |= (1 << PB1);
	PORTB |= 0X00;

	TCCR1A = 0b10100010;
	//PWM não invertido nos pinos OC1A e OC1B
	TCCR1B = 0b00011001;
	//liga TC1, prescaler = 1
	ICR1 = 35000;
	//valor máximo para contagem
	OCR1A = 1000;
	//controle do ciclo ativo do PWM 0C1A
  	
  	while(1) 
  	{
  	}

  	return 0;
}
