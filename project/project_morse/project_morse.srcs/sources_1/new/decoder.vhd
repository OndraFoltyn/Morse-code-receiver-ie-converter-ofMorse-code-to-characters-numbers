library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder is
	generic(
        ch_MAX : natural := 6;
        g_MAX  : natural := 25000000
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
--           AN           : out STD_LOGIC_VECTOR (7 downto 0);
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
    
    p_cnt : process(clk)
    begin
   		if rising_edge(clk) then
        	
            if (reset = '1' or inp_mez = '1') then
            
                s_counter <= 0;
                
            elsif (inp = '1') then
                    s_counter<= s_counter + 1;
                    
              
            end if;
        end if;
	 end process p_cnt;
     
	-- counter znaku
	 p_countchar : process(clk, inp_tran, reset, inp_mez)
     begin
     
        if (inp_tran = '1' or reset = '1') then
           s_cnt_char <= "000";
        
     	elsif inp_mez='1' then
          	s_cnt_char <= s_cnt_char + "001";     
          	 
        elsif (s_cnt_char >= (ch_MAX - 1)) then
             s_cnt_char <= "001";  
             
         end if; 
     
     end process p_countchar;
     char_o <= s_cnt_char;

	 p_out_counter : process(s_counter)
     begin
        
           if (s_counter >= 3000000) then
                seg_o <= '1'; -- carka
                
                
           elsif(s_counter < 3000000) then
                seg_o <= '0'; -- tecka
               
        end if;
     end process p_out_counter;
    
   
    
    -- shift register
    p_shift : process (inp_mez)
    begin
        if inp_mez = '1' then
        	

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
        if inp_mez = '1' then
            
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
    
    p_clear_led : process(reset, inp_tran, inp_mez)
    begin 
    	if (reset = '1' or inp_tran = '1') then
        LED <= "000000000000000";
        
        
        elsif inp_mez= '1' then
    	
        LED <= shift_led;
        
        end if;
   end process p_clear_led;
    
    DIS <= number;
    

end Behavioral;
