----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2022 01:25:49 PM
-- Design Name: 
-- Module Name: shift_register - Behavioral
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

entity shift_register is
    Port ( click : in STD_LOGIC;
           reset : in STD_LOGIC;
           shift_i : in STD_LOGIC;
           seg_o : in std_logic);
end shift_register;

architecture Behavioral of shift_register is
    signal s_q_0 :std_logic;
    signal s_q_1 :std_logic;
    signal s_q_2 :std_logic;
    signal s_q_3 :std_logic;
    signal s_q_4 :std_logic;
begin
    d_ff_0 : entity work.d_ff_rst
        port map(
            click => click,
            rst => reset,
            d   => seg_o,
            q   => s_q_0,
            q_bar => open
        );
        
        d_ff_1 : entity work.d_ff_rst
        port map(
            click => click,
            rst => reset,
            d   => s_q_0,
            q   => s_q_1,
            q_bar=>open
        );
        
        d_ff_2 : entity work.d_ff_rst
        port map(
            click => click,
            rst => reset,
            d   => s_q_1,
            q   => s_q_2,
            q_bar => open
        );
        
        d_ff_3 : entity work.d_ff_rst
        port map(
            click => click,
            rst => reset,
            d   => s_q_2,
            q   => s_q_3,
            q_bar=> open
        );
        
        d_ff_4 : entity work.d_ff_rst
        port map(
            click => click,
            rst => reset,
            d   => s_q_3,
            q   => s_q_4,
            q_bar => open
        );

end Behavioral;
