// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May 18 19:28:35 2023
// Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_SPI_Slave_0_0/system_SPI_Slave_0_0_sim_netlist.v
// Design      : system_SPI_Slave_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_SPI_Slave_0_0,SPI_Slave,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "SPI_Slave,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_SPI_Slave_0_0
   (i_Rst_L,
    i_Clk,
    o_RX_DV,
    o_RX_Byte,
    i_TX_DV,
    i_TX_Byte,
    i_SPI_Clk,
    o_SPI_MISO,
    i_SPI_MOSI,
    i_SPI_CS_n);
  input i_Rst_L;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 i_Clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME i_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input i_Clk;
  output o_RX_DV;
  output [7:0]o_RX_Byte;
  input i_TX_DV;
  input [7:0]i_TX_Byte;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 i_SPI_Clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME i_SPI_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input i_SPI_Clk;
  output o_SPI_MISO;
  input i_SPI_MOSI;
  input i_SPI_CS_n;

  wire i_Clk;
  wire i_Rst_L;
  wire i_SPI_CS_n;
  wire i_SPI_Clk;
  wire i_SPI_MOSI;
  wire [7:0]i_TX_Byte;
  wire i_TX_DV;
  wire [7:0]o_RX_Byte;
  wire o_RX_DV;
  wire o_SPI_MISO;

  system_SPI_Slave_0_0_SPI_Slave inst
       (.i_Clk(i_Clk),
        .i_Rst_L(i_Rst_L),
        .i_SPI_CS_n(i_SPI_CS_n),
        .i_SPI_Clk(i_SPI_Clk),
        .i_SPI_MOSI(i_SPI_MOSI),
        .i_TX_Byte(i_TX_Byte),
        .i_TX_DV(i_TX_DV),
        .o_RX_Byte(o_RX_Byte),
        .o_RX_DV(o_RX_DV),
        .o_SPI_MISO(o_SPI_MISO));
endmodule

(* ORIG_REF_NAME = "SPI_Slave" *) 
module system_SPI_Slave_0_0_SPI_Slave
   (o_SPI_MISO,
    o_RX_DV,
    o_RX_Byte,
    i_SPI_Clk,
    i_SPI_CS_n,
    i_Clk,
    i_SPI_MOSI,
    i_TX_DV,
    i_TX_Byte,
    i_Rst_L);
  output o_SPI_MISO;
  output o_RX_DV;
  output [7:0]o_RX_Byte;
  input i_SPI_Clk;
  input i_SPI_CS_n;
  input i_Clk;
  input i_SPI_MOSI;
  input i_TX_DV;
  input [7:0]i_TX_Byte;
  input i_Rst_L;

  wire i_Clk;
  wire i_Rst_L;
  wire i_SPI_CS_n;
  wire i_SPI_Clk;
  wire i_SPI_MOSI;
  wire [7:0]i_TX_Byte;
  wire i_TX_DV;
  wire [7:0]o_RX_Byte;
  wire o_RX_DV;
  wire o_RX_DV_i_1_n_0;
  wire o_RX_DV_i_2_n_0;
  wire o_SPI_MISO;
  wire o_SPI_MISO_INST_0_i_1_n_0;
  wire [7:1]p_0_in;
  wire p_0_in_0;
  wire [2:0]p_0_in__0;
  wire p_2_in;
  wire r2_RX_Done;
  wire r3_RX_Done;
  wire r_Preload_MISO;
  wire [2:0]r_RX_Bit_Count;
  wire [7:0]r_RX_Byte;
  wire \r_RX_Byte[7]_i_1_n_0 ;
  wire r_RX_Done_i_1_n_0;
  wire r_RX_Done_reg_n_0;
  wire r_SPI_MISO_Bit_C_i_2_n_0;
  wire r_SPI_MISO_Bit_C_i_3_n_0;
  wire r_SPI_MISO_Bit_reg_C_n_0;
  wire r_SPI_MISO_Bit_reg_LDC_i_1_n_0;
  wire r_SPI_MISO_Bit_reg_LDC_i_2_n_0;
  wire r_SPI_MISO_Bit_reg_LDC_n_0;
  wire r_SPI_MISO_Bit_reg_P_n_0;
  wire [2:0]r_TX_Bit_Count;
  wire [0:0]r_TX_Bit_Count0;
  wire \r_TX_Bit_Count[1]_i_1_n_0 ;
  wire \r_TX_Bit_Count[2]_i_1_n_0 ;
  wire \r_TX_Byte_reg_n_0_[0] ;
  wire \r_TX_Byte_reg_n_0_[1] ;
  wire \r_TX_Byte_reg_n_0_[2] ;
  wire \r_TX_Byte_reg_n_0_[3] ;
  wire \r_TX_Byte_reg_n_0_[4] ;
  wire \r_TX_Byte_reg_n_0_[5] ;
  wire \r_TX_Byte_reg_n_0_[6] ;

  FDCE \o_RX_Byte_reg[0] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[0]),
        .Q(o_RX_Byte[0]));
  FDCE \o_RX_Byte_reg[1] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[1]),
        .Q(o_RX_Byte[1]));
  FDCE \o_RX_Byte_reg[2] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[2]),
        .Q(o_RX_Byte[2]));
  FDCE \o_RX_Byte_reg[3] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[3]),
        .Q(o_RX_Byte[3]));
  FDCE \o_RX_Byte_reg[4] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[4]),
        .Q(o_RX_Byte[4]));
  FDCE \o_RX_Byte_reg[5] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[5]),
        .Q(o_RX_Byte[5]));
  FDCE \o_RX_Byte_reg[6] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[6]),
        .Q(o_RX_Byte[6]));
  FDCE \o_RX_Byte_reg[7] 
       (.C(i_Clk),
        .CE(o_RX_DV_i_1_n_0),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Byte[7]),
        .Q(o_RX_Byte[7]));
  LUT2 #(
    .INIT(4'h2)) 
    o_RX_DV_i_1
       (.I0(r2_RX_Done),
        .I1(r3_RX_Done),
        .O(o_RX_DV_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    o_RX_DV_i_2
       (.I0(i_Rst_L),
        .O(o_RX_DV_i_2_n_0));
  FDCE o_RX_DV_reg
       (.C(i_Clk),
        .CE(1'b1),
        .CLR(o_RX_DV_i_2_n_0),
        .D(o_RX_DV_i_1_n_0),
        .Q(o_RX_DV));
  LUT6 #(
    .INIT(64'hB8BBB88800000000)) 
    o_SPI_MISO_INST_0
       (.I0(p_0_in_0),
        .I1(r_Preload_MISO),
        .I2(r_SPI_MISO_Bit_reg_P_n_0),
        .I3(r_SPI_MISO_Bit_reg_LDC_n_0),
        .I4(r_SPI_MISO_Bit_reg_C_n_0),
        .I5(o_SPI_MISO_INST_0_i_1_n_0),
        .O(o_SPI_MISO));
  LUT1 #(
    .INIT(2'h1)) 
    o_SPI_MISO_INST_0_i_1
       (.I0(i_SPI_CS_n),
        .O(o_SPI_MISO_INST_0_i_1_n_0));
  FDCE r2_RX_Done_reg
       (.C(i_Clk),
        .CE(1'b1),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r_RX_Done_reg_n_0),
        .Q(r2_RX_Done));
  FDCE r3_RX_Done_reg
       (.C(i_Clk),
        .CE(1'b1),
        .CLR(o_RX_DV_i_2_n_0),
        .D(r2_RX_Done),
        .Q(r3_RX_Done));
  FDPE r_Preload_MISO_reg
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(i_SPI_CS_n),
        .Q(r_Preload_MISO));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \r_RX_Bit_Count[0]_i_1 
       (.I0(r_RX_Bit_Count[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \r_RX_Bit_Count[1]_i_1 
       (.I0(r_RX_Bit_Count[0]),
        .I1(r_RX_Bit_Count[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \r_RX_Bit_Count[2]_i_1 
       (.I0(r_RX_Bit_Count[0]),
        .I1(r_RX_Bit_Count[1]),
        .I2(r_RX_Bit_Count[2]),
        .O(p_0_in__0[2]));
  FDCE \r_RX_Bit_Count_reg[0] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .CLR(i_SPI_CS_n),
        .D(p_0_in__0[0]),
        .Q(r_RX_Bit_Count[0]));
  FDCE \r_RX_Bit_Count_reg[1] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .CLR(i_SPI_CS_n),
        .D(p_0_in__0[1]),
        .Q(r_RX_Bit_Count[1]));
  FDCE \r_RX_Bit_Count_reg[2] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .CLR(i_SPI_CS_n),
        .D(p_0_in__0[2]),
        .Q(r_RX_Bit_Count[2]));
  LUT4 #(
    .INIT(16'h0080)) 
    \r_RX_Byte[7]_i_1 
       (.I0(r_RX_Bit_Count[0]),
        .I1(r_RX_Bit_Count[2]),
        .I2(r_RX_Bit_Count[1]),
        .I3(i_SPI_CS_n),
        .O(\r_RX_Byte[7]_i_1_n_0 ));
  FDRE \r_RX_Byte_reg[0] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(i_SPI_MOSI),
        .Q(r_RX_Byte[0]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[1] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[1]),
        .Q(r_RX_Byte[1]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[2] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[2]),
        .Q(r_RX_Byte[2]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[3] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[3]),
        .Q(r_RX_Byte[3]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[4] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[4]),
        .Q(r_RX_Byte[4]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[5] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[5]),
        .Q(r_RX_Byte[5]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[6] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[6]),
        .Q(r_RX_Byte[6]),
        .R(1'b0));
  FDRE \r_RX_Byte_reg[7] 
       (.C(i_SPI_Clk),
        .CE(\r_RX_Byte[7]_i_1_n_0 ),
        .D(p_0_in[7]),
        .Q(r_RX_Byte[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFD80)) 
    r_RX_Done_i_1
       (.I0(r_RX_Bit_Count[1]),
        .I1(r_RX_Bit_Count[2]),
        .I2(r_RX_Bit_Count[0]),
        .I3(r_RX_Done_reg_n_0),
        .O(r_RX_Done_i_1_n_0));
  FDCE r_RX_Done_reg
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .CLR(i_SPI_CS_n),
        .D(r_RX_Done_i_1_n_0),
        .Q(r_RX_Done_reg_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    r_SPI_MISO_Bit_C_i_2
       (.I0(\r_TX_Byte_reg_n_0_[3] ),
        .I1(\r_TX_Byte_reg_n_0_[2] ),
        .I2(r_TX_Bit_Count[1]),
        .I3(\r_TX_Byte_reg_n_0_[1] ),
        .I4(r_TX_Bit_Count[0]),
        .I5(\r_TX_Byte_reg_n_0_[0] ),
        .O(r_SPI_MISO_Bit_C_i_2_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    r_SPI_MISO_Bit_C_i_3
       (.I0(p_0_in_0),
        .I1(\r_TX_Byte_reg_n_0_[6] ),
        .I2(r_TX_Bit_Count[1]),
        .I3(\r_TX_Byte_reg_n_0_[5] ),
        .I4(r_TX_Bit_Count[0]),
        .I5(\r_TX_Byte_reg_n_0_[4] ),
        .O(r_SPI_MISO_Bit_C_i_3_n_0));
  FDCE r_SPI_MISO_Bit_reg_C
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .CLR(r_SPI_MISO_Bit_reg_LDC_i_2_n_0),
        .D(p_2_in),
        .Q(r_SPI_MISO_Bit_reg_C_n_0));
  MUXF7 r_SPI_MISO_Bit_reg_C_i_1
       (.I0(r_SPI_MISO_Bit_C_i_2_n_0),
        .I1(r_SPI_MISO_Bit_C_i_3_n_0),
        .O(p_2_in),
        .S(r_TX_Bit_Count[2]));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    r_SPI_MISO_Bit_reg_LDC
       (.CLR(r_SPI_MISO_Bit_reg_LDC_i_2_n_0),
        .D(1'b1),
        .G(r_SPI_MISO_Bit_reg_LDC_i_1_n_0),
        .GE(1'b1),
        .Q(r_SPI_MISO_Bit_reg_LDC_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    r_SPI_MISO_Bit_reg_LDC_i_1
       (.I0(i_SPI_CS_n),
        .I1(p_0_in_0),
        .O(r_SPI_MISO_Bit_reg_LDC_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    r_SPI_MISO_Bit_reg_LDC_i_2
       (.I0(i_SPI_CS_n),
        .I1(p_0_in_0),
        .O(r_SPI_MISO_Bit_reg_LDC_i_2_n_0));
  FDPE r_SPI_MISO_Bit_reg_P
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .D(p_2_in),
        .PRE(r_SPI_MISO_Bit_reg_LDC_i_1_n_0),
        .Q(r_SPI_MISO_Bit_reg_P_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \r_TX_Bit_Count[0]_i_1 
       (.I0(r_TX_Bit_Count[0]),
        .O(r_TX_Bit_Count0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \r_TX_Bit_Count[1]_i_1 
       (.I0(r_TX_Bit_Count[0]),
        .I1(r_TX_Bit_Count[1]),
        .O(\r_TX_Bit_Count[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \r_TX_Bit_Count[2]_i_1 
       (.I0(r_TX_Bit_Count[1]),
        .I1(r_TX_Bit_Count[0]),
        .I2(r_TX_Bit_Count[2]),
        .O(\r_TX_Bit_Count[2]_i_1_n_0 ));
  FDPE \r_TX_Bit_Count_reg[0] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .D(r_TX_Bit_Count0),
        .PRE(i_SPI_CS_n),
        .Q(r_TX_Bit_Count[0]));
  FDPE \r_TX_Bit_Count_reg[1] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .D(\r_TX_Bit_Count[1]_i_1_n_0 ),
        .PRE(i_SPI_CS_n),
        .Q(r_TX_Bit_Count[1]));
  FDPE \r_TX_Bit_Count_reg[2] 
       (.C(i_SPI_Clk),
        .CE(1'b1),
        .D(\r_TX_Bit_Count[2]_i_1_n_0 ),
        .PRE(i_SPI_CS_n),
        .Q(r_TX_Bit_Count[2]));
  FDCE \r_TX_Byte_reg[0] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[0]),
        .Q(\r_TX_Byte_reg_n_0_[0] ));
  FDCE \r_TX_Byte_reg[1] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[1]),
        .Q(\r_TX_Byte_reg_n_0_[1] ));
  FDCE \r_TX_Byte_reg[2] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[2]),
        .Q(\r_TX_Byte_reg_n_0_[2] ));
  FDCE \r_TX_Byte_reg[3] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[3]),
        .Q(\r_TX_Byte_reg_n_0_[3] ));
  FDCE \r_TX_Byte_reg[4] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[4]),
        .Q(\r_TX_Byte_reg_n_0_[4] ));
  FDCE \r_TX_Byte_reg[5] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[5]),
        .Q(\r_TX_Byte_reg_n_0_[5] ));
  FDCE \r_TX_Byte_reg[6] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[6]),
        .Q(\r_TX_Byte_reg_n_0_[6] ));
  FDCE \r_TX_Byte_reg[7] 
       (.C(i_Clk),
        .CE(i_TX_DV),
        .CLR(o_RX_DV_i_2_n_0),
        .D(i_TX_Byte[7]),
        .Q(p_0_in_0));
  FDRE \r_Temp_RX_Byte_reg[0] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(i_SPI_MOSI),
        .Q(p_0_in[1]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[1] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[1]),
        .Q(p_0_in[2]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[2] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[2]),
        .Q(p_0_in[3]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[3] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[3]),
        .Q(p_0_in[4]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[4] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[4]),
        .Q(p_0_in[5]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[5] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[5]),
        .Q(p_0_in[6]),
        .R(1'b0));
  FDRE \r_Temp_RX_Byte_reg[6] 
       (.C(i_SPI_Clk),
        .CE(o_SPI_MISO_INST_0_i_1_n_0),
        .D(p_0_in[6]),
        .Q(p_0_in[7]),
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
