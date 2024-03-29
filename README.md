# CD - ELE2715

Repositório para o estudo da linguagem VHDL da matéria de Circuitos Digitais (ELE2715) da UFRN. 

Muitos dos códigos podem haver erros de lógica, portanto, verifique antes de utiliza-lo em alguma simulação.

## Pré-Requisitos

* Os arquivos criados foram compilados pelo [GHDL](http://ghdl.free.fr/); 
  
* Alguns circuitos integrados foram feitos no _software_ [Logisim](http://www.cburch.com/logisim/pt/index.html) ( biblioteca "7400-lib" foi baixada no site do _software_ );

* As simulações podem serem feitas no [Gtkwave](http://gtkwave.sourceforge.net/).

### Compilação

Para compilar os arquivos, basta seguir a ordem:

1. ghdl -s *circuito.vhd*
   
2. ghdl -a *circuito.vhd*
   
3. ghdl -a *Test_bench.vhd*
   
4. ghdl -e *Arquitetura_Testbench*
   
5. ghdl -r *Arquitetura_Testbench* --vcd=*Nome_da_simulacao*

Caso queira verificar a simulção basta rodar o comando

* gtkwave *Nome_da_simulacao*

Um exemplo da compilação dos arquivos pode ser verificado na pasta [Example](VHDL/Example/).

# AVISO

caso queira criar um circuito com algum *clock* infinito, deve utilizar do argumento **--stop-time=XX[fs, ns, ms, sec, ...]**, pois o GHDL não suporta *clock* infinito no TESTBENCH.


   
