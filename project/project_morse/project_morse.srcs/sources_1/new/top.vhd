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
    signal shift_reg 	: STD_LOGIC_VECTOR(4  downto 0) ;
    signal shift_led 	: STD_LOGIC_VECTOR(14  downto 0) ;
    signal seg_o 		: STD_LOGIC;
    signal number 		: STD_LOGIC_VECTOR(6 downto 0);
    signal s_led		: STD_LOGIC_VECTOR(2 downto 0);
    signal s_dis		: natural;
    signal ce_o         : std_logic;
    
begin
      --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clk_en0 : entity work.decoder
      generic map(
          g_MAX => 25000000
      )
      port map(
          clk   => CLK100MHZ,
          reset => BTNR,
          inp => BTNC,
          inp_mez => BTNU,
          inp_tran => BTNL,
          LED => LED,
          
          DIS_1(0) => CA,
          DIS_1(1) => CB,
          DIS_1(2) => CC,
          DIS_1(3) => CD,
          DIS_1(4) => CE,
          DIS_1(5) => CF,
          DIS_1(6) => CG,

          DIS_2(0) => CA,
          DIS_2(1) => CB,
          DIS_2(2) => CC,
          DIS_2(3) => CD,
          DIS_2(4) => CE,
          DIS_2(5) => CF,
          DIS_2(6) => CG,

          DIS_3(0) => CA,
          DIS_3(1) => CB,
          DIS_3(2) => CC,
          DIS_3(3) => CD,
          DIS_3(4) => CE,
          DIS_3(5) => CF,
          DIS_3(6) => CG,

          DIS_4(0) => CA,
          DIS_4(1) => CB,
          DIS_4(2) => CC,
          DIS_4(3) => CD,
          DIS_4(4) => CE,
          DIS_4(5) => CF,
          DIS_4(6) => CG,

          DIS_5(0) => CA,
          DIS_5(1) => CB,
          DIS_5(2) => CC,
          DIS_5(3) => CD,
          DIS_5(4) => CE,
          DIS_5(5) => CF,
          DIS_5(6) => CG,
           
          AN => AN





      );

  -- Disconnect the top four digits of the 7-segment display
  AN(7 downto 5) <= b"1111";
  
end architecture Behavioral;