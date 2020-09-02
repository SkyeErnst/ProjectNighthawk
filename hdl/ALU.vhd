library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        i_clk                                           : in std_logic := '0';
        i_rst                                           : in std_logic := '1';
        i_op_sel                                        : in std_logic_vector(4 downto 0) := (others => '0');   -- operation selector 
        i_signed                                        : in std_logic := '0';                                  -- 0 = unsigned operations, 1 = signed
        i_read_loc_a, i_read_loc_b                      : in std_logic := '0';                                  -- location to read data from. 0 = bus, 1 = GPR Bank
        i_GPR_a_in, i_GPR_b_in, i_GPR_c_in, i_GPR_d_in  : in std_logic_vector(7 downto 0) := (others => '0');   -- GPR bank inputs
        i_bus_in                                        : in std_logic_vector(7 downto 0) := (others => '0');   -- bus input
        i_ready                                         : in std_logic := '1';                                  -- 0 = ready to proccess input. 1 = setup phase
        i_read_en_a, i_read_en_b                        : in std_logic := '1';                                  -- read enable pin for inputs
        i_acc_oe                                        : in std_logic := '1';                                  -- output enable pin for accumulator register

        o_acc_out                                       : out std_logic_vector(7 downto 0) := (others => '0')   -- accumulator port out
    );
end entity ALU;

architecture rtl of ALU is
    type t_ops is (ADD, SUB, MUL, DIV, NEG, EXP, A_ABS, A_MOD, A_REM, TEQ, TNQ, TLT, TGT, TLE, TGE, LAND, LOR, LNAND, LNOR, LXOR, LXNOR, CSLL, CSRL, CSLA, CSRA, CROL, CROR, NOP);
    signal acc              : std_logic_vector(7 downto 0) := (others => '0');
    signal term_a, term_b   : std_logic_vector(7 downto 0) := (others => '0');

begin
    
    p_on_clk: process(i_clk)
    begin
        if rising_edge(i_clk) then
            if (i_rst = '1') then
                acc <= (others => '0');
            else
                if (i_ready = '0') then
                    case i_op_sel is
                        when ADD =>
                            
                        when others =>
                            
                    end case;
                else
                    if (i_read_loc_a = '0' AND i_read_en_a = '0') then -- reading from bus and read enable is active
                        
                    elsif

                    end if;
                end if;
            end if;
        end if;
    end process proc_name;
    
end architecture rtl;