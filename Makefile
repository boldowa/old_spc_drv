###
#
# Makefile for smw-spc
# author:  757 ÅüiTWiLoLoLo
#
###


PROGNAME = org_drv
EXTENS  = .spc
TARGET  = $(PROGNAME)$(EXTENS)
CC      = wla-spc700
CFLAGS  = -v -D SA
LD      = wlalink
LDFLAGS = -v -r
INCDIR = .

SFILES = main.asm tables.asm brr_table.asm seq_data.asm
IFILES = $(INCDIR)/*.i
OFILES = main.o

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OFILES) Makefile linkfile
	$(LD) $(LDFLAGS) linkfile $@

main.o: $(SFILES) $(IFILES) Makefile
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGET) $(OFILES) $(PROGNAME).sym

