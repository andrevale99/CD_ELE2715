#!/bin/bash

BENCH=$1
ARCH_BENCH=$2
SIMUALTION=$3

ghdl -s $BENCH
ghdl -a $BENCH

ghdl -e $ARCH_BENCH
ghdl -r $ARCH_BENCH --vcd=$SIMUALTION.simulation