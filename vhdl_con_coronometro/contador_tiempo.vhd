library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_tiempo is
    Port ( reset : in STD_LOGIC;
           start : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           tiempo : out  STD_LOGIC_VECTOR (15 downto 0):=(others=>'0'));
end contador_tiempo;

architecture a_contador_tiempo of contador_tiempo is

signal cont_1Hz : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador 1
signal cont_tiempo : STD_LOGIC_VECTOR (15 downto 0):= (others=>'0'); -- contador 1

begin
    PROC_CONT : process (CLK)
    begin
        if reset = '1' then
            cont_1Hz <=(others=>'0');
            cont_tiempo <=(others=>'0');
        end if;
        if start = '1' then
            if CLK'event and CLK='1' then
    		      cont_1Hz <= cont_1Hz + 1;
                if cont_1Hz >= 500000 then -- división de frecuencia a 1 Hz DOS CEROS MENOS
                    cont_tiempo <= cont_tiempo+1;
                    cont_1Hz <=(others=>'0');
                    if cont_tiempo = 3599 then -- maximo tiempo que se puede mostrar 99:99
                        cont_tiempo <=(others=>'0');
                    end if;
                end if;

             end if;
        end if;
     end process;
	  
     tiempo<=cont_tiempo;

end a_contador_tiempo;

