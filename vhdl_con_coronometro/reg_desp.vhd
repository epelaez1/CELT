library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity reg_desp is
	Port (
		SIN : in STD_LOGIC; -- Datos de entrada serie
		CLK : in STD_LOGIC; -- Reloj
		EN : in STD_LOGIC; -- Enable
		Q : out STD_LOGIC_VECTOR (13 downto 0)
	); -- Salida paralelo
end reg_desp;
architecture a_reg_desp of reg_desp is
signal reg  : STD_LOGIC_VECTOR (13 downto 0);
begin
process (CLK)
  begin
  if (CLK'event and CLK='1') then
		if EN = '1' then	
			reg(13 downto 1) <= reg(12 downto 0);
			reg(0)<=SIN;
		end if;
  end if;
end process;
Q<=reg;
end a_reg_desp;
