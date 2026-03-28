----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2026 10:46:05 AM
-- Design Name: 
-- Module Name: ROMM - Behavioral
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

entity ROMM is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
            clk:in std_logic;
           dout : out STD_LOGIC_VECTOR (15 downto 0));
end ROMM;

architecture Behavioral of ROMM is
type rom_type is array(0 to 255) of std_logic_vector(15 downto 0);
signal ROM: rom_type:=(
0=>B"000_011_001_001_0_000", --add $1,$3,$1
1=>B"000_001_001_010_0_001", --sub $2,$1,$1
2=>B"000_000_001_011_1_010", --sll $3,$1,$0
3=>B"000_000_010_011_1_011", --srl $3,$2,$0
4=>B"000_010_001_011_0_100", --and $3,$2,$1
5=>B"000_001_010_011_0_101", --or $3,$1,$2
6=>B"000_001_010_011_0_110", --xor $3,$1,$2
7=>B"000_001_011_011_0_111", --slt $3,$1,$3
8=>B"001_011_001_0000001",  --addi $1,$3,$1
9=>B"010_010_001_0000000",  --lw $1,$0,$2
10=>B"011_011_010_0000000", --sw $2,$0,$3
11=>B"100_010_010_0000001", --ori $2,$2,$1
12=>B"101_001_011_0000011",  --andi $3,$1,$3
13=>B"110_010_010_0000001",  --beq $2,$2,$1
14=>B"111_0000000000011", --jump 3
others=>x"0000");

begin
process(clk)
begin
if rising_edge(clk) then
dout<=ROM(to_integer(unsigned(addr)));
end if;
end process;

end Behavioral;
