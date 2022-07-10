#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (TIMER1_OVF_vect)
{
	PORTB ^= (1<<PB5);
	TCNT1H = 65535 - 62500/2;
}

int main()
{
	DDRB |= (1<<PB5);

	TCCR1A = 0x00;
	TCCR1B = (1<<CS12); //16e6/1024 = 15625Hz
	TIMSK1 = (1<<TOIE1);

	TCNT1H = 65535 - 62500/2;

	sei();

	for(;;)
	{

	}

	return 0;
}
