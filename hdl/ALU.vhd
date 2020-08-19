library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        i_clk                       : in std_logic := '0';
        i_op_sel                    : in std_logic_vector(4 downto 0) := (others => '0'); -- operation selector 
        i_term_a, i_term_b          : in std_logic_vector(7 downto 0) := (others => '0'); -- the a and b terms
        i_signed                    : in std_logic := '0'; -- 0 = unsigned operations, 1 = signed
        i_read_loc_a, i_read_loc_b  : in std_logic := '0'; -- location to read data from. 0 = bus, 1 = GPR Bank
    );
end entity ALU;

architecture rtl of ALU is
    
begin
    
    
    
end architecture rtl;