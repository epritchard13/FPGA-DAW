-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Sat May 20 10:44:23 2023
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
    valid : in STD_LOGIC;
    rst : in STD_LOGIC;
    clk : in STD_LOGIC;
    spi_data : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_spi_link_sm_0_0_spi_link_sm : entity is "spi_link_sm";
end system_spi_link_sm_0_0_spi_link_sm;

architecture STRUCTURE of system_spi_link_sm_0_0_spi_link_sm is
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_reg_n_0_[1]\ : STD_LOGIC;
  signal ctr0 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \ctr0[15]_i_1_n_0\ : STD_LOGIC;
  signal \ctr0[15]_i_2_n_0\ : STD_LOGIC;
  signal \ctr0[15]_i_4_n_0\ : STD_LOGIC;
  signal \ctr0_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \ctr0_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \ctr0_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \ctr0_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \ctr0_reg[15]_i_5_n_2\ : STD_LOGIC;
  signal \ctr0_reg[15]_i_5_n_3\ : STD_LOGIC;
  signal \ctr0_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \ctr0_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \ctr0_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \ctr0_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \ctr0_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \ctr0_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \ctr0_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \ctr0_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[0]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[10]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[11]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[12]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[13]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[14]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[15]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[1]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[2]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[3]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[4]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[5]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[6]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[7]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[8]\ : STD_LOGIC;
  signal \ctr0_reg_n_0_[9]\ : STD_LOGIC;
  signal \dac_state[7]_i_1_n_0\ : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal header : STD_LOGIC;
  signal \header[0][7]_i_1_n_0\ : STD_LOGIC;
  signal \header[0][7]_i_2_n_0\ : STD_LOGIC;
  signal \header[0][7]_i_3_n_0\ : STD_LOGIC;
  signal \header[0][7]_i_4_n_0\ : STD_LOGIC;
  signal \header[0][7]_i_5_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \state1_carry__0_n_2\ : STD_LOGIC;
  signal \state1_carry__0_n_3\ : STD_LOGIC;
  signal \state1_carry_i_1__0_n_0\ : STD_LOGIC;
  signal state1_carry_i_1_n_0 : STD_LOGIC;
  signal \state1_carry_i_2__0_n_0\ : STD_LOGIC;
  signal state1_carry_i_2_n_0 : STD_LOGIC;
  signal state1_carry_i_3_n_0 : STD_LOGIC;
  signal state1_carry_i_4_n_0 : STD_LOGIC;
  signal state1_carry_n_0 : STD_LOGIC;
  signal state1_carry_n_1 : STD_LOGIC;
  signal state1_carry_n_2 : STD_LOGIC;
  signal state1_carry_n_3 : STD_LOGIC;
  signal \state__0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_ctr0_reg[15]_i_5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_ctr0_reg[15]_i_5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_state1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_state1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_state1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_2\ : label is "soft_lutpair7";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "iSTATE:10,iSTATE0:01,iSTATE1:00,iSTATE2:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "iSTATE:10,iSTATE0:01,iSTATE1:00,iSTATE2:11";
  attribute SOFT_HLUTNM of \ctr0[0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \ctr0[10]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \ctr0[11]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \ctr0[12]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \ctr0[13]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \ctr0[14]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \ctr0[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ctr0[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ctr0[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \ctr0[4]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \ctr0[5]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \ctr0[6]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \ctr0[7]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \ctr0[8]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \ctr0[9]_i_1\ : label is "soft_lutpair4";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \ctr0_reg[12]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \ctr0_reg[15]_i_5\ : label is 35;
  attribute ADDER_THRESHOLD of \ctr0_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \ctr0_reg[8]_i_2\ : label is 35;
begin
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAEAEFFAEAEAE0C"
    )
        port map (
      I0 => \FSM_sequential_state[0]_i_2_n_0\,
      I1 => valid,
      I2 => \FSM_sequential_state[1]_i_2_n_0\,
      I3 => rst,
      I4 => \FSM_sequential_state[1]_i_3_n_0\,
      I5 => \state__0\(0),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => spi_data(2),
      I1 => spi_data(3),
      I2 => spi_data(1),
      I3 => spi_data(0),
      I4 => \state__0\(0),
      I5 => \ctr0[15]_i_4_n_0\,
      O => \FSM_sequential_state[0]_i_2_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAEAEFFAEAEAE0C"
    )
        port map (
      I0 => \ctr0[15]_i_1_n_0\,
      I1 => valid,
      I2 => \FSM_sequential_state[1]_i_2_n_0\,
      I3 => rst,
      I4 => \FSM_sequential_state[1]_i_3_n_0\,
      I5 => \FSM_sequential_state_reg_n_0_[1]\,
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \header[0][7]_i_2_n_0\,
      I1 => \ctr0_reg_n_0_[0]\,
      O => \FSM_sequential_state[1]_i_2_n_0\
    );
\FSM_sequential_state[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF80A0"
    )
        port map (
      I0 => valid,
      I1 => \state1_carry__0_n_2\,
      I2 => \state__0\(0),
      I3 => \FSM_sequential_state_reg_n_0_[1]\,
      I4 => \FSM_sequential_state[1]_i_4_n_0\,
      O => \FSM_sequential_state[1]_i_3_n_0\
    );
\FSM_sequential_state[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800200"
    )
        port map (
      I0 => \ctr0[15]_i_4_n_0\,
      I1 => spi_data(1),
      I2 => spi_data(0),
      I3 => spi_data(3),
      I4 => spi_data(2),
      O => \FSM_sequential_state[1]_i_4_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => \state__0\(0),
      R => '0'
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => \FSM_sequential_state_reg_n_0_[1]\,
      R => '0'
    );
\ctr0[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \ctr0_reg_n_0_[0]\,
      O => ctr0(0)
    );
\ctr0[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(10),
      O => ctr0(10)
    );
\ctr0[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(11),
      O => ctr0(11)
    );
\ctr0[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(12),
      O => ctr0(12)
    );
\ctr0[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(13),
      O => ctr0(13)
    );
\ctr0[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(14),
      O => ctr0(14)
    );
\ctr0[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => spi_data(3),
      I1 => spi_data(2),
      I2 => spi_data(1),
      I3 => spi_data(0),
      I4 => \state__0\(0),
      I5 => \ctr0[15]_i_4_n_0\,
      O => \ctr0[15]_i_1_n_0\
    );
\ctr0[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => valid,
      I1 => \FSM_sequential_state_reg_n_0_[1]\,
      O => \ctr0[15]_i_2_n_0\
    );
\ctr0[15]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(15),
      O => ctr0(15)
    );
\ctr0[15]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000001000000000"
    )
        port map (
      I0 => spi_data(4),
      I1 => spi_data(5),
      I2 => spi_data(7),
      I3 => spi_data(6),
      I4 => \FSM_sequential_state_reg_n_0_[1]\,
      I5 => valid,
      O => \ctr0[15]_i_4_n_0\
    );
\ctr0[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(1),
      O => ctr0(1)
    );
\ctr0[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(2),
      O => ctr0(2)
    );
\ctr0[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(3),
      O => ctr0(3)
    );
\ctr0[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(4),
      O => ctr0(4)
    );
\ctr0[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(5),
      O => ctr0(5)
    );
\ctr0[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(6),
      O => ctr0(6)
    );
\ctr0[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(7),
      O => ctr0(7)
    );
\ctr0[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(8),
      O => ctr0(8)
    );
\ctr0[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_sequential_state[1]_i_2_n_0\,
      I1 => data0(9),
      O => ctr0(9)
    );
\ctr0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(0),
      Q => \ctr0_reg_n_0_[0]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(10),
      Q => \ctr0_reg_n_0_[10]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(11),
      Q => \ctr0_reg_n_0_[11]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(12),
      Q => \ctr0_reg_n_0_[12]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \ctr0_reg[8]_i_2_n_0\,
      CO(3) => \ctr0_reg[12]_i_2_n_0\,
      CO(2) => \ctr0_reg[12]_i_2_n_1\,
      CO(1) => \ctr0_reg[12]_i_2_n_2\,
      CO(0) => \ctr0_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3) => \ctr0_reg_n_0_[12]\,
      S(2) => \ctr0_reg_n_0_[11]\,
      S(1) => \ctr0_reg_n_0_[10]\,
      S(0) => \ctr0_reg_n_0_[9]\
    );
\ctr0_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(13),
      Q => \ctr0_reg_n_0_[13]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(14),
      Q => \ctr0_reg_n_0_[14]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(15),
      Q => \ctr0_reg_n_0_[15]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[15]_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \ctr0_reg[12]_i_2_n_0\,
      CO(3 downto 2) => \NLW_ctr0_reg[15]_i_5_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \ctr0_reg[15]_i_5_n_2\,
      CO(0) => \ctr0_reg[15]_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_ctr0_reg[15]_i_5_O_UNCONNECTED\(3),
      O(2 downto 0) => data0(15 downto 13),
      S(3) => '0',
      S(2) => \ctr0_reg_n_0_[15]\,
      S(1) => \ctr0_reg_n_0_[14]\,
      S(0) => \ctr0_reg_n_0_[13]\
    );
\ctr0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(1),
      Q => \ctr0_reg_n_0_[1]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(2),
      Q => \ctr0_reg_n_0_[2]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(3),
      Q => \ctr0_reg_n_0_[3]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(4),
      Q => \ctr0_reg_n_0_[4]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \ctr0_reg[4]_i_2_n_0\,
      CO(2) => \ctr0_reg[4]_i_2_n_1\,
      CO(1) => \ctr0_reg[4]_i_2_n_2\,
      CO(0) => \ctr0_reg[4]_i_2_n_3\,
      CYINIT => \ctr0_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3) => \ctr0_reg_n_0_[4]\,
      S(2) => \ctr0_reg_n_0_[3]\,
      S(1) => \ctr0_reg_n_0_[2]\,
      S(0) => \ctr0_reg_n_0_[1]\
    );
\ctr0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(5),
      Q => \ctr0_reg_n_0_[5]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(6),
      Q => \ctr0_reg_n_0_[6]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(7),
      Q => \ctr0_reg_n_0_[7]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(8),
      Q => \ctr0_reg_n_0_[8]\,
      R => \ctr0[15]_i_1_n_0\
    );
\ctr0_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \ctr0_reg[4]_i_2_n_0\,
      CO(3) => \ctr0_reg[8]_i_2_n_0\,
      CO(2) => \ctr0_reg[8]_i_2_n_1\,
      CO(1) => \ctr0_reg[8]_i_2_n_2\,
      CO(0) => \ctr0_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3) => \ctr0_reg_n_0_[8]\,
      S(2) => \ctr0_reg_n_0_[7]\,
      S(1) => \ctr0_reg_n_0_[6]\,
      S(0) => \ctr0_reg_n_0_[5]\
    );
\ctr0_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \ctr0[15]_i_2_n_0\,
      D => ctr0(9),
      Q => \ctr0_reg_n_0_[9]\,
      R => \ctr0[15]_i_1_n_0\
    );
\dac_state[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \FSM_sequential_state_reg_n_0_[1]\,
      I1 => valid,
      I2 => \state__0\(0),
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
\header[0][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \ctr0_reg_n_0_[0]\,
      I1 => valid,
      I2 => \header[0][7]_i_2_n_0\,
      O => \header[0][7]_i_1_n_0\
    );
\header[0][7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \header[0][7]_i_3_n_0\,
      I1 => \ctr0_reg_n_0_[3]\,
      I2 => \ctr0_reg_n_0_[4]\,
      I3 => \ctr0_reg_n_0_[5]\,
      I4 => \header[0][7]_i_4_n_0\,
      I5 => \header[0][7]_i_5_n_0\,
      O => \header[0][7]_i_2_n_0\
    );
\header[0][7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \ctr0_reg_n_0_[9]\,
      I1 => \ctr0_reg_n_0_[10]\,
      I2 => \ctr0_reg_n_0_[11]\,
      I3 => \ctr0_reg_n_0_[12]\,
      I4 => \ctr0_reg_n_0_[13]\,
      I5 => \ctr0_reg_n_0_[14]\,
      O => \header[0][7]_i_3_n_0\
    );
\header[0][7]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \ctr0_reg_n_0_[8]\,
      I1 => \ctr0_reg_n_0_[7]\,
      I2 => \ctr0_reg_n_0_[6]\,
      O => \header[0][7]_i_4_n_0\
    );
\header[0][7]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFEFF"
    )
        port map (
      I0 => \ctr0_reg_n_0_[15]\,
      I1 => \ctr0_reg_n_0_[1]\,
      I2 => \ctr0_reg_n_0_[2]\,
      I3 => \FSM_sequential_state_reg_n_0_[1]\,
      I4 => \state__0\(0),
      O => \header[0][7]_i_5_n_0\
    );
\header[1][7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => valid,
      I1 => \FSM_sequential_state[1]_i_2_n_0\,
      O => header
    );
\header_reg[0][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(0),
      Q => p_0_in(8),
      R => '0'
    );
\header_reg[0][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(1),
      Q => p_0_in(9),
      R => '0'
    );
\header_reg[0][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(2),
      Q => p_0_in(10),
      R => '0'
    );
\header_reg[0][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(3),
      Q => p_0_in(11),
      R => '0'
    );
\header_reg[0][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(4),
      Q => p_0_in(12),
      R => '0'
    );
\header_reg[0][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(5),
      Q => p_0_in(13),
      R => '0'
    );
\header_reg[0][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(6),
      Q => p_0_in(14),
      R => '0'
    );
\header_reg[0][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \header[0][7]_i_1_n_0\,
      D => spi_data(7),
      Q => p_0_in(15),
      R => '0'
    );
\header_reg[1][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(0),
      Q => p_0_in(0),
      R => '0'
    );
\header_reg[1][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(1),
      Q => p_0_in(1),
      R => '0'
    );
\header_reg[1][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(2),
      Q => p_0_in(2),
      R => '0'
    );
\header_reg[1][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(3),
      Q => p_0_in(3),
      R => '0'
    );
\header_reg[1][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(4),
      Q => p_0_in(4),
      R => '0'
    );
\header_reg[1][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(5),
      Q => p_0_in(5),
      R => '0'
    );
\header_reg[1][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(6),
      Q => p_0_in(6),
      R => '0'
    );
\header_reg[1][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => header,
      D => spi_data(7),
      Q => p_0_in(7),
      R => '0'
    );
state1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => state1_carry_n_0,
      CO(2) => state1_carry_n_1,
      CO(1) => state1_carry_n_2,
      CO(0) => state1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_state1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => state1_carry_i_1_n_0,
      S(2) => \state1_carry_i_2__0_n_0\,
      S(1) => state1_carry_i_3_n_0,
      S(0) => state1_carry_i_4_n_0
    );
\state1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => state1_carry_n_0,
      CO(3 downto 2) => \NLW_state1_carry__0_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \state1_carry__0_n_2\,
      CO(0) => \state1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_state1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => B"00",
      S(1) => \state1_carry_i_1__0_n_0\,
      S(0) => state1_carry_i_2_n_0
    );
state1_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in(11),
      I1 => \ctr0_reg_n_0_[11]\,
      I2 => p_0_in(10),
      I3 => \ctr0_reg_n_0_[10]\,
      I4 => \ctr0_reg_n_0_[9]\,
      I5 => p_0_in(9),
      O => state1_carry_i_1_n_0
    );
\state1_carry_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => p_0_in(15),
      I1 => \ctr0_reg_n_0_[15]\,
      O => \state1_carry_i_1__0_n_0\
    );
state1_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in(14),
      I1 => \ctr0_reg_n_0_[14]\,
      I2 => p_0_in(13),
      I3 => \ctr0_reg_n_0_[13]\,
      I4 => \ctr0_reg_n_0_[12]\,
      I5 => p_0_in(12),
      O => state1_carry_i_2_n_0
    );
\state1_carry_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in(8),
      I1 => \ctr0_reg_n_0_[8]\,
      I2 => p_0_in(7),
      I3 => \ctr0_reg_n_0_[7]\,
      I4 => \ctr0_reg_n_0_[6]\,
      I5 => p_0_in(6),
      O => \state1_carry_i_2__0_n_0\
    );
state1_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in(5),
      I1 => \ctr0_reg_n_0_[5]\,
      I2 => p_0_in(4),
      I3 => \ctr0_reg_n_0_[4]\,
      I4 => \ctr0_reg_n_0_[3]\,
      I5 => p_0_in(3),
      O => state1_carry_i_3_n_0
    );
state1_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8400008421000021"
    )
        port map (
      I0 => p_0_in(2),
      I1 => \ctr0_reg_n_0_[1]\,
      I2 => \ctr0_reg_n_0_[2]\,
      I3 => \ctr0_reg_n_0_[0]\,
      I4 => p_0_in(0),
      I5 => p_0_in(1),
      O => state1_carry_i_4_n_0
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
