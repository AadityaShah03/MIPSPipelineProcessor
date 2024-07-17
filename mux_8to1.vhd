library ieee;
  use ieee.std_logic_1164.all;

entity mux_8to1 is
  port (
    sel0 : in    std_logic;
    sel1 : in    std_logic;
    sel2 : in    std_logic;
    in0  : in    std_logic;
    in1  : in    std_logic;
    in2  : in    std_logic;
    in3  : in    std_logic;
    in4  : in    std_logic;
    in5  : in    std_logic;
    in6  : in    std_logic;
    in7  : in    std_logic;
    y    : out   std_logic
  );
end entity mux_8to1;

architecture struct of mux_8to1 is

  signal sel0not : std_logic;
  signal sel1not : std_logic;
  signal sel2not : std_logic;
  signal and0    : std_logic;
  signal and1    : std_logic;
  signal and2    : std_logic;
  signal and3    : std_logic;
  signal and4    : std_logic;
  signal and5    : std_logic;
  signal and6    : std_logic;
  signal and7    : std_logic;

begin

  sel0not <= not sel0;
  sel1not <= not sel1;
  sel2not <= not sel2;

  and7 <= in7 and (sel0 and sel1 and sel2);
  and6 <= in6 and (sel0not and sel1 and sel2);
  and5 <= in5 and (sel0 and sel1not and sel2);
  and4 <= in4 and (sel1not and sel0not and sel2);
  and3 <= in3 and (sel0 and sel1 and sel2not);
  and2 <= in2 and (sel0not and sel1 and sel2not);
  and1 <= in1 and (sel0 and sel1not and sel2not);
  and0 <= in0 and (sel1not and sel0not and sel2not);

  y <= and0 or and1 or and2 or and3 or and4 or and5 or and6 or and7;

end architecture struct;
