library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.stop;

entity reg_tb is
end entity reg_tb;

architecture rtl_tb of reg_tb is

    component reg
    port(
        clk : in std_logic;
        rst : in std_logic;
        enable_in : in std_logic;
        enable_out : in std_logic;
        data_bus : inout std_logic_vector(7 downto 0)
    );
    end component;

    constant c_CLOCK_PERIOD : time := 1 ns;

    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal EI : std_logic := '0';
    signal EO : std_logic := '0';
    signal tb_data : std_logic_vector(7 downto 0) := (others => '0');

begin

    clock <= not clock after (c_CLOCK_PERIOD / 2);
    
    REG_DUT : reg port map (
        clk => clock,
        rst => reset,
        enable_in => EI,
        enable_out => EO,
        data_bus => tb_data
    );

    p_stim_DUT : process is
    begin

        wait until falling_edge(clock);
        reset <= '1';

        wait until falling_edge(clock);
        reset <= '0';

        wait until falling_edge(clock);
        tb_data <= "10101010";
        EI <= '1';

        wait until falling_edge(clock);
        EI <= '0';

        wait until falling_edge(clock);
        EO <= '1';

        wait until falling_edge(clock);
        EO <= '0';

        wait until falling_edge(clock);
        tb_data <= "01010101";
        EI <= '1';

        wait until falling_edge(clock);
        EI <= '0';

        wait until falling_edge(clock);
        reset <= transport not reset after 1 ns;

        wait until falling_edge(clock);
        reset <= transport not reset after 1 ns;
        
        wait until falling_edge(clock);
        -- Finishes the simulation
        stop;

    end process p_stim_DUT;

end architecture rtl_tb;