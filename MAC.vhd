----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2022 08:51:46 PM
-- Design Name: 
-- Module Name: MAC - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC is
 Port (
    num1 :  in      std_logic_vector (7 downto 0) := "00000000";
    num2 :  in      std_logic_vector (7 downto 0) := "00000000";
    clk:    in      std_logic                     := '0';
    accum_inp:  in  std_logic_vector (15 downto 0):= "0000000000000000";
    cont:   in      std_logic                     := '0';
    accum_out:  out std_logic_vector (15 downto 0):= "0000000000000000"  
  );
end MAC;

architecture Behavioral of MAC is

signal      initial_product     :       std_logic_vector (15 downto 0)  :=  "0000000000000000";
signal      accum_product       :       std_logic_vector (16 downto 0)  :=  "00000000000000000";
signal      counter             :       integer :=  0;
signal      accum_inp_16        :       std_logic_vector (16 downto 0)  :=  "00000000000000000";
signal      initial_16          :       std_logic_vector (16 downto 0)  :=  "00000000000000000";

begin
    temporary: process(clk) is
    begin
        if rising_edge(clk) and cont='1' then
            counter <= (counter + 1) mod 20;
            case counter is
                when 1 =>
                    initial_product <=  num1*num2;
                when 17 =>
                    index_loop1: for ind1 in 0 to 15 loop
                        accum_inp_16(ind1)    <=  accum_inp(ind1);
                    end loop index_loop1;
                when 18 =>
                    accum_product   <=  accum_inp_16   +   initial_16;
                when 19 =>
                    index_loop2: for ind2 in 0 to 15 loop
                        initial_16(ind2)   <=  initial_product(ind2);
                    end loop index_loop2;
                when 0 =>
                    index_loop: for ind in 0 to 15 loop
                        accum_out(ind)    <=  accum_product(ind);
                    end loop index_loop;
                when others =>
                    NULL;
            end case;
        end if;
    end process;
end Behavioral;
