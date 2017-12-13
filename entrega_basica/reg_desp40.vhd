-------------------------------------------------------------
-- Registro de desplazamiento de 40 bits
-- 
-- Registro de desplazamiento de entrada serie y salida
-- paralelo que se encarga de muestrear 40 valores de la 
-- señal de entrada
--
--
--------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity reg_desp40 is
 Port ( SIN : in STD_LOGIC;    				    -- Datos de entrada serie
 CLK : in STD_LOGIC;  						    -- Reloj de muestreo
 Q : out STD_LOGIC_VECTOR (39 downto 0)); 	    -- Salida paralelo
end reg_desp40;

architecture a_reg_desp40 of reg_desp40 is
signal reg  : STD_LOGIC_VECTOR (39 downto 0);   -- Señal auxiliar. Copia del registro
begin
process (CLK)
  begin
  if (CLK'event and CLK='1') then
		
		reg(39 downto 1) <= reg(38 downto 0);   -- Se  desplazan los bits  una posición y se descarta el más significativo
		reg(0)<=SIN;                            -- Se asigna al bit menos significativo el valor de la señal de entrada
		
  end if;
end process;
Q<=reg;
end a_reg_desp40;