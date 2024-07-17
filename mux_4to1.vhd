library ieee;
  use ieee.std_logic_1164.all;

entity mux_4to1 is
  port (
    sel0 : in    std_logic;
    sel1 : in    std_logic;
    in0  : in    std_logic;
    in1  : in    std_logic;
    in2  : in    std_logic;
    in3  : in    std_logic;
    y    : out   std_logic
  );
end entity mux_4to1;

architecture struct of mux_4to1 is

  signal sel0not : std_logic;
  signal sel1not : std_logic;
  signal and0    : std_logic;
  signal and1    : std_logic;
  signal and2    : std_logic;
  signal and3    : std_logic;

begin

  sel0not <= not sel0;
  sel1not <= not sel1;
  and3    <= in3 and (sel0 and sel1);
  and2    <= in2 and (sel0not and sel1);
  and1    <= in1 and (sel0 and sel1not);
  and0    <= in0 and (sel1not and sel0not);

  y <= and0 or and1 or and2 or and3;

end architecture struct;
