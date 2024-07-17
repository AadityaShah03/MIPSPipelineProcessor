library ieee;
  use ieee.std_logic_1164.all;

entity nbitaddsub is
  generic (

    n : integer := 8
  );
  port (
    a           : in    std_logic_vector(n - 1 downto 0);
    b           : in    std_logic_vector(n - 1 downto 0);
    addorsubcin : in    std_logic;
    q           : out   std_logic_vector(n - 1 downto 0);
    cout        : out   std_logic;
    overflow    : out   std_logic
  );
end entity nbitaddsub;

architecture struct of nbitaddsub is

  component full_adder is
    port (
      x    : in    std_logic;
      y    : in    std_logic;
      cin  : in    std_logic;
      s    : out   std_logic;
      cout : out   std_logic
    );
  end component;

  signal int_cin : std_logic_vector(n - 1 downto 0);

begin

  fa1 : component full_adder
    port map (
      x    => a(0),
      y    => b(0) xor addorsubcin,
      cin  => addorsubcin,
      s    => q(0),
      cout => int_cin(0)
    );

  addersubtractorloop : for i in 1 to n - 1 generate

    fax : component full_adder
      port
    map (
        x    => a(i),
        y    => b(i) xor addorsubcin,
        cin  => int_cin(i - 1),
        s    => q(i),
        cout => int_cin(i)
      );

  end generate addersubtractorloop;

  cout <= int_cin(n - 1);

  overflow <= int_cin(n - 1) xor int_cin(n - 2);

end architecture struct;
