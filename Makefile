CC = gcc
CFLAGS = -nostdlib -Wall -m32 -march=i386 -fno-pie -fno-stack-protector -ffreestanding

all: shitshell

shitshell: start.oasm main.oc syscall.oasm syscall.oc stdlib.oc
	@ld -m elf_i386 -nostdlib $^ -o $@

%.oc: %.c
	@echo "-> compiling shitshell/$<"
	@$(CC) $(CFLAGS) -c $< -o $@

%.oasm: %.asm
	@echo "-> compiling shitshell/$^"
	@nasm -f elf32 -o $@ $^

clean:
	@rm -f shitshell *.oasm *.oc *.o