#
# Makefile
#
CHAIN_ROOT= /home/yang/b503/ctools/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin
CROSS_COMPILE=$(CHAIN_ROOT)/arm-linux-gnueabihf-
#CROSS_COMPILE = 

CC     := $(CROSS_COMPILE)gcc
#CC ?= gcc
LVGL_DIR ?= ${shell pwd}
CFLAGS ?= -Wall -Wshadow -Wundef -Wmaybe-uninitialized -O3 -g0 -I$(LVGL_DIR)/
LDFLAGS ?= -lpthread
BIN = demo


#Collect the files to compile
MAINSRC = ./main.c

include $(LVGL_DIR)/lvgl/lvgl.mk
include $(LVGL_DIR)/lv_drivers/lv_drivers.mk
include $(LVGL_DIR)/lv_examples/lv_examples.mk

OBJEXT ?= .o

AOBJS = $(ASRCS:.S=$(OBJEXT))
COBJS = $(CSRCS:.c=$(OBJEXT))

MAINOBJ = $(MAINSRC:.c=$(OBJEXT))

SRCS = $(ASRCS) $(CSRCS) $(MAINSRC)
OBJS = $(AOBJS) $(COBJS)

## MAINOBJ -> OBJFILES

all: default

%.o: %.c
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC $<"
    
default: $(AOBJS) $(COBJS) $(MAINOBJ)
	@echo cc=$(CC)
	@echo Generating ...
	$(CC) -o $(BIN) $(MAINOBJ) $(AOBJS) $(COBJS) $(LDFLAGS)

clean: 
	rm -f $(BIN) $(AOBJS) $(COBJS) $(MAINOBJ)
	@echo Removed!

