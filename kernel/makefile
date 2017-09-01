OBJ = init_GDT.o pic.o init_traps.o traps.o interrupt.o mem.o

all: $(OBJ) 
	
init_GDT.o: init_GDT.asm
	nasm -f elf -o $@ $^ ;

pic.o: pic.asm
	nasm -f elf -o $@ $^ ;

init_traps.o: init_traps.asm
	nasm -f elf -o $@ $^ ;

traps.o: traps.asm
	nasm -f elf -o $@ $^ ;

interrupt.o: interrupt.asm
	nasm -f elf -o $@ $^ ;

mem.o: mem.asm
	nasm -f elf -o $@ $^ ;
clean:
	rm -f $(OBJ) *.o
