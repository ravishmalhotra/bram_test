set_property SRC_FILE_INFO {cfile:c:/Users/ravishm/xilinx_projects/bram_test/bram_test.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc rfile:../../../bram_test.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc id:1 order:EARLY scoped_inst:design_1_i/processing_system7_0/inst} [current_design]
set_property SRC_FILE_INFO {cfile:c:/Users/ravishm/xilinx_projects/bram_test/bram_test.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.xdc rfile:../../../bram_test.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.xdc id:2 order:EARLY scoped_inst:design_1_i/clk_wiz_0/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter clk_fpga_1 0.3
set_property src_info {type:SCOPED_XDC file:1 line:26 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter clk_fpga_0 0.15
set_property src_info {type:SCOPED_XDC file:2 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.0
