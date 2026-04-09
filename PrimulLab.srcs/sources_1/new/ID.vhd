----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2026 10:33:25 AM
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
    Port ( clk : in STD_LOGIC;
    Instr: in std_logic_vector(15 downto 0);
    WD:in std_logic_vector(15 downto 0);
    
    RegWrite:in std_logic;
    RegDst:in std_logic;
    ExtOp:in std_logic;
    
    RD1: out std_logic_vector(15 downto 0);
    RD2: out std_logic_vector(15 downto 0);
    Ext_Imm: out std_logic_vector(15 downto 0);
    func: out std_logic_vector(2 downto 0);
    sa: out std_logic
     
    );
end ID;

architecture Behavioral of ID is

signal wa_sig: std_logic_vector(3 downto 0);
signal ra1_sig: std_logic_vector(3 downto 0);
signal ra2_sig:std_logic_vector(3 downto 0);


begin

--MUXul pt write address.
wa_sig<='0' & Instr(6 downto 4) when RegDst='1' else 
'0' & Instr(9 downto 7);

--rs si rt
ra1_sig<='0' & Instr(12 downto 10);
ra2_sig<='0' & Instr(9 downto 7);

--Reg file ul
 rf_inst : entity work.reg_file
        port map (
            clk => clk,
            ra1 => ra1_sig,
            ra2 => ra2_sig,
            wa  => wa_sig,
            wd  => WD,
            wen => RegWrite,
            rd1 => RD1,
            rd2 => RD2
        );
        
 -- Zero / Sign Extension pentru immediate pe 7 biti
Ext_Imm <= "000000000" & Instr(6 downto 0) when ExtOp = '0' else
              "111111111" & Instr(6 downto 0) when Instr(6) = '1' else
              "000000000" & Instr(6 downto 0);


func <= Instr(2 downto 0);
sa   <= Instr(3);


end Behavioral;
