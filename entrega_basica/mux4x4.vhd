library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x4 is
    Port ( E0 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E0
           E1 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E1
           E2 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E2
           E3 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E3
           Y  : out  STD_LOGIC_VECTOR (3 downto 0);  -- salida Y
           S  : in   STD_LOGIC_VECTOR (1 downto 0)); -- entradas de control
    
end mux4x4;

architecture a_mux4x4 of mux4x4 is
begin

Y <= E0 when S="00" else  -- se selecciona la salida en función de las entradas
     E1 when S="01" else  -- de control
     E2 when S="10" else
     E3 when S="11";	  

end a_mux4x4;
