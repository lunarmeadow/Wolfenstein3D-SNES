# Wolfenstein3D-SNES
Reconstructing the Wolfenstein 3D codebase for the SNES from the released source code of SNA3D

## Compiling

To compile the game, you will need a copy of WDCTools from https://wdc65xx.com/WDCTools. This is a toolsuite developed by the current manufacturer of 6502-family CPUs, but the important part is that the compiler, assembler, and linker included are directly based on the Zardoz toolsuite that ID used to develop Wolfenstein 3D on the SNES back in the 90's. This means that the code is fully compatible, and in fact may be slightly more optimized, while running on a modern Windows machine without a VM. The biggest hitch in compiling the game is reconfiguring the build process and makefile, and skimming the source code for errors during compile, and slowly ironing them out.
