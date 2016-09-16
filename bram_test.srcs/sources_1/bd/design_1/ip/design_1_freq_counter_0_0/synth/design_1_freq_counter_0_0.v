// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: sitimecorp.com:ravish:freq_counter:1.0
// IP Revision: 2

(* X_CORE_INFO = "freq_counter,Vivado 2014.3.1" *)
(* CHECK_LICENSE_TYPE = "design_1_freq_counter_0_0,freq_counter,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_freq_counter_0_0 (
  ref_clk,
  meas_clk1,
  meas_clk2,
  meas_clk3,
  meas_clk4,
  meas_clk5,
  meas_clk6,
  meas_clk7,
  meas_clk8,
  en_counter,
  reset_counter,
  dinb,
  addrb,
  web,
  enb,
  rstb,
  data_transfer_status
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ref_signal_clock CLK" *)
input wire ref_clk;
input wire meas_clk1;
input wire meas_clk2;
input wire meas_clk3;
input wire meas_clk4;
input wire meas_clk5;
input wire meas_clk6;
input wire meas_clk7;
input wire meas_clk8;
input wire en_counter;
input wire reset_counter;
output wire [31 : 0] dinb;
output wire [31 : 0] addrb;
output wire [3 : 0] web;
output wire enb;
output wire rstb;
output wire data_transfer_status;

  freq_counter inst (
    .ref_clk(ref_clk),
    .meas_clk1(meas_clk1),
    .meas_clk2(meas_clk2),
    .meas_clk3(meas_clk3),
    .meas_clk4(meas_clk4),
    .meas_clk5(meas_clk5),
    .meas_clk6(meas_clk6),
    .meas_clk7(meas_clk7),
    .meas_clk8(meas_clk8),
    .en_counter(en_counter),
    .reset_counter(reset_counter),
    .dinb(dinb),
    .addrb(addrb),
    .web(web),
    .enb(enb),
    .rstb(rstb),
    .data_transfer_status(data_transfer_status)
  );
endmodule
