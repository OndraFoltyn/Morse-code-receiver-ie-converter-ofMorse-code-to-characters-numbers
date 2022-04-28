-------------------------------------------------------------
--
-- Testbench for clock enable circuit.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_decoder is
    -- Entity of testbench is always empty
end entity tb_decoder;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_decoder is 
    constant g_MAX  : natural := 25000000;
	constant t_MAX               : natural := 6;
    constant dis_MAX             : natural := 7;
    constant c_MAX               : natural := 10;
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    
    signal s_inp 		: std_logic;
    signal s_inp_mez 	: std_logic;
    signal s_inp_tran	: std_logic;
    signal s_LED		: STD_LOGIC_VECTOR(14 downto 0);
    signal s_DIS		: STD_LOGIC_VECTOR(6 downto 0);
    
 
begin
    -- Connecting testbench signals with clock_enable entity
    -- (Unit Under Test)
    uut_ce : entity work.decoder
        generic map(
            g_MAX => c_MAX,
            d_MAX => dis_MAX,
            ch_MAX => t_MAX
            
            )   -- Note that there is NO comma or semicolon between
            -- generic map section and port map section
        port map(
            clk   => s_clk_100MHz,
            reset => s_reset,
           -- ce_o  => s_ce,
            inp   => s_inp,
            inp_mez   => s_inp_mez,
            inp_tran => s_inp_tran,            
            LED => s_LED,
            DIS => s_DIS
            
           
        );

    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 15000 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                   -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 20 ns;
        
        -- Reset activated
        s_reset <= '1';
        
        wait for 100 ns;
		
        -- Reset deactivated
        s_reset <= '0';
       

        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
       s_inp_mez<= '0';
       s_inp <= '0';
       s_inp_tran <= '0';
       
       

--1 cyklus- èárka
		wait for 800 ns;
        --Reset activated
        s_inp <= '1';
        wait for 500 ns; --èárka

        -- Reset deactivated
        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;
       
       
        
  --2 cyklus- teèka
  		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
        
        
        s_inp<= '1';
        wait for 100 ns;
        
        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;
       
       
   
--3 cyklus - èárka
		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
                
        s_inp <= '1';
        wait for 500 ns; 

        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;
       
        s_inp_tran<= '1'; --translate
        wait for 100 ns;
        
        s_inp_tran<= '0';
        wait for 100 ns;
        
--4 cyklus - teèka
		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
       
        s_inp <= '1';
        wait for 100 ns; --teèka

        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;
       
        s_inp_tran<= '1'; --translate
        wait for 100 ns;
        
        s_inp_tran<= '0';
        wait for 100 ns;

        
--5 cyklus - èárka
		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
       
        s_inp <= '1';
        wait for 500 ns; 

        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;

--6 cyklus - èárka
		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
        
        --Reset activated
        s_inp <= '1';
        wait for 500 ns; 

        -- Reset deactivated
        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;

--7 cyklus - èárka
		s_inp_mez<= '0';
        s_inp <= '0';
        wait for 800 ns;
        
        --Reset activated
        s_inp <= '1';
        wait for 500 ns; 

        -- Reset deactivated
        s_inp<= '0';
        wait for 100 ns;
        
        s_inp_mez<= '1';
        wait for 100 ns;
        
        s_inp_mez<= '0';
        wait for 100 ns;
        
        s_inp_tran<= '1'; --translate
        wait for 100 ns;
        
        s_inp_tran<= '0';
        wait for 100 ns;

       
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;