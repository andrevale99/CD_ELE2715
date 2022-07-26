#include <avr/io.h>

#define F_CPU 16000000
#define BLINK_DELAY_MS 500

#include <util/delay.h>
#include <avr/interrupt.h>

uint16_t addr_eeprom = 0x00;

void EEPROM_write(uint16_t uiAddress, unsigned char ucData);
unsigned char EEPROM_read(uint16_t uiAddress);

ISR(TIMER1_OVF_vect)
{

}

int main (void)
{
	sei();

	char *msg = "andre";
  
  	while(1) 
  	{

  	}

  	return 0;
}

void EEPROM_write(uint16_t uiAddress, unsigned char ucData)
{
	/* Wait for completion of previous write */
	while(EECR & (1<<EEPE))
		;
	/* Set up address and Data Registers */
	EEAR = uiAddress;
	EEDR = ucData;
	/* Write logical one to EEMPE */
	EECR |= (1<<EEMPE);
	/* Start eeprom write by setting EEPE */
	EECR |= (1<<EEPE);
}

unsigned char EEPROM_read(uint16_t uiAddress)
{
	/* Wait for completion of previous write */
	while(EECR & (1<<EEPE))
		;
	/* Set up address register */
	EEAR = uiAddress;
	/* Start eeprom read by writing EERE */
	EECR |= (1<<EERE);
	/* Return data from Data Register */
	return EEDR;
}
