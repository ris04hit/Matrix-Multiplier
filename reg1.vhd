----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2022 04:19:00 PM
-- Design Name: 
-- Module Name: reg1 - Behavioral
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

entity reg1 is
  Port (
  wr: in std_logic;
  clk: in std_logic;
  reset: in std_logic;
  inp: in std_logic_vector (7 downto 0);
  op: out std_logic_vector (7 downto 0));
end reg1;

architecture Behavioral of reg1 is

begin
    
process(clk) is
    begin
        if rising_edge(clk) then
            if (wr = '1') then 
                op <= inp;
            elsif(reset = '1') then
                op <= "00000000";
            end if;
        end if;
end process;
end Behavioral;
