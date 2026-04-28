----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 01:03:13 PM
-- Design Name: 
-- Module Name: tb_test_new - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_test_new is
end tb_test_new;

architecture sim of tb_test_new is

    signal clk  : std_logic := '0';
    signal btn  : std_logic := '0';
    signal sw   : std_logic_vector(7 downto 0) := (others => '0');
    signal leds : std_logic_vector(7 downto 0);
    signal cat  : std_logic_vector(6 downto 0);
    signal an   : std_logic_vector(3 downto 0);

begin

    -- clock (100 MHz)
    clk <= not clk after 5 ns;

    -- instan?? design
    uut : entity work.test_new
        port map (
            clk  => clk,
            btn  => btn,
            sw   => sw,
            leds => leds,
            cat  => cat,
            an   => an
        );

    process
    begin
        -- RESET
        sw(4) <= '1';
        wait for 100 ns;
        sw(4) <= '0';

        -- afi?eaz? PC+1
        sw(7 downto 5) <= "001";

        wait for 1 ms;

        -- STEP 1
        btn <= '1';
        wait for 2 ms;
        btn <= '0';
        wait for 2 ms;

        -- STEP 2
        btn <= '1';
        wait for 2 ms;
        btn <= '0';
        wait for 2 ms;

        -- STEP 3
        btn <= '1';
        wait for 2 ms;
        btn <= '0';
        wait for 2 ms;

        wait;
    end process;

end sim;
