library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity user_control is
    port (
        -- data and control switches
        sw : in std_logic_vector (0 to 9) := (others => '0');
        key : in std_logic_vector (0 to 3) := (others => '0');

        -- reset button
        rst : in std_logic := '0';

        -- input and output enable switches for a-d registers
        ra_en_i, ra_en_o : out std_logic := '0';
        
        rb_en_i, rb_en_o : out std_logic := '0';

        rc_en_i, rc_en_o : out std_logic := '0';

        rd_en_i, rd_en_o : out std_logic := '0';

        -- the data from the switches
        switch_data : out std_logic_vector(0 to 7)
    );
end entity user_control;

architecture rtl of user_control is
    signal r_en_i_sel : std_logic_vector(0 to 1) := (others => '0');
    signal r_en_o_sel : std_logic_vector(0 to 1) := (others => '0');
begin

    p_on_data : process(rst, sw, key) is
    begin

        if (rst = '1') then
            r_en_i_sel <= (others => '0');
            r_en_o_sel <= (others => '0');
        elsif (sw(0) = '1') then
            switch_data <= "10101010";
        elsif (sw(9) = '1') then
            switch_data <= "01010101";
        else 
            switch_data <= (others => '0');
        end if;

    end process p_on_data;
    
    
    
end architecture rtl;