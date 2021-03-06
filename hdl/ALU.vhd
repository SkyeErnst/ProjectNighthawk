library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.common.all;

entity ALU is
    port (
        i_clk                                           : in std_logic                      := '0';
        i_rst                                           : in std_logic                      := '1';
        i_op_sel                                        : in std_logic_vector(5 downto 0)   := (others => '0');   -- operation selector 
        i_signed                                        : in std_logic                      := '0';               -- 0 = unsigned operations, 1 = signed
        i_read_loc_a, i_read_loc_b                      : in std_logic                      := '0';               -- location to read data from. 0 = bus, 1 = GPR Bank
        i_GPR_a_in, i_GPR_b_in, i_GPR_c_in, i_GPR_d_in  : in std_logic_vector(7 downto 0)   := (others => '0');   -- GPR bank inputs
        i_GPR_a_sel, i_GPR_b_sel                        : in std_logic_vector(1 downto 0)   := (others => '0');   -- select 
        i_bus_in                                        : in std_logic_vector(7 downto 0)   := (others => '0');   -- bus input
        i_ready                                         : in std_logic                      := '1';               -- 0 = ready to proccess input. 1 = setup phase
        i_read_en_a, i_read_en_b                        : in std_logic                      := '1';               -- read enable pin for inputs
        i_acc_oe                                        : in std_logic                      := '1';               -- output enable pin for accumulator register

        o_acc_out                                       : out std_logic_vector(7 downto 0)  := (others => '0');   -- accumulator port out
        o_err_flag                                      : out std_logic                     := '1'                -- generic error flag
        
    );
end entity ALU;

architecture rtl of ALU is

    signal uacc             : unsigned(7 downto 0)   := (others => '0');
    signal sacc             : signed(7 downto 0)     := (others => '0');
    signal term_a, term_b   : unsigned(7 downto 0)   := (others => '0');
    signal n_error          : std_logic              := '1';
    shared variable temp    : unsigned (15 downto 0) := (others => '0');
begin
    
    p_on_clk: process(i_clk)
    begin
        if rising_edge(i_clk) then
            if (i_rst = '0') then
                uacc <= (others => '0');
                sacc <= (others => '0');
                term_a <= (others => '0');
                term_b <= (others => '0');
                o_acc_out <= (others => 'Z');
                o_err_flag <= '1';
            else
                if (i_ready = '0' AND n_error = '1') then
                    case to_ops_from_slv(i_op_sel) is
                        when ADD =>
                            if (i_signed = '0') then
                                uacc <= term_a + term_b;
                            else
                                sacc <= signed(term_a) + signed(term_b);
                            end if;
                        when SUB =>
                            if (i_signed = '0') then
                                uacc <= term_a - term_b;
                            else
                                sacc <= signed(term_a) - signed(term_b);
                            end if;
                        when MUL =>
                            if (i_signed = '0') then
                                temp := term_a * term_b;
                                uacc <= temp(7 downto 0);
                            else
                                --temp := signed(term_a) * signed(term_b);
                                --sacc <= temp(7 downto 0);
                                o_err_flag <= '0';
                            end if;
                        when DIV =>
                            if (term_b = 0) then
                                o_err_flag <= '0';
                            else
                                if (i_signed = '0') then
                                    uacc <= term_a / term_b;
                                else
                                    sacc <= signed(term_a) / signed(term_b);
                                end if;
                            end if;
                        when NEG =>
                            sacc <=  -(signed(term_a));
                        when EXP =>
                            if (i_signed = '0') then
                                --uacc <= term_a ** term_b;
                                o_err_flag <= '0';
                            else
                                --sacc <= signed(term_a) ** signed(term_b);
                                o_err_flag <= '0';
                            end if;
                        when A_ABS =>
                            if (i_signed = '1') then
                                sacc <= ABS(signed(term_a));
                            else
                                o_err_flag <= '0';
                            end if;
                        when A_MOD =>
                            if (i_signed = '1' AND term_b /= 0) then
                                sacc <= signed(term_a) MOD signed(term_b);
                            else
                                o_err_flag <= '0';
                            end if;
                        when A_REM =>
                            if (i_signed = '0' AND term_b /= 0) then
                                uacc <= term_a REM term_b;
                            else
                                o_err_flag <= '0';
                            end if;
                        when TEQ =>
                        when TNQ =>
                        when TLT =>
                        when TGT =>
                        when TLE =>
                        when TGE =>
                        when LAND =>
                            uacc <= term_a AND term_b;
                        when LOR =>
                            uacc <= term_a OR term_b;
                        when LNOT =>
                            if (i_signed = '0') then
                                uacc <= NOT term_a;
                            else
                                uacc <= NOT term_b;
                            end if;
                        when LNAND =>
                            uacc <= term_a NAND term_b;
                        when LNOR =>
                            uacc <= term_a NOR term_b;
                        when LXOR =>
                            uacc <= term_a XOR term_b;
                        when LXNOR =>
                            uacc <= term_a XNOR term_b;
                        when CSLL =>
                        when CSRL =>
                        when CSLA =>
                        when CSRA =>
                        when CROL =>
                        when CROR =>
                        when NOP =>
                        when others =>
                            o_err_flag <= '0';
                    end case;
                else
                    -- Handles loading into term A
                    if (i_read_loc_a = '0' AND i_read_en_a = '0') then -- reading from bus and read enable is active
                        term_a <= unsigned(i_bus_in);
                    elsif (i_read_loc_a = '1' AND i_read_en_a = '0') then
                        case i_GPR_a_sel is
                            when "00" =>
                                term_a <= unsigned(i_GPR_a_in);
                            when "01" =>
                                term_a <= unsigned(i_GPR_b_in);
                            when "10" =>
                                term_a <= unsigned(i_GPR_c_in);
                            when "11" =>
                                term_a <= unsigned(i_GPR_c_in);
                            when others =>
                                n_error <= '0';
                        end case;
                    end if;

                    -- Handles loading into term B
                    if (i_read_loc_b = '0' AND i_read_en_b = '0') then
                        term_b <= unsigned(i_bus_in);
                    elsif(i_read_loc_b = '1' AND i_read_en_b = '0') then
                        case i_GPR_b_sel is
                            when "00" =>
                                term_b <= unsigned(i_GPR_a_in);
                            when "01" =>
                                term_b <= unsigned(i_GPR_b_in);
                            when "10" =>
                                term_b <= unsigned(i_GPR_c_in);
                            when "11" =>
                                term_b <= unsigned(i_GPR_c_in);
                            when others =>
                                n_error <= '0';
                        end case;
                    end if;

                    -- Handles acc register output
                    if (i_acc_oe = '0') then
                        if(i_signed = '0') then
                            o_acc_out <= std_logic_vector(uacc);
                        else
                            o_acc_out <= std_logic_vector(sacc);
                        end if;
                    else
                        o_acc_out <= (others => 'Z');
                    end if;
                end if;
            end if;
        end if;
    end process p_on_clk;
end architecture rtl;