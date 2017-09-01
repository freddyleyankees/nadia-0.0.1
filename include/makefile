OBJ=io.o

all: $(OBJ) 

io.o: io.asm
	nasm -f elf -o $@ $^ 

clean:
	rm -f $(OBJ) *.o
