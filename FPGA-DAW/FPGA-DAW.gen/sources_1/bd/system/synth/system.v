//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Sat May 20 10:43:13 2023
//Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
//Command     : generate_target system.bd
//Design      : system
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "system,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=system,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,da_clkrst_cnt=3,da_ps7_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "system.hwdef" *) 
module system
   (A_OUT,
    MISO,
    MOSI,
    SCLK,
    SS,
    led,
    rgb,
    sysclk);
  output A_OUT;
  output MISO;
  input MOSI;
  input SCLK;
  input SS;
  output [3:0]led;
  output [2:0]rgb;
  input sysclk;

  wire [0:0]HIGH_dout;
  wire [0:0]LOW_dout;
  wire MOSI_1;
  wire SCLK_1;
  wire [7:0]SPI_Slave_0_o_RX_Byte;
  wire SPI_Slave_0_o_RX_DV;
  wire SPI_Slave_1_o_SPI_MISO;
  wire SS_1;
  wire processing_system7_0_FCLK_CLK0;
  wire pwm_dac_0_analog;
  wire [7:0]spi_link_sm_0_dac_state;
  wire [3:0]top_0_led;
  wire [2:0]top_0_rgb;

  assign A_OUT = pwm_dac_0_analog;
  assign MISO = SPI_Slave_1_o_SPI_MISO;
  assign MOSI_1 = MOSI;
  assign SCLK_1 = SCLK;
  assign SS_1 = SS;
  assign led[3:0] = top_0_led;
  assign processing_system7_0_FCLK_CLK0 = sysclk;
  assign rgb[2:0] = top_0_rgb;
  system_xlconstant_0_0 HIGH
       (.dout(HIGH_dout));
  system_xlconstant_1_0 LOW
       (.dout(LOW_dout));
  system_SPI_Slave_1_0 SPI_Slave_1
       (.i_Clk(processing_system7_0_FCLK_CLK0),
        .i_Rst_L(HIGH_dout),
        .i_SPI_CS_n(SS_1),
        .i_SPI_Clk(SCLK_1),
        .i_SPI_MOSI(MOSI_1),
        .i_TX_Byte({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_TX_DV(LOW_dout),
        .o_RX_Byte(SPI_Slave_0_o_RX_Byte),
        .o_RX_DV(SPI_Slave_0_o_RX_DV),
        .o_SPI_MISO(SPI_Slave_1_o_SPI_MISO));
  system_pwm_dac_0_0 pwm_dac_0
       (.analog(pwm_dac_0_analog),
        .clk(processing_system7_0_FCLK_CLK0),
        .val(spi_link_sm_0_dac_state));
  system_spi_link_sm_0_0 spi_link_sm_0
       (.clk(processing_system7_0_FCLK_CLK0),
        .dac_state(spi_link_sm_0_dac_state),
        .rst(LOW_dout),
        .spi_data(SPI_Slave_0_o_RX_Byte),
        .valid(SPI_Slave_0_o_RX_DV));
  system_top_0_0 top_0
       (.led(top_0_led),
        .rgb(top_0_rgb),
        .spi_data(SPI_Slave_0_o_RX_Byte),
        .sysclk(processing_system7_0_FCLK_CLK0),
        .valid(SPI_Slave_0_o_RX_DV));
endmodule
