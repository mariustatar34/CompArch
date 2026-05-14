----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2026 11:09:44 AM
-- Design Name: 
-- Module Name: reg_file - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
    Port ( clk : in STD_LOGIC;
           ra1 : in STD_LOGIC_VECTOR (2 downto 0);
           ra2 : in STD_LOGIC_VECTOR (2 downto 0);
           wa : in STD_LOGIC_VECTOR (2 downto 0);
           wd : in STD_LOGIC_VECTOR (15 downto 0);
           wen : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (15 downto 0);
           rd2 : out STD_LOGIC_VECTOR (15 downto 0));
end reg_file;

architecture Behavioral of reg_file is

type reg_array is array(0 to 7) of std_logic_vector(15 downto 0);
signal reg_mem:reg_array:=(others => (others=>'0'));

begin

process(clk)
begin
if rising_edge(clk) then 
     if wen='1' and wa/="000"
        then reg_mem(to_integer(unsigned(wa)))<=wd;
     end if;
end if;

end process;
rd1<=x"0000" when ra1="000" else reg_mem(to_integer(unsigned(ra1)));
rd2<=x"0000" when ra2="000" else reg_mem(to_integer(unsigned(ra2)));

end Behavioral;
