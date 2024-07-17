library ieee;
  use ieee.std_logic_1164.all;

entity nbitmux4to1 is
  generic (

    n : integer := 8
  );
  port (
    sel0 : in    std_logic;
    sel1 : in    std_logic;
    in0  : in    std_logic_vector(n - 1 downto 0);
    in1  : in    std_logic_vector(n - 1 downto 0);
    in2  : in    std_logic_vector(n - 1 downto 0);
    in3  : in    std_logic_vector(n - 1 downto 0);
    y    : out   std_logic_vector(n - 1 downto 0)
  );
end entity nbitmux4to1;

architecture struct of nbitmux4to1 is

  signal and0       : std_logic_vector(n - 1 downto 0);
  signal and1       : std_logic_vector(n - 1 downto 0);
  signal and2       : std_logic_vector(n - 1 downto 0);
  signal and3       : std_logic_vector(n - 1 downto 0);
  signal sel0vec    : std_logic_vector(n - 1 downto 0);
  signal sel1vec    : std_logic_vector(n - 1 downto 0);
  signal sel0notvec : std_logic_vector(n - 1 downto 0);
  signal sel1notvec : std_logic_vector(n - 1 downto 0);

begin

  sel0vec    <= (others => sel0);
  sel1vec    <= (others => sel1);
  sel0notvec <= not sel0vec;
  sel1notvec <= not sel1vec;
  and3       <= in3 and (sel0vec and sel1vec);
  and2       <= in2 and (sel0notvec and sel1vec);
  and1       <= in1 and (sel0vec and sel1notvec);
  and0       <= in0 and (sel1notvec and sel0notvec);

  y <= and0 or and1 or and2 or and3;

end architecture struct;
