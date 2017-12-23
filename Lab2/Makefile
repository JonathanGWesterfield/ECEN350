# ASS01 Example Makefile
#
# This makefile is intended for use with GNU make
# This example is intended to be built with Linaro bare-metal GCC

TARGET=Lab02.axf

CC=aarch64-elf-gcc
LD=aarch64-elf-gcc

# Select build rules based on Windows or Unix
ifdef WINDIR
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then echo Build completed.; fi
RM=rm -f $(1)
endif
endif

all: $(TARGET)
	$(call DONE,$(TARGET))
	
rebuild: clean all

clean:
	$(call RM,*.o)
	$(call RM,$(TARGET))

main.o: main.c
# Compile for best debug view (lowest optimization)
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

lab02d.o: lab02d.S
# Compile for best debug view (lowest optimization)
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

$(TARGET): main.o lab02d.o
# Link with specific base address to suit VE model memory layout
	$(LD) --specs=aem-ve.specs -Wl,--build-id=none main.o lab02d.o -o $@
