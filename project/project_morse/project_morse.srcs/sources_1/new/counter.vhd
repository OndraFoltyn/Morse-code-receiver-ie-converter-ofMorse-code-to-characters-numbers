----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2022 02:12:30 PM
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
--  Port ( );
 Port (     ce_o : in STD_LOGIC;
            inp_mez : in STD_LOGIC;
            inp : in STD_LOGIC;
            seg_o : out std_logic_vector(1 downto 0);
            reset : in STD_LOGIC);
end counter;

architecture Behavioral of counter is
        signal s_counter : natural;
begin
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

	 p_out_counter : process(s_counter)
     begin
        
           if (s_counter >= 3) then
                seg_o <= "1"; -- èárka
           else
                seg_o <= "0"; -- teèka
                
        end if;
     end process p_out_counter;

end Behavioral;
