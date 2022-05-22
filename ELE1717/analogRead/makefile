FILENAME   = main
PORT       = /dev/ttyUSB0
DEVICE     = atmega328p
PROGRAMMER = arduino

#Se for usar o arduino nano usar o BAUD a 57600
BAUD       = 57600
COMPILE    = avr-as -Wall -mmcu=$(DEVICE)


default: compile upload clean

compile:
	$(COMPILE) -c $(FILENAME).S -o $(FILENAME).o
	avr-objcopy -j .text -j .data -O ihex $(FILENAME).o $(FILENAME).hex 

upload:
	avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(FILENAME).hex:i

clean:
	rm $(FILENAME).o
	rm $(FILENAME).hex
