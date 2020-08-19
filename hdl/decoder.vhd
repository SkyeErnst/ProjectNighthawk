library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder is -- Works similar to a demultiplexer, but with the "input" bit pre-set to '1'.
    generic (
        g_sel_width : integer range 2 to 8 := 2); -- Number of bits to use in select bus. 1bit = 2 output lines, 2bits = 4, etc.
    port (
        -- INPUTS
        i_select : in  std_logic_vector(g_sel_width-1 downto 0);
        i_enable : in std_logic := '0';

        -- OUTPUTS
        o_decoder_out : out std_logic_vector (2**g_sel_width-1));
end entity decoder;

architecture rtl of decoder is
    
begin
    
    decode: process(i_select, i_enable)
    begin
        if(i_enable = '1') then
            o_decoder_out <= (others => '0');
            o_decoder_out <= to_integer(unsigned(i_select));
        else
            o_decoder_out <= (others => '0');
        end if;
    end process decode;
    
end architecture rtl;