----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2022 11:18:54 AM
-- Design Name: 
-- Module Name: hex_7seg - Behavioral
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

entity hex_7seg is
    Port (
           DIS : in STD_LOGIC_VECTOR (6 - 1 downto 0);
           seg2_o : out STD_LOGIC_VECTOR (8 - 1 downto 0);
  
           dp_o  : out std_logic;
           dig_o : out std_logic_vector(8 - 1 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is
    signal s_hex   : std_logic_vector(6 - 1 downto 0);
    signal data0_i : std_logic_vector(6 - 1 downto 0);
    signal data1_i : std_logic_vector(6 - 1 downto 0);
    signal data2_i : std_logic_vector(6 - 1 downto 0);
    signal data3_i : std_logic_vector(6 - 1 downto 0);
    signal data4_i : std_logic_vector(6 - 1 downto 0);
    signal data5_i : std_logic_vector(6 - 1 downto 0);
    signal data6_i : std_logic_vector(6 - 1 downto 0);
    signal data7_i : std_logic_vector(6 - 1 downto 0);
begin
    --------------------------------------------------------
    p_7seg_decoder : process(DIS)
    begin
        case DIS is
            when "000000" =>
                seg2_o <= "10000001"; -- 0
            when "000001" =>
                seg2_o <= "11001111"; -- 1
            when "000010" =>
                seg2_o <= "10010010"; -- 2
            when "000011" =>
                seg2_o <= "10000110"; -- 3
            when "000100" =>
                seg2_o <= "11001100"; -- 4
            when "000101" =>
                seg2_o <= "10100100"; -- 5
            when "000110" =>
                seg2_o <= "10100000"; -- 6
            when "000111" =>
                seg2_o <= "10001111"; -- 7
            when "001000" =>
                seg2_o <= "10000000"; -- 8
            when "001001" =>
                seg2_o <= "10000100"; -- 9
            when "001010" =>
                seg2_o <= "10001000"; -- A
            when "001011" =>
                seg2_o <= "11100000"; -- b
            when "001100" =>
                seg2_o <= "10110001"; -- C
            when "001101" =>
                seg2_o <= "11000010"; -- d
            when "001110" =>
                seg2_o <= "10110000"; -- E
            when "001111" =>
                seg2_o <= "10111000"; -- F
            when "010000" =>
                seg2_o <= "10100001"; -- G
            when "010001" =>
                seg2_o <= "11101000"; -- h
            when "010010" =>
                seg2_o <= "11111001"; -- I
            when "010011" =>
                seg2_o <= "11000011"; -- J
            when "010100" =>
                seg2_o <= "10101000"; -- k
            when "010101" =>
                seg2_o <= "11110001"; -- L
            when "010110" =>
                seg2_o <= "10101011"; -- m
            when "010111" =>
                seg2_o <= "10001001"; -- N
            when "011000" =>
                seg2_o <= "10000001"; -- O
            when "011001" =>
                seg2_o <= "10011000"; -- P
            when "011010" =>
                seg2_o <= "10001100"; -- q
            when "011011" =>
                seg2_o <= "10011001"; -- r
            when "011100" =>
                seg2_o <= "10100100"; -- S
            when "011101" =>
                seg2_o <= "11110000"; -- t
            when "011110" =>
                seg2_o <= "11000001"; -- U
            when "011111" =>
                seg2_o <= "11000101"; -- V
            when "100000" =>
                seg2_o <= "11010101"; -- W
            when "100001" =>
                seg2_o <= "11001000"; -- X
            when "100010" =>
                seg2_o <= "11000100"; -- Y
            when "100011" =>
                seg2_o <= "10010110"; -- Z
            when others =>
                seg2_o <= "00000000"; -- Error, brain is missing   
        end case;
    end process p_7seg_decoder;
    

end architecture Behavioral;