; https://stackoverflow.com/questions/43180889/how-to-do-analogread-in-avr-assembly-language
; UTILIZANDO: 17 e 18
; 25 26  
; Funcao para configurar as coisas do pino analogico
adcInit:
    ldi r17, 0b01100100  ; Voltage Reference: AVcc with external capacitor at AREF pin
    sts ADMUX, r17       ; Enable ADC Left Adjust Result
    clr r17              ; Analog Channel: ADC0
	
    ldi r17, 0b10000101  ; Enable ADC
    sts ADCSRA, r17      ; ADC Prescaling Factor: 32
    clr r17

    ret
;====================================================
; Ler a porta analogica 0 do arduino
adcRead:
    ldi r17, 0b01000000  ;
    lds r18, ADCSRA      ; Set ADSC flag to Trigger ADC Conversion process              
    
    or  r18, r17         ;
    sts  ADCSRA, r18     ;

    ret
;====================================================

; Espera pegar o valor da porta analogica e salva 
;nos registradores r3(LSB) e r4(MSB)
adcWait:

    lds r18, ADCSRA       ; Observe the ADIF flag, it gets set by hardware when ADC conversion completes
    sbrs r18, 4           ;

    jmp adcwait           ; 

    ldi r17, 0b00010000   ; Set the flag again to signal 'ready-to-be-cleared' by hardware

    lds r18, ADCSRA       ;
    or  r18, r17          ;
    sts  ADCSRA, r18      ;

    lds r31, ADCL	      ; Armazena os 8 bits LSB da entrada analogica
    lds r30, ADCH	      ; //       // // //  MSB // //        //

    ret
;====================================================

; Verifica se o ADCL esta em 231
Estouro_ADCL:
    cpi r31, 0b11100111  ; Compara com 231
    breq Ajustar_limite  

    rjmp 0b00010000      ; Pula para ret de Pegar_senha_Pot (17 linhas)
;====================================================

; Salva o valor 999 nos registradores r5 e r6
;para consulta para  display
Ajustar_limite:
    ldi r31, 0b11100111  ; Pot LSB
    ldi r30, 0b00000011  ; Pot MSB

    rjmp 0b00001010      ; Pula para o ret de Pegar_senha_Pot
;====================================================

; Funcao para pegar os dados do potenciometro
;chama ela para pegar os dados, o ajuste já é feito
Pegar_senha_Pot:
    call adcRead
    call adcWait
    
    cpi r30, 0b00000011	; Compara o ADCH com 3
    breq Estouro_ADCL   ;

    ret

;====================================================


