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
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
  Port (
        clk :   in  std_logic   :=  '0';
        enable: in  std_logic   :=  '0';
        RAM_read_add : in std_logic_vector (13 downto 0)    :=  "00000000000000";
        light:  out std_logic   :=  '0';
        RAM_read_out : out std_logic_vector (15 downto 0)   :=  "0000000000000000"
         );
end FSM;

architecture Behavioral of FSM is

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
    
    
    --map signals
    signal ROM_address1 :   std_logic_vector    (13 downto 0)   :=  "00000000000000";
    signal ROM_output1  :   std_logic_vector    (7  downto 0)   :=  "00000000";
    signal ROM_address2 :   std_logic_vector    (13 downto 0)   :=  "00000000000000";
    signal ROM_output2  :   std_logic_vector    (7  downto 0)   :=  "00000000";
    signal RAM_address  :   std_logic_vector    (13 downto 0)   :=  "00000000000000";
    signal reg8_write   :   std_logic   :=  '0';
    signal reg8_reset   :   std_logic   :=  '1';
--    signal reg1_input   :   std_logic_vector    (7  downto  0)  :=  "00000000";
--    signal reg2_input   :   std_logic_vector    (7  downto  0)  :=  "00000000";
    signal reg1_output  :   std_logic_vector    (7  downto  0)  :=  "00000000";
    signal reg2_output  :   std_logic_vector    (7  downto  0)  :=  "00000000";
--    signal MAC_input1   :   std_logic_vector    (7  downto  0)  :=  "00000000";
--    signal MAC_input2   :   std_logic_vector    (7  downto  0)  :=  "00000000";
    signal MAC_control  :   std_logic   :=  '0';
    signal MAC_acc      :   std_logic_vector    (15 downto  0)  :=  "0000000000000000";
    signal MAC_output   :   std_logic_vector    (15 downto  0)  :=  "0000000000000000";
    signal reg16_output :   std_logic_vector    (15 downto  0)  :=  "0000000000000000";
    signal reg16_write  :   std_logic   :=  '0';
    signal reg16_reset  :   std_logic   :=  '1';
    signal RAM_output   :   std_logic_vector    (15 downto  0)  :=  "0000000000000000";
    signal RAM_write    :   std_logic   :=  '0';
    signal state        :   std_logic_vector    (7  downto  0)  :=  "00000000";
    signal light_sig    :   std_logic   :=  '0';
--    signal RAM_data     :   std_logic_vector    (15 downto  0)  :=  "0000000000000000";
    --intermediate signals
    signal counter      :   integer     :=  0;
    
    
    --functions
--    function address(col :  std_logic_vector (6  downto  0) :=  "0000000";
--                     row :  std_logic_vector (6  downto  0) :=  "0000000") return std_logic_vector (13 downto 0) is
--         variable add   :   std_logic_vector (13 downto  0) :=  "00000000000000";
--    begin
--    add :=  ((col  *   "1000000") +   row);
--    return add;
--    end function;

begin
--port maps
    UUT_ROM1 :   dist_mem_gen_0  port map    (clk=>clk,   a=>ROM_address1 ,  spo=> ROM_output1);
    UUT_ROM2 :   dist_mem_gen_2  port map    (clk=>clk,   a=>ROM_address2 ,  spo=> ROM_output2);
    UUT_reg1 :   reg1            port map    (wr=>reg8_write, clk=>clk, reset=>reg8_reset, inp=>ROM_output1, op=>reg1_output);
    UUT_reg2 :   reg1            port map    (wr=>reg8_write, clk=>clk, reset=>reg8_reset, inp=>ROM_output2, op=>reg2_output);
    UUT_MAC  :   MAC             port map    (num1=>reg1_output, num2=>reg2_output, clk=>clk, cont=>MAC_control, accum_inp=>MAC_acc, accum_out=>MAC_output);
    UUT_reg16 :  reg16           port map    (wr=>reg16_write, clk=>clk, reset=>reg16_reset, inp=>MAC_output, op=>reg16_output);
    UUT_RAM  :   dist_mem_gen_1  port map    (clk=>clk, we=>RAM_write ,a=>RAM_address, d=>reg16_output, spo=>RAM_output);
--process
--    Main_process    :   process
--        variable    column  :   std_logic_vector    (6  downto  0)  :=  "0000000";
--        variable    row     :   std_logic_vector    (6  downto  0)  :=  "0000000";
--        variable    index   :   std_logic_vector    (6  downto  0)  :=  "0000000";
--        variable    time    :   integer;
--    begin
--        wait on enable;
--        light   <=  '0';
--        if enable = '1' then
--            column_loop :   for column_int in 0 to 127 loop
--                row_loop :  for row_int in 0 to 127 loop
--                    column  :=  std_logic_vector( to_unsigned( column_int, 7));
--                    row     :=  std_logic_vector( to_unsigned( row_int, 7));
--                    RAM_address <= ((column *   "1000000")  +   (row    *   "0000001"));
--                    index_loop  :   for index_int in 0 to 127 loop
                        
--                        time    :=  counter;
--                        wait until counter = (time + 2);
                    
--                        RAM_write   <=  '0';
--                        reg16_reset <=  '1';
--                        index   :=  std_logic_vector( to_unsigned( index_int, 7));
--                        ROM_address1    <=  ((index *   "1000000")  +   (row    *   "0000001"));
--                        time    :=  counter;
--                        ROM_address2    <=  ((column*   "1000000")  +   (index  *   "0000001"));
--                        reg8_write  <=  '1';
--                        reg8_reset  <=  '0';
--                        wait until counter = (time + 2);
                        
--                        reg8_write  <=  '0';
--                        MAC_control <=  '1';
--                        time    :=  counter;
--                        wait until counter = (time + 21);
                        
--                        reg8_reset  <=  '1';
--                        MAC_control <=  '0';
--                        MAC_acc     <=  MAC_output;
                        
--                    end loop index_loop;
                    
--                    MAC_acc <=  "0000000000000000";
--                    reg16_reset <=  '0';
--                    reg16_write <=  '1';
--                    time    :=  counter;
--                    wait until counter = (time + 2);
                    
--                    reg16_write <=  '0';
--                    RAM_write   <=  '1';
--                    time    :=  counter;
--                    wait until counter = (time + 2);
                    
--                end loop row_loop;
--            end loop column_loop;
--        light   <=  '1';
--        end if;
--    end process;
    
    Clock_process   :   process (clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                if light_sig = '0' then
                    counter <=  (counter +   1) mod 3210;
                    if (counter = 3201) then
                        state <= "00010000";
                    elsif (counter = 3203) then
                        state <= "00001000";
                    elsif (counter = 3205) then
                        state <= "00000100";
                    elsif (counter mod 25) = 1 then
                        state <= "10000000";
                    elsif (counter mod 25) = 3 then
                        state <= "01000000";
                    elsif (counter mod 25) = 23 then
                        state <= "00100000";
                    end if;
                elsif state = "00000010" then
                    state <= "00000001";
                else
                    state <= "00000010";
                end if;
--            else
--                state <= "00000010";
--                counter <= 0;
            end if;
        end if;
    end process;
    
    State_process   :   process(state)
        variable column_int :   integer :=  0;
        variable row_int    :   integer :=  0;
        variable index_int  :   integer :=  0;
        variable    column  :   std_logic_vector    (6  downto  0)  :=  "0000000";
        variable    row     :   std_logic_vector    (6  downto  0)  :=  "0000000";
        variable    index   :   std_logic_vector    (6  downto  0)  :=  "0000000";
--        variable    time    :   integer;
    begin
        case state is
            when "10000000" =>
                RAM_address <= ((column *   "1000000")  +   (row    *   "0000001"));
                RAM_write   <=  '0';
                reg16_reset <=  '1';
                index   :=  std_logic_vector( to_unsigned( index_int, 7));
                ROM_address1    <=  ((index *   "1000000")  +   (row    *   "0000001"));
                ROM_address2    <=  ((column*   "1000000")  +   (index  *   "0000001"));
                reg8_write  <=  '1';
                reg8_reset  <=  '0';
            when "01000000" =>
                reg8_write  <=  '0';
                MAC_control <=  '1';
            when "00100000" =>
                reg8_reset  <=  '1';
                MAC_control <=  '0';
                MAC_acc     <=  MAC_output;
                index_int   :=  (index_int   +   1) mod 128;
            when "00010000" =>
                MAC_acc <=  "0000000000000000";
                reg16_reset <=  '0';
                reg16_write <=  '1';
            when "00001000" =>
                reg16_write <=  '0';
                RAM_write   <=  '1';
            when "00000100" =>
                row_int :=  (row_int    +   1)  mod     128;
                if row_int = 0 then
                    column_int := (column_int + 1) mod 128;
                    if column_int = 0 then
                        light_sig <= '1';
                        light     <= '1';
                    end if;
                end if;
                column  :=  std_logic_vector( to_unsigned( column_int, 7));
                row     :=  std_logic_vector( to_unsigned( row_int, 7));
            when "00000001" =>
                RAM_write   <=  '0';
                RAM_address <=  RAM_read_add;
                RAM_read_out <= RAM_output;
            when "00000010" =>
                RAM_write   <=  '0';
                RAM_address <=  RAM_read_add;
                RAM_read_out <= RAM_output;
--            when "00000010" =>
--                light_sig       <=      '0';
--                light           <=      '0';
--                ROM_address1    <=      "00000000000000";
--                ROM_address2    <=      "00000000000000";
--                ROM_output1     <=      "00000000";
--                ROM_output2     <=      "00000000";
--                RAM_address     <=      "00000000000000";
--                reg8_write      <=      '0';
--                reg8_reset      <=      '1';
--                reg1_output     <=      "00000000";
--                reg2_output     <=      "00000000";
--                MAC_control     <=      '0';
--                MAC_acc         <=      "0000000000000000";
--                MAC_output      <=      "0000000000000000";
--                reg16_output    <=      "0000000000000000";
--                reg16_write     <=      '0';
--                reg16_reset     <=      '1';
--                RAM_output      <=      "0000000000000000";
--                RAM_write       <=      '0';
--                state           <=      "00000000";
--                column_int      :=      0;
--                row_int         :=      0;
--                index_int       :=      0;
--                column          :=      "0000000";
--                row             :=      "0000000";
--                index           :=      "0000000";
            when others =>
                NULL;
        end case;
    end process;
end Behavioral;
