library ieee;
  use ieee.std_logic_1164.all;

entity mux_1to2 is
  port (
    sel0 : in    std_logic;
    in0  : in    std_logic;
    in1  : in    std_logic;
    y    : out   std_logic
  );
end entity mux_1to2;

architecture struct of mux_1to2 is

  signal and0, and1 : std_logic;

begin

  and0 <= (not sel0) and in0;
  and1 <= sel0 and in1;
  y    <= and0 or and1;

end architecture struct;
