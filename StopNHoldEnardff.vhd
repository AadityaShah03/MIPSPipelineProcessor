library ieee;
  use ieee.std_logic_1164.all;

entity StopNHoldEnardff is
  port (
		rst      : in    std_logic;
		d        : in    std_logic;
		en       : in    std_logic;
		clk      : in    std_logic;
		q        : out   std_logic;
		int_d1	: out   std_logic
  );
end entity StopNHoldEnardff;

architecture struct of StopNHoldEnardff is

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

  signal int_d: std_logic;

begin

	dff_1 : component enardff_2
      port map (
        i_d        => d,
        i_clock    => clk,
        i_enable   => en,
        i_resetbar => not rst,
        o_q        => int_d,
        o_qbar     => open
   );
	
	
	dff_2 : component enardff_2
      port map (
        i_d        => int_d,
        i_clock    => clk,
        i_enable   => en,
        i_resetbar => not rst,
        o_q        => q,
        o_qbar     => open
   );
	
	int_d1 <= int_d;
	

end architecture struct;