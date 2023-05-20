// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sat May 20 10:44:23 2023
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
    valid,
    rst,
    clk,
    spi_data);
  output [7:0]dac_state;
  input valid;
  input rst;
  input clk;
  input [7:0]spi_data;

  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state_reg_n_0_[1] ;
  wire clk;
  wire [15:0]ctr0;
  wire \ctr0[15]_i_1_n_0 ;
  wire \ctr0[15]_i_2_n_0 ;
  wire \ctr0[15]_i_4_n_0 ;
  wire \ctr0_reg[12]_i_2_n_0 ;
  wire \ctr0_reg[12]_i_2_n_1 ;
  wire \ctr0_reg[12]_i_2_n_2 ;
  wire \ctr0_reg[12]_i_2_n_3 ;
  wire \ctr0_reg[15]_i_5_n_2 ;
  wire \ctr0_reg[15]_i_5_n_3 ;
  wire \ctr0_reg[4]_i_2_n_0 ;
  wire \ctr0_reg[4]_i_2_n_1 ;
  wire \ctr0_reg[4]_i_2_n_2 ;
  wire \ctr0_reg[4]_i_2_n_3 ;
  wire \ctr0_reg[8]_i_2_n_0 ;
  wire \ctr0_reg[8]_i_2_n_1 ;
  wire \ctr0_reg[8]_i_2_n_2 ;
  wire \ctr0_reg[8]_i_2_n_3 ;
  wire \ctr0_reg_n_0_[0] ;
  wire \ctr0_reg_n_0_[10] ;
  wire \ctr0_reg_n_0_[11] ;
  wire \ctr0_reg_n_0_[12] ;
  wire \ctr0_reg_n_0_[13] ;
  wire \ctr0_reg_n_0_[14] ;
  wire \ctr0_reg_n_0_[15] ;
  wire \ctr0_reg_n_0_[1] ;
  wire \ctr0_reg_n_0_[2] ;
  wire \ctr0_reg_n_0_[3] ;
  wire \ctr0_reg_n_0_[4] ;
  wire \ctr0_reg_n_0_[5] ;
  wire \ctr0_reg_n_0_[6] ;
  wire \ctr0_reg_n_0_[7] ;
  wire \ctr0_reg_n_0_[8] ;
  wire \ctr0_reg_n_0_[9] ;
  wire [7:0]dac_state;
  wire \dac_state[7]_i_1_n_0 ;
  wire [15:1]data0;
  wire header;
  wire \header[0][7]_i_1_n_0 ;
  wire \header[0][7]_i_2_n_0 ;
  wire \header[0][7]_i_3_n_0 ;
  wire \header[0][7]_i_4_n_0 ;
  wire \header[0][7]_i_5_n_0 ;
  wire [15:0]p_0_in;
  wire rst;
  wire [7:0]spi_data;
  wire state1_carry__0_n_2;
  wire state1_carry__0_n_3;
  wire state1_carry_i_1__0_n_0;
  wire state1_carry_i_1_n_0;
  wire state1_carry_i_2__0_n_0;
  wire state1_carry_i_2_n_0;
  wire state1_carry_i_3_n_0;
  wire state1_carry_i_4_n_0;
  wire state1_carry_n_0;
  wire state1_carry_n_1;
  wire state1_carry_n_2;
  wire state1_carry_n_3;
  wire [0:0]state__0;
  wire valid;
  wire [3:2]\NLW_ctr0_reg[15]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_ctr0_reg[15]_i_5_O_UNCONNECTED ;
  wire [3:0]NLW_state1_carry_O_UNCONNECTED;
  wire [3:2]NLW_state1_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_state1_carry__0_O_UNCONNECTED;

  LUT6 #(
    .INIT(64'hAEAEAEFFAEAEAE0C)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(valid),
        .I2(\FSM_sequential_state[1]_i_2_n_0 ),
        .I3(rst),
        .I4(\FSM_sequential_state[1]_i_3_n_0 ),
        .I5(state__0),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(spi_data[2]),
        .I1(spi_data[3]),
        .I2(spi_data[1]),
        .I3(spi_data[0]),
        .I4(state__0),
        .I5(\ctr0[15]_i_4_n_0 ),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAEAEAEFFAEAEAE0C)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(\ctr0[15]_i_1_n_0 ),
        .I1(valid),
        .I2(\FSM_sequential_state[1]_i_2_n_0 ),
        .I3(rst),
        .I4(\FSM_sequential_state[1]_i_3_n_0 ),
        .I5(\FSM_sequential_state_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(\header[0][7]_i_2_n_0 ),
        .I1(\ctr0_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF80A0)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(valid),
        .I1(state1_carry__0_n_2),
        .I2(state__0),
        .I3(\FSM_sequential_state_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1]_i_4_n_0 ),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00800200)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(\ctr0[15]_i_4_n_0 ),
        .I1(spi_data[1]),
        .I2(spi_data[0]),
        .I3(spi_data[3]),
        .I4(spi_data[2]),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:10,iSTATE0:01,iSTATE1:00,iSTATE2:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state__0),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "iSTATE:10,iSTATE0:01,iSTATE1:00,iSTATE2:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(\FSM_sequential_state_reg_n_0_[1] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \ctr0[0]_i_1 
       (.I0(\ctr0_reg_n_0_[0] ),
        .O(ctr0[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[10]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[10]),
        .O(ctr0[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[11]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[11]),
        .O(ctr0[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[12]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[12]),
        .O(ctr0[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[13]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[13]),
        .O(ctr0[13]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[14]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[14]),
        .O(ctr0[14]));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \ctr0[15]_i_1 
       (.I0(spi_data[3]),
        .I1(spi_data[2]),
        .I2(spi_data[1]),
        .I3(spi_data[0]),
        .I4(state__0),
        .I5(\ctr0[15]_i_4_n_0 ),
        .O(\ctr0[15]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[15]_i_2 
       (.I0(valid),
        .I1(\FSM_sequential_state_reg_n_0_[1] ),
        .O(\ctr0[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[15]_i_3 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[15]),
        .O(ctr0[15]));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \ctr0[15]_i_4 
       (.I0(spi_data[4]),
        .I1(spi_data[5]),
        .I2(spi_data[7]),
        .I3(spi_data[6]),
        .I4(\FSM_sequential_state_reg_n_0_[1] ),
        .I5(valid),
        .O(\ctr0[15]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[1]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[1]),
        .O(ctr0[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[2]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[2]),
        .O(ctr0[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[3]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[3]),
        .O(ctr0[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[4]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[4]),
        .O(ctr0[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[5]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[5]),
        .O(ctr0[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[6]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[6]),
        .O(ctr0[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[7]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[7]),
        .O(ctr0[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[8]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[8]),
        .O(ctr0[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ctr0[9]_i_1 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(data0[9]),
        .O(ctr0[9]));
  FDRE \ctr0_reg[0] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[0]),
        .Q(\ctr0_reg_n_0_[0] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[10] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[10]),
        .Q(\ctr0_reg_n_0_[10] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[11] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[11]),
        .Q(\ctr0_reg_n_0_[11] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[12] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[12]),
        .Q(\ctr0_reg_n_0_[12] ),
        .R(\ctr0[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ctr0_reg[12]_i_2 
       (.CI(\ctr0_reg[8]_i_2_n_0 ),
        .CO({\ctr0_reg[12]_i_2_n_0 ,\ctr0_reg[12]_i_2_n_1 ,\ctr0_reg[12]_i_2_n_2 ,\ctr0_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({\ctr0_reg_n_0_[12] ,\ctr0_reg_n_0_[11] ,\ctr0_reg_n_0_[10] ,\ctr0_reg_n_0_[9] }));
  FDRE \ctr0_reg[13] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[13]),
        .Q(\ctr0_reg_n_0_[13] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[14] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[14]),
        .Q(\ctr0_reg_n_0_[14] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[15] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[15]),
        .Q(\ctr0_reg_n_0_[15] ),
        .R(\ctr0[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ctr0_reg[15]_i_5 
       (.CI(\ctr0_reg[12]_i_2_n_0 ),
        .CO({\NLW_ctr0_reg[15]_i_5_CO_UNCONNECTED [3:2],\ctr0_reg[15]_i_5_n_2 ,\ctr0_reg[15]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_ctr0_reg[15]_i_5_O_UNCONNECTED [3],data0[15:13]}),
        .S({1'b0,\ctr0_reg_n_0_[15] ,\ctr0_reg_n_0_[14] ,\ctr0_reg_n_0_[13] }));
  FDRE \ctr0_reg[1] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[1]),
        .Q(\ctr0_reg_n_0_[1] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[2] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[2]),
        .Q(\ctr0_reg_n_0_[2] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[3] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[3]),
        .Q(\ctr0_reg_n_0_[3] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[4] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[4]),
        .Q(\ctr0_reg_n_0_[4] ),
        .R(\ctr0[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ctr0_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\ctr0_reg[4]_i_2_n_0 ,\ctr0_reg[4]_i_2_n_1 ,\ctr0_reg[4]_i_2_n_2 ,\ctr0_reg[4]_i_2_n_3 }),
        .CYINIT(\ctr0_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({\ctr0_reg_n_0_[4] ,\ctr0_reg_n_0_[3] ,\ctr0_reg_n_0_[2] ,\ctr0_reg_n_0_[1] }));
  FDRE \ctr0_reg[5] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[5]),
        .Q(\ctr0_reg_n_0_[5] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[6] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[6]),
        .Q(\ctr0_reg_n_0_[6] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[7] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[7]),
        .Q(\ctr0_reg_n_0_[7] ),
        .R(\ctr0[15]_i_1_n_0 ));
  FDRE \ctr0_reg[8] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[8]),
        .Q(\ctr0_reg_n_0_[8] ),
        .R(\ctr0[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ctr0_reg[8]_i_2 
       (.CI(\ctr0_reg[4]_i_2_n_0 ),
        .CO({\ctr0_reg[8]_i_2_n_0 ,\ctr0_reg[8]_i_2_n_1 ,\ctr0_reg[8]_i_2_n_2 ,\ctr0_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({\ctr0_reg_n_0_[8] ,\ctr0_reg_n_0_[7] ,\ctr0_reg_n_0_[6] ,\ctr0_reg_n_0_[5] }));
  FDRE \ctr0_reg[9] 
       (.C(clk),
        .CE(\ctr0[15]_i_2_n_0 ),
        .D(ctr0[9]),
        .Q(\ctr0_reg_n_0_[9] ),
        .R(\ctr0[15]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \dac_state[7]_i_1 
       (.I0(\FSM_sequential_state_reg_n_0_[1] ),
        .I1(valid),
        .I2(state__0),
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
  LUT3 #(
    .INIT(8'h04)) 
    \header[0][7]_i_1 
       (.I0(\ctr0_reg_n_0_[0] ),
        .I1(valid),
        .I2(\header[0][7]_i_2_n_0 ),
        .O(\header[0][7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \header[0][7]_i_2 
       (.I0(\header[0][7]_i_3_n_0 ),
        .I1(\ctr0_reg_n_0_[3] ),
        .I2(\ctr0_reg_n_0_[4] ),
        .I3(\ctr0_reg_n_0_[5] ),
        .I4(\header[0][7]_i_4_n_0 ),
        .I5(\header[0][7]_i_5_n_0 ),
        .O(\header[0][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \header[0][7]_i_3 
       (.I0(\ctr0_reg_n_0_[9] ),
        .I1(\ctr0_reg_n_0_[10] ),
        .I2(\ctr0_reg_n_0_[11] ),
        .I3(\ctr0_reg_n_0_[12] ),
        .I4(\ctr0_reg_n_0_[13] ),
        .I5(\ctr0_reg_n_0_[14] ),
        .O(\header[0][7]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \header[0][7]_i_4 
       (.I0(\ctr0_reg_n_0_[8] ),
        .I1(\ctr0_reg_n_0_[7] ),
        .I2(\ctr0_reg_n_0_[6] ),
        .O(\header[0][7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \header[0][7]_i_5 
       (.I0(\ctr0_reg_n_0_[15] ),
        .I1(\ctr0_reg_n_0_[1] ),
        .I2(\ctr0_reg_n_0_[2] ),
        .I3(\FSM_sequential_state_reg_n_0_[1] ),
        .I4(state__0),
        .O(\header[0][7]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \header[1][7]_i_1 
       (.I0(valid),
        .I1(\FSM_sequential_state[1]_i_2_n_0 ),
        .O(header));
  FDRE \header_reg[0][0] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[0]),
        .Q(p_0_in[8]),
        .R(1'b0));
  FDRE \header_reg[0][1] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[1]),
        .Q(p_0_in[9]),
        .R(1'b0));
  FDRE \header_reg[0][2] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[2]),
        .Q(p_0_in[10]),
        .R(1'b0));
  FDRE \header_reg[0][3] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[3]),
        .Q(p_0_in[11]),
        .R(1'b0));
  FDRE \header_reg[0][4] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[4]),
        .Q(p_0_in[12]),
        .R(1'b0));
  FDRE \header_reg[0][5] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[5]),
        .Q(p_0_in[13]),
        .R(1'b0));
  FDRE \header_reg[0][6] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[6]),
        .Q(p_0_in[14]),
        .R(1'b0));
  FDRE \header_reg[0][7] 
       (.C(clk),
        .CE(\header[0][7]_i_1_n_0 ),
        .D(spi_data[7]),
        .Q(p_0_in[15]),
        .R(1'b0));
  FDRE \header_reg[1][0] 
       (.C(clk),
        .CE(header),
        .D(spi_data[0]),
        .Q(p_0_in[0]),
        .R(1'b0));
  FDRE \header_reg[1][1] 
       (.C(clk),
        .CE(header),
        .D(spi_data[1]),
        .Q(p_0_in[1]),
        .R(1'b0));
  FDRE \header_reg[1][2] 
       (.C(clk),
        .CE(header),
        .D(spi_data[2]),
        .Q(p_0_in[2]),
        .R(1'b0));
  FDRE \header_reg[1][3] 
       (.C(clk),
        .CE(header),
        .D(spi_data[3]),
        .Q(p_0_in[3]),
        .R(1'b0));
  FDRE \header_reg[1][4] 
       (.C(clk),
        .CE(header),
        .D(spi_data[4]),
        .Q(p_0_in[4]),
        .R(1'b0));
  FDRE \header_reg[1][5] 
       (.C(clk),
        .CE(header),
        .D(spi_data[5]),
        .Q(p_0_in[5]),
        .R(1'b0));
  FDRE \header_reg[1][6] 
       (.C(clk),
        .CE(header),
        .D(spi_data[6]),
        .Q(p_0_in[6]),
        .R(1'b0));
  FDRE \header_reg[1][7] 
       (.C(clk),
        .CE(header),
        .D(spi_data[7]),
        .Q(p_0_in[7]),
        .R(1'b0));
  CARRY4 state1_carry
       (.CI(1'b0),
        .CO({state1_carry_n_0,state1_carry_n_1,state1_carry_n_2,state1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_state1_carry_O_UNCONNECTED[3:0]),
        .S({state1_carry_i_1_n_0,state1_carry_i_2__0_n_0,state1_carry_i_3_n_0,state1_carry_i_4_n_0}));
  CARRY4 state1_carry__0
       (.CI(state1_carry_n_0),
        .CO({NLW_state1_carry__0_CO_UNCONNECTED[3:2],state1_carry__0_n_2,state1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_state1_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,state1_carry_i_1__0_n_0,state1_carry_i_2_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    state1_carry_i_1
       (.I0(p_0_in[11]),
        .I1(\ctr0_reg_n_0_[11] ),
        .I2(p_0_in[10]),
        .I3(\ctr0_reg_n_0_[10] ),
        .I4(\ctr0_reg_n_0_[9] ),
        .I5(p_0_in[9]),
        .O(state1_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    state1_carry_i_1__0
       (.I0(p_0_in[15]),
        .I1(\ctr0_reg_n_0_[15] ),
        .O(state1_carry_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    state1_carry_i_2
       (.I0(p_0_in[14]),
        .I1(\ctr0_reg_n_0_[14] ),
        .I2(p_0_in[13]),
        .I3(\ctr0_reg_n_0_[13] ),
        .I4(\ctr0_reg_n_0_[12] ),
        .I5(p_0_in[12]),
        .O(state1_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    state1_carry_i_2__0
       (.I0(p_0_in[8]),
        .I1(\ctr0_reg_n_0_[8] ),
        .I2(p_0_in[7]),
        .I3(\ctr0_reg_n_0_[7] ),
        .I4(\ctr0_reg_n_0_[6] ),
        .I5(p_0_in[6]),
        .O(state1_carry_i_2__0_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    state1_carry_i_3
       (.I0(p_0_in[5]),
        .I1(\ctr0_reg_n_0_[5] ),
        .I2(p_0_in[4]),
        .I3(\ctr0_reg_n_0_[4] ),
        .I4(\ctr0_reg_n_0_[3] ),
        .I5(p_0_in[3]),
        .O(state1_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h8400008421000021)) 
    state1_carry_i_4
       (.I0(p_0_in[2]),
        .I1(\ctr0_reg_n_0_[1] ),
        .I2(\ctr0_reg_n_0_[2] ),
        .I3(\ctr0_reg_n_0_[0] ),
        .I4(p_0_in[0]),
        .I5(p_0_in[1]),
        .O(state1_carry_i_4_n_0));
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
