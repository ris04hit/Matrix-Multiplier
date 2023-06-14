----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 02:02:10 AM
-- Design Name: 
-- Module Name: FSM_tb - tb
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

entity FSM_tb is
--  Port ( );
end FSM_tb;

architecture tb of FSM_tb is

component fsm is
  Port (
      clk :   in  std_logic   :=  '0';
      enable: in  std_logic   :=  '0';
      RAM_read_add : in std_logic_vector (13 downto 0)    :=  "00000000000000";
      light:  out std_logic   :=  '0';
      RAM_read_out : out std_logic_vector (13 downto 0)   :=  "00000000000000"
       );
end component;

signal clk  :   std_logic   :=  '0';
signal enable   :   std_logic   :=  '0';
signal light    : std_logic :=  '0';


begin
uut :   fsm port map (clk => clk, enable => enable, light => light);

clk <= not clk after 10 ns;
enable <= '0', '1' after 50 ns;

end tb;
