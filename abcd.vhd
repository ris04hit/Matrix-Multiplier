----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2022 18:32:31
-- Design Name: 
-- Module Name: abcd - Behavioral
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

entity seven_segment_decoder is
  Port ( a, b, c, d : in std_logic;
         x, y, z, w, p, q, r : out std_logic;
         an : out std_logic_vector (3 downto 0) );
end seven_segment_decoder;

architecture Behavioral of seven_segment_decoder is
begin
      an(0) <= '0';
      an(1) <= '1';
      an(2) <= '1';
      an(3) <= '1';
      x<= (a and b and not c and d) or (not a and b and not c and not d)  or (not a and not b and not c and d) or (a and not b and c and d);
      y<= (a and c and d) or (not a and b and not c and d) or (not a and b and not c and d) or (not a and b and c and not d) or (a and b and not c and not d);
      z<= (a and b and not d) or (a and b and c) or ( not a and not b and c and not d);
      w<= (b and c and d) or (not a and not b and not c and d) or (not a and b and not c and not d);
      p<= (not a and d) or (not b and not c and d) or (not a and b and not c);
      q<= (not a and not b and d) or (not b and c and not d) or (not a and c and d) or (a and b and not c and d);
      r<= (not a and not b and not c)  or (not a and b and c and d) or (a and b and not c and not d);


end Behavioral;
