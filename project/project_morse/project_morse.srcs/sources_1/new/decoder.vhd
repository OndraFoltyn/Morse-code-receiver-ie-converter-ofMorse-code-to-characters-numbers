library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder is
	generic(
        ch_MAX : natural := 6
        );  
    
    Port ( inp_mez : in  STD_LOGIC;
           clk     : in  std_logic;
           reset   : in  std_logic;
           inp	   : in	std_logic;
           LED 	   : out STD_LOGIC_VECTOR(14 downto 0);
           DIS	   : out STD_LOGIC_VECTOR(6 downto 0);
--           DIS_2	   : out STD_LOGIC_VECTOR(6 downto 0);
--           DIS_3	   : out STD_LOGIC_VECTOR(6 downto 0);
--           DIS_4	   : out STD_LOGIC_VECTOR(6 downto 0);
--           DIS_5	   : out STD_LOGIC_VECTOR(6 downto 0);
           inp_tran     : in std_logic;
           AN           : out STD_LOGIC_VECTOR (7 downto 0);
           ce_i         : in std_logic;
           shift_reg_o  : out std_logic_vector(4 downto 0);
           char_o       : out std_logic_vector(2 downto 0)
           );
           
end decoder;
    
architecture Behavioral of decoder is

    signal s_cnt_local  : natural;
    signal s_cnt_char   : std_logic_vector(2 downto 0);
    signal s_counter 	: natural;
    signal shift_reg 	: STD_LOGIC_VECTOR(4  downto 0) ;
    signal shift_led 	: STD_LOGIC_VECTOR(14  downto 0) ;
    signal seg_o 		: STD_LOGIC;
    signal number 		: STD_LOGIC_VECTOR(6 downto 0);
    signal s_led		: STD_LOGIC_VECTOR(2 downto 0);
    
begin
    
    p_cnt : process(ce_i)
    begin
   		if rising_edge(ce_i) then
        	
            if (reset = '1' or inp_mez = '1') then
            
                s_counter <= 0;
                
            elsif (inp = '1') then
                    s_counter<= s_counter + 1;
                    
              
            end if;
        end if;
	 end process p_cnt;
     
	-- counter znaku
	 p_countchar : process(inp_mez, inp_tran, reset)
     begin
        if rising_edge(inp_tran)or(rising_edge(reset)) then
           s_cnt_char <= "000";
        end if;
        
     	if rising_edge(inp_mez) then
                
            if (s_cnt_char >= (ch_MAX - 1)) then
                s_cnt_char <= "001";  
            
            else
             	s_cnt_char <= s_cnt_char + "001";
            end if;
        end if;  
     end process p_countchar;
     char_o <= s_cnt_char;

	 p_out_counter : process(s_counter)
     begin
        
           if (s_counter >= 3) then
                seg_o <= '1'; -- carka
                
                
           elsif(s_counter < 3) then
                seg_o <= '0'; -- tecka
               
        end if;
     end process p_out_counter;
    
   
    
    -- shift register
    p_shift : process (inp_mez)
    begin
        if rising_edge(inp_mez) then
        	

            shift_reg(0) <= seg_o;
            shift_reg(1) <= shift_reg(0);
            shift_reg(2) <= shift_reg(1);
            shift_reg(3) <= shift_reg(2);
            shift_reg(4) <= shift_reg(3);
            
            
        end if;
    end process p_shift;
    shift_reg_o <= shift_reg;
    --vstupní led
    p_led : process (s_counter)
    begin
    	
            if (s_counter < 3 and s_counter > 0) then 
            	s_led(0) <= '1';
                s_led(1) <= '0';
                s_led(2) <= '0';
                
            elsif (s_counter >= 3)  then 
            	s_led(0) <= '1';
                s_led(1) <= '1';
                s_led(2) <= '0';
            elsif (s_counter = 0) then 
            	s_led(0) <= '0';
                s_led(1) <= '0';
                s_led(2) <= '0';
                
            end if;
        
    end process p_led;
    
     -- shift led
    p_shift_led : process (inp_mez)
    begin
        if rising_edge(inp_mez) then
            
          shift_led(0) <= s_led(0);
          shift_led(1) <= s_led(1);
          shift_led(2) <= s_led(2);
          
          shift_led(3) <= shift_led(0);
          shift_led(4) <= shift_led(1);
          shift_led(5) <= shift_led(2);
          
          shift_led(6) <= shift_led(3);
          shift_led(7) <= shift_led(4);
          shift_led(8) <= shift_led(5);
          
          shift_led(9) <= shift_led(6);
          shift_led(10) <= shift_led(7);
          shift_led(11) <= shift_led(8);
          
          shift_led(12) <= shift_led(9);
          shift_led(13) <= shift_led(10);
          shift_led(14) <= shift_led(11);
          
      end if;
    end process p_shift_led; 
      
--   p_zero : process (inp_mez)
--   begin     
--        if (rising_edge(inp_tran) or reset = '1') then
--        --shift_led(14 downto 0) <= b"000000000000000";
--                s_led(0) <= '0';
--                s_led(1) <= '0';
--                s_led(2) <= '0';
                
--          shift_led(14) <= '0';
--          shift_led(13) <= '0';
--          shift_led(12) <= '0';
          
--          shift_led(11) <= '0';
--          shift_led(10) <= '0';
--          shift_led(9) <= '0';
          
--          shift_led(8) <= '0';
--          shift_led(7) <= '0';
--          shift_led(6) <= '0';
          
--          shift_led(5) <= '0';
--          shift_led(4) <= '0';
--          shift_led(3) <= '0';
          
--          shift_led(2) <= '0';
--          shift_led(1) <= '0';
--          shift_led(0) <= '0';
--        end if;
--   end process p_zero;
    
    p_clear_led : process(reset, inp_tran, inp_mez)
    begin 
    	if (reset = '1' or falling_edge(inp_tran)) then
        LED <= "000000000000000";
        
        
        elsif falling_edge(inp_mez) then
    	
        LED <= shift_led;
        
        end if;
   end process p_clear_led;
    
--    p_translate : process(inp_tran)
--    begin
    	
--    	if rising_edge(inp_tran) then
                
--             --cisla
--		if (s_cnt_char = "101" and shift_reg = "11111") then --0
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='1';

--		elsif (s_cnt_char = "101" and shift_reg = "11110") then --1
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='1';
--			number(5) <='1';
--			number(6) <='1';

--		elsif (s_cnt_char = "101" and shift_reg = "11100") then --2
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='1';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "11000") then --3
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='1';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "10000") then --4
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='1';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "00000") then --5
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='1';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "00001") then --6
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "00011") then --7
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='1';
--			number(5) <='1';
--			number(6) <='1';

--		elsif (s_cnt_char = "101" and shift_reg = "00111") then --8
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "101" and shift_reg = "01111") then --9
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='1';
--			number(5) <='0';
--			number(6) <='0';

--		--pismena

--		elsif (s_cnt_char = "010" and shift_reg = "10000") then --A
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "00010") then --b
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "01010") then --C
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='1';

--		elsif (s_cnt_char = "011" and shift_reg = "00100") then --d
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "001" and shift_reg = "00000") then --E
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "01000") then --F
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "011" and shift_reg = "01100") then --G
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "00000") then --H
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "010" and shift_reg = "00000") then --I
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='1';

--		elsif (s_cnt_char = "100" and shift_reg = "11100") then --J
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='1';

--		elsif (s_cnt_char = "100" and shift_reg = "00100") then --L
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='1';

--		elsif (s_cnt_char = "010" and shift_reg = "01000") then --n
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "011" and shift_reg = "11100") then --o
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "01100") then --P
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='1';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "011" and shift_reg = "01000") then --r
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='1';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';

--		elsif (s_cnt_char = "011" and shift_reg = "00000") then --S
--			number(0) <='0';
--			number(1) <='1';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='1';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "011" and shift_reg = "10000") then --U
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='0';
--			number(6) <='1';

--		elsif (s_cnt_char = "100" and shift_reg = "11010") then --y
--			number(0) <='1';
--			number(1) <='0';
--			number(2) <='0';
--			number(3) <='0';
--			number(4) <='1';
--			number(5) <='0';
--			number(6) <='0';

--		elsif (s_cnt_char = "100" and shift_reg = "00110") then --Z
--			number(0) <='0';
--			number(1) <='0';
--			number(2) <='1';
--			number(3) <='0';
--			number(4) <='0';
--			number(5) <='1';
--			number(6) <='0';	
			
			
--		else 
--			number(0) <='1';
--			number(1) <='1';
--			number(2) <='1';
--			number(3) <='1';
--			number(4) <='1';
--			number(5) <='1';
--			number(6) <='1';	
			
--       	end if;
--      end if;
--    end process p_translate;
    
    --volba displeje
    
    
--    --zapisování na displej
--    p_display : process(s_dis)
--    begin
    
--    	if (s_dis = 1) then
--        	DIS_1 <= number;
--        	AN(0) <= '1';
        
--        elsif (s_dis = 2) then
--        	DIS_2 <= number;
--            AN(1) <= '1';
            
--        elsif (s_dis = 3) then
----        	DIS_3 <= number;
--            AN(2) <= '1';
            
--        elsif (s_dis = 4) then
--        	DIS_4 <= number;
--            AN(3) <= '1';
            
--        elsif (s_dis = 5) then
--        	DIS_5 <= number;
--            AN(4) <= '1';
            
--        end if;        
--    end process p_display;
    DIS <= number;
    

end Behavioral;
