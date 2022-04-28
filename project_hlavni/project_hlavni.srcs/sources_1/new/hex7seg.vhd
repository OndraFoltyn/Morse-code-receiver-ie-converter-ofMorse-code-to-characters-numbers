----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2022 10:59:23 AM
-- Design Name: 
-- Module Name: hex7seg - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------
entity hex7seg is
    port(
        hex_i  : in  std_logic_vector(6 downto 0);
        seg2_o : out std_logic_vector(7 - 1 downto 0);
        rst    : in std_logic;
        char_i : in  std_logic_vector(2 downto 0);
        inp_tran : in std_logic;
        shift_reg_i : in std_logic_vector(4 downto 0)
    );
end entity hex7seg;
------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------
architecture Behavioral of hex7seg is
begin

    p_7seg_decoder : process(inp_tran)
   begin
        if inp_tran = '1' then
           
                case char_i is 
                    when "001" => -- if character output from decoder is 1
                        case shift_reg_i is
                            when "00000" => -- 
                                seg2_o <= "0110000";-- E .
                            when others =>
                                seg2_o <= "1111110"; -- -
                        end case;
                        
                    when "010" => -- 2 char
                        case shift_reg_i is
                            when "10000" => -- 
                                seg2_o <= "0001000";-- A .-
                            when others =>
                                seg2_o <= "1111110"; -- -
                        end case;
                        
                    when "011" => -- 3 char
                        case shift_reg_i is
                            when "00100" =>
                                seg2_o <= "1000010";-- d -..
                            when "10000" =>
                                seg2_o <= "1000001";-- U ..-
                            when "00000" =>
                                seg2_o <= "0100100";-- S ...
                            when others =>
                                seg2_o <= "1111110"; -- -
                        end case;
                        
                    when "100" =>  -- 4 char
                        case shift_reg_i is
                            when "00010" =>
                                seg2_o <= "1100000";-- b -...
                            when "01010" =>
                                seg2_o <= "0110001";-- C -.-.
                            when "01000" =>
                                seg2_o <= "0111000";-- F ..-.
                            when "01100" =>
                                seg2_o <= "0011000";-- P .--.
                            when "00100" =>
                                seg2_o <= "1110001";-- L .-..
                            when "00000" =>
                                seg2_o <= "1001000";-- H ....
                            when others =>
                                seg2_o <= "1111110"; -- -
                        end case;
                        
                    when "101" => -- 5 char
                          case shift_reg_i is
                            when "11111" =>
                                seg2_o <= "0000001";-- 0 -----
                            when "11110" =>
                                seg2_o <= "1001111";-- 1 .----
                            when "11100" =>
                                seg2_o <= "0010010";-- 2 ..---
                            when "11000" =>
                                seg2_o <= "0000110";-- 3 ...--
                            when "10000" =>
                                seg2_o <= "1001100";-- 4 ....-
                            when "00000" =>
                                seg2_o <= "0100100";-- 5 .....
                            when "00001" =>
                                seg2_o <= "0100000";-- 6 -....
                            when "00011" =>
                                seg2_o <= "0001111";-- 7 --...
                            when "00111" =>
                                seg2_o <= "0000000";-- 8 ---..
                            when "01111" =>
                                seg2_o <= "0000100";-- 9 ----.
                            when others =>
                                seg2_o <= "1111110"; -- -
                        end case;
                        when others =>
                        seg2_o <= "1111110";
                end case;
            end if;
    end process p_7seg_decoder;

end architecture Behavioral;
