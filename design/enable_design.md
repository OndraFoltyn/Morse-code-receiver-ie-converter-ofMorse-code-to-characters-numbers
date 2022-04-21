library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

------------------------------------------------------------
-- Entity declaration for clock enable
------------------------------------------------------------
entity counter is
    generic(
        g_MAX : natural := 10; -- Number of clk pulses to
        t_MAX : natural := 10  -- generate one enable signal
                             -- period
    );  -- Note that there IS a semicolon between generic 
        -- and port sections
    port(
        clk   : in  std_logic; -- Main clock
        reset : in  std_logic; -- Synchronous reset
        ce_o  : out std_logic;-- Clock enable pulse signal
        inp	  : in	std_logic;
        seg_o : out std_logic_vector(2 - 1 downto 0)
       
    );
end entity counter;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------
architecture Behavioral of counter is

    -- Local counter
    signal s_cnt_local  : natural;
    signal s_enable_cnt : natural;
    signal s_counter :natural;
    

begin
    --------------------------------------------------------
    -- p_clk_ena:
    -- Generate clock enable signal. By default, enable signal
    -- is low and generated pulse is always one clock long.
    --------------------------------------------------------
    p_clk_ena : process(clk)
    begin
        if rising_edge(clk) then    -- Synchronous process

            if (reset = '1') then   -- High active reset
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '0'; -- Set output to low

            -- Test number of clock periods
            elsif (s_cnt_local >= (g_MAX - 1)) then
                s_cnt_local <= 0;   -- Clear local counter
                ce_o        <= '1'; -- Generate clock enable pulse

            else
                s_cnt_local <= s_cnt_local + 1;
                ce_o        <= '0';
            end if;
        end if;
    end process p_clk_ena;
    
    p_cnt : process(ce_o)
    begin
   		if rising_edge(ce_o) then
        	
            if (reset = '1') then
            	s_enable_cnt <= 0;
                s_counter <= 0;
                
            elsif (s_enable_cnt >= (t_MAX - 1)) then
            	s_enable_cnt <= 0;
                s_counter <= 0;
            
            elsif (inp= '0') then
            	s_enable_cnt <= s_enable_cnt + 1;
                s_counter <= 0;
                
            elsif (inp = '1') then
                    s_counter<= s_counter + 1;
                    s_enable_cnt <= 0;
            else 
            		s_counter <=0; 
           
            end if;
        end if;
	 end process p_cnt;

	 p_out_counter : process(s_counter)
     begin
        if falling_edge(inp) then
            elsif (s_counter > 0 and s_counter<3) then
                seg_o <= "01"; -- tečka
                
           elsif (s_counter >3)  then
                seg_o <= "10"; -- čárka
                
           elsif (s_counter =0) then
           		seg_o <= "00"; -- mezera mezi znakama
                
            elsif (s_enable_cnt >= 9) then
            	seg_o <= "11";-- mezera písmenama
                
        end if;
      
    end process p_out_counter;
     
    
     
end architecture Behavioral;
