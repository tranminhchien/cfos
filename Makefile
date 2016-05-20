CFLAGS = -ffreestanding -O2 -nostdlib
CC = i386-linux-gcc $(CFLAGS)
OBJS = kernel.o lib.a boot.o
MAKE = make
LIB_DIR = lib
KERNEL_DIR = kernel

all: myos.bin
	
myos.bin: boot.o
	$(MAKE) -C $(LIB_DIR)
	$(MAKE) -C $(KERNEL_DIR)
	cp $(PWD)/kernel/kernel.o $(PWD)
	cp $(PWD)/lib/lib.a $(PWD) 
	$(CC) -T linker.ld -o myos.bin $(OBJS) -lgcc

boot.o: boot.asm
	nasm -felf32 $^ -o $@

clean:
	$(MAKE) -C $(LIB_DIR) clean
	$(MAKE) -C $(KERNEL_DIR) clean
	rm -f *.o myos.bin