--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:34:55 12/09/2017
-- Design Name:   
-- Module Name:   /home/kike/Escritorio/Proyectos/celt/vhdl_con_coronometro/test_principal.vhd
-- Project Name:  prueba1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: principal
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
 
ENTITY test_principal IS
END test_principal;
 
ARCHITECTURE behavior OF test_principal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT principal
    PORT(
         SIN : IN  std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         START : IN  std_logic;
         CRONO : IN  std_logic;
         SAL : OUT  std_logic_vector(6 downto 0);
         ACT_SEG : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SIN : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal START : std_logic := '0';
   signal CRONO : std_logic := '0';

 	--Outputs
   signal SAL : std_logic_vector(6 downto 0);
   signal ACT_SEG : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: principal PORT MAP (
          SIN => SIN,
          CLK => CLK,
          RESET => RESET,
          START => START,
          CRONO => CRONO,
          SAL => SAL,
          ACT_SEG => ACT_SEG
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
		RESET <= '1';
		CRONO <= '1';
		START <= '0';
		SIN <= '1';
		wait for 100 ns;
		RESET <= '0';
		START <= '1';
		wait for 1000ms;
		START <= '0';
		wait for 10ms;
		CRONO <= '0';
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
