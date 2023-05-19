// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May 18 20:19:26 2023
// Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_pwm_dac_0_0/system_pwm_dac_0_0_sim_netlist.v
// Design      : system_pwm_dac_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_pwm_dac_0_0,pwm_dac,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "pwm_dac,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_pwm_dac_0_0
   (clk,
    val,
    analog);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  input [7:0]val;
  output analog;

  wire analog;
  wire clk;
  wire [7:0]val;

  system_pwm_dac_0_0_pwm_dac inst
       (.analog(analog),
        .clk(clk),
        .val(val));
endmodule

(* ORIG_REF_NAME = "pwm_dac" *) 
module system_pwm_dac_0_0_pwm_dac
   (analog,
    clk,
    val);
  output analog;
  input clk;
  input [7:0]val;

  wire analog;
  wire analog_carry_i_1_n_0;
  wire analog_carry_i_2_n_0;
  wire analog_carry_i_3_n_0;
  wire analog_carry_i_4_n_0;
  wire analog_carry_i_5_n_0;
  wire analog_carry_i_6_n_0;
  wire analog_carry_i_7_n_0;
  wire analog_carry_i_8_n_0;
  wire analog_carry_n_1;
  wire analog_carry_n_2;
  wire analog_carry_n_3;
  wire clk;
  wire \ctr[0]_i_1_n_0 ;
  wire \ctr[7]_i_2_n_0 ;
  wire [7:0]ctr_reg;
  wire [7:1]p_0_in;
  wire [7:0]val;
  wire [3:0]NLW_analog_carry_O_UNCONNECTED;

  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 analog_carry
       (.CI(1'b0),
        .CO({analog,analog_carry_n_1,analog_carry_n_2,analog_carry_n_3}),
        .CYINIT(1'b0),
        .DI({analog_carry_i_1_n_0,analog_carry_i_2_n_0,analog_carry_i_3_n_0,analog_carry_i_4_n_0}),
        .O(NLW_analog_carry_O_UNCONNECTED[3:0]),
        .S({analog_carry_i_5_n_0,analog_carry_i_6_n_0,analog_carry_i_7_n_0,analog_carry_i_8_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    analog_carry_i_1
       (.I0(val[6]),
        .I1(ctr_reg[6]),
        .I2(ctr_reg[7]),
        .I3(val[7]),
        .O(analog_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    analog_carry_i_2
       (.I0(val[4]),
        .I1(ctr_reg[4]),
        .I2(ctr_reg[5]),
        .I3(val[5]),
        .O(analog_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    analog_carry_i_3
       (.I0(val[2]),
        .I1(ctr_reg[2]),
        .I2(ctr_reg[3]),
        .I3(val[3]),
        .O(analog_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    analog_carry_i_4
       (.I0(val[0]),
        .I1(ctr_reg[0]),
        .I2(ctr_reg[1]),
        .I3(val[1]),
        .O(analog_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    analog_carry_i_5
       (.I0(val[6]),
        .I1(ctr_reg[6]),
        .I2(val[7]),
        .I3(ctr_reg[7]),
        .O(analog_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    analog_carry_i_6
       (.I0(val[4]),
        .I1(ctr_reg[4]),
        .I2(val[5]),
        .I3(ctr_reg[5]),
        .O(analog_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    analog_carry_i_7
       (.I0(val[2]),
        .I1(ctr_reg[2]),
        .I2(val[3]),
        .I3(ctr_reg[3]),
        .O(analog_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    analog_carry_i_8
       (.I0(val[0]),
        .I1(ctr_reg[0]),
        .I2(val[1]),
        .I3(ctr_reg[1]),
        .O(analog_carry_i_8_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \ctr[0]_i_1 
       (.I0(ctr_reg[0]),
        .O(\ctr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \ctr[1]_i_1 
       (.I0(ctr_reg[0]),
        .I1(ctr_reg[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \ctr[2]_i_1 
       (.I0(ctr_reg[0]),
        .I1(ctr_reg[1]),
        .I2(ctr_reg[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \ctr[3]_i_1 
       (.I0(ctr_reg[1]),
        .I1(ctr_reg[0]),
        .I2(ctr_reg[2]),
        .I3(ctr_reg[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \ctr[4]_i_1 
       (.I0(ctr_reg[2]),
        .I1(ctr_reg[0]),
        .I2(ctr_reg[1]),
        .I3(ctr_reg[3]),
        .I4(ctr_reg[4]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \ctr[5]_i_1 
       (.I0(ctr_reg[3]),
        .I1(ctr_reg[1]),
        .I2(ctr_reg[0]),
        .I3(ctr_reg[2]),
        .I4(ctr_reg[4]),
        .I5(ctr_reg[5]),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \ctr[6]_i_1 
       (.I0(\ctr[7]_i_2_n_0 ),
        .I1(ctr_reg[6]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \ctr[7]_i_1 
       (.I0(\ctr[7]_i_2_n_0 ),
        .I1(ctr_reg[6]),
        .I2(ctr_reg[7]),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \ctr[7]_i_2 
       (.I0(ctr_reg[5]),
        .I1(ctr_reg[3]),
        .I2(ctr_reg[1]),
        .I3(ctr_reg[0]),
        .I4(ctr_reg[2]),
        .I5(ctr_reg[4]),
        .O(\ctr[7]_i_2_n_0 ));
  FDRE \ctr_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\ctr[0]_i_1_n_0 ),
        .Q(ctr_reg[0]),
        .R(1'b0));
  FDRE \ctr_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(ctr_reg[1]),
        .R(1'b0));
  FDRE \ctr_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(ctr_reg[2]),
        .R(1'b0));
  FDRE \ctr_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(ctr_reg[3]),
        .R(1'b0));
  FDRE \ctr_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(ctr_reg[4]),
        .R(1'b0));
  FDRE \ctr_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[5]),
        .Q(ctr_reg[5]),
        .R(1'b0));
  FDRE \ctr_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[6]),
        .Q(ctr_reg[6]),
        .R(1'b0));
  FDRE \ctr_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(p_0_in[7]),
        .Q(ctr_reg[7]),
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
