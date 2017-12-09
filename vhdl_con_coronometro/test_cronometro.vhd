--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:52:08 12/09/2017
-- Design Name:   
-- Module Name:   /home/kike/Escritorio/Proyectos/celt/vhdl_con_coronometro/test_cronometro.vhd
-- Project Name:  prueba1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cronometro
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_cronometro IS
END test_cronometro;
 
ARCHITECTURE behavior OF test_cronometro IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cronometro
    PORT(
         reset : IN  std_logic;
         start : IN  std_logic;
         CLK : IN  std_logic;
         minutos_decenas : OUT  std_logic_vector(2 downto 0);
         minutos_unidades : OUT  std_logic_vector(3 downto 0);
         segundos_decenas : OUT  std_logic_vector(2 downto 0);
         segundos_unidades : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal minutos_decenas : std_logic_vector(2 downto 0);
   signal minutos_unidades : std_logic_vector(3 downto 0);
   signal segundos_decenas : std_logic_vector(2 downto 0);
   signal segundos_unidades : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cronometro PORT MAP (
          reset => reset,
          start => start,
          CLK => CLK,
          minutos_decenas => minutos_decenas,
          minutos_unidades => minutos_unidades,
          segundos_decenas => segundos_decenas,
          segundos_unidades => segundos_unidades
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			reset <= '1';
      wait for 100 ns;	
			reset <= '0';
		wait for 100 ns;	
			start <= '1';
		wait for 10000 ms;	
			start <= '0';

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
