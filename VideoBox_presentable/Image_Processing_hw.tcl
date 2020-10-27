# TCL File Generated by Component Editor 16.1
# Mon Oct 26 12:16:21 CET 2020
# DO NOT MODIFY


# 
# Image_Processing "Image_Processing" v1.0
# Dejan Milojica 2020.10.26.12:16:21
# Izvrsavanje predefinisanih transformacija nad definisanom slikom!
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module Image_Processing
# 
set_module_property DESCRIPTION "Izvrsavanje predefinisanih transformacija nad definisanom slikom!"
set_module_property NAME Image_Processing
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP VideoBox_Team_3
set_module_property AUTHOR "Dejan Milojica"
set_module_property DISPLAY_NAME Image_Processing
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Image_Processing
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file Image_Processing.vhd VHDL PATH Image_Processing.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point s0
# 
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 maximumPendingWriteTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 avs_s0_address address Input 8
add_interface_port s0 avs_s0_read read Input 1
add_interface_port s0 avs_s0_readdata readdata Output 32
add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_writedata writedata Input 32
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point in0
# 
add_interface in0 avalon_streaming end
set_interface_property in0 associatedClock clock
set_interface_property in0 associatedReset reset
set_interface_property in0 dataBitsPerSymbol 16
set_interface_property in0 errorDescriptor ""
set_interface_property in0 firstSymbolInHighOrderBits true
set_interface_property in0 maxChannel 0
set_interface_property in0 readyLatency 0
set_interface_property in0 ENABLED true
set_interface_property in0 EXPORT_OF ""
set_interface_property in0 PORT_NAME_MAP ""
set_interface_property in0 CMSIS_SVD_VARIABLES ""
set_interface_property in0 SVD_ADDRESS_GROUP ""

add_interface_port in0 asi_in0_data data Input 16
add_interface_port in0 asi_in0_ready ready Output 1
add_interface_port in0 asi_in0_valid valid Input 1
add_interface_port in0 asi_in0_endofpacket endofpacket Input 1
add_interface_port in0 asi_in0_startofpacket startofpacket Input 1


# 
# connection point out0
# 
add_interface out0 avalon_streaming start
set_interface_property out0 associatedClock clock
set_interface_property out0 associatedReset reset
set_interface_property out0 dataBitsPerSymbol 16
set_interface_property out0 errorDescriptor ""
set_interface_property out0 firstSymbolInHighOrderBits true
set_interface_property out0 maxChannel 0
set_interface_property out0 readyLatency 0
set_interface_property out0 ENABLED true
set_interface_property out0 EXPORT_OF ""
set_interface_property out0 PORT_NAME_MAP ""
set_interface_property out0 CMSIS_SVD_VARIABLES ""
set_interface_property out0 SVD_ADDRESS_GROUP ""

add_interface_port out0 aso_out0_data data Output 16
add_interface_port out0 aso_out0_ready ready Input 1
add_interface_port out0 aso_out0_valid valid Output 1
add_interface_port out0 aso_out0_endofpacket endofpacket Output 1
add_interface_port out0 aso_out0_startofpacket startofpacket Output 1


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
