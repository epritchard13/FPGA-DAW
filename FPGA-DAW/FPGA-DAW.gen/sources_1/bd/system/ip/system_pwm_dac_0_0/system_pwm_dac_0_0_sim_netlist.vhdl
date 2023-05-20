-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Fri May 19 20:29:02 2023
-- Host        : DESKTOP-MJRS0I7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/Ethan/Documents/Certain-Synthesizer-FPGA-DAW/FPGA-DAW/FPGA-DAW.gen/sources_1/bd/system/ip/system_pwm_dac_0_0/system_pwm_dac_0_0_sim_netlist.vhdl
-- Design      : system_pwm_dac_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_pwm_dac_0_0_pwm_dac is
  port (
    analog : out STD_LOGIC;
    clk : in STD_LOGIC;
    val : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_pwm_dac_0_0_pwm_dac : entity is "pwm_dac";
end system_pwm_dac_0_0_pwm_dac;

architecture STRUCTURE of system_pwm_dac_0_0_pwm_dac is
  signal analog_carry_i_1_n_0 : STD_LOGIC;
  signal analog_carry_i_2_n_0 : STD_LOGIC;
  signal analog_carry_i_3_n_0 : STD_LOGIC;
  signal analog_carry_i_4_n_0 : STD_LOGIC;
  signal analog_carry_i_5_n_0 : STD_LOGIC;
  signal analog_carry_i_6_n_0 : STD_LOGIC;
  signal analog_carry_i_7_n_0 : STD_LOGIC;
  signal analog_carry_i_8_n_0 : STD_LOGIC;
  signal analog_carry_n_1 : STD_LOGIC;
  signal analog_carry_n_2 : STD_LOGIC;
  signal analog_carry_n_3 : STD_LOGIC;
  signal \ctr[0]_i_1_n_0\ : STD_LOGIC;
  signal \ctr[7]_i_2_n_0\ : STD_LOGIC;
  signal ctr_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal NLW_analog_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of analog_carry : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ctr[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \ctr[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \ctr[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ctr[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ctr[6]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \ctr[7]_i_1\ : label is "soft_lutpair1";
begin
analog_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => analog,
      CO(2) => analog_carry_n_1,
      CO(1) => analog_carry_n_2,
      CO(0) => analog_carry_n_3,
      CYINIT => '0',
      DI(3) => analog_carry_i_1_n_0,
      DI(2) => analog_carry_i_2_n_0,
      DI(1) => analog_carry_i_3_n_0,
      DI(0) => analog_carry_i_4_n_0,
      O(3 downto 0) => NLW_analog_carry_O_UNCONNECTED(3 downto 0),
      S(3) => analog_carry_i_5_n_0,
      S(2) => analog_carry_i_6_n_0,
      S(1) => analog_carry_i_7_n_0,
      S(0) => analog_carry_i_8_n_0
    );
analog_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => val(6),
      I1 => ctr_reg(6),
      I2 => ctr_reg(7),
      I3 => val(7),
      O => analog_carry_i_1_n_0
    );
analog_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => val(4),
      I1 => ctr_reg(4),
      I2 => ctr_reg(5),
      I3 => val(5),
      O => analog_carry_i_2_n_0
    );
analog_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => val(2),
      I1 => ctr_reg(2),
      I2 => ctr_reg(3),
      I3 => val(3),
      O => analog_carry_i_3_n_0
    );
analog_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => val(0),
      I1 => ctr_reg(0),
      I2 => ctr_reg(1),
      I3 => val(1),
      O => analog_carry_i_4_n_0
    );
analog_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => val(6),
      I1 => ctr_reg(6),
      I2 => val(7),
      I3 => ctr_reg(7),
      O => analog_carry_i_5_n_0
    );
analog_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => val(4),
      I1 => ctr_reg(4),
      I2 => val(5),
      I3 => ctr_reg(5),
      O => analog_carry_i_6_n_0
    );
analog_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => val(2),
      I1 => ctr_reg(2),
      I2 => val(3),
      I3 => ctr_reg(3),
      O => analog_carry_i_7_n_0
    );
analog_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => val(0),
      I1 => ctr_reg(0),
      I2 => val(1),
      I3 => ctr_reg(1),
      O => analog_carry_i_8_n_0
    );
\ctr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => ctr_reg(0),
      O => \ctr[0]_i_1_n_0\
    );
\ctr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => ctr_reg(0),
      I1 => ctr_reg(1),
      O => p_0_in(1)
    );
\ctr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => ctr_reg(0),
      I1 => ctr_reg(1),
      I2 => ctr_reg(2),
      O => p_0_in(2)
    );
\ctr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => ctr_reg(1),
      I1 => ctr_reg(0),
      I2 => ctr_reg(2),
      I3 => ctr_reg(3),
      O => p_0_in(3)
    );
\ctr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => ctr_reg(2),
      I1 => ctr_reg(0),
      I2 => ctr_reg(1),
      I3 => ctr_reg(3),
      I4 => ctr_reg(4),
      O => p_0_in(4)
    );
\ctr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => ctr_reg(3),
      I1 => ctr_reg(1),
      I2 => ctr_reg(0),
      I3 => ctr_reg(2),
      I4 => ctr_reg(4),
      I5 => ctr_reg(5),
      O => p_0_in(5)
    );
\ctr[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \ctr[7]_i_2_n_0\,
      I1 => ctr_reg(6),
      O => p_0_in(6)
    );
\ctr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \ctr[7]_i_2_n_0\,
      I1 => ctr_reg(6),
      I2 => ctr_reg(7),
      O => p_0_in(7)
    );
\ctr[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => ctr_reg(5),
      I1 => ctr_reg(3),
      I2 => ctr_reg(1),
      I3 => ctr_reg(0),
      I4 => ctr_reg(2),
      I5 => ctr_reg(4),
      O => \ctr[7]_i_2_n_0\
    );
\ctr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ctr[0]_i_1_n_0\,
      Q => ctr_reg(0),
      R => '0'
    );
\ctr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(1),
      Q => ctr_reg(1),
      R => '0'
    );
\ctr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(2),
      Q => ctr_reg(2),
      R => '0'
    );
\ctr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(3),
      Q => ctr_reg(3),
      R => '0'
    );
\ctr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(4),
      Q => ctr_reg(4),
      R => '0'
    );
\ctr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(5),
      Q => ctr_reg(5),
      R => '0'
    );
\ctr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(6),
      Q => ctr_reg(6),
      R => '0'
    );
\ctr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(7),
      Q => ctr_reg(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_pwm_dac_0_0 is
  port (
    clk : in STD_LOGIC;
    val : in STD_LOGIC_VECTOR ( 7 downto 0 );
    analog : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_pwm_dac_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_pwm_dac_0_0 : entity is "system_pwm_dac_0_0,pwm_dac,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_pwm_dac_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_pwm_dac_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_pwm_dac_0_0 : entity is "pwm_dac,Vivado 2022.2";
end system_pwm_dac_0_0;

architecture STRUCTURE of system_pwm_dac_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
inst: entity work.system_pwm_dac_0_0_pwm_dac
     port map (
      analog => analog,
      clk => clk,
      val(7 downto 0) => val(7 downto 0)
    );
end STRUCTURE;
