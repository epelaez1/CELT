--------------------------------------
-- Decodificador      
--
-- Activa los leds correspondientes, 
-- según los números dados (activos 
-- a nivel bajo)
--
-------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod7s is
    port ( DIN   : in  STD_LOGIC_VECTOR (3 downto 0);   -- Entrada de datos
           S7SEG : out STD_LOGIC_VECTOR (0 to 6)  -- Salidas 7seg (abcdefg)
    ); 
end decod7s;

architecture a_decod7s of decod7s is
begin
    with DIN select S7SEG <=
        "0000001" when "0000",  
        "1001111" when "0001",
        "0010010" when "0010",
        "0000110" when "0011",
        "1001100" when "0100",
        "0100100" when "0101",
        "0100000" when "0110",
        "0001111" when "0111",
        "0000000" when "1000",
        "0001100" when "1001",
        "1111111" when others;
end a_decod7s;
