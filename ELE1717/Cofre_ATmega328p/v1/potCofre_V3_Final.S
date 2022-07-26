; https://stackoverflow.com/questions/43180889/how-to-do-analogread-in-avr-assembly-language
; UTILIZANDO: 17 e 18
; 25 26  

; Funcao para configurar as coisas do pino analogico
;Basta chamar UMA vez no código todo
adcInit:
    ldi r17, 0b01100100              ; Voltage Reference: AVcc with external capacitor at AREF pin
    sts ADMUX, r17                   ; Enable ADC Left Adjust Result
    clr r17                          ; Analog Channel: ADC0
	
    ldi r17, 0b10000101              ; Enable ADC
    sts ADCSRA, r17                  ; ADC Prescaling Factor: 32
    clr r17

    ret
;====================================================

; Funcao para pegar os dados do potenciometro
;chama ela para pegar os dados, o ajuste 
;para os displays ja eh feito

Pegar_senha_Pot:
    adcRead:
        ldi r17, 0b01000000           ;
        lds r18, ADCSRA               ; Set ADSC flag to Trigger ADC Conversion process              
    
        or  r18, r17                  ;
        sts  ADCSRA, r18              ;

    adcWait:

        lds r18, ADCSRA               ; Observe the ADIF flag, it gets set by hardware when ADC conversion completes
        sbrs r18, 4                   ;

        jmp adcwait                   ; Se for debugar, tem que tirar esse ret    

        ldi r17, 0b00010000           ; Set the flag again to signal 'ready-to-be-cleared' by hardware

        lds r18, ADCSRA               ;
        or  r18, r17                  ;
        sts  ADCSRA, r18              ;

        ldi r31, ADCL	              ; Armazena os 8 bits LSB da entrada analogica
        ldi r30, ADCH	              ; //       // // //  MSB // //        //
    
    cpi r30, 0b00000011	              ; Compara se eh IGUAL a 3 o ADCH
    breq Estouro_ADCL                 ; Se for vai para Estouro_ADCL

    rjmp Conversao_para_display       ; Se nao pula logo para o ajustes

    Estouro_ADCL:
        cpi r31, 0b11100111           ; Compara se ADCL eh igual ou maior que 231
        brge Ajustar_limite           ; Se for vai para a funcao Ajustar_limite

        jmp conversao_para_display    ; Se nao pula para o ajuste

    Ajustar_limite:
        ldi r31, 0b11100111           ; Salva o valor 999 (limite maximo)
        ldi r30, 0b00000011           ;

        rjmp Conversao_para_display   ; Pula para o ajuste

    mov r1, r30                       ; Salva o ADCH no r1
    mov r2, r31                       ; Salva o ADCL no r2

    Conversao_para_display:
        ldi r29, 0              
        ldi r28, 0                    ;zerando acumuladores (dezena,centena,unidade)
        ldi r27, 0

    verifica2b_msb1:
        cpi r30,1                     ;teste msb
        brlo verifica2b_msb2
        ldi r29, 2                    ;centena recebe +2
        ldi r28, 5                    ;dezena recebe +5
        ldi r27, 6                    ;unidade recebe +6

    verifica2b_msb2:
        cpi r30, 2
        brlo verifica2b_msb3
        ldi r29, 5                    ;centena recebe +5
        ldi r28, 1                    ;dezena recebe +1
        ldi r27, 2                    ;unidade recebe +2

    verifica2b_msb3:
        cpi r30, 3
        brlo centena
        ldi r29, 7                    ;centena recebe +7
        ldi r28, 6                    ;dezena recebe +6
        ldi r27, 8                    ;unidade recebe +8


    centena:
        cpi r31, 100
        brlo dezena
        subi r31, 100
        inc r29
        jmp centena


    dezena:
        cpi r31, 10
        brlo unidade
        subi r31, 10
        inc r28
        jmp dezena

    unidade:
        cpi r31, 1
        brlo balanceamento_unidade_dezena
        subi r31, 1
        inc r27
        jmp unidade

    balanceamento_unidade_dezena:
        cpi r27,10
        brlo balanceamento_dezena_centena
        subi r27,10
        inc r28

    balanceamento_dezena_centena:
        cpi r28,10
        brlo pular
        subi r28,10
        inc r29

	pular:
        ret

;FIM da conversao para o display
;====================================================

;─────────────███████████████────────────
;──────────████▒▒▒▒▒▒▒▒▒▒▒▒▒████─────────
;────────███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███───────
;───────██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███─────
;──────██▒▒▒▒▒▒▒▒▒▒██▒▒▒▒███████▒▒▒██────
;─────██▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒██▒▒▒██───
;────██▒▒██▒▒▒▒███▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▒▒██──
;───██▒▒▒▒▒████▒▒▒▒██▒▒▒██▒▒▒▒▒▒▒▒██▒▒█──
;───█▒▒▒▒▒▒▒▒▒▒▒███░█▒▒▒█░███▒▒▒▒▒▒▒▒▒█──
;───█▒▒▒▒▒██████░░░░█▒▒▒█░░░░██████▒▒▒█──
;───█▒▒▒▒▒▒▒█░░░░▓▓██▒▒▒██▓▓░░░░█▒▒▒▒▒█──
;───█▒▒▒▒▒▒▒▒██████▒▒▒▒▒▒▒██████▒█▒▒▒▒█──
;───█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▒▒▒▒█──
;───█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█░█▒▒▒█──
;───██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█░█▒▒██──
;────██▒▒▒▒▒▒▒▒▒▒▒████████▒▒▒▒▒▒██▒▒██───
;─────██▒▒▒▒▒▒█████▒▒▒▒▒▒█████▒▒▒▒▒██────
;──────██▒▒▒███▒▒▒▒▒████▒▒▒▒▒███▒▒██─────
;───────███▒▒▒▒▒▒▒▒█▒▒▒▒█▒▒▒▒▒▒▒▒██──────
;─────────███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███───────
;───────────█████▒▒▒▒▒▒▒▒▒██████─────────
;───────────────████████████─────────────
