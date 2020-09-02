-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
-- CREATED		"Tue Aug 25 16:10:29 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Nx8 IS 
	PORT
	(
		CLOCK_50 :  IN  STD_LOGIC;
		RESET_N :  IN  STD_LOGIC;
		GPIO_0 :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		LEDR :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END Nx8;

ARCHITECTURE bdf_type OF Nx8 IS 

COMPONENT direct_bus_control
	PORT(i_clk : IN STD_LOGIC;
		 i_rst : IN STD_LOGIC;
		 i_module_en : IN STD_LOGIC;
		 i_write_enable : IN STD_LOGIC;
		 i_switches : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 o_databus : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg
	PORT(i_clock : IN STD_LOGIC;
		 i_rst : IN STD_LOGIC;
		 i_enable_in : IN STD_LOGIC;
		 i_enable_out : IN STD_LOGIC;
		 o_data_bus : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fourxone_decoder
	PORT(i_en : IN STD_LOGIC;
		 i_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 o_decode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	CORE-CLOCK_PEDGE :  STD_LOGIC;
SIGNAL	dBus :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	nReset :  STD_LOGIC;
SIGNAL	read_decode :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	Read_Sel :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	write_decode :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	Write_Sel :  STD_LOGIC_VECTOR(1 DOWNTO 0);


BEGIN 



b2v_dBus_HID : direct_bus_control
PORT MAP(i_clk => CORE-CLOCK_PEDGE,
		 i_rst => nReset,
		 i_module_en => GPIO_0(6),
		 i_write_enable => GPIO_0(7),
		 i_switches => SW,
		 o_databus => dBus);


b2v_REG_A : reg
PORT MAP(i_clock => CORE-CLOCK_PEDGE,
		 i_rst => nReset,
		 i_enable_in => read_decode(0),
		 i_enable_out => write_decode(0),
		 o_data_bus => dBus);


b2v_REG_B : reg
PORT MAP(i_clock => CORE-CLOCK_PEDGE,
		 i_rst => nReset,
		 i_enable_in => read_decode(1),
		 i_enable_out => write_decode(1),
		 o_data_bus => dBus);


b2v_reg_bank_rd_decoder : fourxone_decoder
PORT MAP(i_en => GPIO_0(0),
		 i_sel => Read_Sel,
		 o_decode => read_decode);


b2v_reg_bank_wr_decoder : fourxone_decoder
PORT MAP(i_sel => Write_Sel,
		 o_decode => write_decode);


b2v_REG_C : reg
PORT MAP(i_clock => CORE-CLOCK_PEDGE,
		 i_rst => nReset,
		 i_enable_in => read_decode(2),
		 i_enable_out => write_decode(2),
		 o_data_bus => dBus);


b2v_REG_D : reg
PORT MAP(i_clock => CORE-CLOCK_PEDGE,
		 i_rst => nReset,
		 i_enable_in => read_decode(3),
		 i_enable_out => write_decode(3),
		 o_data_bus => dBus);

CORE-CLOCK_PEDGE <= CLOCK_50;
LEDR(1) <= CORE-CLOCK_PEDGE;
LEDR(9 DOWNTO 2) <= dBus(7 DOWNTO 0);
nReset <= RESET_N;

Read_Sel(0) <= GPIO_0(2);
Read_Sel(1) <= GPIO_0(3);
Write_Sel(0) <= GPIO_0(4);
Write_Sel(1) <= GPIO_0(5);
END bdf_type;