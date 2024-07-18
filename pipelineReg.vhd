library ieee;
  use ieee.std_logic_1164.all;

entity pipelineReg is
  -- Generic for number of bits
  generic (

    n : positive := 64 -- Defaults to 8 bits
  );
  port (
    d     : in    std_logic_vector(n - 1 downto 0);
    clk   : in    std_logic;
    rst   : in    std_logic;
    load  : in    std_logic;
    q     : out   std_logic_vector(n - 1 downto 0)
  );
end entity pipelineReg;

architecture structural of pipelineReg is

  component StopNHoldEnardff is
  port (
		rst      : in    std_logic;
		d        : in    std_logic;
		en       : in    std_logic;
		clk      : in    std_logic;
		q        : out   std_logic
  );
  end component;

begin


  make_ff : for i in 0 to n - 1 generate

    dff_inst : component StopNHoldEnardff
      port map (
			rst      => rst,
			d        => d(i),
			en       => load,
			clk      => clk,
			q        => q(i)
      );

  end generate make_ff;

end architecture structural;
