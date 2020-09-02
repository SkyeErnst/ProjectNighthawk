library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity direct_bus_control is
    port (
        i_clk                   : in std_logic := '0';
        i_rst                   : in std_logic := '1';
        i_module_en             : in std_logic := '1';
        i_write_enable          : in std_logic := '1'; -- 1 = implicit read enable
        i_switches              : in std_logic_vector(7 downto 0) := (others => '0');

        o_databus               : out std_logic_vector(7 downto 0) := (others => 'Z')
    );
end entity direct_bus_control;

architecture rtl of direct_bus_control is
    signal q : std_logic_vector(7 downto 0) := (others => 'Z');
begin
    
    control: process(i_clk, i_rst)
    begin
        if i_rst = '0' then
            q <= (others => 'Z');
        elsif rising_edge(i_clk) then
            if (i_module_en = '0' AND i_rst = '1') then
                if (i_write_enable = '1') then -- 'read' condition
                    q <= i_switches;
                else                           -- 'write' condition
                    o_databus <= q;
                end if;
            end if;
            if (i_module_en = '1' AND i_rst = '1') then -- Module disabled condition
                o_databus   <= (others => 'Z');
            end if;
        end if;
    end process control;
    
end architecture rtl;