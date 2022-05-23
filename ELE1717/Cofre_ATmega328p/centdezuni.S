ldi r29, 0              
ldi r28, 0         ;zerando acumuladores (dezena,centena,unidade)
ldi r27, 0

;ldi r31, 0b11100111        ;teste lsb (tirei pq o pot ja armazena nesses regs)
;ldi r30, 0b00000011         ;teste msb

verifica2b_msb1:

cpi r30,1                  ;teste msb
brlo verifica2b_msb2
ldi r29, 2                 ;centena recebe +2
ldi r28, 5                 ;dezena recebe +5
ldi r27, 6                 ;unidade recebe +6

verifica2b_msb2:
cpi r30, 2
brlo verifica2b_msb3
ldi r29, 5                 ;centena recebe +5
ldi r28, 1                 ;dezena recebe +1
ldi r27, 2                 ;unidade recebe +2

verifica2b_msb3:
cpi r30, 3
brlo centena
ldi r29, 7                 ;centena recebe +7
ldi r28, 6                 ;dezena recebe +6
ldi r27, 8                 ;unidade recebe +8


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
brlo pxetapa
subi r28,10
inc r29

pxetapa:

ldi r21, 0
