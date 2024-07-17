library ieee;
  use ieee.std_logic_1164.all;

entity decoder_3to8 is
  port (
    en   : in    std_logic;
    sel0 : in    std_logic;
    sel1 : in    std_logic;
    sel2 : in    std_logic;
    out0 : out   std_logic;
    out1 : out   std_logic;
    out2 : out   std_logic;
    out3 : out   std_logic;
    out4 : out   std_logic;
    out5 : out   std_logic;
    out6 : out   std_logic;
    out7 : out   std_logic
  );
end entity decoder_3to8;

architecture struct of decoder_3to8 is

  signal sel0not : std_logic;
  signal sel1not : std_logic;
  signal sel2not : std_logic;

begin

  sel0not <= not sel0;
  sel1not <= not sel1;
  sel2not <= not sel2;

  out7 <= en and (sel0 and sel1 and sel2);
  out6 <= en and (sel0not and sel1 and sel2);
  out5 <= en and (sel0 and sel1not and sel2);
  out4 <= en and (sel1not and sel0not and sel2);
  out3 <= en and (sel0 and sel1 and sel2not);
  out2 <= en and (sel0not and sel1 and sel2not);
  out1 <= en and (sel0 and sel1not and sel2not);
  out0 <= en and (sel1not and sel0not and sel2not);

end architecture struct;
