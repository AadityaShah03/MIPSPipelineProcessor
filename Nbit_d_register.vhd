library ieee;
  use ieee.std_logic_1164.all;

entity nbit_d_register is
  -- Generic for number of bits
  generic (

    n : positive := 8 -- Defaults to 8 bits
  );
  port (
    d     : in    std_logic_vector(n - 1 downto 0);
    clk   : in    std_logic;
    rst   : in    std_logic;
    load  : in    std_logic;
    q     : out   std_logic_vector(n - 1 downto 0);
    q_not : out   std_logic_vector(n - 1 downto 0)
  );
end entity nbit_d_register;

architecture structural of nbit_d_register is

  component enardff_2 is
    port (
      i_resetbar : in    std_logic;
      i_d        : in    std_logic;
      i_enable   : in    std_logic;
      i_clock    : in    std_logic;
      o_q        : out   std_logic;
      o_qbar     : out   std_logic
    );
  end component;

  signal int_dff : std_logic_vector(n - 1 downto 0);
  signal notrst  : std_logic;

begin

  -- Instance d flipflops for each bit

  notrst <= not rst;

  make_ff : for i in 0 to n - 1 generate

    dff_inst : component enardff_2
      port map (
        i_d        => d(i),
        i_clock    => clk,
        i_enable   => load,
        i_resetbar => notrst,
        o_q        => int_dff(i),
        o_qbar     => q_not(i)
      );

  end generate make_ff;

  -- Output assignment
  q <= int_dff;

end architecture structural;
