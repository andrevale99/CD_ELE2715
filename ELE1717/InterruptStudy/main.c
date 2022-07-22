#include <avr/io.h>

#define F_CPU 16000000
#define BLINK_DELAY_MS 500

#include <util/delay.h>
#include <avr/interrupt.h>

ISR ()
{

}

int main (void)
{
  
  	DDRC &= ~(1 << PC0);
  	PORTC |= (1 << PC0);

	DDRB |= (1 << PB5);
	PORTB = 0x00;

	PCICR |= (1 << PCIE0);

  	uint8_t pin = 0;
  	while(1) 
  	{
		pin = PINC;
		if ((pin & 0x01) == 0x01)
			PORTB ^= (1 << PB5);
	
		_delay_ms(100);
  	}

  	return 0;
}
