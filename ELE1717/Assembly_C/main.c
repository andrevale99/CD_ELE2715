#include <avr/io.h>

#define F_CPU 16000000
#define BLINK_DELAY_MS 500

#include <util/delay.h>

int main (void)
{
    //Habilita o adc e a flag de interrupcao do adc (ADEN)
    //e inicializa o bit de interrupçao
    ADCSRA = 0x93;
    ADMUX = 0x40;

    int analog_MSB, analog_LSB, analog;
    while(1)   
    {
        ADCSRA |= (1<<ADSC);

        while(!(ADCSRA &= ~(1<<ADIF)));

        ADCSRA |= (1<<ADIF);

        analog_LSB = ADCL;
        analog_MSB = ADCH;

        analog = (analog_MSB << 8) | analog_LSB;
    }
}
