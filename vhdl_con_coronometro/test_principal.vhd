--------------------------------------------------------------------------------
--
-- TEST  DEL MODULO PRINCIPAL CON EL CRONOMETRO INTEGRADO
--
-- Se alternan los botones de control del cronómetro
-- y se comrpueba el funcionamiento de todas las señales
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
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
    
    COMPONENT gen_signal
        PORT(
            clk : in  STD_LOGIC; -- Señal de reloj de 50 Mhz
            sal_dig : out  STD_LOGIC -- Señal de audio simulada
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
    signal sal_dig : STD_LOGIC;
    -- Clock period definitions
    constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    modulo_principal: principal PORT MAP (
        SIN => sal_dig, -- Se asocia la señal simulada a la señal de entrada del módulo principal
        CLK => CLK,
        RESET => RESET,
        START => START,
        CRONO => CRONO,
        SAL => SAL,
        ACT_SEG => ACT_SEG
    );

    simulated_signal: gen_signal PORT MAP (
        clk => CLK,
        sal_dig => sal_dig
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
        wait for 1000 ns;
		-- Modo cronometro y reset activado
        -- En el display se muestra el cronometro a 0
        RESET <= '1';
		CRONO <= '1';
		START <= '0';
		
		wait for 100 ns;
		-- Se desactiva el reset y se activa el start
      -- En el display se muestra el cronometro en funcionamiento
      RESET <= '0';
		START <= '1';
		wait for 400ms;
        -- Se pausa el cronometro
		START <= '0';
		wait for 10ms;
        -- Se desactiva el modo cronometro
        -- En el display se muestra la hora de la señal de entrada
		CRONO <= '0';
       wait for CLK_period*10;

       wait;
    end process;

END;
