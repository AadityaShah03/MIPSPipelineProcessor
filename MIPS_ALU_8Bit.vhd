library ieee;
  use ieee.std_logic_1164.all;

entity mips_alu_8bit is
  port (
    ain    : in    std_logic_vector(7 downto 0);
    bin    : in    std_logic_vector(7 downto 0);
    aluop  : in    std_logic_vector(1 downto 0);
    aluout : out   std_logic_vector(7 downto 0);
    zero   : out   std_logic
  );
end entity mips_alu_8bit;

architecture struct of mips_alu_8bit is

  component nbitaddsub is
    generic (

      n : integer
    );
    port (
      a           : in    std_logic_vector(n - 1 downto 0);
      b           : in    std_logic_vector(n - 1 downto 0);
      addorsubcin : in    std_logic;
      q           : out   std_logic_vector(n - 1 downto 0);
      cout        : out   std_logic;
      overflow    : out   std_logic
    );
  end component;

  component nbitmux4to1 is
    generic (

      n : integer
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
  end component;

  signal aluresult : std_logic_vector(7 downto 0);
  signal andresult : std_logic_vector(7 downto 0);
  signal orresult  : std_logic_vector(7 downto 0);
  signal muxout    : std_logic_vector(7 downto 0);
  signal cin       : std_logic;

begin

  cin <= ((not aluop(1)) and aluop(0));

  addsub8bit : component nbitaddsub
    generic map (
      n => 8
    )
    port map (
      a           => ain,
      b           => bin,
      addorsubcin => cin,
      q           => aluresult,
      cout        => open,
      overflow    => open
    );

  andresult <= ain and bin;
  orresult  <= ain or bin;

  outmux : component nbitmux4to1
    generic map (
      n => 8
    )
    port map (
      sel0 => aluop(0),
      sel1 => aluop(1),
      in0  => aluresult,
      in1  => aluresult,
      in2  => andresult,
      in3  => orresult,
      y    => muxout
    );

  aluout <= muxout;

  zero <= not(muxout(7) or muxout(6) or muxout(5) or muxout(4) or muxout(3) or muxout(2) or muxout(1) or muxout(0));

end architecture struct;
