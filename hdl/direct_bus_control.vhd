library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity direct_bus_control is
    port (
        i_clk           : in std_logic := '0';
        i_mod_en        : in std_logic := '1';
        i_enable_in     : in std_logic := '1';
        i_enable_out    : in std_logic := '1';
        i_switches      : in std_logic_vector(7 downto 0) := (others => '0');

    );
end entity direct_bus_control;

architecture rtl of direct_bus_control is
    
begin
    
    
    
end architecture rtl;