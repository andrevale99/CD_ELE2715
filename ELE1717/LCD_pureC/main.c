#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

#define set_bit(y,bit) (y|=(1<<bit))
#define clr_bit(y,bit) (y&=~(1<<bit))
#define cpl_bit(y,bit) (y^=(1<<bit))
#define tst_bit(y,bit) (y&(1<<bit))

#define DADOS_LCD PORTB
#define nibble_dados 0
#define CONTR_LCD PORTC
#define E PC0
#define RS PC1

#define tam_vetor 5
#define conv_ascii 48

#define PULAR_LINHA 0xC0

#define pulso_enable() _delay_us(1); set_bit(CONTR_LCD,E); _delay_us(1); clr_bit(CONTR_LCD,E); _delay_us(45)

void cmd_LCD(unsigned char c, char cd);
void inic_LCD_4bits();
void escreve_LCD(char *c);
void set_modulacao();
void set_freq();
void set_msg();
char *to_char(int num, unsigned size);

int main()
{
	DDRC = 0x03;
	DDRB = 0x0F;

	inic_LCD_4bits();
	
	escreve_LCD_menu();
	_delay_ms(2000);

	set_modulacao();
	set_freq();
	set_msg();

	cmd_LCD(0x02, 0);

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

void escreve_LCD_menu(const char *c)
{
	inic_LCD_4bits();
	escreve_LCD("MOD XXX T:XXHz");
	cmd_LCD(PULAR_LINHA, 0);
	cmd_LCD(0xC0, 0);
	escreve_LCD("MSG: xx.xx.xx.xx");
}

void set_modulacao()
{

	cmd_LCD(0x84, 0);

	for(int teste=0; teste<3; teste++)
	{
		if( teste == 0 )
			escreve_LCD(" FM");
		else if ( teste == 1 )
			escreve_LCD("AFK");
		else 
			escreve_LCD("ASK");

		for(int i=1; i<=3; ++i)
			cmd_LCD(0x10, 0);

		_delay_ms(1000);
	}

	cmd_LCD(0x02, 0);
}

void set_freq()
{
	cmd_LCD(0x8A, 0);
	escreve_LCD("33");
	cmd_LCD(0x02, 0);
}

void set_msg()
{
	cmd_LCD(0xC0, 0);
	for (int i=1; i<=5; ++i)
		cmd_LCD(0x14, 0);

	_delay_ms(1000);

	escreve_LCD("10.11.01.00");
	for (int i=1; i<=11; ++i)
		cmd_LCD(0x10, 0);
	
}


char *to_char(int num, unsigned size)
{
	size += 1;
    char *num_char = malloc(1*size);
    for(int i=size-2; i>=0; --i)
    {
            int aux = num % 10;
            num_char[i] = '0' + aux;
            num /= 10;
    }
	num_char[size-1] = '\0';
	return num_char;
}
