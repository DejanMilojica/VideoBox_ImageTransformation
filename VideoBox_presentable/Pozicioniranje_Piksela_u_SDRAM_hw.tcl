# TCL File Generated by Component Editor 16.1
# Sun Oct 25 08:17:45 CET 2020
# DO NOT MODIFY


# 
# Pozicioniranje_Piksela_u_SDRAM "Pozicioniranje_Piksela_u_SDRAM" v1.0
# Dejan Milojica 2020.10.25.08:17:45
# Nakon �to dobijemo poziciju piksela iz preslikavanja unazad, taj piksel trebamo smjestiti u SDRAM!
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module Pozicioniranje_Piksela_u_SDRAM
# 
set_module_property DESCRIPTION "Nakon �to dobijemo poziciju piksela iz preslikavanja unazad, taj piksel trebamo smjestiti u SDRAM!"
set_module_property NAME Pozicioniranje_Piksela_u_SDRAM
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP VideoBox_Team_3
set_module_property AUTHOR "Dejan Milojica"
set_module_property DISPLAY_NAME Pozicioniranje_Piksela_u_SDRAM
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Pozicioniranje_Piksela_u_SDRAM
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file Pozicioniranje_Piksela_u_SDRAM.vhd VHDL PATH Pozicioniranje_Piksela_u_SDRAM.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_reset reset Input 1


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock_clk clk Input 1


# 
# connection point out_piksel
# 
add_interface out_piksel avalon_streaming start
set_interface_property out_piksel associatedClock clock
set_interface_property out_piksel associatedReset reset
set_interface_property out_piksel dataBitsPerSymbol 16
set_interface_property out_piksel errorDescriptor ""
set_interface_property out_piksel firstSymbolInHighOrderBits true
set_interface_property out_piksel maxChannel 0
set_interface_property out_piksel readyLatency 0
set_interface_property out_piksel ENABLED true
set_interface_property out_piksel EXPORT_OF ""
set_interface_property out_piksel PORT_NAME_MAP ""
set_interface_property out_piksel CMSIS_SVD_VARIABLES ""
set_interface_property out_piksel SVD_ADDRESS_GROUP ""

add_interface_port out_piksel out_piksel_data data Output 16
add_interface_port out_piksel out_piksel_endofpacket endofpacket Output 1
add_interface_port out_piksel out_piksel_ready ready Input 1
add_interface_port out_piksel out_piksel_startofpacket startofpacket Output 1
add_interface_port out_piksel out_piksel_valid valid Output 1


# 
# connection point in_piksel
# 
add_interface in_piksel avalon_streaming end
set_interface_property in_piksel associatedClock clock
set_interface_property in_piksel associatedReset reset
set_interface_property in_piksel dataBitsPerSymbol 16
set_interface_property in_piksel errorDescriptor ""
set_interface_property in_piksel firstSymbolInHighOrderBits true
set_interface_property in_piksel maxChannel 0
set_interface_property in_piksel readyLatency 0
set_interface_property in_piksel ENABLED true
set_interface_property in_piksel EXPORT_OF ""
set_interface_property in_piksel PORT_NAME_MAP ""
set_interface_property in_piksel CMSIS_SVD_VARIABLES ""
set_interface_property in_piksel SVD_ADDRESS_GROUP ""

add_interface_port in_piksel in_piksel_ready ready Output 1
add_interface_port in_piksel in_piksel_valid valid Input 1
add_interface_port in_piksel in_piksel_endofpacket endofpacket Input 1
add_interface_port in_piksel in_piksel_data data Input 16
add_interface_port in_piksel in_piksel_startofpacket startofpacket Input 1


# 
# connection point in_xy_1
# 
add_interface in_xy_1 avalon_streaming end
set_interface_property in_xy_1 associatedClock clock
set_interface_property in_xy_1 associatedReset reset
set_interface_property in_xy_1 dataBitsPerSymbol 16
set_interface_property in_xy_1 errorDescriptor ""
set_interface_property in_xy_1 firstSymbolInHighOrderBits true
set_interface_property in_xy_1 maxChannel 0
set_interface_property in_xy_1 readyLatency 0
set_interface_property in_xy_1 ENABLED true
set_interface_property in_xy_1 EXPORT_OF ""
set_interface_property in_xy_1 PORT_NAME_MAP ""
set_interface_property in_xy_1 CMSIS_SVD_VARIABLES ""
set_interface_property in_xy_1 SVD_ADDRESS_GROUP ""

add_interface_port in_xy_1 in_xy_valid valid Input 1
add_interface_port in_xy_1 in_xy_startofpacket startofpacket Input 1
add_interface_port in_xy_1 in_xy_endofpacket endofpacket Input 1
add_interface_port in_xy_1 in_xy_ready ready Output 1
add_interface_port in_xy_1 in_xy_data data Input 32

