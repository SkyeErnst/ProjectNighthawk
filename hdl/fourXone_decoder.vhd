library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fourXone_decoder is
    port (
        i_sel       : in std_logic_vector(1 downto 0) := (others => '0');
        i_en        : in std_logic := '0';

        o_decode    : out std_logic_vector(3 downto 0) := (others => '0')
    );
end entity fourXone_decoder;

architecture rtl of fourXone_decoder is
    
begin
    
    decoder: process(i_sel, i_en)
    begin
        if (i_en = '1') then
            case i_sel is
                when "00" =>
                    o_decode <= "0001";
                when "01" =>
                    o_decode <= "0010";
                when "10" =>
                    o_decode <= "0100";
                when "11" =>
                    o_decode <= "1000";
                when others =>
                    o_decode <= "0000";
            end case;
        else
            o_decode <= "0000";
        end if;
    end process decoder;
    
end architecture rtl;