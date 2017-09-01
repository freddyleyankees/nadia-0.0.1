OBJ = floppy.raw

NASM = nasm -f elf -o

LD = ld --oformat binary -melf_i386 -Ttext 10000

QEMU = qemu-system-x86_64 -boot a -fda

OUTPUT = kernel_

qemu: floppy.raw
	$(QEMU) $^

floppy.raw: boot.o kernel_
	cat boot/boot.o $(OUTPUT) /dev/zero | dd of=$(@) bs=512 count=2880

boot.o: 
	make -C boot

kernel_: head.o init_GDT.o mem.o io.o print.o
	$(LD) $^ -o $(@) ;

head.o:boot/head.asm
	$(NASM) $@ $^

init_GDT.o:kernel/init_GDT.asm
	$(NASM) $@ $^

pic.o:kernel/pic.asm
	$(NASM) $@ $^

init_traps.o:kernel/init_traps.asm
	$(NASM) $@ $^

traps.o:kernel/traps.asm
	$(NASM) $@ $^

interrupt.o:kernel/interrupt.asm
	$(NASM) $@ $^

mem.o:kernel/mem.asm
	$(NASM) $@ $^

io.o:lib/io.asm
	$(NASM) $@ $^

print.o:include/print.asm
	$(NASM) $@ $^

clean: 
	rm -f $(OBJ) kernel_ *.o boot/*.o








