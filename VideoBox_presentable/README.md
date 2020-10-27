# VideoBox_presentable

VideoBox_presentable is a working version of a project made for digital systems design.
Current version is lacking histogram implementation. Once the hisogram is done and integrated, team 2 will be finished.

Current capabilites:
HPS side:
C code is supposed to be the final version (minimal changes possible) where it is possible to select foreground and background image. It is also possible to read all three histogram components from the on_chip memory and it is possible to read and enter affine transformation matrix that will be used by other teams.

FPGA side:
Custom made Alpha blender IP component. Alpha blender receives one 32bit Avalon Stream, blends first 16bits with the other 16bits of the 32bit data. Blended bits are transfered to VGA controler with another Avalon strem.
On_chip memory used to store histogram values.
On_chip memory used to store transformation matrix. 

