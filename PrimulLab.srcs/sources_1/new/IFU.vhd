----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2026 11:33:41 AM
-- Design Name: 
-- Module Name: IFU - Behavioral
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

entity IFU is
  Port (
clk:in std_logic;
reset: in std_logic; --pune pc ul inapoi la 0000
en:in std_logic;  --avem nevoie pentru ca pc ul sa nu se actualizeze la fiecare clock, vine din mpg
PCSrc:in std_logic;
Jump:in std_logic;
BranchAddress:in std_logic_vector(15 downto 0);
JumpAddress:in std_logic_vector(15 downto 0);

Instruction:out std_logic_vector(15 downto 0);
PC_plus_1:out std_logic_vector(15 downto 0)

 );
end IFU;

architecture Behavioral of IFU is
signal PC_reg:std_logic_vector(15 downto 0):=(others=>'0');
signal PC_inc:std_logic_vector(15 downto 0);
signal next_pc:std_logic_vector(15 downto 0);
signal branch_mux:std_logic_vector(15 downto 0);




type rom_type is array(0 to 255) of std_logic_vector(15 downto 0);
signal ROM : rom_type := (
    0 => x"2085", --addi $1, $0, 5
    1 => x"2104", -- addi $2, $0, 4
    2=>x"0000",
    3=>x"0000",
    
    4 => x"04B0", -- add $3, $1, $1
    5=>x"0000",
    6=>x"0000",
    7=>x"0000",
    
    8 => x"0D41", -- sub $4, $3, $2
    9 => x"08D4", -- and $5, $2, $1
    10=>x"0000",
    11=>x"0000",
    
    12 => x"1165", -- or $6, $4, $2
    13 => x"017A", -- sll $7, $2, 1
    14 => x"01FB", -- srl $7, $3, 1
    15=> x"1116", -- xor $1, $4, $2
    16=> x"11A7", -- slt $2, $4, $3
    17=>x"0000",
    18=>x"0000",
    
    19 => x"A58F", -- andi $3, $1, 15 nu
    20=>x"0000",
    21=>x"0000",
    22=>x"0000",
    
    23 => x"6180", -- sw $3, 0 
    24 => x"4200", -- lw $4, 0 da
    25 => x"8000", -- beq $0, $0, 0  
    26=>x"0000",
    27=>x"0000",
    28=>x"0000",
    29 => x"8602", -- ori $4,$1,2 
    30 => x"E000", -- jumpp 0 
    31=>x"0000",
               
    others => x"0000"
    );



begin
--PC+1
PC_inc<=std_logic_vector(unsigned(PC_reg)+1);

--mux branch
branch_mux<=BranchAddress when PCSrc='1' else PC_inc;

--mux jump
next_pc<=JumpAddress when Jump='1' else branch_mux;

--regidtrul pc
process(clk,reset)
begin
if reset='1' then
PC_reg<=(others=>'0');
elsif rising_edge(clk) then
if en='1' then PC_reg<=next_pc;
end if;
end if;
end process;

Instruction<=ROM(to_integer(unsigned(PC_reg(7 downto 0))));

PC_plus_1<=PC_inc;
end Behavioral;
