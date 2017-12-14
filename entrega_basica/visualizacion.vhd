--------------------------------------------
-- Mdulo de visualizacin
-- 
-- Conjunto de componentes que muestran en el display 
-- de la FPGA la hora calculada a partir de la seal
-- binaria recibida
--
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
    Port ( 
        CLK : in  STD_LOGIC;                       -- Reloj interno de la FPGA
        E0 : in   STD_LOGIC_VECTOR (3 downto 0);   -- Entrada destinada al display de unidades
        E1 : in   STD_LOGIC_VECTOR (3 downto 0);   -- Entrada destinada al display de decenas
        E2 : in   STD_LOGIC_VECTOR (3 downto 0);   -- Entrada destinada al display de centenas
        E3 : in   STD_LOGIC_VECTOR (3 downto 0);   -- Entrada destinada al display de millares
        SEG7 : out  STD_LOGIC_VECTOR (6 downto 0); -- Valor de cada uno de los segmentos de un nmero
        AN : out  STD_LOGIC_VECTOR (3 downto 0) -- Seal de control de activacin del display
    );  
end visualizacion;

architecture a_visualizacion of visualizacion is

    signal N_S  : STD_LOGIC_VECTOR (1 downto 0);    -- Conexin entre el mdulo refresco y el multiplexor
    signal N_Y  : STD_LOGIC_VECTOR (3 downto 0);    -- Conexin entre el multiplexor y el decodificador




    component mux4x4 
        Port ( 
            E0 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E0
            E1 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E1
            E2 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E2
            E3 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E3
            Y  : out  STD_LOGIC_VECTOR (3 downto 0);  -- salida Y
            S  : in   STD_LOGIC_VECTOR (1 downto 0)   -- entradas de control
        );
        
    end component;

    component decod7s 
        port ( 
            DIN   : in  STD_LOGIC_VECTOR (3 downto 0);   -- entrada de datos
            S7SEG : out STD_LOGIC_VECTOR (0 to 6) -- salidas 7seg
        );    
    end component;

    component refresco
        Port ( 
            CLK : in  STD_LOGIC;			-- entrada de reloj
            AN : out  STD_LOGIC_VECTOR (3 downto 0); -- activacin displays
            S : out  STD_LOGIC_VECTOR (1 downto 0) -- seleccin en el MUX
        ); 
    end component;

    begin
    U1 : decod7s
        port map (
            DIN=>N_Y,
            S7SEG=>SEG7
        ); 
    U2 : mux4x4
        port map (
        	E0=>E0,
        	E1=>E1,
        	E2=>E2,
        	E3=>E3,
        	Y=>N_Y,
    		S=>N_S
    	);
    U3 : refresco
        port map (
        	CLK=>CLK,
            AN=>AN,
            S=>N_S
        );

end a_visualizacion;

