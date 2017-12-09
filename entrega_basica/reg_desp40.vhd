library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity reg_desp40 is
 Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
 CLK : in STD_LOGIC; -- Reloj de muestreo
 Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
end reg_desp40;

architecture a_reg_desp40 of reg_desp40 is
signal reg  : STD_LOGIC_VECTOR (39 downto 0); 
begin
process (CLK)
  begin
  if (CLK'event and CLK='1') then
		
		reg(39 downto 1) <= reg(38 downto 0);
		reg(0)<=SIN;
		
  end if;
end process;
Q<=reg;
end a_reg_desp40;