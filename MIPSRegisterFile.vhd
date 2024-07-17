library ieee;
  use ieee.std_logic_1164.all;

entity mipsregisterfile is
  port (
    clk             : in    std_logic;
    rst             : in    std_logic;
    regwrite        : in    std_logic;
    writeregaddress : in    std_logic_vector(4 downto 0);
    rs              : in    std_logic_vector(4 downto 0);
    rt              : in    std_logic_vector(4 downto 0);
    writedata       : in    std_logic_vector(7 downto 0);
    readreg1        : out   std_logic_vector(7 downto 0);
    readreg2        : out   std_logic_vector(7 downto 0);

    reg1 : out   std_logic_vector(7 downto 0);
    reg2 : out   std_logic_vector(7 downto 0);
    reg3 : out   std_logic_vector(7 downto 0);
    reg4 : out   std_logic_vector(7 downto 0);
    reg5 : out   std_logic_vector(7 downto 0);
    reg6 : out   std_logic_vector(7 downto 0);
    reg7 : out   std_logic_vector(7 downto 0);
    reg8 : out   std_logic_vector(7 downto 0)
  );
end entity mipsregisterfile;

architecture struct of mipsregisterfile is

  component decoder_3to8 is
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
  end component;

  component mux_8to1 is
    port (
      sel0 : in    std_logic;
      sel1 : in    std_logic;
      sel2 : in    std_logic;
      in0  : in    std_logic;
      in1  : in    std_logic;
      in2  : in    std_logic;
      in3  : in    std_logic;
      in4  : in    std_logic;
      in5  : in    std_logic;
      in6  : in    std_logic;
      in7  : in    std_logic;
      y    : out   std_logic
    );
  end component;

  component nbit_d_register is
    generic (
      n : positive
    );
    port (
      d     : in    std_logic_vector(n - 1 downto 0);
      clk   : in    std_logic;
      rst   : in    std_logic;
      load  : in    std_logic;
      q     : out   std_logic_vector(n - 1 downto 0);
      q_not : out   std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal decodereg   : std_logic_vector(7 downto 0);
  signal regout_1    : std_logic_vector(7 downto 0);
  signal regout_2    : std_logic_vector(7 downto 0);
  signal regout_3    : std_logic_vector(7 downto 0);
  signal regout_4    : std_logic_vector(7 downto 0);
  signal regout_5    : std_logic_vector(7 downto 0);
  signal regout_6    : std_logic_vector(7 downto 0);
  signal regout_7    : std_logic_vector(7 downto 0);
  signal regout_8    : std_logic_vector(7 downto 0);
  signal readreg1mux : std_logic_vector(7 downto 0);
  signal readreg2mux : std_logic_vector(7 downto 0);

begin

  writeregdecode : component decoder_3to8
    port map (
      en   => regwrite,
      sel0 => writeregaddress(0),
      sel1 => writeregaddress(1),
      sel2 => writeregaddress(2),
      out0 => decodereg(0),
      out1 => decodereg(1),
      out2 => decodereg(2),
      out3 => decodereg(3),
      out4 => decodereg(4),
      out5 => decodereg(5),
      out6 => decodereg(6),
      out7 => decodereg(7)
    );

  reg_inst_1 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(0),
      q     => regout_1,
      q_not => open
    );

  reg_inst_2 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(1),
      q     => regout_2,
      q_not => open
    );

  reg_inst_3 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(2),
      q     => regout_3,
      q_not => open
    );

  reg_inst_4 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(3),
      q     => regout_4,
      q_not => open
    );

  reg_inst_5 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(4),
      q     => regout_5,
      q_not => open
    );

  reg_inst_6 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(5),
      q     => regout_6,
      q_not => open
    );

  reg_inst_7 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(6),
      q     => regout_7,
      q_not => open
    );

  reg_inst_8 : component nbit_d_register
    generic map (
      n => 8
    )
    port map (
      d     => writedata,
      clk   => clk,
      rst   => rst,
      load  => decodereg(7),
      q     => regout_8,
      q_not => open
    );

  readreg1mux_1 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(0),
      in1  => regout_2(0),
      in2  => regout_3(0),
      in3  => regout_4(0),
      in4  => regout_5(0),
      in5  => regout_6(0),
      in6  => regout_7(0),
      in7  => regout_8(0),
      y    => readreg1mux(0)
    );

  readreg2mux_1 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(0),
      in1  => regout_2(0),
      in2  => regout_3(0),
      in3  => regout_4(0),
      in4  => regout_5(0),
      in5  => regout_6(0),
      in6  => regout_7(0),
      in7  => regout_8(0),
      y    => readreg2mux(0)
    );

  readreg1mux_2 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(1),
      in1  => regout_2(1),
      in2  => regout_3(1),
      in3  => regout_4(1),
      in4  => regout_5(1),
      in5  => regout_6(1),
      in6  => regout_7(1),
      in7  => regout_8(1),
      y    => readreg1mux(1)
    );

  readreg2mux_2 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(1),
      in1  => regout_2(1),
      in2  => regout_3(1),
      in3  => regout_4(1),
      in4  => regout_5(1),
      in5  => regout_6(1),
      in6  => regout_7(1),
      in7  => regout_8(1),
      y    => readreg2mux(1)
    );

  readreg1mux_3 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(2),
      in1  => regout_2(2),
      in2  => regout_3(2),
      in3  => regout_4(2),
      in4  => regout_5(2),
      in5  => regout_6(2),
      in6  => regout_7(2),
      in7  => regout_8(2),
      y    => readreg1mux(2)
    );

  readreg2mux_3 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(2),
      in1  => regout_2(2),
      in2  => regout_3(2),
      in3  => regout_4(2),
      in4  => regout_5(2),
      in5  => regout_6(2),
      in6  => regout_7(2),
      in7  => regout_8(2),
      y    => readreg2mux(2)
    );

  readreg1mux_4 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(3),
      in1  => regout_2(3),
      in2  => regout_3(3),
      in3  => regout_4(3),
      in4  => regout_5(3),
      in5  => regout_6(3),
      in6  => regout_7(3),
      in7  => regout_8(3),
      y    => readreg1mux(3)
    );

  readreg2mux_4 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(3),
      in1  => regout_2(3),
      in2  => regout_3(3),
      in3  => regout_4(3),
      in4  => regout_5(3),
      in5  => regout_6(3),
      in6  => regout_7(3),
      in7  => regout_8(3),
      y    => readreg2mux(3)
    );

  readreg1mux_5 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(4),
      in1  => regout_2(4),
      in2  => regout_3(4),
      in3  => regout_4(4),
      in4  => regout_5(4),
      in5  => regout_6(4),
      in6  => regout_7(4),
      in7  => regout_8(4),
      y    => readreg1mux(4)
    );

  readreg2mux_5 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(4),
      in1  => regout_2(4),
      in2  => regout_3(4),
      in3  => regout_4(4),
      in4  => regout_5(4),
      in5  => regout_6(4),
      in6  => regout_7(4),
      in7  => regout_8(4),
      y    => readreg2mux(4)
    );

  readreg1mux_6 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(5),
      in1  => regout_2(5),
      in2  => regout_3(5),
      in3  => regout_4(5),
      in4  => regout_5(5),
      in5  => regout_6(5),
      in6  => regout_7(5),
      in7  => regout_8(5),
      y    => readreg1mux(5)
    );

  readreg2mux_6 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(5),
      in1  => regout_2(5),
      in2  => regout_3(5),
      in3  => regout_4(5),
      in4  => regout_5(5),
      in5  => regout_6(5),
      in6  => regout_7(5),
      in7  => regout_8(5),
      y    => readreg2mux(5)
    );

  readreg1mux_7 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(6),
      in1  => regout_2(6),
      in2  => regout_3(6),
      in3  => regout_4(6),
      in4  => regout_5(6),
      in5  => regout_6(6),
      in6  => regout_7(6),
      in7  => regout_8(6),
      y    => readreg1mux(6)
    );

  readreg2mux_7 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(6),
      in1  => regout_2(6),
      in2  => regout_3(6),
      in3  => regout_4(6),
      in4  => regout_5(6),
      in5  => regout_6(6),
      in6  => regout_7(6),
      in7  => regout_8(6),
      y    => readreg2mux(6)
    );

  readreg1mux_8 : component mux_8to1
    port map (
      sel0 => rs(0),
      sel1 => rs(1),
      sel2 => rs(2),
      in0  => regout_1(7),
      in1  => regout_2(7),
      in2  => regout_3(7),
      in3  => regout_4(7),
      in4  => regout_5(7),
      in5  => regout_6(7),
      in6  => regout_7(7),
      in7  => regout_8(7),
      y    => readreg1mux(7)
    );

  readreg2mux_8 : component mux_8to1
    port map (
      sel0 => rt(0),
      sel1 => rt(1),
      sel2 => rt(2),
      in0  => regout_1(7),
      in1  => regout_2(7),
      in2  => regout_3(7),
      in3  => regout_4(7),
      in4  => regout_5(7),
      in5  => regout_6(7),
      in6  => regout_7(7),
      in7  => regout_8(7),
      y    => readreg2mux(7)
    );

  reg1 <= regout_1;
  reg2 <= regout_2;
  reg3 <= regout_3;
  reg4 <= regout_4;
  reg5 <= regout_5;
  reg6 <= regout_6;
  reg7 <= regout_7;
  reg8 <= regout_8;

  readreg1 <= readreg1mux;
  readreg2 <= readreg2mux;

end architecture struct;
