-----------------------------------------
-- Refresco
--
--
--
-----------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
    Port ( CLK : in  STD_LOGIC;			-- entrada de reloj
           AN : out  STD_LOGIC_VECTOR (3 downto 0); -- activación displays
           S : out  STD_LOGIC_VECTOR (1 downto 0)); -- selección en el MUX
end refresco;

architecture a_refresco of refresco is

signal SS  : STD_LOGIC_VECTOR (1 downto 0); 
signal div1   : STD_LOGIC_VECTOR (31 downto 0);
begin

process (CLK)
  begin
  if (CLK'event and CLK='1') then
		div1<=div1+1;   
		if div1=25000 then      -- div1=2500 cuando han transcurrido 500 us
	       SS<=SS+1;    -- se conmuta el valor de S_1MS
	       div1<=(others=>'0');
	   end if;
  end if;
  end process;

S<=SS;
AN<="0111" when SS="00" else   -- activa cada display en function del valor de SS
    "1011" when SS="01" else
    "1101" when SS="10" else
    "1110" when SS="11";

end a_refresco;
