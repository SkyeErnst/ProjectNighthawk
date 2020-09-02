library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        i_clk                                           : in std_logic := '0';
        i_rst                                           : in std_logic := '1';
        i_op_sel                                        : in std_logic_vector(4 downto 0) := (others => '0');   -- operation selector 
        i_term_a, i_term_b                              : in std_logic_vector(7 downto 0) := (others => '0');   -- the a and b terms
        i_signed                                        : in std_logic := '0';                                  -- 0 = unsigned operations, 1 = signed
        i_read_loc_a, i_read_loc_b                      : in std_logic := '0';                                  -- location to read data from. 0 = bus, 1 = GPR Bank
        i_GPR_a_in, i_GPR_b_in, i_GPR_c_in, i_GPR_d_in  : in std_logic_vector(7 downto 0) := (others => '0');   -- GPR bank inputs
        i_bus_in                                        : in std_logic_vector(7 downto 0) := (others => '0');   -- bus input

        o_acc_out                                       : out std_logic_vector(7 downto 0) := (others => '0')
    );
end entity ALU;

architecture rtl of ALU is
    type t_ops is (ADD, SUB, MUL, DIV, NEG, EXP, A_ABS, A_MOD, A_REM, TEQ, TNQ, TLT, TGT, TLE, TGE, LAND, LOR, LNAND, LNOR, LXOR, LXNOR, CSLL, CSRL, CSLA, CSRA, CROL, CROR);
    signal acc : std_logic_vector(7 downto 0) := (others => '0');
begin
    
    proc_name: process(clk)
    begin
        if rising_edge(clk) then
            if (i_rst = '1') then
                acc <= (others => '0');
            else
                case expression is
                    when choice =>
                        
                    when others =>
                        
                end case;
            end if;
        end if;
    end process proc_name;
    
end architecture rtl;