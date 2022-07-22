/*
 * MDE.c
 *
 * Created: 16/07/2022 12:40:35
 * Author : Elke
 */ 

//Bibliotecas
#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

#define SetBit(RES, BIT)(RES |= (1 << BIT)) // Por BIT em nível alto
#define ClrBit(RES, BIT)(RES &= ~ (1 << BIT))// Por BIT em nível baixo
#define TstBit(RES, BIT)(RES &  (1 << BIT)) // testar BIT, retorna 0 ou 1
#define CplBit(RES, BIT)(RES ^= (1 << BIT)) // Inverter estado do BIT

//UART CALC
#define BAUD 9600
#define MYUBRR F_CPU/16/BAUD-1


//entradas (poderao ser trocadas)
#define A 0 //Botao de inserir senha
#define e 1 //Finaliza o estado de Programacao
#define D 2 //Desassociar alguma coisa
#define P 3 //Botao para inicializar a Programacao
#define S 4 //Botao de panico
#define R 5 //Recuperacao
#define T 6

//saidas
#define led 2

#define false 0x00
#define true 0x01

//variaveis  (acho que devem ser registradores,entao substituir)
uint16_t senha_digitada = 0;
uint16_t senha_correta = 0;
uint16_t senha_mestre = 0;

uint8_t Temporizador_de_ativacao = 0;
uint8_t timeout = 0;
uint8_t Temporizador_sirene = 0;

uint8_t E_A = false; //Variavel "booleana"

void (*PonteiroDeFuncao)(); //Ponteiro de funcao da MDE. Ele aponta sempre para a funcao da MDE que deve ser executada.


char *msg_debug = "TRABALHO SEBOSO\n";
//***********************************
void USART_Transmit(unsigned char data); //Eniva caractere para a uart
void USART_Init(unsigned int ubrr); //Inicializa a UART
void setup();
void Desativado(void);
void InserirSenha(void);
void ComparaSenha(void);   //funcao que representa o estado compara_senha na MDE
void Temporizador (void);   //funcao que representa o estado temporizador na MDE
void Ativado (void);   //funcao que representa o estado ativado na MDE
void Recuperacao(void);
void Programacao(void);

ISR (TIMER1_COMPA_vect)
{
	PORTB ^= (1<<PB5);
	TCNT1 = 0;
}

//===============================================
int main(void)
{
	setup();
	USART_Init(MYUBRR);
	
	PonteiroDeFuncao = Desativado; //aponta para o estado inicial.

	sei(); //Ativar as interrupcoes do arduino

	while(1)
	{
		(*PonteiroDeFuncao)();    //chama a função apontada pelo ponteiro de funcao 
		_delay_ms(100);
	}
  
	return 0;
 }

//===============================================
//	CONFIGURACOES
//===============================================
void setup() 
{
	ClrBit(DDRB, A);
	ClrBit(DDRB, e);
	ClrBit(DDRB, T);
	ClrBit(DDRB, D);

	SetBit(DDRD, led);
	ClrBit(PORTD, led);

    senha_mestre = 1234;

    Temporizador_de_ativacao = 0;

    timeout = 99;

	Temporizador_sirene = 0;

	senha_digitada = senha_correta = 1234;
}

void USART_Init(unsigned int ubrr)
{
    /*Set baud rate */
    UBRR0H = (unsigned char)(ubrr>>8);
    UBRR0L = (unsigned char)ubrr;
    /*Enable receiver and transmitter */
    UCSR0B = (1<<RXEN0)|(1<<TXEN0);
    /* Set frame format: 8data, 2stop bit */
    UCSR0C = (1<<USBS0)|(3<<UCSZ00);
}

void USART_Transmit(unsigned char data)
{
    /* Wait for empty transmit buffer */
    while (!(UCSR0A & (1<<UDRE0))) 
        ;
    /* Put data into buffer, sends the data */
    UDR0 = data;
}

//=================================
//	FUNCOES ESTADOS
//=================================
 void Recuperacao(void)
 {
	senha_mestre = 1234;
    Temporizador_de_ativacao = 0;
    timeout = 99;
	Temporizador_sirene = 0;
 }

 void Desativado(void)
 {
	if(TstBit(PINB,A))//se botão pressionado
		PonteiroDeFuncao = InserirSenha;
	else if(TstBit(PINB, P))
		PonteiroDeFuncao = Programacao;
	else
		PonteiroDeFuncao = Desativado;
}


void InserirSenha(void)
{       
	//Laco para digitar a senha
	PonteiroDeFuncao = ComparaSenha;	
}


void ComparaSenha(void){
	//se botão pressionado
	if(TstBit(PINB,e) && senha_digitada==senha_correta && !E_A)
	{
		PonteiroDeFuncao = Temporizador;
	}
	else
		PonteiroDeFuncao = Desativado;
	
}


void Temporizador(void)
{
	//se botão pressionado
	if(TstBit(PINB,e))
		PonteiroDeFuncao = Ativado;
	else
		PonteiroDeFuncao = Temporizador;
	
}

void Ativado(void)
{
	//se botão pressionado
	if(TstBit(PINB,D)) 
		PonteiroDeFuncao = InserirSenha;
	else
	{
		E_A = true;
		PonteiroDeFuncao = Ativado;

		for(char *i = &msg_debug[0]; *i != '\0'; ++i)
			USART_Transmit(*i);

		E_A = false;

		if (TstBit(PINB, D))
			PonteiroDeFuncao = InserirSenha;
	}	
}

void Programacao(void)
{
	SetBit(PORTB, PB5);
	ClrBit(PORTD, PD2);
}