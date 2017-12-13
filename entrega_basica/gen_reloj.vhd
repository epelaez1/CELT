---------------------------------------------------------
-- Generador de señal digital de 40 Hz
--
-- Este módulo se encarga de generar una señal de reloj
-- de 40 Hz que se usará para muestrear la señal de
-- entrada.
-- Ésta se calcula partir de la señal de reloj interna 
-- de 50 MHz que posee la FPGA.
--
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_reloj is
    Port ( CLK : in  STD_LOGIC;      -- Reloj de la FPGA
           CLK_M : out  STD_LOGIC);  -- Reloj de muestreo
end gen_reloj;

architecture a_gen_reloj of gen_reloj is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador 1
signal S_M : STD_LOGIC :='0';

begin
    PROC_CONT : process (CLK)
    begin
        if CLK'event and CLK='1' then
		      cont_M <= cont_M + 1;
            if cont_M >= 625000 then -- división de frecuencia a 40 Hz
                S_M <=not S_M;
                cont_M <=(others=>'0');
            end if;
         end if;
     end process;
	  
     CLK_M<=S_M;

end a_gen_reloj;
