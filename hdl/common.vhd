library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package common is

type t_errors is (DIV_ZERO, BOUNDS_EXCEED, INVALID_SETUP, UNKNOWN, NONE);
type t_ops is (ADD, SUB, MUL, DIV, NEG, EXP, A_ABS, A_MOD, A_REM, TEQ, TNQ, TLT, TGT, TLE, TGE, LAND, LOR, LNAND, LNOR, LXOR, LXNOR, CSLL, CSRL, CSLA, CSRA, CROL, CROR, NOP);

function to_slv (e : t_errors) return std_logic_vector;
function to_err (s: std_logic_vector(5 downto 0)) return t_ops;


end common;

package body common is

end common;