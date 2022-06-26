#include <avr/io.h>

#define F_CPU 16000000

#include <util/delay.h>

#define RS PC0
#define E PC1

#define SET_BIT(porta, pin) (porta |= (1<<pin)
#define CLR_BIT(porta, pin) (porta &= ~(1<<pin)
#define pulse_enbale() _delay_us(1); SET_BIT(PORTB, E); _delay_us(1); CLR_BIT(PORTB, E); _delay_us(45)


//====================================
//	PROTOTIPOS
//====================================
void iniciar_LCD_4bits();

//====================================
//	MAIN
//====================================
int main()
{
	
	DDRB = 0xFF;   //Define todos os pinos PB0 ate PB3 como OUT
	DDRC = 0xFF; //Define PC0 e PC1 em OUT
	
	iniciar_LCD_4bits();

	while(1)
	{
	}

	return 0;
}

//====================================
//	FUNCOES
//====================================
void iniciar_LCD_4bits()
{
	CLR_BIT(PORTC, RS);
	CLR_BIT(PORTC, E);

	_delay_ms(20);	//Tempo para estabilizar o LCD, datasheet PAG 46 HD44780U

	PORTB = (PORTB & 0x0F) | 0x30; 

	pulse_enbale();
	_delay_ms(5);
	pulse_enbale();
	_delay_us(200);
	pulse_enbale();

	PORTB = (PORTB & 0x0F) | 0x20;

	pulse_enbale();


}
