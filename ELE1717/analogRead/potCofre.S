adcInit:
    ldi r16, 0b01100000   ; Voltage Reference: AVcc with external capacitor at AREF pin
    sts ADMUX, r16        ; Enable ADC Left Adjust Result
                          ; Analog Channel: ADC0

    ldi r16, 0b10000101   ; Enable ADC
    sts ADCSRA, r16       ; ADC Prescaling Factor: 32

    ret

adcRead:
    ldi r16, 0b01000000   ; Set ADSC flag to Trigger ADC Conversion process
    lds r17, ADCSRA       ;
    or  r17, r16          ;
    sts  ADCSRA, r17      ;
    ret

adcWait:
    lds r17, ADCSRA       ; Observe the ADIF flag, it gets set by hardware when ADC conversion completes
    sbrs r17, 4           ;

    jmp adcWait           ; Keep checking until the flag is set by hardware

    ldi r16, 0b00010000   ; Set the flag again to signal 'ready-to-be-cleared' by hardware

    lds r17, ADCSRA       ;
    or  r17, r16          ;
    sts  ADCSRA, r17      ;
    ret

mainLoop:
    call adcRead
    call adcWait
    lds r18, ADCL  ; Must read ADCL first, and ADCH after that
    lds r19, ADCH
