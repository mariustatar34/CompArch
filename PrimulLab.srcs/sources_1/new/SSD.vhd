----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2026 09:35:13 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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
use IEEE.Numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end SSD;

architecture Behavioral of SSD is

signal cnt: unsigned(15 downto 0):=(others=>'0');
signal sel:std_logic_vector(1 downto 0);
signal hex_digit:std_logic_vector(3 downto 0);

begin

process(clk)
begin
  if rising_edge(clk)
  then cnt<=cnt+1;
  end if;
  end process;

sel<=std_logic_vector(cnt(15 downto 14));

process(sel,digit0,digit1,digit2,digit3)
begin
case sel is
when "00"=>hex_digit<=digit0;
when "01"=>hex_digit<=digit1;
when "10"=>hex_digit<=digit2;
when "11"=>hex_digit<=digit3;
when others=> hex_digit<="0000";
end case;
end process;

process(sel)
begin
case sel is
when "00"=>an<="1110";
when "01"=>an<="1101";
when "10"=>an<="1011";
when "11"=>an<="0111";
when others=>an<="1111";
end case;
end process;

process(hex_digit)
begin
case hex_digit is
when "0000"=>cat<="1000000";
when "0001"=>cat<="1111001";
when "0010"=>cat<="0100100";
when "0011"=>cat<="0110000";
when "0100"=>cat<="0011001";
when "0101"=>cat<="0010010";
when "0110"=>cat<="0000010";
when "0111"=>cat<="1111000";
when "1000"=>cat<="0000000";
when "1001"=>cat<="0010000";
when "1010"=>cat<="0001000";
when "1011"=>cat<="0000011";
when "1100"=>cat<="1000110";
when "1101"=>cat<="0100001";
when "1110"=>cat<="0000110";
when "1111"=>cat<="0001110";
when others=>cat<="1111111";
end case;
end process;


end Behavioral;
