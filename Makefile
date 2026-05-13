# --- Project Settings ---
TARGET      := WebUI
APP_TITLE   := WebUI
APP_DESC    := A WebUI client for the 3DS.
APP_AUTHOR  := L0nk55

# --- Paths ---
DEVKITPRO   := /c/devkitPro
DEVKITARM   := $(DEVKITPRO)/devkitARM
LIBCTRU     := $(DEVKITPRO)/libctru
PORTLIBS    := $(DEVKITPRO)/portlibs/3ds

# --- Tools ---
CC          := arm-none-eabi-gcc
BANNERTOOL  := ./bannertool.exe

include $(DEVKITARM)/3ds_rules

# --- Files ---
BANNER_PNG  := Open-WebUI-banner.png
BANNER_WAV  := jingle.wav
BANNER_BNR  := banner.bnr
ICON_PNG    := WebUI-icon.png
SMDH        := $(TARGET).smdh
RSF         := cia.rsf
ROMFS_DIR   := romfs

# --- Compiler Flags ---
ARCH        := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS      := -g -Wall -O2 -mword-relocations $(ARCH) -D__3DS__ \
               -Iinclude -I$(LIBCTRU)/include -I$(PORTLIBS)/include
LDFLAGS     := -specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(TARGET).map
LIBPATHS    := -L$(LIBCTRU)/lib -L$(PORTLIBS)/lib
LIBS        := -lcitro2d -lcitro3d -lcurl -lmbedtls -lmbedx509 -lmbedcrypto -lz -lctru -lm

# --- Objects ---
OBJDIR      := build
SRCDIR      := source
SOURCES     := $(wildcard $(SRCDIR)/*.c)
OBJS        := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))

.PHONY: all clean

all: $(TARGET).3dsx $(TARGET).cia

# Ensure build directory exists
$(OBJDIR):
	@mkdir -p $(OBJDIR)

# Compile
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link
$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) $(LIBPATHS) $(LIBS) -o $@

# SMDH icon from PNG
$(SMDH): $(ICON_PNG)
	smdhtool --create "$(APP_TITLE)" "$(APP_DESC)" "$(APP_AUTHOR)" $(ICON_PNG) $@

# Banner binary from PNG + WAV
$(BANNER_BNR): $(BANNER_PNG) $(BANNER_WAV)
	$(BANNERTOOL) makebanner -i $(BANNER_PNG) -a $(BANNER_WAV) -o $@

# Homebrew Launcher version (3dsxtool accepts the directory directly)
$(TARGET).3dsx: $(TARGET).elf $(SMDH)
	3dsxtool $(TARGET).elf $@ --smdh=$(SMDH) --romfs=$(ROMFS_DIR)

# CIA version (romfs is packed by makerom via RomFs.RootPath in cia.rsf)
$(TARGET).cia: $(TARGET).elf $(SMDH) $(BANNER_BNR) $(RSF)
	makerom -f cia -o $@ -elf $(TARGET).elf -rsf $(RSF) \
	        -desc app:4 -icon $(SMDH) -banner $(BANNER_BNR) \
	        -major 0 -minor 0

clean:
	@rm -rf $(OBJDIR) $(TARGET).elf $(TARGET).3dsx \
	        $(TARGET).cia $(TARGET).map $(BANNER_BNR) $(SMDH)
	@echo "Cleanup complete. The workspace is as empty as a developer's coffee mug at 3 AM."