TOTAL=$#

if [ $1 == "-h" ] || [ $1 == "--help" ]; then
    echo "AINDA VOU FAZER"

else 
    ghdl -s $1
    ghdl -a $1

    ghdl -s $2
    ghdl -a $2

    ghdl -e $3
    ghdl -r $3 --vcd=$4

fi