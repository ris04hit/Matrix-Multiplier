----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2022 11:00:06 PM
-- Design Name: 
-- Module Name: MAC_tb - tb
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

entity MAC_tb is
--  Port ( );
end MAC_tb;

architecture tb of MAC_tb is
component MAC is
 Port (
   num1 :  in      std_logic_vector (7 downto 0) := "00000000";
   num2 :  in      std_logic_vector (7 downto 0) := "00000000";
   clk:    in      std_logic                     := '0';
   accum_inp:  in  std_logic_vector (15 downto 0):= "0000000000000000";
   cont:   in      std_logic                     := '0';
   accum_out:  out std_logic_vector (15 downto 0):= "0000000000000000"  
 );
 end component;
 
signal num1, num2 : std_logic_vector (7 downto 0);
signal clk, cont  : std_logic:='1';
signal accum_inp, accum_out : std_logic_vector (15 downto 0);
 
begin

uut : MAC port map (num1 => num1, num2 => num2, clk => clk, cont => cont, accum_inp => accum_inp, accum_out => accum_out);

num1 <= "00001101";
num2 <= "00000111";
clk <=  not clk after 10 ns;
cont <= '1', '0' after 500 ns;
accum_inp <= "0100000001000000";

end tb;
