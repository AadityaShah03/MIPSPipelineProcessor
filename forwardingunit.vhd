library ieee;
use ieee.std_logic_1164.all;

entity forwardingunit is
  port (
    EXMEMRegWrite  : in    std_logic;
	 MemWBRegWrite  : in    std_logic;
	 EXMemRegisterRd  : in    std_logic_vector(4 DOWNTO 0);
	 MEMWBRegisterRd  : in    std_logic_vector(4 DOWNTO 0);
	 IDEXRegisterRs  : in    std_logic_vector(4 DOWNTO 0);
	 IDEXRegisterRt  : in    std_logic_vector(4 DOWNTO 0);

    fa    : out   std_logic_vector(1 DOWNTO 0);
	 fb    : out   std_logic_vector(1 DOWNTO 0)

  );
end entity forwardingunit;

architecture struct of forwardingunit is

  signal noteq0, noteq1, noteq2, noteq3, noteq4, noteq5, noteq6, noteq7 : std_logic;
  signal if0, if1, if2, if3 : std_logic_vector(1 DOWNTO 0);
  signal zero_signal : std_logic_vector(4 downto 0) := (others => '0');

  signal muxoutsiga : std_logic_vector(1 DOWNTO 0);
  signal muxoutsigb : std_logic_vector(1 DOWNTO 0);

  
  component comparator5bit is
    port (
      a  : in    std_logic_vector(4 DOWNTO 0);
      b  : in    std_logic_vector(4 DOWNTO 0);
      y  : out   std_logic
    );
  end component;
  
  component nbitmux4to1 is
   generic (
        n : integer := 2
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

begin
	 
comparator5bit_0 : component comparator5bit
    port map (
      a  => EXMemRegisterRd,
      b	=> zero_signal,
      y  => noteq0
    );
	 
comparator5bit_1 : component comparator5bit
    port map (
      a  => EXMemRegisterRd,
      b	=> IDEXRegisterRs,
      y  => noteq1
    );
comparator5bit_2 : component comparator5bit
    port map (
      a  => EXMemRegisterRd,
      b	=> zero_signal,
      y  => noteq2
    );
	 
comparator5bit_3 : component comparator5bit
    port map (
      a  => EXMemRegisterRd,
      b	=> IDEXRegisterRt,
      y  => noteq3
    );
comparator5bit_4 : component comparator5bit
    port map (
      a  => MEMWBRegisterRd,
      b	=> zero_signal,
      y  => noteq4
    );
	 
comparator5bit_5 : component comparator5bit
    port map (
      a  => MEMWBRegisterRd,
      b	=> IDEXRegisterRs,
      y  => noteq5
    );
comparator5bit_6 : component comparator5bit
    port map (
      a  => MEMWBRegisterRd,
      b	=> zero_signal,
      y  => noteq6
    );
	 
comparator5bit_7 : component comparator5bit
    port map (
      a  => MEMWBRegisterRd,
      b	=> IDEXRegisterRt,
      y  => noteq7
    );
	 
	 
muxa : component nbitmux4to1
	generic map(
		n => 2
	)
	port map (
      sel0  => if2(0),
      sel1	=> if0(1),
		in0	=> zero_signal(1 DOWNTO 0),
		in1	=> if2,
		in2	=> if0,
		in3	=> if0,
      y	   => muxoutsiga
    );
muxb : component nbitmux4to1
   generic map(
		n => 2
	)
	port map (
      sel0  => if3(0),
      sel1	=> if1(1),
		in0	=> zero_signal(1 DOWNTO 0),
		in1	=> if3,
		in2	=> if1,
		in3	=> if1,
      y	   => muxoutsigb
    );
	 
	 if0(1) <= (EXMEMRegWrite and not (noteq0) and noteq1);
	 if1(1) <= (EXMEMRegWrite and not (noteq2) and noteq3);
	 if2(0) <= (MemWBRegWrite and not (noteq4) and noteq5);
	 if3(0) <= (MemWBRegWrite and not (noteq6) and noteq7);

	 
	 
	 fa <= muxoutsiga;
	 fb <= muxoutsigb;
	 

end architecture struct;
