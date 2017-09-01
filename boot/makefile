OBJ=boot.o

all: $(OBJ) 

boot.o: boot.asm
	nasm -f bin -o $@ $^ ;

clean:
	rm -f $(OBJ) *.o
