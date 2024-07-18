library ieee;
  use ieee.std_logic_1164.all;

entity comparator8bit is
  port (
    a : in    std_logic_vector(7 DOWNTO 0);
	 b : in    std_logic_vector(7 DOWNTO 0);

    y    : out   std_logic
  );
end entity comparator8bit;

architecture struct of comparator8bit is

  signal int : std_logic_vector(7 DOWNTO 0);

begin

  int <= a xnor b;

  y <= int(0) and int(1) and int(2) and int(3) and int(4) and int(5) and int(6) and int(7);

end architecture struct;
