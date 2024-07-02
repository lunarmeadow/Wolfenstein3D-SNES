#--------------------------------------------------------------------
# Makefile for SNES Wolfenstein 3D
#--------------------------------------------------------------------

# Change this variable to your WDCTools installation directory! 
WDC = C:\wdc

CC = $(WDC)\Tools\bin\WDC816CC.exe
ASM = $(WDC)\Tools\bin\WDC816AS.exe
LINK = $(WDC)\Tools\bin\WDCLN.exe

INCLUDEDIR = $(WDC)\Tools\include
LIBDIR = $(WDC)\Tools\lib\cl

# Compiler flags. Moved to a variable to allow quick and easy changes, as this may require experimentation, and some features are deprecated.
# These compiler flags target the large memory model, with "general-purpose" optimizations, and specific warning settings. These flags are directly equivalent to what ID originally used to compile.
COMPFLAGS = -ML -SO

DEFINES = -D__ORCAC__ -DID_VERSION

#--------------------------------------------------------------------
# WOLF.HEX
#--------------------------------------------------------------------

WOLF = \
test.obj \
wolfasm.obj \
struc.obj \
tables.obj \
sounds.obj \
iosnes.obj \
wolfio.obj \
snesmain.obj \
intermis.obj \
newrefa.obj \
extdata.obj \
rwall.obj \
rsprite.obj \
music.obj \
intro.obj \
doors.obj \
enmove.obj \
enthink.obj \
level.obj \
missiles.obj \
plmove.obj \
plstuff.obj \
plthink.obj \
pushwall.obj \
refresh.obj \
refbsp.obj \
refspr.obj \
sight.obj \
wolfmain.obj \
statedef.obj

wolf.hex:	$(WOLF) wolf.lnk
	$(LINK) -F wolf.lnk -Q -L$(LIBDIR)

#--------------------------------------------------------------------
# ASM FILES
#--------------------------------------------------------------------

test.obj:	snes.equ idmacros.asm test.asm
	$(ASM) test.asm

wolfasm.obj:	snes.equ idmacros.asm wolfasm.asm
	$(ASM) wolfasm.asm

struc.obj: struc.asm
	$(ASM) struc.asm

iosnes.obj:	snes.equ idmacros.asm iosnes.asm
	$(ASM) iosnes.asm

newrefa.obj:	snes.equ idmacros.asm newrefa.asm
	$(ASM) newrefa.asm

extdata.obj: extdata.asm
	$(ASM) extdata.asm

rwall.obj:	snes.equ idmacros.asm notes.asm rwall.asm
	$(ASM) rwall.asm

rsprite.obj:	snes.equ idmacros.asm rsprite.asm
	$(ASM) rsprite.asm


#--------------------------------------------------------------------
# C FILES
#--------------------------------------------------------------------

tables.obj:	wolfdef.h sprites.h tables.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) tables.c

sounds.obj: sounds.c
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) sounds.c

wolfio.obj:	refresh.h sneswolf.h wolfdef.h sprites.h version.h extdata.h noahmisc.h iosnes.h wolfio.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) wolfio.c

snesmain.obj:	refresh.h sneswolf.h wolfdef.h sprites.h version.h extdata.h noahmisc.h iosnes.h snesmain.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) snesmain.c

intermis.obj:	sneswolf.h wolfdef.h sprites.h version.h extdata.h noahmisc.h iosnes.h intermis.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) intermis.c

music.obj:	refresh.h sneswolf.h wolfdef.h sprites.h version.h extdata.h noahmisc.h iosnes.h music.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) music.c

intro.obj:	wolfdef.h sprites.h sneswolf.h wolfdef.h sprites.h version.h extdata.h noahmisc.h iosnes.h intro.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) intro.c

doors.obj:	wolfdef.h sprites.h doors.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) doors.c

enmove.obj:	wolfdef.h sprites.h enmove.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) enmove.c

enthink.obj:	wolfdef.h sprites.h enthink.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) enthink.c

level.obj:	wolfdef.h sprites.h level.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) level.c

missiles.obj:	wolfdef.h sprites.h missiles.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) missiles.c

plmove.obj:	wolfdef.h sprites.h plmove.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) plmove.c

plstuff.obj:	wolfdef.h sprites.h plstuff.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) plstuff.c

plthink.obj:	wolfdef.h sprites.h plthink.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) plthink.c

pushwall.obj:	wolfdef.h sprites.h pushwall.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) pushwall.c

refresh.obj:	refresh.h refresh.c
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) refresh.c

refbsp.obj:	refresh.h refbsp.c
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) refbsp.c

refspr.obj:	refresh.h sprstruc.c refspr.c
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) refspr.c

sight.obj:	wolfdef.h sprites.h sight.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) sight.c

wolfmain.obj:	wolfdef.h sprites.h wolfmain.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) wolfmain.c

statedef.obj:	wolfdef.h sprites.h statedef.c sounds.h states.h
	$(CC) $(DEFINES) $(COMPFLAGS) -I $(INCLUDEDIR) statedef.c