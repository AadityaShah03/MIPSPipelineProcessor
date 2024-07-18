library ieee;
  use ieee.std_logic_1164.all;

entity comparator5bit is
  port (
    a : in    std_logic_vector(4 DOWNTO 0);
	 b : in    std_logic_vector(4 DOWNTO 0);

    y    : out   std_logic
  );
end entity comparator5bit;

architecture struct of comparator5bit is

  signal int : std_logic_vector(4 DOWNTO 0);

begin

  int <= a xnor b;

  y <= int(0) and int(1) and int(2) and int(3) and int(4);
end architecture struct;
