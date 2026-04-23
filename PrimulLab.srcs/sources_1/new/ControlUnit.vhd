----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2026 10:35:54 AM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    Port ( opcode : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_vector(2 downto 0);
           MemWrite : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is

begin
process(opcode)
begin

RegDst<='0';
ExtOp<='0';
ALUSrc<='0';
Branch<='0';
Jump<='0';
ALUOp<="000";
MemWrite<='0';
MemtoReg<='0';
RegWrite<='0';

case opcode is
when "000"=> --r tyoe
        RegDst<='1';
        RegWrite<='1';
        ALUOp<="010";
when "001"=>--addi
        ALUSrc<='1';
        RegWrite<='1';
        ExtOp<='1';
        ALUOp<="000";
when "010"=>--lw
        ALUSrc<='1';
        MemtoReg<='1';
        RegWrite<='1';
        ExtOp<='1';
        ALUOp<="000";
when "011"=>--sw store
        ALUSrc<='1';
        MemWrite<='1';
        ExtOp<='1';
        ALUOp<="000";
when "100"=>--ori
        ALUSrc<='1';
        RegWrite<='1';
        ExtOp<='0';
        ALUOp<="100";
when "101"=>--andi
        ALUSrc<='1';
        RegWrite<='1';
        ExtOp<='0';
        ALUOp<="100";
when "110"=>--beq
        Branch<='1';
        ExtOp<='1';
        ALUOp<="001";
when "111"=>--jump
        Jump<='1';
           
when others=>null;
end case;
        

end process;

end Behavioral;
