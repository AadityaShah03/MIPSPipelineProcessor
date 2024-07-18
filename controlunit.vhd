library ieee;
  use ieee.std_logic_1164.all;

entity controlunit is
  port (
    intsruction : in    std_logic_vector(5 downto 0);
    regdst      : out   std_logic;
    alusrc      : out   std_logic;
    memtoreg    : out   std_logic;
    regwrite    : out   std_logic;
    memread     : out   std_logic;
    memwrite    : out   std_logic;
    branch      : out   std_logic;
    aluopout    : out   std_logic_vector(1 downto 0);
    jump        : out   std_logic;
	 stall       : out   std_logic
  );
end entity controlunit;

architecture struct of controlunit is

  signal add    : std_logic;
  signal sub    : std_logic;
  signal andop  : std_logic;
  signal orop   : std_logic;
  signal lw     : std_logic;
  signal sw     : std_logic;
  signal beq    : std_logic;
  signal jumpop : std_logic;
  signal aluop1 : std_logic;
  signal aluop0 : std_logic;

begin

  add <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (not intsruction(2)) and (not intsruction(1)) and (not intsruction(0));

  sub <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (not intsruction(2)) and (not intsruction(1)) and (intsruction(0));

  andop <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (not intsruction(2)) and (intsruction(1)) and (not intsruction(0));

  orop <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (not intsruction(2)) and (intsruction(1)) and (intsruction(0));

  lw <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (intsruction(2)) and (not intsruction(1)) and (not intsruction(0));

  sw <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (intsruction(2)) and (not intsruction(1)) and (intsruction(0));

  beq <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (intsruction(2)) and (intsruction(1)) and (not intsruction(0));

  jumpop <= (not intsruction(5)) and (not intsruction(4)) and (not intsruction(3)) and
            (intsruction(2)) and (intsruction(1)) and (intsruction(0));

  stall    <= (beq or jumpop) and not (add or sub or andop or orop or lw or sw);
  jump     <= (jumpop) and not (beq or sw or lw or orop or andop or sub or add);
  branch   <= (beq) and not (jumpop or sw or lw or orop or andop or sub or add);
  
  alusrc   <= (lw or sw) and not(add or sub or orop or andop or beq);  
  regdst   <= (add or sub or orop or andop) and not(lw or jumpop);
  aluop1   <= (andop or orop) and not (add  or sub or lw or sw);
  aluop0   <= (sub or orop) and not (add or andop or lw or sw);
  
  memread  <= (lw) and not (add or sub or orop or andop or beq or sw or jumpop);
  memwrite <= (sw) and not (add or sub or orop or andop or beq or lw or jumpop);
  
  regwrite <= (add or sub or orop or andop or lw) and not (beq or sw or jumpop);
  memtoreg <=  lw and not(add or sub or orop or andop);
  
  aluopout(0) <= aluop0;
  aluopout(1) <= aluop1;

end architecture struct;
