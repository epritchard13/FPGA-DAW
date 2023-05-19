// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May 18 23:26:56 2023
// Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_spi_link_sm_0_0/system_spi_link_sm_0_0_sim_netlist.v
// Design      : system_spi_link_sm_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_spi_link_sm_0_0,spi_link_sm,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "spi_link_sm,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_spi_link_sm_0_0
   (clk,
    rst,
    spi_data,
    valid,
    dac_state);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input [7:0]spi_data;
  input valid;
  output [7:0]dac_state;

  wire clk;
  wire [7:0]dac_state;
  wire rst;
  wire [7:0]spi_data;
  wire valid;

  system_spi_link_sm_0_0_spi_link_sm inst
       (.clk(clk),
        .dac_state(dac_state),
        .rst(rst),
        .spi_data(spi_data),
        .valid(valid));
endmodule

(* ORIG_REF_NAME = "spi_link_sm" *) 
module system_spi_link_sm_0_0_spi_link_sm
   (dac_state,
    spi_data,
    clk,
    valid,
    rst);
  output [7:0]dac_state;
  input [7:0]spi_data;
  input clk;
  input valid;
  input rst;

  wire FSM_sequential_state_i_1_n_0;
  wire FSM_sequential_state_i_2_n_0;
  wire FSM_sequential_state_reg_n_0;
  wire clk;
  wire [7:0]dac_state;
  wire \dac_state[7]_i_1_n_0 ;
  wire rst;
  wire [7:0]spi_data;
  wire valid;

  LUT6 #(
    .INIT(64'h000400000004FF00)) 
    FSM_sequential_state_i_1
       (.I0(spi_data[5]),
        .I1(FSM_sequential_state_i_2_n_0),
        .I2(spi_data[4]),
        .I3(FSM_sequential_state_reg_n_0),
        .I4(valid),
        .I5(rst),
        .O(FSM_sequential_state_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000040000000)) 
    FSM_sequential_state_i_2
       (.I0(spi_data[3]),
        .I1(spi_data[7]),
        .I2(spi_data[1]),
        .I3(spi_data[0]),
        .I4(spi_data[2]),
        .I5(spi_data[6]),
        .O(FSM_sequential_state_i_2_n_0));
  (* FSM_ENCODED_STATES = "iSTATE:0,iSTATE0:1" *) 
  FDRE #(
    .INIT(1'b0)) 
    FSM_sequential_state_reg
       (.C(clk),
        .CE(1'b1),
        .D(FSM_sequential_state_i_1_n_0),
        .Q(FSM_sequential_state_reg_n_0),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \dac_state[7]_i_1 
       (.I0(FSM_sequential_state_reg_n_0),
        .I1(valid),
        .O(\dac_state[7]_i_1_n_0 ));
  FDRE \dac_state_reg[0] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[0]),
        .Q(dac_state[0]),
        .R(1'b0));
  FDRE \dac_state_reg[1] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[1]),
        .Q(dac_state[1]),
        .R(1'b0));
  FDRE \dac_state_reg[2] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[2]),
        .Q(dac_state[2]),
        .R(1'b0));
  FDRE \dac_state_reg[3] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[3]),
        .Q(dac_state[3]),
        .R(1'b0));
  FDRE \dac_state_reg[4] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[4]),
        .Q(dac_state[4]),
        .R(1'b0));
  FDRE \dac_state_reg[5] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[5]),
        .Q(dac_state[5]),
        .R(1'b0));
  FDRE \dac_state_reg[6] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[6]),
        .Q(dac_state[6]),
        .R(1'b0));
  FDRE \dac_state_reg[7] 
       (.C(clk),
        .CE(\dac_state[7]_i_1_n_0 ),
        .D(spi_data[7]),
        .Q(dac_state[7]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
