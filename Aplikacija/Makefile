#
TARGET = program

#
CROSS_COMPILE = arm-linux-gnueabihf-

HWLIBS_ROOT = ${SOCEDS_DEST_ROOT}/ip/altera/hps/altera_hps/hwlib
ALT_DEVICE_FAMILY ?= soc_cv_av
CFLAGS := -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)


LDFLAGS =  -g -Wall
CC = $(CROSS_COMPILE)gcc
ARCH= arm
LIBS    	=  -lpthread -lrt -lm -lcrypt

build: $(TARGET)
$(TARGET): main.o
	$(CC) $(LDFLAGS)  $(LIBS)   $^ -o $@  
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~ 

