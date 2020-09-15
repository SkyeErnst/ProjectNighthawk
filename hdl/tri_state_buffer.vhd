library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tri_state_buffer is
    port (
        i_input         : in std_logic_vector(7 downto 0) := (others => '0');
        i_n_output_en   : in std_logic := '1';

        o_q             : out std_logic_vector(7 downto 0) := (others => '0')
    );
end entity tri_state_buffer;

architecture rtl of tri_state_buffer is
    
begin
    
    on_input_change: process(i_input, i_n_output_en)
    begin

        if (i_n_output_en = '1') then
            o_q <= (others => 'Z');
        else
            o_q <= i_input;
        end if;
    end process on_input_change;
    
end architecture rtl;