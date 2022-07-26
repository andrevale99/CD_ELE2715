#include <avr/io.h>

    ldi r23,0x00
    ldi r24,0xFF
    out _SFR_IO_ADDR(DDRB), r24

main:
    out _SFR_IO_ADDR(PORTB), r24
    out _SFR_IO_ADDR(PORTB), r23
    rjmp main
