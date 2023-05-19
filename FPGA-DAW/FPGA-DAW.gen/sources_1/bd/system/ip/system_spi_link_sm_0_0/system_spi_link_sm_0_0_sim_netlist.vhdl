-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Thu May 18 23:26:56 2023
-- Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_spi_link_sm_0_0/system_spi_link_sm_0_0_sim_netlist.vhdl
-- Design      : system_spi_link_sm_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_spi_link_sm_0_0_spi_link_sm is
  port (
    dac_state : out STD_LOGIC_VECTOR ( 7 downto 0 );
    spi_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    valid : in STD_LOGIC;
    rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_spi_link_sm_0_0_spi_link_sm : entity is "spi_link_sm";
end system_spi_link_sm_0_0_spi_link_sm;

architecture STRUCTURE of system_spi_link_sm_0_0_spi_link_sm is
  signal FSM_sequential_state_i_1_n_0 : STD_LOGIC;
  signal FSM_sequential_state_i_2_n_0 : STD_LOGIC;
  signal FSM_sequential_state_reg_n_0 : STD_LOGIC;
  signal \dac_state[7]_i_1_n_0\ : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of FSM_sequential_state_reg : label is "iSTATE:0,iSTATE0:1";
begin
FSM_sequential_state_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000400000004FF00"
    )
        port map (
      I0 => spi_data(5),
      I1 => FSM_sequential_state_i_2_n_0,
      I2 => spi_data(4),
      I3 => FSM_sequential_state_reg_n_0,
      I4 => valid,
      I5 => rst,
      O => FSM_sequential_state_i_1_n_0
    );
FSM_sequential_state_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
        port map (
      I0 => spi_data(3),
      I1 => spi_data(7),
      I2 => spi_data(1),
      I3 => spi_data(0),
      I4 => spi_data(2),
      I5 => spi_data(6),
      O => FSM_sequential_state_i_2_n_0
    );
FSM_sequential_state_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => FSM_sequential_state_i_1_n_0,
      Q => FSM_sequential_state_reg_n_0,
      R => '0'
    );
\dac_state[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => FSM_sequential_state_reg_n_0,
      I1 => valid,
      O => \dac_state[7]_i_1_n_0\
    );
\dac_state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(0),
      Q => dac_state(0),
      R => '0'
    );
\dac_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(1),
      Q => dac_state(1),
      R => '0'
    );
\dac_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(2),
      Q => dac_state(2),
      R => '0'
    );
\dac_state_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(3),
      Q => dac_state(3),
      R => '0'
    );
\dac_state_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(4),
      Q => dac_state(4),
      R => '0'
    );
\dac_state_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(5),
      Q => dac_state(5),
      R => '0'
    );
\dac_state_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(6),
      Q => dac_state(6),
      R => '0'
    );
\dac_state_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dac_state[7]_i_1_n_0\,
      D => spi_data(7),
      Q => dac_state(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_spi_link_sm_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    spi_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    valid : in STD_LOGIC;
    dac_state : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_spi_link_sm_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_spi_link_sm_0_0 : entity is "system_spi_link_sm_0_0,spi_link_sm,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_spi_link_sm_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_spi_link_sm_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_spi_link_sm_0_0 : entity is "spi_link_sm,Vivado 2022.2";
end system_spi_link_sm_0_0;

architecture STRUCTURE of system_spi_link_sm_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.system_spi_link_sm_0_0_spi_link_sm
     port map (
      clk => clk,
      dac_state(7 downto 0) => dac_state(7 downto 0),
      rst => rst,
      spi_data(7 downto 0) => spi_data(7 downto 0),
      valid => valid
    );
end STRUCTURE;
