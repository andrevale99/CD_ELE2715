#!/bin/bash
# Ordem para compilar o arquivo VHDL

TOTAL=$#

if [ $1 == "-h" ] || [ $1 == "--help" ]; then
    echo "AINDA VOU FAZER"

else 
    ghdl -s and.vhd
    ghdl -a and.vhd

    ghdl -s and_tb.vhd
    ghdl -a and_tb.vhd

    ghdl -e ckt_tb
    ghdl -r ckt_tb --vcd=Simulacao

fi