# $@ = target file
# $< = first dependency
# $^ = all dependency

# Note:Makefile has a very stupid relation with tabs, all actions of every rule are identified by [tabs].
# Define a varity in Makefile
qemu='/opt/qemu/bin/qemu-system-x86_64'

# First rule is the one executed when no parameters are fed to the Makefile
all: run

# Notice how dependencies are built as needed
kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -m32 -ffreestanding -c $< -o $@

# Rule to disassemble the kernel - may be useful to debug
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@ 

bootsect.bin: bootsect.asm
	nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	$(qemu) -fda $<

clean:
	rm *.bin *.o *.dis 

