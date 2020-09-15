library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package common is

type t_errors is (DIV_ZERO, BOUNDS_EXCEED, INVALID_SETUP, UNKNOWN, NONE, UNDERFLOW, OVERFLOW, ICE);
type t_ops is (ADD, SUB, MUL, DIV, NEG, EXP, A_ABS, A_MOD, A_REM, TEQ, TNQ, TLT, TGT, TLE, TGE, LAND, LOR, LNOT, LNAND, LNOR, LXOR, LXNOR, CSLL, CSRL, CSLA, CSRA, CROL, CROR, NOP);

function to_slv (e : t_errors) return std_logic_vector;
function to_ops_from_slv (s: std_logic_vector(5 downto 0)) return t_ops;

end common;

package body common is

    function to_slv (e : t_errors) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(t_errors'pos(e), 8));
    end to_slv;

    function to_ops_from_slv (s: std_logic_vector(5 downto 0) := (others => '0')) return t_ops is
    begin
        case s is
            when "000000" => 
                return ADD;
            when others =>
                return NOP;
        end case;
    end to_ops_from_slv;

end common;