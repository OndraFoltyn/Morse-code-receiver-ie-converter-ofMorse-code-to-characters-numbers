library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder is
	generic(
        g_MAX : natural := 10;
        d_MAX : natural := 7;
        ch_MAX : natural := 6
        );  
    
    Port ( inp_mez : in  STD_LOGIC;
           clk     : in  std_logic;
           reset   : in  std_logic;
           inp	   : in	std_logic;
           LED 	   : out STD_LOGIC_VECTOR(14 downto 0);
           DIS_1	   : out STD_LOGIC_VECTOR(6 downto 0);
           DIS_2	   : out STD_LOGIC_VECTOR(6 downto 0);
           DIS_3	   : out STD_LOGIC_VECTOR(6 downto 0);
           DIS_4	   : out STD_LOGIC_VECTOR(6 downto 0);
           DIS_5	   : out STD_LOGIC_VECTOR(6 downto 0);
           inp_tran : in std_logic;
           AN         : out STD_LOGIC_VECTOR (7 downto 0)
           );
           
end decoder;
    
architecture Behavioral of decoder is

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

    -- clock
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
            
                s_counter <= 0;
                
            
            elsif (inp_mez = '1') then
                s_counter <= 0;
                
            elsif (inp = '1') then
                    s_counter<= s_counter + 1;
                    
              
            end if;
        end if;
	 end process p_cnt;
     
	-- counter znaku
	 p_countchar : process(inp, inp_tran)
     begin
        if rising_edge(inp_tran) then
           s_cnt_char<=0;
        end if;
        
     	if rising_edge(inp) then
                
            if (s_cnt_char >= (ch_MAX - 1)) then
                s_cnt_char <= 1;  
            
            else
             	s_cnt_char <= s_cnt_char + 1;
            end if;
        end if;  
     end process p_countchar;
     

	 p_out_counter : process(s_counter)
     begin
        
           if (s_counter >= 3) then
                seg_o <= '1'; -- èárka
                
                
           elsif(s_counter < 3 and s_counter > 0) then
                seg_o <= '0'; -- teèka
               
        end if;
     end process p_out_counter;
    
   
    
    -- shift register
    p_shift : process (inp_mez)
    begin
        if rising_edge(inp_mez) then
        	

            shift_reg(4) <= seg_o;
            shift_reg(3) <= shift_reg(4);
            shift_reg(2) <= shift_reg(3);
            shift_reg(1) <= shift_reg(2);
            shift_reg(0) <= shift_reg(1);
            
            
        end if;
    end process p_shift;
    
    --vstupní led
    p_led : process (s_counter)
    begin
    	
            if (s_counter > 0 and s_counter < 3) then 
            	s_led(0) <= '1';
                s_led(1) <= '0';
                s_led(2) <= '0';
                
            elsif (s_counter >= 3) then 
            	s_led(0) <= '1';
                s_led(1) <= '1';
                s_led(2) <= '0';
            end if;
        
    end process p_led;
    
     -- shift led
    p_shift_led : process (inp_mez, inp_tran)
    begin
        if rising_edge(inp_mez) then
            
          shift_led(14) <= s_led(0);
          shift_led(13) <= s_led(1);
          shift_led(12) <= s_led(2);
          
          shift_led(11) <= shift_led(14);
          shift_led(10) <= shift_led(13);
          shift_led(9) <= shift_led(12);
          
          shift_led(8) <= shift_led(11);
          shift_led(7) <= shift_led(10);
          shift_led(6) <= shift_led(9);
          
          shift_led(5) <= shift_led(8);
          shift_led(4) <= shift_led(7);
          shift_led(3) <= shift_led(6);
          
          shift_led(2) <= shift_led(5);
          shift_led(1) <= shift_led(4);
          shift_led(0) <= shift_led(3);
          
        elsif (rising_edge(inp_tran) or reset = '1') then
        shift_led <= "000000000000000";
        
        end if;
    end process p_shift_led;
    
    p_clear_led : process(reset, inp_tran, inp_mez)
    begin 
    	if (reset = '1' or falling_edge(inp_tran)) then
        LED <= "000000000000000";
        
        
        elsif falling_edge(inp_mez) then
    	
        LED<= shift_led;
        
        end if;
   end process p_clear_led;
    
    p_translate : process(inp_tran)
    begin
    	
    	if rising_edge(inp_tran) then
                
             --čísla
		if (s_cnt_char = 5 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='1' and shift_reg(0)='1') then --0
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='1';

		elsif (s_cnt_char = 5 and shift_reg(4)='0' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='1' and shift_reg(0)='1') then --1
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='1';
			number(4) <='1';
			number(5) <='1';
			number(6) <='1';

		elsif (s_cnt_char = 5 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='1' and shift_reg(1)='1' and shift_reg(0)='1') then --2
			number(0) <='0';
			number(1) <='0';
			number(2) <='1';
			number(3) <='0';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='1' and shift_reg(0)='1') then --3
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='1';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='0' and shift_reg(0)='1') then --4
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='1';
			number(4) <='1';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='0' and shift_reg(0)='0') then --5
			number(0) <='0';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='1';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='1' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='0' and shift_reg(0)='0') then --6
			number(0) <='0';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='0' and shift_reg(1)='0' and shift_reg(0)='0') then --7
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='1';
			number(4) <='1';
			number(5) <='1';
			number(6) <='1';

		elsif (s_cnt_char = 5 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='0' and shift_reg(0)='0') then --8
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 5 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='1' and shift_reg(0)='0') then --9
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='1';
			number(5) <='0';
			number(6) <='0';

		--pismena

		elsif (s_cnt_char = 2 and shift_reg(4)='0' and shift_reg(3)='1') then --A
			number(0) <='0';
			number(1) <='0';
			number(2) <='0';
			number(3) <='1';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='1' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='0') then --b
			number(0) <='1';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='1' and shift_reg(3)='0' and shift_reg(2)='1' and shift_reg(1)='0') then --C
			number(0) <='0';
			number(1) <='1';
			number(2) <='1';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='1';

		elsif (s_cnt_char = 3 and shift_reg(4)='1' and shift_reg(3)='0' and shift_reg(2)='0') then --d
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 1 and shift_reg(4)='0') then --E
			number(0) <='0';
			number(1) <='1';
			number(2) <='1';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='1'and shift_reg(1)='0') then --F
			number(0) <='0';
			number(1) <='1';
			number(2) <='1';
			number(3) <='1';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 3 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='0') then --G
			number(0) <='0';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='0' and shift_reg(1)='0') then --H
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='1';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 2 and shift_reg(4)='0' and shift_reg(3)='0') then --I
			number(0) <='1';
			number(1) <='1';
			number(2) <='1';
			number(3) <='1';
			number(4) <='0';
			number(5) <='0';
			number(6) <='1';

		elsif (s_cnt_char = 4 and shift_reg(4)='0' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='1') then --J
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='1';
			number(6) <='1';

		elsif (s_cnt_char = 4 and shift_reg(4)='0' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='1') then --L
			number(0) <='1';
			number(1) <='1';
			number(2) <='1';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='1';

		elsif (s_cnt_char = 2 and shift_reg(4)='1' and shift_reg(3)='0') then --n
			number(0) <='1';
			number(1) <='1';
			number(2) <='0';
			number(3) <='1';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 3 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='1') then --o
			number(0) <='1';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='0' and shift_reg(3)='1' and shift_reg(2)='1' and shift_reg(1)='0') then --P
			number(0) <='0';
			number(1) <='0';
			number(2) <='1';
			number(3) <='1';
			number(4) <='0';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 3 and shift_reg(4)='0' and shift_reg(3)='1' and shift_reg(2)='0') then --r
			number(0) <='1';
			number(1) <='1';
			number(2) <='1';
			number(3) <='1';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';

		elsif (s_cnt_char = 3 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='0') then --S
			number(0) <='0';
			number(1) <='1';
			number(2) <='0';
			number(3) <='0';
			number(4) <='1';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 3 and shift_reg(4)='0' and shift_reg(3)='0' and shift_reg(2)='1') then --U
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='0';
			number(5) <='0';
			number(6) <='1';

		elsif (s_cnt_char = 4 and shift_reg(4)='1' and shift_reg(3)='0' and shift_reg(2)='1' and shift_reg(1)='1') then --y
			number(0) <='1';
			number(1) <='0';
			number(2) <='0';
			number(3) <='0';
			number(4) <='1';
			number(5) <='0';
			number(6) <='0';

		elsif (s_cnt_char = 4 and shift_reg(4)='1' and shift_reg(3)='1' and shift_reg(2)='0' and shift_reg(1)='0') then --Z
			number(0) <='0';
			number(1) <='0';
			number(2) <='1';
			number(3) <='0';
			number(4) <='0';
			number(5) <='1';
			number(6) <='0';	
			
			
		else 
			number(0) <='1';
			number(1) <='1';
			number(2) <='1';
			number(3) <='1';
			number(4) <='1';
			number(5) <='1';
			number(6) <='1';	
			
       	end if;
      end if;
    end process p_translate;
    
    --volba displeje
    p_dis_sel : process(inp_tran)
    begin
   		if rising_edge(inp_tran) then
        	
            if (reset = '1') then
            
                s_dis <= 0;
                
            
           	elsif (s_dis >= (d_MAX - 1)) then
                 s_dis <= 0;  
            
           	else
             	 s_dis <= s_dis + 1;
                    
              
            	
        	end if;
        end if;
	 end process p_dis_sel;
    
    --zapisování na displej
    p_display : process(s_dis)
    begin
    
    	if (s_dis = 1) then
        	DIS_1 <= number;
        	AN(0) <= '1';
        
        elsif (s_dis = 2) then
        	DIS_2 <= number;
            AN(1) <= '1';
            
        elsif (s_dis = 3) then
        	DIS_3 <= number;
            AN(2) <= '1';
            
        elsif (s_dis = 4) then
        	DIS_4 <= number;
            AN(3) <= '1';
            
        elsif (s_dis = 5) then
        	DIS_5 <= number;
            AN(4) <= '1';
            
        end if;        
    end process p_display;
    
	
    

end Behavioral;
