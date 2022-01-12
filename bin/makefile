GCC = g++-11
FLAGS = -Wall

ALVO = ghdl_run.cpp
OUT = ghdl_run

all: $(OUT)

$(OUT): $(ALVO)
	$(GCC) $(FLAGS) $(ALVO) -o $(OUT)

clear: 
	@rm ./$(OUT)

install:
	@make
	@cp ./$(OUT) /home/$(USER)/bin/
 
desinstall:
	@rm /home/$(USER)/bin/$(OUT)
