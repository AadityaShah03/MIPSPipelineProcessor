library ieee;
  use ieee.std_logic_1164.all;

entity nbit2to1mux is
  generic (
    n : integer := 8
  );
  port (
    sel0 : in    std_logic;
    in0  : in    std_logic_vector(n - 1 downto 0);
    in1  : in    std_logic_vector(n - 1 downto 0);
    y    : out   std_logic_vector(n - 1 downto 0)
  );
end entity nbit2to1mux;

architecture struct of nbit2to1mux is

  signal notsel0vec : std_logic_vector(n - 1 downto 0);
  signal sel0vec    : std_logic_vector(n - 1 downto 0);
  signal and0       : std_logic_vector(n - 1 downto 0);
  signal and1       : std_logic_vector(n - 1 downto 0);

begin

  notsel0vec <= (others => not sel0);
  sel0vec    <= (others => sel0);
  and0       <= notsel0vec and in0;
  and1       <= sel0vec and in1;
  y          <= and0 or and1;

end architecture struct;
