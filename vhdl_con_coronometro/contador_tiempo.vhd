----------------------------------------
-- Cronómetro
-- 
-- Módulo encargado de llevar la cuenta  de minutos
-- y segundos del cronometro integrado  en el 
-- proyecto.
--
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cronometro is
    Port ( 
        reset : in STD_LOGIC; -- Control de reset del cronómetro
        start : in STD_LOGIC; -- Control de Start / Pause del cronómetro
        CLK : in  STD_LOGIC; -- Reloj de la FPGA
        minutos_decenas : out  STD_LOGIC_VECTOR (2 downto 0);
        minutos_unidades : out  STD_LOGIC_VECTOR (3 downto 0);
        segundos_decenas : out  STD_LOGIC_VECTOR (2 downto 0);
        segundos_unidades : out  STD_LOGIC_VECTOR (3 downto 0)
    );
end cronometro;

architecture a_cronometro of cronometro is

    signal cont_1Hz : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0');
    signal cont_segundos_unidades : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
    signal cont_minutos_unidades : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0'); 
    signal cont_segundos_decenas : STD_LOGIC_VECTOR (2 downto 0):= (others=>'0');
    signal cont_minutos_decenas : STD_LOGIC_VECTOR (2 downto 0):= (others=>'0'); 

begin
    PROC_CONT : process (CLK, reset, start)
    begin
        -- Se ponen a 0 todos los displays si el botón reset esta activo
        if reset = '1' then
            cont_1Hz <=(others=>'0');
            cont_segundos_unidades<=(others=>'0');
            cont_minutos_unidades<=(others=>'0');
            cont_segundos_decenas<=(others=>'0');
            cont_minutos_decenas<=(others=>'0');
        -- Con start a 1 comienza la cuenta
        -- Si alguno de los contadores llega a su limite
        -- (6 para las decenas y 9 para las unidades)
        -- pasan a ponerse a 0
        elsif start = '1' then
            if CLK'event and CLK='1' then
    		    cont_1Hz <= cont_1Hz + 1;
                if cont_1Hz >= 50000000 then -- división de frecuencia a 1 Hz 
			        cont_1Hz <=(others=>'0');
					if cont_segundos_unidades = 9 then
					    cont_segundos_unidades <= (others=>'0');
					    if cont_segundos_decenas = 5 then
						    cont_segundos_decenas <= (others=>'0');
                            if cont_minutos_unidades = 9 then
                                cont_minutos_unidades <= (others=>'0');
                                if cont_minutos_decenas = 5 then
                                    cont_minutos_decenas <= (others=>'0');
                                else
                                    cont_minutos_decenas <= cont_minutos_decenas + 1;
                                end if;
                            else
                                cont_minutos_unidades <= cont_minutos_unidades + 1;
                            end if;
                        else
                            cont_segundos_decenas <= cont_segundos_decenas + 1;
                        end if;
                    else
                        cont_segundos_unidades <= cont_segundos_unidades + 1;
                    end if;
                end if;
             end if;
        end if;
    end process;
      
    segundos_decenas<=cont_segundos_decenas;
    segundos_unidades<=cont_segundos_unidades;
    minutos_unidades<=cont_minutos_unidades;
    minutos_decenas<=cont_minutos_decenas;

end a_cronometro;

