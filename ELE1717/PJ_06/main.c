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

#include "LCD.h"

#define SetBit(RES, BIT)(RES |= (1 << BIT)) // Por BIT em nivel alto
#define ClrBit(RES, BIT)(RES &= ~ (1 << BIT))// Por BIT em nivel baixo
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
uint8_t send_log_bool = true;

//Ponteiro de funcao da MDE. 
//Ele aponta sempre para a funcao da MDE que deve ser executada.
void (*PonteiroDeFuncao)(); 


char *msg_log = "USER 250722 2149SS\n"; //Desativado
char *msg_log2 = "USER 222222 1010SS\n"; //Ativado
char *msg_log3 = "USER 666666 2222SS\n"; //Prog
//***********************************
void USART_Transmit(unsigned char data); //Eniva caractere para a uart
void USART_Init(unsigned int ubrr); //Inicializa a UART
void send_log(char *m);

void setup();

void Desativado(void);
void InserirSenha(void);
void ComparaSenha(void);   //funcao que representa o estado compara_senha na MDE
void Temporizador (void);   //funcao que representa o estado temporizador na MDE
void Ativado (void);   //funcao que representa o estado ativado na MDE
void Recuperacao(void);
void Programacao(void);
void Panico(void);

ISR (TIMER0_OVF_vect)
{
	if(TstBit(PIND, S))
		PORTD ^= (1 << PD7);
}

//===============================================
int main(void)
{
	setup();
	USART_Init(MYUBRR);
	
	PonteiroDeFuncao = Desativado; //aponta para o estado inicial.

	inic_LCD_4bits();

	while(1)
	{
		(*PonteiroDeFuncao)();    //chama a funcao apontada pelo ponteiro de funcao 
		//_delay_ms(100);
	}
  
	return 0;
 }

//===============================================
//	CONFIGURACOES
//===============================================
void setup() 
{
	ClrBit(DDRD, A);
	ClrBit(DDRD, e);
	ClrBit(DDRD, D);
	ClrBit(DDRD, P);
	ClrBit(DDRD, S);

	SetBit(PORTD, A);
	SetBit(PORTD, e);
	SetBit(PORTD, D);
	SetBit(PORTD, P);
	SetBit(PORTD, S);

	//Configura as portas do LCD como saida
	//eh redundante por causa do LCD.c e LCD.h
	DDRB |= 0x1F;

	//Saida para Buzzer
	DDRD |= (1<<PD7);
	PORTD |= (1<<PD7);

    senha_mestre = 1234;

    Temporizador_de_ativacao = 0;
    timeout = 99;
	Temporizador_sirene = 0;

	E_A = false;
	send_log_bool = true;

	senha_digitada = 1234;
	senha_correta = 1234;
	
	TCCR0B |= (1 << CS02) ;
	TIMSK0 |= (1 << TOIE0);
	TCNT0 = 0;

	cli();
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

void send_log(char *m)
{
	for (char *i = &m[0]; *i!='\0'; ++i)
		USART_Transmit(*i);
}

//=================================
//	FUNCOES ESTADOS
//=================================
 void Recuperacao(void)
 {
	escreve_LCD("Recuperacao");
	cmd_LCD(RETURN_HOME, 0);

	senha_mestre = 1234;
    Temporizador_de_ativacao = 0;
    timeout = 99;
	Temporizador_sirene = 0;

	cmd_LCD(CLEAR_DISPLAY, 0);
 }

 void Desativado(void)
 {
	escreve_LCD("Desativado");
	cmd_LCD(RETURN_HOME, 0);
	
	if (send_log_bool == true)
		send_log(&msg_log[0]);

	send_log_bool = false;

	if(!TstBit(PIND, A))
	{
		PonteiroDeFuncao = InserirSenha;
		cmd_LCD(CLEAR_DISPLAY, 0);
	}
	else if(!TstBit(PIND, P))
	{
		cmd_LCD(CLEAR_DISPLAY, 0);
		send_log_bool = true;
		PonteiroDeFuncao = Programacao;
	}
	else if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
	else
		PonteiroDeFuncao = Desativado;
}


void InserirSenha(void)
{     
	escreve_LCD("Inserir Senha");
	cmd_LCD(RETURN_HOME, 0);

	//Laco para digitar a senha

	if (!TstBit(PIND, e))
	{
		cmd_LCD(CLEAR_DISPLAY, 0);
		PonteiroDeFuncao = ComparaSenha;	
	}
	else if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
}

void ComparaSenha(void){

	escreve_LCD("ComparaSenha");
	cmd_LCD(RETURN_HOME, 0);

	_delay_ms(500);

	if(!TstBit(PIND, e))
	{
		if(senha_digitada == senha_correta)
		{
			cmd_LCD(CLEAR_DISPLAY, 0);
			escreve_LCD("SENHA CORRETA");

			_delay_ms(1000);

			cmd_LCD(CLEAR_DISPLAY, 0);
			PonteiroDeFuncao = Temporizador;
		}
		else
		{
			cmd_LCD(CLEAR_DISPLAY, 0);
			escreve_LCD("SENHA INCORRETA");
		}
	}
	else if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
}


void Temporizador(void)
{
	escreve_LCD("Temporizador");
	cmd_LCD(RETURN_HOME, 0);
	//se botao pressionado
	if(!TstBit(PIND, e))
	{
		cmd_LCD(CLEAR_DISPLAY, 0);
		send_log_bool = true;
		PonteiroDeFuncao = Ativado;
	}
	else if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
}

void Ativado(void)
{
	escreve_LCD("Ativado");
	cmd_LCD(RETURN_HOME, 0);

	if(!TstBit(PIND, D)) 
	{
		PonteiroDeFuncao = InserirSenha;
		cmd_LCD(CLEAR_DISPLAY, 0);
	}
	else if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
	else
	{
		E_A = true;
		PonteiroDeFuncao = Ativado;

		if (send_log_bool == true)
		send_log(&msg_log2[0]);
		
		send_log_bool = false;

		E_A = false;
	}	
	
}

void Programacao(void)
{
	cmd_LCD(CLEAR_DISPLAY, 0);
	escreve_LCD("Programacao");
	cmd_LCD(RETURN_HOME, 0);
	
	if (send_log_bool == false)
		send_log(&msg_log3[0]);
		
	send_log_bool = true;

	_delay_ms(500);

	cmd_LCD(CLEAR_DISPLAY, 0);
	PonteiroDeFuncao = Desativado;

	if(!TstBit(PIND, S))
	{
		sei();
		cmd_LCD(CLEAR_DISPLAY, 0);
		_delay_ms(1000);
		PonteiroDeFuncao = Panico;
	}
}

void Panico(void)
{
	if(!TstBit(PIND, S))
	{	
		cli();
		_delay_ms(500);
		PonteiroDeFuncao = Desativado;
		send_log_bool = true;
		cmd_LCD(CLEAR_DISPLAY, 0);
	}
}