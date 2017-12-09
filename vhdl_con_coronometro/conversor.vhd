library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
entity conversor is
	Port ( 
		cuenta_tiempo : in STD_LOGIC_VECTOR (15 downto 0); 
		minutos : out STD_LOGIC_VECTOR (7 downto 0);
		segundos : out STD_LOGIC_VECTOR(7 downto 0)
	); 
end conversor;
architecture a_conversor of conversor is

begin
    minutos<= std_logic_vector(to_unsigned(to_integer(unsigned(cuenta_tiempo))  mod 60, minutos'length) );	
    segundos<= std_logic_vector(to_unsigned(to_integer(unsigned(cuenta_tiempo)) rem 60,  segundos'length) );
end a_conversor;