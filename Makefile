# Minimal Makefile for single-file NDS project
NAME := blocknds
SOURCES := source/main.c

# BlocksDS paths (from Docker image)
BLOCKSDS := /opt/blocksds/core
ARM7ELF := $(BLOCKSDS)/sys/arm7/main_core/arm7.elf

# Tools
PREFIX := arm-none-eabi-
CC := $(PREFIX)gcc
LD := $(PREFIX)gcc

# Flags
ARCH := -mthumb -mcpu=arm946e-s
CFLAGS := -std=gnu17 -Wall -O2 -I$(BLOCKSDS)/libs/libnds/include $(ARCH)
LDFLAGS := -L$(BLOCKSDS)/libs/libnds/lib -lnds9 $(ARCH)

# Targets
ELF := $(NAME).elf
NDS := $(NAME).nds

all: $(NDS)

$(NDS): $(ELF)
	$(BLOCKSDS)/tools/ndstool/ndstool -c $@ -7 $(ARM7ELF) -9 $<

$(ELF): $(SOURCES)
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

clean:
	rm -f $(ELF) $(NDS)
