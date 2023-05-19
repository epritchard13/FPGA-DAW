-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Thu May 18 19:28:35 2023
-- Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_SPI_Slave_0_0/system_SPI_Slave_0_0_sim_netlist.vhdl
-- Design      : system_SPI_Slave_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_SPI_Slave_0_0_SPI_Slave is
  port (
    o_SPI_MISO : out STD_LOGIC;
    o_RX_DV : out STD_LOGIC;
    o_RX_Byte : out STD_LOGIC_VECTOR ( 7 downto 0 );
    i_SPI_Clk : in STD_LOGIC;
    i_SPI_CS_n : in STD_LOGIC;
    i_Clk : in STD_LOGIC;
    i_SPI_MOSI : in STD_LOGIC;
    i_TX_DV : in STD_LOGIC;
    i_TX_Byte : in STD_LOGIC_VECTOR ( 7 downto 0 );
    i_Rst_L : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_SPI_Slave_0_0_SPI_Slave : entity is "SPI_Slave";
end system_SPI_Slave_0_0_SPI_Slave;

architecture STRUCTURE of system_SPI_Slave_0_0_SPI_Slave is
  signal o_RX_DV_i_1_n_0 : STD_LOGIC;
  signal o_RX_DV_i_2_n_0 : STD_LOGIC;
  signal o_SPI_MISO_INST_0_i_1_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal p_0_in_0 : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal p_2_in : STD_LOGIC;
  signal r2_RX_Done : STD_LOGIC;
  signal r3_RX_Done : STD_LOGIC;
  signal r_Preload_MISO : STD_LOGIC;
  signal r_RX_Bit_Count : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r_RX_Byte : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \r_RX_Byte[7]_i_1_n_0\ : STD_LOGIC;
  signal r_RX_Done_i_1_n_0 : STD_LOGIC;
  signal r_RX_Done_reg_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_C_i_2_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_C_i_3_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_reg_C_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_reg_LDC_i_1_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_reg_LDC_i_2_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_reg_LDC_n_0 : STD_LOGIC;
  signal r_SPI_MISO_Bit_reg_P_n_0 : STD_LOGIC;
  signal r_TX_Bit_Count : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r_TX_Bit_Count0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \r_TX_Bit_Count[1]_i_1_n_0\ : STD_LOGIC;
  signal \r_TX_Bit_Count[2]_i_1_n_0\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[0]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[1]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[2]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[3]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[4]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[5]\ : STD_LOGIC;
  signal \r_TX_Byte_reg_n_0_[6]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \r_RX_Bit_Count[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \r_RX_Bit_Count[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \r_RX_Bit_Count[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of r_RX_Done_i_1 : label is "soft_lutpair0";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of r_SPI_MISO_Bit_reg_LDC : label is "LDC";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of r_SPI_MISO_Bit_reg_LDC : label is "VCC:GE";
  attribute SOFT_HLUTNM of \r_TX_Bit_Count[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \r_TX_Bit_Count[2]_i_1\ : label is "soft_lutpair1";
begin
\o_RX_Byte_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(0),
      Q => o_RX_Byte(0)
    );
\o_RX_Byte_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(1),
      Q => o_RX_Byte(1)
    );
\o_RX_Byte_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(2),
      Q => o_RX_Byte(2)
    );
\o_RX_Byte_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(3),
      Q => o_RX_Byte(3)
    );
\o_RX_Byte_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(4),
      Q => o_RX_Byte(4)
    );
\o_RX_Byte_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(5),
      Q => o_RX_Byte(5)
    );
\o_RX_Byte_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(6),
      Q => o_RX_Byte(6)
    );
\o_RX_Byte_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => o_RX_DV_i_1_n_0,
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Byte(7),
      Q => o_RX_Byte(7)
    );
o_RX_DV_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => r2_RX_Done,
      I1 => r3_RX_Done,
      O => o_RX_DV_i_1_n_0
    );
o_RX_DV_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => i_Rst_L,
      O => o_RX_DV_i_2_n_0
    );
o_RX_DV_reg: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => '1',
      CLR => o_RX_DV_i_2_n_0,
      D => o_RX_DV_i_1_n_0,
      Q => o_RX_DV
    );
o_SPI_MISO_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8BBB88800000000"
    )
        port map (
      I0 => p_0_in_0,
      I1 => r_Preload_MISO,
      I2 => r_SPI_MISO_Bit_reg_P_n_0,
      I3 => r_SPI_MISO_Bit_reg_LDC_n_0,
      I4 => r_SPI_MISO_Bit_reg_C_n_0,
      I5 => o_SPI_MISO_INST_0_i_1_n_0,
      O => o_SPI_MISO
    );
o_SPI_MISO_INST_0_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => i_SPI_CS_n,
      O => o_SPI_MISO_INST_0_i_1_n_0
    );
r2_RX_Done_reg: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => '1',
      CLR => o_RX_DV_i_2_n_0,
      D => r_RX_Done_reg_n_0,
      Q => r2_RX_Done
    );
r3_RX_Done_reg: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => '1',
      CLR => o_RX_DV_i_2_n_0,
      D => r2_RX_Done,
      Q => r3_RX_Done
    );
r_Preload_MISO_reg: unisim.vcomponents.FDPE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      D => '0',
      PRE => i_SPI_CS_n,
      Q => r_Preload_MISO
    );
\r_RX_Bit_Count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => r_RX_Bit_Count(0),
      O => \p_0_in__0\(0)
    );
\r_RX_Bit_Count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => r_RX_Bit_Count(0),
      I1 => r_RX_Bit_Count(1),
      O => \p_0_in__0\(1)
    );
\r_RX_Bit_Count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => r_RX_Bit_Count(0),
      I1 => r_RX_Bit_Count(1),
      I2 => r_RX_Bit_Count(2),
      O => \p_0_in__0\(2)
    );
\r_RX_Bit_Count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      CLR => i_SPI_CS_n,
      D => \p_0_in__0\(0),
      Q => r_RX_Bit_Count(0)
    );
\r_RX_Bit_Count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      CLR => i_SPI_CS_n,
      D => \p_0_in__0\(1),
      Q => r_RX_Bit_Count(1)
    );
\r_RX_Bit_Count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      CLR => i_SPI_CS_n,
      D => \p_0_in__0\(2),
      Q => r_RX_Bit_Count(2)
    );
\r_RX_Byte[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => r_RX_Bit_Count(0),
      I1 => r_RX_Bit_Count(2),
      I2 => r_RX_Bit_Count(1),
      I3 => i_SPI_CS_n,
      O => \r_RX_Byte[7]_i_1_n_0\
    );
\r_RX_Byte_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => i_SPI_MOSI,
      Q => r_RX_Byte(0),
      R => '0'
    );
\r_RX_Byte_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(1),
      Q => r_RX_Byte(1),
      R => '0'
    );
\r_RX_Byte_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(2),
      Q => r_RX_Byte(2),
      R => '0'
    );
\r_RX_Byte_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(3),
      Q => r_RX_Byte(3),
      R => '0'
    );
\r_RX_Byte_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(4),
      Q => r_RX_Byte(4),
      R => '0'
    );
\r_RX_Byte_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(5),
      Q => r_RX_Byte(5),
      R => '0'
    );
\r_RX_Byte_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(6),
      Q => r_RX_Byte(6),
      R => '0'
    );
\r_RX_Byte_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => \r_RX_Byte[7]_i_1_n_0\,
      D => p_0_in(7),
      Q => r_RX_Byte(7),
      R => '0'
    );
r_RX_Done_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD80"
    )
        port map (
      I0 => r_RX_Bit_Count(1),
      I1 => r_RX_Bit_Count(2),
      I2 => r_RX_Bit_Count(0),
      I3 => r_RX_Done_reg_n_0,
      O => r_RX_Done_i_1_n_0
    );
r_RX_Done_reg: unisim.vcomponents.FDCE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      CLR => i_SPI_CS_n,
      D => r_RX_Done_i_1_n_0,
      Q => r_RX_Done_reg_n_0
    );
r_SPI_MISO_Bit_C_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \r_TX_Byte_reg_n_0_[3]\,
      I1 => \r_TX_Byte_reg_n_0_[2]\,
      I2 => r_TX_Bit_Count(1),
      I3 => \r_TX_Byte_reg_n_0_[1]\,
      I4 => r_TX_Bit_Count(0),
      I5 => \r_TX_Byte_reg_n_0_[0]\,
      O => r_SPI_MISO_Bit_C_i_2_n_0
    );
r_SPI_MISO_Bit_C_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => p_0_in_0,
      I1 => \r_TX_Byte_reg_n_0_[6]\,
      I2 => r_TX_Bit_Count(1),
      I3 => \r_TX_Byte_reg_n_0_[5]\,
      I4 => r_TX_Bit_Count(0),
      I5 => \r_TX_Byte_reg_n_0_[4]\,
      O => r_SPI_MISO_Bit_C_i_3_n_0
    );
r_SPI_MISO_Bit_reg_C: unisim.vcomponents.FDCE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      CLR => r_SPI_MISO_Bit_reg_LDC_i_2_n_0,
      D => p_2_in,
      Q => r_SPI_MISO_Bit_reg_C_n_0
    );
r_SPI_MISO_Bit_reg_C_i_1: unisim.vcomponents.MUXF7
     port map (
      I0 => r_SPI_MISO_Bit_C_i_2_n_0,
      I1 => r_SPI_MISO_Bit_C_i_3_n_0,
      O => p_2_in,
      S => r_TX_Bit_Count(2)
    );
r_SPI_MISO_Bit_reg_LDC: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => r_SPI_MISO_Bit_reg_LDC_i_2_n_0,
      D => '1',
      G => r_SPI_MISO_Bit_reg_LDC_i_1_n_0,
      GE => '1',
      Q => r_SPI_MISO_Bit_reg_LDC_n_0
    );
r_SPI_MISO_Bit_reg_LDC_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => i_SPI_CS_n,
      I1 => p_0_in_0,
      O => r_SPI_MISO_Bit_reg_LDC_i_1_n_0
    );
r_SPI_MISO_Bit_reg_LDC_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_SPI_CS_n,
      I1 => p_0_in_0,
      O => r_SPI_MISO_Bit_reg_LDC_i_2_n_0
    );
r_SPI_MISO_Bit_reg_P: unisim.vcomponents.FDPE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      D => p_2_in,
      PRE => r_SPI_MISO_Bit_reg_LDC_i_1_n_0,
      Q => r_SPI_MISO_Bit_reg_P_n_0
    );
\r_TX_Bit_Count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => r_TX_Bit_Count(0),
      O => r_TX_Bit_Count0(0)
    );
\r_TX_Bit_Count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => r_TX_Bit_Count(0),
      I1 => r_TX_Bit_Count(1),
      O => \r_TX_Bit_Count[1]_i_1_n_0\
    );
\r_TX_Bit_Count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E1"
    )
        port map (
      I0 => r_TX_Bit_Count(1),
      I1 => r_TX_Bit_Count(0),
      I2 => r_TX_Bit_Count(2),
      O => \r_TX_Bit_Count[2]_i_1_n_0\
    );
\r_TX_Bit_Count_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      D => r_TX_Bit_Count0(0),
      PRE => i_SPI_CS_n,
      Q => r_TX_Bit_Count(0)
    );
\r_TX_Bit_Count_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      D => \r_TX_Bit_Count[1]_i_1_n_0\,
      PRE => i_SPI_CS_n,
      Q => r_TX_Bit_Count(1)
    );
\r_TX_Bit_Count_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => i_SPI_Clk,
      CE => '1',
      D => \r_TX_Bit_Count[2]_i_1_n_0\,
      PRE => i_SPI_CS_n,
      Q => r_TX_Bit_Count(2)
    );
\r_TX_Byte_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(0),
      Q => \r_TX_Byte_reg_n_0_[0]\
    );
\r_TX_Byte_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(1),
      Q => \r_TX_Byte_reg_n_0_[1]\
    );
\r_TX_Byte_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(2),
      Q => \r_TX_Byte_reg_n_0_[2]\
    );
\r_TX_Byte_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(3),
      Q => \r_TX_Byte_reg_n_0_[3]\
    );
\r_TX_Byte_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(4),
      Q => \r_TX_Byte_reg_n_0_[4]\
    );
\r_TX_Byte_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(5),
      Q => \r_TX_Byte_reg_n_0_[5]\
    );
\r_TX_Byte_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(6),
      Q => \r_TX_Byte_reg_n_0_[6]\
    );
\r_TX_Byte_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => i_Clk,
      CE => i_TX_DV,
      CLR => o_RX_DV_i_2_n_0,
      D => i_TX_Byte(7),
      Q => p_0_in_0
    );
\r_Temp_RX_Byte_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => i_SPI_MOSI,
      Q => p_0_in(1),
      R => '0'
    );
\r_Temp_RX_Byte_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(1),
      Q => p_0_in(2),
      R => '0'
    );
\r_Temp_RX_Byte_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(2),
      Q => p_0_in(3),
      R => '0'
    );
\r_Temp_RX_Byte_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(3),
      Q => p_0_in(4),
      R => '0'
    );
\r_Temp_RX_Byte_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(4),
      Q => p_0_in(5),
      R => '0'
    );
\r_Temp_RX_Byte_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(5),
      Q => p_0_in(6),
      R => '0'
    );
\r_Temp_RX_Byte_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => i_SPI_Clk,
      CE => o_SPI_MISO_INST_0_i_1_n_0,
      D => p_0_in(6),
      Q => p_0_in(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_SPI_Slave_0_0 is
  port (
    i_Rst_L : in STD_LOGIC;
    i_Clk : in STD_LOGIC;
    o_RX_DV : out STD_LOGIC;
    o_RX_Byte : out STD_LOGIC_VECTOR ( 7 downto 0 );
    i_TX_DV : in STD_LOGIC;
    i_TX_Byte : in STD_LOGIC_VECTOR ( 7 downto 0 );
    i_SPI_Clk : in STD_LOGIC;
    o_SPI_MISO : out STD_LOGIC;
    i_SPI_MOSI : in STD_LOGIC;
    i_SPI_CS_n : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_SPI_Slave_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_SPI_Slave_0_0 : entity is "system_SPI_Slave_0_0,SPI_Slave,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_SPI_Slave_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_SPI_Slave_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_SPI_Slave_0_0 : entity is "SPI_Slave,Vivado 2022.2";
end system_SPI_Slave_0_0;

architecture STRUCTURE of system_SPI_Slave_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of i_Clk : signal is "xilinx.com:signal:clock:1.0 i_Clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of i_Clk : signal is "XIL_INTERFACENAME i_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of i_SPI_Clk : signal is "xilinx.com:signal:clock:1.0 i_SPI_Clk CLK";
  attribute X_INTERFACE_PARAMETER of i_SPI_Clk : signal is "XIL_INTERFACENAME i_SPI_Clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
begin
inst: entity work.system_SPI_Slave_0_0_SPI_Slave
     port map (
      i_Clk => i_Clk,
      i_Rst_L => i_Rst_L,
      i_SPI_CS_n => i_SPI_CS_n,
      i_SPI_Clk => i_SPI_Clk,
      i_SPI_MOSI => i_SPI_MOSI,
      i_TX_Byte(7 downto 0) => i_TX_Byte(7 downto 0),
      i_TX_DV => i_TX_DV,
      o_RX_Byte(7 downto 0) => o_RX_Byte(7 downto 0),
      o_RX_DV => o_RX_DV,
      o_SPI_MISO => o_SPI_MISO
    );
end STRUCTURE;
