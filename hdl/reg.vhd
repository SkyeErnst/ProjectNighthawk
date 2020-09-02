library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg is
    port (
        i_clock : in std_logic := '0';
        i_rst : in std_logic := '1';
        i_enable_in : in std_logic := '0';
        i_enable_out : in std_logic := '0';
        o_data_bus : inout std_logic_vector(7 downto 0) := (others => '0')
    );
end entity reg;

architecture rtl of reg is
    signal r_latched_data : std_logic_vector(7 downto 0) := (others => '0');
begin
    
    p_on_clock : process(i_clock) is
    begin
        if(rising_edge(i_clock)) then
            if (i_rst = '0') then
                r_latched_data <= (others => '0');
            else
                if (i_enable_in = '1') then
                    r_latched_data <= o_data_bus;
                elsif (i_enable_out = '1') then
                    o_data_bus <= r_latched_data;
                else
                    o_data_bus <= (others => 'Z');
                end if;
				 end if;
        end if;
    end process p_on_clock;
    
end architecture rtl;