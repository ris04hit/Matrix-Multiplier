----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2022 01:02:50 AM
-- Design Name: 
-- Module Name: final_part - Behavioral
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

entity final_part is
  Port ( d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16 : in std_logic:='0';
         clk : in std_logic;
         an: out std_logic_vector (3 downto 0):="0111";
--         m : out std_logic;
         o1, o2, o3, o4, o5, o6, o7 : out std_logic:='0');
end final_part;
--signal s1, s2, s3, s4, s5, s6, s7
architecture Behavioral of final_part is
component Clock_divider 
Port (inp_clk : in std_logic;
        out_clk : out std_logic);
end component;
component Multiplex
Port (m1, m2,m3, m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16, c1, c2 : in std_logic;
        output1: out std_logic_vector (3 downto 0) );
end component;
component seven_segment_decoder
Port ( a, b, c, d : in std_logic;
         x, y, z, w, p, q, r : out std_logic;
         an : out std_logic_vector (3 downto 0) );
end component;
signal out_clk, s3, s4: std_logic := '0'; 
signal c2, c1 : std_logic := '0';
signal s5: std_logic_vector (3 downto 0);
signal s6: std_logic_vector (3 downto 0);
signal q: integer:=0;
begin    
UUTa : Clock_divider port map(inp_clk => clk, out_clk => out_clk);
UUTb : Multiplex port map(m1 => d1, m2=> d2, m3=> d3, m4=>d4, m5=>d5, m6=>d6, m7=>d7, m8=>d8, m9=>d9, m10=>d10, m11=>d11, m12=>d12, m13=>d13, m14=>d14, m15=>d15, m16=>d16,c1=>c1, c2=>c2, output1=>s5);
UUTc : seven_segment_decoder port map(a => s5(0), b=>s5(1), c=>s5(2), d=>s5(3), x=>o1, y=>o2,z=>o3,w=>o4,p=>o5,q=>o6,r=>o7, an => s6);
--m<=out_clk;
process(out_clk)
begin
if rising_edge(out_clk) then
    if q=0 then
        c1<='0';
        c2<='0';
        an<="1110";
        q<=1;
    elsif q=1 then
        c1<='0';
        c2<='1';
        an<="1101";
        q<=2;
    elsif q=2 then
        c1<='1';
        c2<='0';
        an<="1011";
        q<=3;
    else
        c1<='1';
        c2<='1';
        an<="0111";
        q<=0;
    end if;
end if;
end process;
end Behavioral;
