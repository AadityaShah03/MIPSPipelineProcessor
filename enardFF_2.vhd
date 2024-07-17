--------------------------------------------------------------------------------
-- Title         : Enabled Asynchronous Reset D Flip-Flop - 1st realization
-- Project       : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- File          : enARdFF_2.vhd
-- Author        : Rami Abielmona  <rabielmo@site.uottawa.ca>
-- Created       : 2003/05/17
-- Last modified : 2007/09/25
-------------------------------------------------------------------------------
-- Description : This file creates an enabled asynchronous reset D flip-flop
--     as defined in the VHDL Synthesis lecture.  The architecture is
--     done at the RTL abstraction level and the implementation is done
--     in structural VHDL.
-------------------------------------------------------------------------------
-- Modification history :
-- 2003.05.17   R. Abielmona    Creation
-- 2004.09.22   R. Abielmona    Ported for CEG 3550
-- 2007.09.25   R. Abielmona    Modified copyright notice
-------------------------------------------------------------------------------
-- This file is copyright material of Rami Abielmona, Ph.D., P.Eng., Chief Research
-- Scientist at Larus Technologies.  Permission to make digital or hard copies of part
-- or all of this work for personal or classroom use is granted without fee
-- provided that copies are not made or distributed for profit or commercial
-- advantage and that copies bear this notice and the full citation of this work.
-- Prior permission is required to copy, republish, redistribute or post this work.
-- This notice is adapted from the ACM copyright notice.
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

entity enardff_2 is
  port (
    i_resetbar : in    std_logic;
    i_d        : in    std_logic;
    i_enable   : in    std_logic;
    i_clock    : in    std_logic;
    o_q        : out   std_logic;
    o_qbar     : out   std_logic
  );
end entity enardff_2;

architecture rtl of enardff_2 is

  signal int_q : std_logic;

begin

  onebitregister : process (i_resetbar, i_clock) is
  begin

    if (i_resetbar = '0') then
      int_q <= '0';
    elsif (i_clock'EVENT and i_clock = '1') then
      if (i_enable = '1') then
        int_q <= i_d;
      end if;
    end if;

  end process onebitregister;

  --  Output Driver

  o_q    <= int_q;
  o_qbar <= not(int_q);

end architecture rtl;
