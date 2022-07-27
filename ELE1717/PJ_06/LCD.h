#ifndef LCD_H
#define LCD_h

#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

#define SetBit(RES, BIT)(RES |= (1 << BIT)) // Por BIT em nível alto
#define ClrBit(RES, BIT)(RES &= ~ (1 << BIT))// Por BIT em nível baixo
#define TstBit(RES, BIT)(RES &  (1 << BIT)) // testar BIT, retorna 0 ou 1
#define CplBit(RES, BIT)(RES ^= (1 << BIT)) // Inverter estado do BIT

#define DADOS_LCD PORTB
#define nibble_dados 0
#define CONTR_LCD PORTB
#define E PB4
#define RS PB5

#define tam_vetor 5
#define conv_ascii 48

#define CLEAR_DISPLAY 0x01
#define RETURN_HOME 0x02
#define PULAR_LINHA 0xA0

#define pulso_enable() _delay_us(1); SetBit(CONTR_LCD,E); _delay_us(1); ClrBit(CONTR_LCD,E); _delay_us(45)

void inic_LCD_4bits();
void cmd_LCD(unsigned char c, char cd);
void escreve_LCD(char *c);

#endif
