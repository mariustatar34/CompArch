----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2026 01:21:44 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MPG is
    Port (
        clk    : in  STD_LOGIC;
        btn    : in  STD_LOGIC;
        enable : out STD_LOGIC
    );
end MPG;

architecture Behavioral of MPG is

    signal counter      : unsigned(19 downto 0) := (others => '0');
    signal btn_sync0    : std_logic := '0';
    signal btn_sync1    : std_logic := '0';
    signal btn_stable   : std_logic := '0';
    signal btn_prev     : std_logic := '0';
    signal enable_reg   : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            enable_reg <= '0';

            counter <= counter + 1;

            btn_sync0 <= btn;
            btn_sync1 <= btn_sync0;

            if counter = x"FFFFF" then
                btn_prev   <= btn_stable;
                btn_stable <= btn_sync1;

                if btn_sync1 = '1' and btn_stable = '0' then
                    enable_reg <= '1';
                end if;
            end if;
        end if;
    end process;

    enable <= enable_reg;

end Behavioral; 