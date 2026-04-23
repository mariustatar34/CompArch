----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 10:51:12 AM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
    Port ( PCPlus1 : in STD_LOGIC_vector(15 downto 0);
           RD1 : in STD_LOGIC_vector(15 downto 0);
           RD2 : in STD_LOGIC_vector(15 downto 0);
           ExtImm: in std_logic_vector(15 downto 0);
           func:in std_logic_vector(2 downto 0);
           sa:in std_logic;
           ALUSrc:in std_logic;
           ALUOp:in std_logic_vector(1 downto 0);
           
           ALURes:out std_logic_vector(15 downto 0);
           Zero:out std_logic;
           BranchAddr:out std_logic_vector(15 downto 0)
           
           );
end EX;

architecture Behavioral of EX is

signal ALU_in2:std_logic_vector(15 downto 0);
signal ALUCtrl:std_logic_vector(2 downto 0);
signal ALURes_int:std_logic_vector(15 downto 0);

begin

ALU_in2<=RD2 when ALUSrc='0' else ExtImm;

--alu cntrl
process(ALUOp,func)
begin

case ALUOp is
when "000"=>ALUCtrl<="000"; --add
when "001"=>ALUCtrl<="001";--sub
when "010"=>ALUCtrl<=func; --r type
when "011"=>ALUCtrl<="101";--ori or
when "100"=>ALUCtrl<="100";--andi and
when others=>ALUCtrl<="000";
end case;

end process;

process(RD1,ALU_in2,ALUCtrl,sa)
begin
case ALUCtrl is
when "000"=> --add
    ALURes_int<=std_logic_vector(unsigned(RD1)+unsigned(ALU_in2));
when "001"=>--sub
    ALURes_int<=std_logic_vector(unsigned(RD1)-unsigned(ALU_in2));
when "010"=>--sll
    if sa='1' then
        ALURes_int<=std_logic_vector(shift_left(unsigned(ALU_in2),1));
    else
        ALURes_int<=ALU_in2;
     end if;
when "011"=>--srl
     if sa='1' then
        ALURes_int<=std_logic_vector(shift_right(unsigned(ALU_in2),1));
    else
        ALURes_int<=ALU_in2;
    end if;
when "100"=>--and
    ALURes_int<=RD1 or ALU_in2;
when "101"=>--or
    ALURes_int<=RD1 or ALU_in2;
when "110"=>--xor
    ALURes_int<=RD1 xor ALU_in2;
when "111"=>--slt
    if(signed(RD1)<signed(ALU_in2)) then
        ALURes_int<=x"0001";
    else 
        ALURes_int<=x"0000";
    end if;
when others=>
    ALURes_int<=(others=>'0');
end case;
end process;

--zero
Zero<='1' when ALURes_int=x"0000" else '0';

--branchu
BranchAddr<=std_logic_vector(unsigned(PCPlus1)+unsigned(ExtImm));

ALURes<=ALURes_int;

end Behavioral;
