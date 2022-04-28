library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is 
  Port ( CLK100MHZ  : in STD_LOGIC;
         LED        : out STD_LOGIC_VECTOR (14 downto 0); 
         CA         : out STD_LOGIC;
         CB         : out STD_LOGIC;
         CC         : out STD_LOGIC;
         CD         : out STD_LOGIC;
         CE         : out STD_LOGIC;
         CF         : out STD_LOGIC;
         CG         : out STD_LOGIC;
         AN         : out STD_LOGIC_VECTOR (7 downto 0); 
         BTNC       : in STD_LOGIC;
         BTNR       : in STD_LOGIC;
         BTNU       : in STD_LOGIC;
         BTNL       : in STD_LOGIC
       );
end top;  
  
  
architecture Behavioral of top is
    signal s_cnt_local  : natural;
    signal s_cnt_char   : natural;
    signal s_counter 	: natural;
    signal s_shift_reg 	: STD_LOGIC_VECTOR(4  downto 0) ;
    signal shift_led 	: STD_LOGIC_VECTOR(14  downto 0) ;
    signal seg_o 		: STD_LOGIC;
    signal number 		: STD_LOGIC_VECTOR(6 downto 0);
    signal s_led		: STD_LOGIC_VECTOR(2 downto 0);
    signal s_ce         : std_logic;
    signal clk_dis      : STD_LOGIC_VECTOR(6 downto 0);
    signal s_rst       : std_logic;
    signal s_btnc       : std_logic;
    signal s_btnu       : std_logic;
    signal s_btnl       : std_logic;
    signal s_char       : std_logic_vector(2 downto 0);

begin
      --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clock_enable : entity work.clock_enable
      generic map(
        g_MAX  => 25000000
      )
      port map(
      clk   => CLK100MHZ,
      reset => s_rst,
      ce_o => s_ce
      );
      
  decoder : entity work.decoder
      port map(
          clk   => CLK100MHZ,
          reset => s_rst,
          inp => s_btnc,
          inp_mez => s_btnu,
          inp_tran => s_btnl,
          LED => LED,
          ce_i => s_ce,
          DIS => clk_dis,
          shift_reg_o => s_shift_reg,
          char_o => s_char
      );

hex7seg : entity work.hex7seg
      port map(
      hex_i  => clk_dis,
      rst    => s_rst,
      seg2_o(0) => CA,
      seg2_o(1) => CB,
      seg2_o(2) => CC,
      seg2_o(3) => CD,
      seg2_o(4) => CE,
      seg2_o(5) => CF,
      seg2_o(6) => CG,
      char_i    => s_char,
      inp_tran  => s_btnl,
      shift_reg_i => s_shift_reg
      );
  -- Disconnect the top four digits of the 7-segment display
   AN <= b"1111_0111";
  input_reg : process(CLK100MHZ) -- synchronization of inputs
    begin
    if rising_edge(CLK100MHZ) then
        s_btnc <= btnc;
        s_rst  <= btnr;
        s_btnu <= btnu;
        s_btnl <= btnl;
    end if;
    end process input_reg;
end architecture Behavioral;