--------------------------------------------------------------------------------
-- Test del módulo principal
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY test_principal IS
END test_principal;
 
ARCHITECTURE behavior OF test_principal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT principal
    PORT(
        CLK : IN  std_logic;
        SAL : OUT  std_logic_vector(6 downto 0);
        ACT_SEG : OUT  std_logic_vector(3 downto 0)
    );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal SAL : std_logic_vector(6 downto 0);
   signal ACT_SEG : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: principal PORT MAP (
        CLK => CLK,
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

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
    end process;

END;
