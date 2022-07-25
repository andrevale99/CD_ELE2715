#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

#define set_bit(y,bit) (y|=(1<<bit))
#define clr_bit(y,bit) (y&=~(1<<bit))
#define cpl_bit(y,bit) (y^=(1<<bit))
#define tst_bit(y,bit) (y&(1<<bit))

#define DADOS_LCD PORTB
#define nibble_dados 0
#define CONTR_LCD PORTB
#define E PB4
#define RS PB5

#define tam_vetor 5
#define conv_ascii 48

#define PULAR_LINHA 0xA0

#define pulso_enable() _delay_us(1); set_bit(CONTR_LCD,E); _delay_us(1); clr_bit(CONTR_LCD,E); _delay_us(45)

//protótipo das funções
void cmd_LCD(unsigned char c, char cd);
void inic_LCD_4bits();
void escreve_LCD(char *c);

int main()
{
	DDRC = 0xFF;
	DDRB = 0xFF;

	inic_LCD_4bits();
	escreve_LCD("MOD XXX T:XXHz");
	cmd_LCD(PULAR_LINHA, 0);
	cmd_LCD(0xC0, 0);
	escreve_LCD("MSG: xx.xx.xx.xx");

	for(;;){}

	return 0;
}


void cmd_LCD(unsigned char c, char cd)
{
	if(cd==0) //instrução
		clr_bit(CONTR_LCD,RS);
	else //caractere
		set_bit(CONTR_LCD,RS);

	#if (nibble_dados )//compila o código para os pinos de dados do LCD nos 4 MSB do PORT
		DADOS_LCD = (DADOS_LCD & 0x0F)|(0xF0 & c);
	#else //compila o código para os pinos de dados do LCD nos 4 LSB do PORT
		DADOS_LCD = (DADOS_LCD & 0xF0)|(c>>4);
	#endif

	pulso_enable();

	#if (nibble_dados) //compila o código para os
		DADOS_LCD = (DADOS_LCD & 0x0F) | (0xF0 & (c<<4));
	#else
		DADOS_LCD = (DADOS_LCD & 0xF0) | (0x0F & c);
	#endif

	pulso_enable();

	if((cd==0) && (c<4))
		_delay_ms(2);
}

void inic_LCD_4bits()
{
	clr_bit(CONTR_LCD,RS);
	clr_bit(CONTR_LCD,E);

	_delay_ms(20);

	#if (nibble_dados)
		DADOS_LCD = (DADOS_LCD & 0x0F) | 0x30;
	#else
		DADOS_LCD = (DADOS_LCD & 0xF0) | 0x03;
	#endif

	pulso_enable();
	_delay_ms(5);
	pulso_enable();
	_delay_us(200);
	pulso_enable();

	#if (nibble_dados)
		DADOS_LCD = (DADOS_LCD & 0x0F) | 0x20;
	#else
		DADOS_LCD = (DADOS_LCD & 0xF0) | 0x02;
	#endif
	
	pulso_enable();
	cmd_LCD(0x28, 0);

	cmd_LCD(0x08,0); //desliga o display
	cmd_LCD(0x01,0); //limpa todo o displayI
	cmd_LCD(0x0F,0); //mensagem aparente cursor inativo não piscando
	cmd_LCD(0x80,0); //inicializa cursor na primeira posição a esquerda - 1a linha

}


void escreve_LCD(char *c)
{
	for (; *c!=0;c++) cmd_LCD(*c,1);
}

void ident_num(unsigned int valor, unsigned char *disp)
{
	unsigned char n;
	for(n=0; n<tam_vetor; n++)
	disp[n] = 0 + conv_ascii;

	do
	{
		*disp = (valor%10) + conv_ascii;
		valor /=10;
		disp++;
	}while (valor!=0);
}
