----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2022 10:08:53 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity Prac is
  Port (
        clk :   in  std_logic   :=  '0';
        enable: in  std_logic   :=  '0';
        light:  out std_logic   :=  '0'
         );
end Prac;

architecture Behavioral of Prac is

COMPONENT dist_mem_gen_0 is
PORT(
clk : IN STD_LOGIC;
a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

COMPONENT dist_mem_gen_2 is
PORT(
clk : IN STD_LOGIC;
a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

COMPONENT reg1 is
  Port (
wr: in std_logic;
clk: in std_logic;
reset: in std_logic;
inp: in std_logic_vector (7 downto 0);
op: out std_logic_vector (7 downto 0));
end component;

component reg16 is
  Port (
  wr: in std_logic;
  clk: in std_logic;
  reset: in std_logic;
  inp: in std_logic_vector (15 downto 0);
  op: out std_logic_vector (15 downto 0));
end component;

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

component dist_mem_gen_1 is
PORT(
clk : IN STD_LOGIC;
we  :   in std_logic    :=  '0';
a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
d   :   in  std_logic_vector (15 downto 0);
spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

signal a, b, c : integer := 0;

signal rom1_add, rom2_add : std_logic_vector (13 downto 0) := "00000000000000";
signal rom1_out, rom2_out : std_logic_vector (7 downto 0) := "00000000";

signal wr_reg1, reset_reg1 : std_logic := '0';
signal mac_inp1, mac_inp2 : std_logic_vector (7 downto 0) := "00000000";
signal mac_cont : std_logic := '0';
signal mac_accum_inp, mac_accum_out : std_logic_vector (15 downto 0) := "0000000000000000";

signal wr_reg16, reset_reg16 : std_logic := '0'; 

signal ram_add : std_logic_vector (13 downto 0) := "00000000000000";
signal ram_inp : std_logic_vector (15 downto 0) := "0000000000000000";
signal ram_out : std_logic_vector (15 downto 0) := "0000000000000000";
signal we_ram  : std_logic := '0';

begin

--port maps
UUT_ROM1 :   dist_mem_gen_0  port map     (clk=>clk,  a => rom1_add,  spo => rom1_out);
UUT_ROM2 :   dist_mem_gen_2  port map     (clk=>clk,  a => rom2_add,  spo => rom2_out);

UUT_reg1 :   reg1            port map     (wr => wr_reg1, clk => clk, reset => reset_reg1, inp => rom1_out, op => mac_inp1);
UUT_reg2 :   reg1            port map     (wr => wr_reg1, clk => clk, reset => reset_reg1, inp => rom2_out, op => mac_inp2);

UUT_MAC :    MAC             port map     (num1 => mac_inp1, num2 => mac_inp2, clk => clk, accum_inp => mac_accum_inp, cont => mac_cont, accum_out => mac_accum_out);

UUT_reg16 :  reg16           port map     (wr => wr_reg16, clk => clk, reset => reset_reg16, inp => mac_accum_out, op => mac_accum_inp);

UUT_RAM :    dist_mem_gen_1  port map     (clk=>clk, we => we_ram, a => rom1_add,  d => ram_inp, spo => ram_out);

process(clk)
begin
if rising_edge(clk) and enable = '1' then
--    a <= (a + 1);
    if b = 259 then 
        c <= c + 1;
        
    end if;
    b <= (b + 1) mod 260;
--    b <= b mod 260;
--    c <= (a - (a mod 260)) / 260;
    
end if;
end process;
end Behavioral;
