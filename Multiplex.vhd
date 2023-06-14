----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2022 10:43:00 PM
-- Design Name: 
-- Module Name: Multiplex - Behavioral
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

entity Multiplex is
  Port (m1, m2,m3, m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16, c1, c2 : in std_logic;
        output1: out std_logic_vector (3 downto 0) );
end Multiplex;

architecture Behavioral of Multiplex is

begin   


        output1 <= (m1, m2,m3,m4) when c1 = '0'and c2 =  '0' else
                   (m5, m6, m7, m8) when c1 = '0'and c2 =  '1' else
                   (m9, m10, m11, m12) when c1 = '1'and c2 =  '0'else
                   (m13, m14, m15, m16);

end Behavioral;
