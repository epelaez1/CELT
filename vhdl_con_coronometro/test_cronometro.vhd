-- test_cronometro Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY test_cronometro IS
  END test_cronometro;

  ARCHITECTURE behavior OF test_cronometro IS 

  -- Component Declaration
          COMPONENT cronometro
          PORT(
                 BOTON1_START : in STD_LOGIC;
					  BOTON2_RESET : in  STD_LOGIC;
					  CLK : in STD_LOGIC;
					  tiempo : OUT STD_LOGIC_VECTOR (15 downto 0)
                  );
          END COMPONENT;

   signal BOTON1_START : std_logic := '0';
   signal BOTON2_RESET : std_logic := '0';
   signal CLK : std_logic := '0';
	 	--Outputs
   signal tiempo : std_logic_vector(15 downto 0);
   constant CLK_period : time := 10 ns;

  BEGIN

  -- Component Instantiation
          uut: cronometro PORT MAP(
                  BOTON1_START => BOTON1_START,
                  BOTON2_RESET => BOTON2_RESET,
						CLK => CLK,
						tiempo => tiempo
						
          );


  --  Test Bench Statements
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
		  BOTON1_START <= '0';
		  BOTON2_RESET <= '0';
      wait for 1 ms;
      BOTON1_START <= '1';
      wait for 1000000 ms;
      BOTON1_START <= '0';
      wait for 100 ms;
      BOTON2_RESET <= '1';
      wait for 100 ms;
      BOTON2_RESET <= '0';
      -- insert stimulus here 

      wait;
   end process;

  END;
