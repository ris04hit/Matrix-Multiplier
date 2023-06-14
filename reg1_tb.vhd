----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2022 04:28:52 PM
-- Design Name: 
-- Module Name: reg1_tb - tb
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

entity reg1_tb is
--  Port ( );
end reg1_tb;

architecture tb of reg1_tb is
component reg1 is
  Port (
wr: in std_logic;
clk: in std_logic;
reset: in std_logic;
inp: in std_logic_vector (7 downto 0);
op: out std_logic_vector (7 downto 0));
end component;
signal wr, clk, reset :  std_logic := '0';
signal op : std_logic_vector (7 downto 0); 
signal inp : std_logic_vector (7 downto 0) := "00000000"; 
begin
UUT : reg1 port map (wr => wr, clk => clk, reset => reset, inp => inp, op => op);

clk <= not clk after 20 ns;
wr <= '0', '1' after 70 ns,'0' after 130 ns, '1' after 230 ns;
reset <= '0', '1' after 170 ns, '0' after 210 ns;
inp <= "00000000", "00001010" after 50 ns, "00010111" after 150 ns;
 

end tb;
