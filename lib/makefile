OBJ=print.o

all: $(OBJ) 

print.o: print.asm
	nasm -f elf -o $@ $^ 

clean:
	rm -f $(OBJ) *.o
