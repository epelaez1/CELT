-----------------------------------------------------------------
-- TEST DEL MODULO PRINCIPAL
-- 
-- Para poder testear el modulo principal se le proporciona
-- una señal de entrada simulada, idéntica a la proporcionada
-- a la salida del circuito analógico.
--
-----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY test_principal IS
END test_principal;
 
ARCHITECTURE behavior OF test_principal IS 
 
 
    COMPONENT principal
        PORT(
            SIN : IN  std_logic; -- Señal de entrada a muestrear
            CLK : IN  std_logic; -- Señal de reloj de 50 MHz
            ACT_SEG : OUT  std_logic_vector(3 downto 0); -- Salida de selección de display
            SAL : OUT  std_logic_vector(6 downto 0) -- Salida de activación de segmentos
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
    
    --Outputs
    signal ACT_SEG : std_logic_vector(3 downto 0);
    signal SAL : std_logic_vector(6 downto 0);
    signal sal_dig : STD_LOGIC;
    -- Clock period definitions
    constant CLK_period : time := 10 ns;
    
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    modulo_principal: principal PORT MAP (
        SIN => sal_dig, -- Se asocia la señal simulada a la señal de entrada del módulo principal
        CLK => CLK,
        ACT_SEG => ACT_SEG,
        SAL => SAL
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
        -- No se requieren modificaciones a lo largo del tiempo.
        -- Basta con visualizar las señales de cada módulo para
        -- comprobar el correcto funcionamiento.
        -- hold reset state for 100 ns.
        wait for 100 ns;  

        wait for CLK_period*10;

        -- insert stimulus here 

        wait;
    end process;

END;
