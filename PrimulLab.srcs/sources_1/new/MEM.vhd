----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 10:28:36 AM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( clk : in STD_LOGIC;
    ALURes_in: in std_logic_vector(15 downto 0);
    RD2: in std_logic_vector(15 downto 0);
    MemWrite: in std_logic;
    
    MemData:out std_logic_vector(15 downto 0);
    ALURes_out: out std_logic_vector(15 downto 0)
    
    );
end MEM;

architecture Behavioral of MEM is

type ram_type is array(0 to 255) of std_logic_vector(15 downto 0);
signal RAM: ram_type:=(others=>(others=>'0'));

begin

process(clk)
begin

if rising_edge(clk) then
    if MemWrite='1' then
        RAM(to_integer(unsigned(ALURes_in(7 downto 0))))<=RD2;
     end if;
 end if;

end process;


MemData<=RAM(to_integer(unsigned(ALURes_in(7 downto 0))));

ALURes_out<=ALURes_in;

end Behavioral;
