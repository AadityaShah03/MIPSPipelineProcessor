library ieee;
  use ieee.std_logic_1164.all;

entity full_adder is
  port (
    x    : in    std_logic;
    y    : in    std_logic;
    cin  : in    std_logic;
    s    : out   std_logic;
    cout : out   std_logic
  );
end entity full_adder;

architecture struct of full_adder is

  signal xor0 : std_logic;
  signal and0 : std_logic;
  signal and1 : std_logic;

begin

  xor0 <= x xor y;
  s    <= xor0 xor cin;
  and0 <= x and y;
  and1 <= xor0 and cin;
  cout <= and0 or and1;

end architecture struct;
