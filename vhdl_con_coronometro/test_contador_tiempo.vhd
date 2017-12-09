--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:39:19 11/27/2017
-- Design Name:   
-- Module Name:   C:/Users/alumno/Desktop/celt/archivos/test_contador_tiempo.vhd
-- Project Name:  proyecto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contador_tiempo
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
 
ENTITY test_contador_tiempo IS
END test_contador_tiempo;
 
ARCHITECTURE behavior OF test_contador_tiempo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador_tiempo
    PORT(
         reset : IN  std_logic;
         start : IN  std_logic;
         CLK : IN  std_logic;
         tiempo : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal tiempo : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador_tiempo PORT MAP (
          reset => reset,
          start => start,
          CLK => CLK,
          tiempo => tiempo
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
      -- Caso tipico, se enciende, se pausa y se resetea.
      wait for 100 ns;	
		  start <= '0';
		  reset <= '0';
      wait for CLK_period*500000*3;
      start <= '1';
      wait for CLK_period*500000*6;
      start <= '0';
      wait for CLK_period*500000*3;
      reset <= '1';
      wait for 100 ms;
      reset <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
