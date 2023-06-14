----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 02:44:11 PM
-- Design Name: 
-- Module Name: Matrix_Multiplier_tb - tb
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

entity Matrix_Multiplier_tb is
--  Port ( );
end Matrix_Multiplier_tb;

architecture tb of Matrix_Multiplier_tb is

component Matrix_Multiplier is
  Port (
      clk :   in  std_logic                           :=  '0';
      start : in std_logic                            :=  '0';
      add_enable : in std_logic                       :=  '0';
      add :   in  std_logic_vector    (13 downto 0)   :=  "00000000000000";
      an  :   out std_logic_vector    (3 downto 0)    :=  "0111";
      ca  :   out std_logic_vector    (6 downto 0)    :=  "0000000";
      light : out std_logic                           :=  '0'
       );
end component;

signal      clk :   std_logic                           :=  '0';
signal      start : std_logic                            :=  '0';
signal      add_enable : std_logic                       :=  '0';
signal      add :   std_logic_vector    (13 downto 0)   :=  "00000000000000";
signal      an  :   std_logic_vector    (3 downto 0)    :=  "0111";
signal      ca  :   std_logic_vector    (6 downto 0)    :=  "0000000";
signal      light : std_logic                           :=  '0';

begin

uut :   Matrix_Multiplier   port map (clk => clk, start => start, add_enable => add_enable, add => add, an => an, ca => ca, light => light);

clk <= not clk after 10 ns;
start <= '0', '1' after 50 ns;
add_enable <= '0', '1' after 65000 ns;
add <= "00000000000000", "11111111111111" after 70000 ns;

end tb;
