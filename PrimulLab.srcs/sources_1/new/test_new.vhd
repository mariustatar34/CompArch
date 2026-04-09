----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2026 07:31:55 PM
-- Design Name: 
-- Module Name: test_new - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_new is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           sw:in std_logic_vector(7 downto 0);
           leds: out std_logic_vector(7 downto 0);
           cat:out std_logic_vector(6 downto 0);
           an:out std_logic_vector(3 downto 0));
end test_new;


architecture Behavioral of test_new is

component MPG is 
Port( clk: in STD_logic;
btn: in std_logic;
enable: out std_logic
);
end component;

component SSD is
Port(
clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

component ROMM is
Port(
addr: in STD_LOGIC_VEctor(7 downto 0);
clk:in std_logic;
dout:out std_logic_vector(15 downto 0));
end component;

signal en:std_logic;
--signal count16:unsigned(15 downto 0):=(others=>'0');
--signal op_sel:unsigned(1 downto 0):=(others=>'0');
--signal A:unsigned(15 downto 0);
--signal B:unsigned(15 downto 0);
--signal C:unsigned(15 downto 0);
--signal result:unsigned(15 downto 0);
signal addr:unsigned(7 downto 0):=(others=>'0');
signal rom_out:std_logic_vector(15 downto 0);

begin

mpg_inst: MPG 
port map(
clk=>clk,
btn=>btn,
enable=>en
);

process(clk)
begin
   if rising_edge(clk) then
   if en='1' then 
  -- op_sel<=op_sel+1;
  addr<=addr+1;
   end if;
   end if;
 end process;  
 
 --A<=resize(unsigned(sw(3 downto 0)),16);
 --B<=resize(unsigned(sw(7 downto 4)),16);
 --C<=resize(unsigned(sw(7 downto 0)),16);
 
 rom_inst:ROMM
 port map(
 addr=>std_logic_vector(addr),
 clk=>clk,
 dout=>rom_out);
 
 --process(op_sel,A,B,C)
 --begin
 --    case op_sel is
   --      when "00"=>result<=A+B;
     --    when "01"=>result<=A-B;
       --  when "10"=>result<=C sll 2;
       --  when "11"=>result<=C srl 2;
       --  when others=>result<=(others =>'0');
 --end case;
 --end process;
 
 ssd_inst: SSD
 port map(
 clk=>clk,
 digit0=>rom_out(3 downto 0),
 digit1=>rom_out(7 downto 4),
 digit2=>rom_out(11 downto 8),
 digit3=>rom_out(15 downto 12),
 cat=>cat,
 an=>an
 );
 
 --process(result)
 --begin
 --if result=to_unsigned(0,16) then leds<="10000000";
 --else leds<="00000000";
 --end if;
 --end process;
 
 
--process(count)
--begin
--case std_logic_vector(count) is
--when "000"=>leds<="00000001";
--when "001"=>leds<="00000010";
--when "010"=>leds<="00000100";
--when "011"=>leds<="00001000";
--when "100"=>leds<="00010000";
--when "101"=>leds<="00100000";
--when "110"=>leds<="01000000";
--when "111"=>leds<="10000000";
--when others=>leds<="00000000";
--end case;
--end process;
leds<=(others =>'0');
end Behavioral;
