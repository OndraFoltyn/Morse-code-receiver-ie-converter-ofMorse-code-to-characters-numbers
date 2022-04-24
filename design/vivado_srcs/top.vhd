library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is 
  Port ( CLK100MHZ : in STD_LOGIC;
         LED : out STD_LOGIC;
         CA : out STD_LOGIC;
         CB : out STD_LOGIC;
         CC : out STD_LOGIC;
         CD : out STD_LOGIC;
         CF : out STD_LOGIC;
         CG : out STD_LOGIC;
         AN : out STD_LOGIC_VECTOR (7 downto 0); 
         BTNC : in STD_LOGIC;
         BTNR : IN STD_LOGIC
       );
end top;  
  
  
architecture Behavioral of top is
      signal s_en  : std_logic;
      signal s_cnt : std_logic_vector(4 - 1 downto 0);
begin
      --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 25000000
      )
      port map(
          clk   => CLK100MHZ,
          reset => BTNR, 
          ce_o  => s_en
      );
    
    
--------------------------------------------------------------------
  -- Instance (copy) of cnt_up entity
  bin_cnt0 : entity work.cnt_up_down
     generic map(
          g_CNT_WIDTH   => 4 
      )
      port map(
          en_i          => s_en,
          reset         => BTNR,
          clk           => CLK100MHZ,
          cnt_up_i      => BTNC,
          cnt_o         => s_cnt
      );
end architecture Behavioral;