-----------------------------------------------------
-- Refresco
-- 
-- A partir de la señal de reloj interna de la FPGA
-- selecciona cuál de los cuatro displays debe estar
-- activo.
-- 
-----------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
    Port ( 
        CLK : in  STD_LOGIC;			-- Entrada de reloj
        AN : out  STD_LOGIC_VECTOR (3 downto 0); -- Activación displays
        S : out  STD_LOGIC_VECTOR (1 downto 0)  -- Selección en el MUX
    );
end refresco;

architecture a_refresco of refresco is

    signal SS  : STD_LOGIC_VECTOR (1 downto 0):= (others=>'0'); 
    signal div1   : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- Contador
    begin

    process (CLK)
        begin
        if (CLK'event and CLK='1') then
    	    div1<=div1+1;   
    	    if div1=25000 then      -- Tras 25000 ciclos de reloj han transcurrido 50 us
                SS<=SS+1;          -- Se conmuta el valor de S_1MS
                div1<=(others=>'0');
            end if;
        end if;
    end process;

    S<=SS;
    AN<="0111" when SS="00" else   -- Activa un display u otro en función del valor de SS
        "1011" when SS="01" else
        "1101" when SS="10" else
        "1110" when SS="11";

end a_refresco;
