----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2026 10:28:27 AM
-- Design Name: 
-- Module Name: RAMM - Behavioral
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
use IEEE.NUMERIC_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAMM is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           addr : in STD_LOGIC_vector(5 downto 0);
           di : in STD_LOGIC_vector(15 downto 0);
           do : out STD_LOGIC_vector(15 downto 0));
end RAMM;

architecture Behavioral of RAMM is

type ram_type is array (0 to 63) of std_logic_vector(15 downto 0);
signal RAM:ram_type:=(others=>(others=>'0'));

begin

process(clk)
begin
if rising_edge(clk) then
if en='1' then
if we='1' then RAM(to_integer(unsigned(addr)))<=di;
else do<=RAM(to_integer(unsigned(addr)));
end if;
end if;
end if;

end process;

end Behavioral;
