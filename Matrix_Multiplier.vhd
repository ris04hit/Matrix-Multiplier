----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 01:06:13 PM
-- Design Name: 
-- Module Name: Matrix_Multiplier - Behavioral
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

entity Matrix_Multiplier is
  Port (
        clk :   in  std_logic                           :=  '0';
        start : in std_logic                            :=  '0';
        add_enable : in std_logic                       :=  '0';
        add :   in  std_logic_vector    (13 downto 0)   :=  "00000000000000";
        an  :   out std_logic_vector    (3 downto 0)    :=  "0111";
        ca  :   out std_logic_vector    (6 downto 0)    :=  "0000000";
        light : out std_logic                           :=  '0'
         );
end Matrix_Multiplier;

architecture Behavioral of Matrix_Multiplier is

component fsm is
  Port (
      clk :   in  std_logic   :=  '0';
      enable: in  std_logic   :=  '0';
      RAM_read_add : in std_logic_vector (13 downto 0)    :=  "00000000000000";
      light:  out std_logic   :=  '0';
      RAM_read_out : out std_logic_vector (15 downto 0)   :=  "0000000000000000"
       );
end component;

--component dist_mem_gen_1 is
--    PORT(
--        clk : IN STD_LOGIC;
--        we  :   in std_logic    :=  '0';
--        a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
--        d   :   in  std_logic_vector (15 downto 0);
--        spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
--        );
--end component;

component final_part is
  Port ( d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16 : in std_logic:='0';
       clk : in std_logic;
       an: out std_logic_vector (3 downto 0):="0111";
--         m : out std_logic;
       o1, o2, o3, o4, o5, o6, o7 : out std_logic:='0');
end component;

--signal
signal RAM_out   :   std_logic_vector    (15 downto 0)   :=  "0000000000000000";
signal RAM_output :  std_logic_vector    (15 downto 0)   :=  "0000000000000000";
--signal ca           :   std_logic_vector    (6  downto 0)   :=  "0000000";

begin

uut_fsm :   fsm port map (clk => clk, enable => start, light => light, RAM_read_add=>add, RAM_read_out=>RAM_out);
--UUT_RAM :   dist_mem_gen_1  port map    (clk=>clk,   a=>add  ,  spo=> RAM_out,  we=>'0', d=>"0000000000000000");
UUT_part :  final_part      port map    (d1=>RAM_output(0), d2=>RAM_output(1), d3=>RAM_output(2), d4=>RAM_output(3), d5=>RAM_output(4), d6=>RAM_output(5), d7=>RAM_output(6), d8=>RAM_output(7), d9=>RAM_output(8), d10=>RAM_output(9), d11=>RAM_output(10), d12=>RAM_output(11), d13=>RAM_output(12), d14=>RAM_output(13), d15=>RAM_output(14), d16=>RAM_output(15), clk=> clk, an=>an, o1=>ca(0), o2=>ca(1), o3=>ca(2), o4=>ca(3), o5=>ca(4), o6=>ca(5), o7=>ca(6));

process(clk)
begin
    if rising_edge(clk) then
        if add_enable = '1' then
            RAM_output <=   RAM_out;
--        else
--            RAM_output <=   "0000000000000000";
        end if;
    end if;
end process;

end Behavioral;
