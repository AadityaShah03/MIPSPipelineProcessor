library ieee;
use ieee.std_logic_1164.all;

entity hazardunit is
  port (
    IDEXMemRead  : in    std_logic;
	 IDEXRegisterRt  : in    std_logic_vector(4 DOWNTO 0);
	 IFIDRegisterRs  : in    std_logic_vector(4 DOWNTO 0);
	 IFIDRegisterRt  : in    std_logic_vector(4 DOWNTO 0);

    f    : out   std_logic
  );
end entity hazardunit;

architecture struct of hazardunit is

  signal andsig, andsig2 : std_logic;
  
  component comparator5bit is
    port (
      a  : in    std_logic_vector(4 DOWNTO 0);
      b  : in    std_logic_vector(4 DOWNTO 0);
      y  : out   std_logic
    );
  end component;

begin
	 
comparator5bit_1 : component comparator5bit
    port map (
      a  => IDEXRegisterRt,
      b	=> IFIDRegisterRs,
      y  => andsig
    );
	 
comparator5bit_2 : component comparator5bit
    port map (
      a  => IDEXRegisterRt,
      b	=> IFIDRegisterRt,
      y  => andsig2
    );
	 
	 f <= (IDEXMemRead and (andsig or  andsig2));

end architecture struct;
