library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity automata is
	Port ( 
		CLK : in STD_LOGIC; -- Reloj del autómata
		C0 : in STD_LOGIC; -- Condición de decision para “0”
		C1 : in STD_LOGIC; -- Condición de decisión para “1”
		DATO : out STD_LOGIC; -- Datos a cargar 
		CAPTUR : out STD_LOGIC; -- Enable del reg. de desplaz.
		VALID : out STD_LOGIC
	); -- Enable del reg de validación
end automata;
architecture a_automata of automata is
	type TIPO_ESTADO is (ESP_SYNC,AVAN_ZM,MUESTREO,DATO0,DATO1,DATOSYNC);
	signal ST : TIPO_ESTADO:= ESP_SYNC ; -- Estado inicial en que arranca
	signal salidas : STD_LOGIC_VECTOR (2 downto 0) :="000";
	begin
	process (CLK)
		variable cont : STD_LOGIC_VECTOR (7 downto 0):="00000000";
		begin
			if (CLK'event and CLK = '1') then
				case ST is
					when ESP_SYNC => 
						if (C0 = '0') and (C1 = '0') then
							ST<=AVAN_ZM;
						else
							ST<=ESP_SYNC;
						end if;
					
					when AVAN_ZM => 
						cont:= cont+1;
						if (cont=20) then
							cont:=(others=>'0'); 
							ST<=MUESTREO; 
						else
							ST<=AVAN_ZM; 
						end if; 
					
					when MUESTREO =>
						cont:= cont+1;
						if (cont=39) then
							if (C0 = '0') and (C1 = '0') then
								ST<=DATOSYNC;
								cont:=(others=>'0'); 
							elsif (C0 = '1') and (C1 = '0') then
								ST<=DATO0;
								cont:=(others=>'0'); 
							elsif (C0 = '0') and (C1 = '1') then
								ST<=DATO1;
								cont:=(others=>'0'); 
							else
								ST<=MUESTREO;
								cont:=(others=>'0');
							end if;
						else
							ST<=MUESTREO;
						end if;
					when others => 
						ST <= MUESTREO;
				end case;
			end if;
	 end process; 
	 with ST select
		 salidas<=
			"000" when ESP_SYNC,
			"000" when AVAN_ZM,
			"000" when MUESTREO,
			"010" when DATO0,
			"110" when DATO1,
			"001" when DATOSYNC,
			"000" when others;
	DATO <= salidas(2);
	CAPTUR <= salidas(1);
	VALID <= salidas(0);
end a_automata;