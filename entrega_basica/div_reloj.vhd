------------------------------------------------------
-- EJEMPLO 4: DIVISOR DEL RELOJ
--
-- Departamento de Ingeniería Electrónica (2013)
------------------------------------------------------ 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_reloj is
    Port ( CLK : in  STD_LOGIC;
           CLK_1MS : out  STD_LOGIC);
end div_reloj;

architecture a_div_reloj of div_reloj is

signal div1   : STD_LOGIC_VECTOR (31 downto 0); -- contador para dividir el reloj
signal S_1MS : STD_LOGIC;                      -- señal de period 1ms




begin
  DIV : process (CLK)
    begin
	   if (CLK'event and CLK='1') then
	     div1<=div1+1;           -- en cada flanco de CLK se incrementa div2

	     if div1=25000 then      -- div1=2500 cuando han transcurrido 500 us
	       S_1MS<=not S_1MS;     -- se conmuta el valor de S_1MS
	       div1<=(others=>'0');
	     end if;
		  
	   end if;
    end process;

  CLK_1MS<=S_1MS;  

end a_div_reloj;

