
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1
#    set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set clk_in1 [ create_bd_port -dir I -type clk clk_in1 ]
  set_property -dict [ list CONFIG.CLK_DOMAIN {design_1_processing_system7_0_0_FCLK_CLK0} CONFIG.FREQ_HZ {125000000}  ] $clk_in1
  set en_counter [ create_bd_port -dir I en_counter ]
  set lock_high [ create_bd_port -dir O lock_high ]
  set reset_counter [ create_bd_port -dir I reset_counter ]
  set reset_rtl [ create_bd_port -dir I -type rst reset_rtl ]
  set_property -dict [ list CONFIG.POLARITY {ACTIVE_HIGH}  ] $reset_rtl
  set trans_status [ create_bd_port -dir O trans_status ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list CONFIG.DATA_WIDTH {32} CONFIG.PROTOCOL {AXI4} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.SUPPORTS_NARROW_BURST {0} CONFIG.USE_ECC {0}  ] $axi_bram_ctrl_0

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $axi_mem_intercon

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_0 ]
  set_property -dict [ list CONFIG.Enable_32bit_Address {true} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Use_RSTB_Pin {true} CONFIG.Write_Depth_A {8192} CONFIG.use_bram_block {BRAM_Controller}  ] $blk_mem_gen_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0 ]
  set_property -dict [ list CONFIG.CLKIN1_JITTER_PS {0.0} CONFIG.CLKIN1_UI_JITTER {0} CONFIG.CLKIN2_JITTER_PS {100.0} CONFIG.CLKOUT1_DRIVES {BUFGCE} CONFIG.CLKOUT1_JITTER {226.747} CONFIG.CLKOUT1_PHASE_ERROR {224.819} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {24.000} CONFIG.CLKOUT2_JITTER {225.304} CONFIG.CLKOUT2_PHASE_ERROR {224.819} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25.000} CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_JITTER {223.807} CONFIG.CLKOUT3_PHASE_ERROR {224.819} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {26.000} CONFIG.CLKOUT3_USED {true} CONFIG.CLKOUT4_JITTER {226.032} CONFIG.CLKOUT4_PHASE_ERROR {224.819} CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {24.5000} CONFIG.CLKOUT4_USED {true} CONFIG.CLKOUT5_JITTER {223.037} CONFIG.CLKOUT5_PHASE_ERROR {224.819} CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {27.000} CONFIG.CLKOUT5_USED {true} CONFIG.CLKOUT6_JITTER {218.939} CONFIG.CLKOUT6_PHASE_ERROR {224.819} CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {30.000} CONFIG.CLKOUT6_USED {true} CONFIG.CLKOUT7_JITTER {226.747} CONFIG.CLKOUT7_PHASE_ERROR {224.819} CONFIG.CLKOUT7_REQUESTED_OUT_FREQ {24.000} CONFIG.CLKOUT7_USED {true} CONFIG.JITTER_OPTIONS {UI} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.NUM_OUT_CLKS {7} CONFIG.PRIMITIVE {MMCM} CONFIG.PRIM_IN_FREQ {125} CONFIG.USE_SAFE_CLOCK_STARTUP {true}  ] $clk_wiz_0

  # Create instance: freq_counter_0, and set properties
  set freq_counter_0 [ create_bd_cell -type ip -vlnv sitimecorp.com:ravish:freq_counter:1.0 freq_counter_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650} CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000} CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_RESET_ENABLE {0} CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_EN_CLK2_PORT {0} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {25} CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} CONFIG.PCW_MIO_0_PULLUP {enabled} CONFIG.PCW_MIO_10_PULLUP {enabled} CONFIG.PCW_MIO_11_PULLUP {enabled} CONFIG.PCW_MIO_12_PULLUP {enabled} CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_16_PULLUP {disabled} CONFIG.PCW_MIO_16_SLEW {fast} CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_17_PULLUP {disabled} CONFIG.PCW_MIO_17_SLEW {fast} CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_18_PULLUP {disabled} CONFIG.PCW_MIO_18_SLEW {fast} CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_19_PULLUP {disabled} CONFIG.PCW_MIO_19_SLEW {fast} CONFIG.PCW_MIO_1_PULLUP {disabled} CONFIG.PCW_MIO_1_SLEW {fast} CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_20_PULLUP {disabled} CONFIG.PCW_MIO_20_SLEW {fast} CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_21_PULLUP {disabled} CONFIG.PCW_MIO_21_SLEW {fast} CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_22_PULLUP {disabled} CONFIG.PCW_MIO_22_SLEW {fast} CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_23_PULLUP {disabled} CONFIG.PCW_MIO_23_SLEW {fast} CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_24_PULLUP {disabled} CONFIG.PCW_MIO_24_SLEW {fast} CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_25_PULLUP {disabled} CONFIG.PCW_MIO_25_SLEW {fast} CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_26_PULLUP {disabled} CONFIG.PCW_MIO_26_SLEW {fast} CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_27_PULLUP {disabled} CONFIG.PCW_MIO_27_SLEW {fast} CONFIG.PCW_MIO_28_PULLUP {disabled} CONFIG.PCW_MIO_28_SLEW {fast} CONFIG.PCW_MIO_29_PULLUP {disabled} CONFIG.PCW_MIO_29_SLEW {fast} CONFIG.PCW_MIO_2_SLEW {fast} CONFIG.PCW_MIO_30_PULLUP {disabled} CONFIG.PCW_MIO_30_SLEW {fast} CONFIG.PCW_MIO_31_PULLUP {disabled} CONFIG.PCW_MIO_31_SLEW {fast} CONFIG.PCW_MIO_32_PULLUP {disabled} CONFIG.PCW_MIO_32_SLEW {fast} CONFIG.PCW_MIO_33_PULLUP {disabled} CONFIG.PCW_MIO_33_SLEW {fast} CONFIG.PCW_MIO_34_PULLUP {disabled} CONFIG.PCW_MIO_34_SLEW {fast} CONFIG.PCW_MIO_35_PULLUP {disabled} CONFIG.PCW_MIO_35_SLEW {fast} CONFIG.PCW_MIO_36_PULLUP {disabled} CONFIG.PCW_MIO_36_SLEW {fast} CONFIG.PCW_MIO_37_PULLUP {disabled} CONFIG.PCW_MIO_37_SLEW {fast} CONFIG.PCW_MIO_38_PULLUP {disabled} CONFIG.PCW_MIO_38_SLEW {fast} CONFIG.PCW_MIO_39_PULLUP {disabled} CONFIG.PCW_MIO_39_SLEW {fast} CONFIG.PCW_MIO_3_SLEW {fast} CONFIG.PCW_MIO_40_PULLUP {disabled} CONFIG.PCW_MIO_40_SLEW {fast} CONFIG.PCW_MIO_41_PULLUP {disabled} CONFIG.PCW_MIO_41_SLEW {fast} CONFIG.PCW_MIO_42_PULLUP {disabled} CONFIG.PCW_MIO_42_SLEW {fast} CONFIG.PCW_MIO_43_PULLUP {disabled} CONFIG.PCW_MIO_43_SLEW {fast} CONFIG.PCW_MIO_44_PULLUP {disabled} CONFIG.PCW_MIO_44_SLEW {fast} CONFIG.PCW_MIO_45_PULLUP {disabled} CONFIG.PCW_MIO_45_SLEW {fast} CONFIG.PCW_MIO_47_PULLUP {disabled} CONFIG.PCW_MIO_48_PULLUP {disabled} CONFIG.PCW_MIO_49_PULLUP {disabled} CONFIG.PCW_MIO_4_SLEW {fast} CONFIG.PCW_MIO_50_PULLUP {disabled} CONFIG.PCW_MIO_51_PULLUP {disabled} CONFIG.PCW_MIO_52_PULLUP {disabled} CONFIG.PCW_MIO_52_SLEW {slow} CONFIG.PCW_MIO_53_PULLUP {disabled} CONFIG.PCW_MIO_53_SLEW {slow} CONFIG.PCW_MIO_5_SLEW {fast} CONFIG.PCW_MIO_6_SLEW {fast} CONFIG.PCW_MIO_8_SLEW {fast} CONFIG.PCW_MIO_9_PULLUP {enabled} CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} CONFIG.PCW_SD0_GRP_WP_ENABLE {1} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} CONFIG.PCW_SPI0_SPI0_IO {<Select>} CONFIG.PCW_SPI1_GRP_SS1_ENABLE {1} CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} CONFIG.PCW_SPI1_SPI1_IO {MIO 10 .. 15} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.03} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082} CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB0_RESET_ENABLE {1} CONFIG.PCW_USB0_RESET_IO {MIO 46} CONFIG.preset {Default*}  ] $processing_system7_0

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net clk_in1_1 [get_bd_ports clk_in1] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins freq_counter_0/meas_clk1]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins freq_counter_0/meas_clk2]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins freq_counter_0/meas_clk3]
  connect_bd_net -net clk_wiz_0_clk_out4 [get_bd_pins clk_wiz_0/clk_out4] [get_bd_pins freq_counter_0/meas_clk4]
  connect_bd_net -net clk_wiz_0_clk_out5 [get_bd_pins clk_wiz_0/clk_out5] [get_bd_pins freq_counter_0/meas_clk5]
  connect_bd_net -net clk_wiz_0_clk_out6 [get_bd_pins clk_wiz_0/clk_out6] [get_bd_pins freq_counter_0/meas_clk6]
  connect_bd_net -net clk_wiz_0_clk_out7 [get_bd_pins clk_wiz_0/clk_out7] [get_bd_pins freq_counter_0/meas_clk7]
  connect_bd_net -net clk_wiz_0_locked [get_bd_ports lock_high] [get_bd_pins clk_wiz_0/locked]
  connect_bd_net -net en_counter_1 [get_bd_ports en_counter] [get_bd_pins freq_counter_0/en_counter]
  connect_bd_net -net freq_counter_0_addrb [get_bd_pins blk_mem_gen_0/addrb] [get_bd_pins freq_counter_0/addrb]
  connect_bd_net -net freq_counter_0_data_transfer_status [get_bd_ports trans_status] [get_bd_pins freq_counter_0/data_transfer_status]
  connect_bd_net -net freq_counter_0_dinb [get_bd_pins blk_mem_gen_0/dinb] [get_bd_pins freq_counter_0/dinb]
  connect_bd_net -net freq_counter_0_enb [get_bd_pins blk_mem_gen_0/enb] [get_bd_pins freq_counter_0/enb]
  connect_bd_net -net freq_counter_0_rstb [get_bd_pins blk_mem_gen_0/rstb] [get_bd_pins freq_counter_0/rstb]
  connect_bd_net -net freq_counter_0_web [get_bd_pins blk_mem_gen_0/web] [get_bd_pins freq_counter_0/web]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins blk_mem_gen_0/clkb] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins freq_counter_0/ref_clk] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net reset_counter_1 [get_bd_ports reset_counter] [get_bd_pins freq_counter_0/reset_counter]
  connect_bd_net -net reset_rtl_1 [get_bd_ports reset_rtl] [get_bd_pins clk_wiz_0/reset]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x1000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


