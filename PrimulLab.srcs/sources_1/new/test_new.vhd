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
           btn : in STD_LOGIC;--enable
           sw:in std_logic_vector(7 downto 0); -- sw(4)=reset, sw(7:5)=SSD select, sw(0)=LED select
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

--component ROMM is
--Port(
--addr: in STD_LOGIC_VEctor(7 downto 0);
--clk:in std_logic;
--dout:out std_logic_vector(15 downto 0));
--end component;

--MPG
signal en:std_logic;
--signal count16:unsigned(15 downto 0):=(others=>'0');
--signal op_sel:unsigned(1 downto 0):=(others=>'0');
--signal A:unsigned(15 downto 0);
--signal B:unsigned(15 downto 0);
--signal C:unsigned(15 downto 0);
--signal result:unsigned(15 downto 0);
--signal addr:unsigned(7 downto 0):=(others=>'0');
--signal rom_out:std_logic_vector(15 downto 0);


--IF
signal instr:std_logic_vector(15 downto 0);
signal pc_plus_1:std_logic_vector(15 downto 0);
signal jump_addr:std_logic_vector(15 downto 0);
signal branch_addr:std_logic_vector(15 downto 0);
signal pcsrc:std_logic;


--Control
signal RegDst_ctrl:std_logic;
signal ExtOp_ctrl:std_logic;
signal ALUSrc_ctrl:std_logic;
signal Branch_ctrl:std_logic;
signal Jump_ctrl:std_logic;
signal MemWrite_ctrl:std_logic;
signal MemtoReg_ctrl:std_logic;
signal RegWrite_ctrl:std_logic;
signal ALUOp_ctrl:std_logic_vector(2 downto 0);

--control signals
signal RegWrite_final:std_logic;
signal MemWrite_final:std_logic;

--ID
signal RD1:std_logic_vector(15 downto 0);
signal RD2:std_logic_vector(15 downto 0);
signal Ext_Imm:std_logic_vector(15 downto 0);
signal func:std_logic_vector(2 downto 0);
signal sa:std_logic;
signal WD:std_logic_vector(15 downto 0);

--EX
signal ALURes:std_logic_vector(15 downto 0);
signal Zero:std_logic;

--MEM
signal MemData:std_logic_vector(15 downto 0);
signal ALURes_MEM:std_logic_vector(15 downto 0);

--ssd
signal display_data:std_logic_vector(15 downto 0);

begin

--IF unit
ifu_inst : entity work.IFU
port map(
    clk           => clk,
    reset           => sw(4),         -- folosim sw(4) xa reset
    en            => en,
   PCSrc=>pcsrc,
   Jump=>Jump_ctrl,
   BranchAddress=>branch_addr,
   JumpAddress=>jump_addr,
   Instruction=>instr,
   PC_plus_1=>pc_plus_1
);

mpg_inst: MPG 
port map(
clk=>clk,
btn=>btn,
enable=>en
);



--Main vontrol unit
ctrl_inst: entity work.ControlUnit
port map(
opcode=>instr(15 downto 13),
RegDst=>RegDst_ctrl,
ExtOp=>ExtOp_ctrl,
ALUSrc=>ALUSrc_ctrl,
Branch=>Branch_ctrl,
Jump=>Jump_ctrl,
ALUOp=>ALUOp_ctrl,
MemWrite=>MemWrite_ctrl,
MemtoReg=>MemtoReg_ctrl,
RegWrite=>RegWrite_ctrl
);

--Validare cu mpg
RegWrite_final<=RegWrite_ctrl; --and en;
MemWrite_final<=MemWrite_ctrl; --and en;

--jump addr computation. opcode(15:13)+addr(12:0)
jump_addr<="000"&instr(12 downto 0);

--branch decizion
pcsrc<=Branch_ctrl and Zero;


--ID unit
id_inst:entity work.ID
port map(
clk=>clk,
Instr=>instr,
WD=>WD,
RegWrite=>RegWrite_final,
RegDst=>RegDst_ctrl,
ExtOp=>ExtOp_ctrl,
RD1=>RD1,
RD2=>RD2,
EXT_Imm=>Ext_Imm,
func=>func,
sa=>sa
);


--EX unitu
ex_inst:entity work.EX
port map(
PCPlus1=>pc_plus_1,
RD1=>RD1,
RD2=>RD2,
ExtImm=>Ext_Imm,
func=>func,
sa=>sa,
ALUSrc=>ALUSrc_ctrl,
ALUOp=>ALUOp_ctrl,
ALURes=>ALURes,
Zero=>Zero,
BranchAddr=>branch_addr
);

--MEM unit
mem_inst:entity work.MEM
port map(
clk=>clk,
ALURes_in=>ALURes,
RD2=>RD2,
MemWrite=>MemWrite_final,
MemData=>MemData,
ALURes_out=>ALURes_MEM
);

--WB MUX
WD<=MemData when MemtoReg_ctrl='1' else ALURes_MEM;

--process(clk)
--begin
 --  if rising_edge(clk) then
  -- if en='1' then 
  -- op_sel<=op_sel+1;
  --addr<=addr+1;
   --end if;
   --end if;
 --end process;  
 
 --A<=resize(unsigned(sw(3 downto 0)),16);
 --B<=resize(unsigned(sw(7 downto 4)),16);
 --C<=resize(unsigned(sw(7 downto 0)),16);
 
 --rom_inst:ROMM
 --port map(
 --addr=>std_logic_vector(addr),
 --clk=>clk,
 --dout=>rom_out);
 
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
 
 
 --ssd display select
 with sw (7 downto 5) select
 display_data<=
        instr when "000",
        pc_plus_1 when "001",
        RD1 when "010",
        RD2 when "011",
        Ext_Imm when "100",
        ALURes when "101",
        MemData when "110",
        WD when others;
 
 --ssd instance
 ssd_inst: SSD
 port map(
 clk=>clk,
digit0=>display_data(3 downto 0),
digit1=>display_data(7 downto 4),
digit2=>display_data(11 downto 8),
digit3=>display_data(15 downto 12),
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


--LEDS: sw(0)=0 afiseaza control signals, daca e 1 afiseaza ALUOp pe leduri
leds<=(7=>RegWrite_ctrl,
       6=>MemtoReg_ctrl,
       5=>MemWrite_ctrl,
       4=>Jump_ctrl,
       3=>Branch_ctrl,
       2=>ALUSrc_ctrl,
       1=>ExtOp_ctrl,
       0=>RegDst_ctrl) when sw(0)='0'
       else
       "00000" & ALUOp_ctrl;





--display_data <= instr when sw(7) = '0' else pc_plus_1;

--leds<=(others =>'0');
end Behavioral;
