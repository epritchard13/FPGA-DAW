-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Fri May 19 20:29:11 2023
-- Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_top_0_0/system_top_0_0_sim_netlist.vhdl
-- Design      : system_top_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_top_0_0_top is
  port (
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    valid : in STD_LOGIC;
    spi_data : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sysclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_top_0_0_top : entity is "top";
end system_top_0_0_top;

architecture STRUCTURE of system_top_0_0_top is
begin
\spi_byte_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => sysclk,
      CE => valid,
      D => spi_data(0),
      Q => led(0),
      R => '0'
    );
\spi_byte_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => sysclk,
      CE => valid,
      D => spi_data(1),
      Q => led(1),
      R => '0'
    );
\spi_byte_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => sysclk,
      CE => valid,
      D => spi_data(2),
      Q => led(2),
      R => '0'
    );
\spi_byte_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => sysclk,
      CE => valid,
      D => spi_data(3),
      Q => led(3),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_top_0_0 is
  port (
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sysclk : in STD_LOGIC;
    spi_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    valid : in STD_LOGIC;
    rgb : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_top_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_top_0_0 : entity is "system_top_0_0,top,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_top_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_top_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_top_0_0 : entity is "top,Vivado 2022.2";
end system_top_0_0;

architecture STRUCTURE of system_top_0_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  rgb(2) <= \<const0>\;
  rgb(1) <= \<const0>\;
  rgb(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.system_top_0_0_top
     port map (
      led(3 downto 0) => led(3 downto 0),
      spi_data(3 downto 0) => spi_data(3 downto 0),
      sysclk => sysclk,
      valid => valid
    );
end STRUCTURE;
