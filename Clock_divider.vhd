----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2022 16:11:32
-- Design Name: 
-- Module Name: Clock_divider - Behavioral
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

entity Clock_divider is
  Port (inp_clk : in std_logic;
        out_clk : out std_logic:='0');
end Clock_divider;

architecture Behavioral of Clock_divider is
 signal x: std_logic := '0';
 signal a,b: integer :=0;
-- x <= '0';
begin
b<=500000;
process
begin
--if rising_edge(inp_clk) then
--    if a/=50 then
--        a<= a+1;
--    elsif x='0' then
--        x<='1';
--        a<=0;
--        out_clk<='1';
--    elsif x='1' then
--        x<='0';
--        a<=0;
--        out_clk<='0';
--    end if; 
--end if;
if (rising_edge(inp_clk)) then
    if (a<b/2-1) then
        a<=a+1;
        out_clk<='0';
    elsif (a<b-1) then
        a<=a+1;
        out_clk<='1';
    else
        out_clk<='0';
        a<=0;
    end if;
end if;
wait on inp_clk;
end process;
end Behavioral;
