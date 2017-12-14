library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity gen_signal is
    Port ( clk : in  STD_LOGIC;
           sal_dig : out  STD_LOGIC);
end gen_signal;

architecture Behavioral of gen_signal is


signal clk_100ms : std_logic:='0';

signal hora_dec: std_logic_vector (2 downto 0):="001";   -- Configuracin digito decenas de la hora
signal hora_unid: std_logic_vector (3 downto 0):="1001"; -- Configuracin digito unidades de la hora
signal min_dec:std_logic_vector (2 downto 0):="011";     -- Configuracin digito decenas de los minutos
signal min_unid:std_logic_vector (3 downto 0):="0000";   -- Configuracin digito unidades de los minutos

signal cont:std_logic_vector (3 downto 0):="0000";
signal salida:std_logic:='0';

TYPE state_type IS (h6,h5,h4,h3,h2,h1,h0,m6,m5,m4,m3,m2,m1,m0,sync);
SIGNAL state : state_type :=h6;

begin

process (clk)

variable cont_clk : std_logic_vector (22 downto 0):= (others=>'0');
begin
if clk'event and clk='1' then
 clk_100ms <='0';
 cont_clk := cont_clk +1;
			
		-- DIFERENTES configuraciones de la duracin de 1 bit y por lo tanto de la trama (=15bits)
		-- SOLO debe haber una lnea de "if" sin comentar
		-- Si se quiere probar con el resto del circuito hay que ajustar tambin 
		-- la frecuencia de muestreo (seal de reloj CLK_M)
			
   -- if cont_clk>= 5000000 then         ----  1s por bit -         15s por trama
   -- if cont_clk>= 333333 then       ----  1/15s por bit -     1 s por trama
      if cont_clk>= 50000 then        ----  10ms por bit -     150ms por trama
   -- if cont_clk>= 5000 then          ----  1ms por bit -       15ms por trama
         
		  clk_100ms <= '1';
	     cont_clk := (others=>'0');
      end if;
end if;  
end process;

process (clk)


begin


if clk'event and clk='1' then

if clk_100ms ='1' then
case state is

WHEN h6 =>

  if cont>=9 then 
    state<=h5;
	 cont<="0000";
	else
    state<=h6;
	 cont<=cont+1;
  end if;

	
WHEN h5 =>
 
   if cont>=9 then 
    state<=h4;
	 cont<="0000";
	else
    state<=h5;
	 cont<=cont+1;
  end if;

   
WHEN h4 =>
 
   if cont>=9 then 
    state<=h3;
	 cont<="0000";
	else
    state<=h4;
	 cont<=cont+1;
  end if;
 

WHEN h3 =>
 
   if cont>=9 then 
    state<=h2;
	 cont<="0000";
	else
    state<=h3;
	  cont<=cont+1;
  end if;
  

WHEN h2 =>
 
   if cont>=9 then 
    state<=h1;
	 cont<="0000";
	else
    state<=h2;
	 cont<=cont+1;
  end if;
  

WHEN h1 =>
 
   if cont>=9 then 
    state<=h0;
	 cont<="0000";
	else
    state<=h1;
	 cont<=cont+1;
  end if;
   
		
WHEN h0 =>
 
   if cont>=9 then 
    state<=m6;
	 cont<="0000";
	else
    state<=h0;
	 cont<=cont+1;
  end if;
   

WHEN m6 =>
 
   if cont>=9 then 
    state<=m5;
	 cont<="0000";
	else
    state<=m6;
	 cont<=cont+1;
  end if;
   

WHEN m5 =>
 
   if cont>=9 then 
    state<=m4;
	 cont<="0000";
	else
    state<=m5;
	 cont<=cont+1;
  end if;
   


WHEN m4 =>
 
   if cont>=9 then 
    state<=m3;
	 cont<="0000";
	else
    state<=m4;
	 cont<=cont+1;
  end if;
   

WHEN m3 =>
 
   if cont>=9 then 
    state<=m2;
	 cont<="0000";
	else
    state<=m3;
	 cont<=cont+1;
  end if;
   
	
WHEN m2 =>
 
   if cont>=9 then 
    state<=m1;
	 cont<="0000";
	else
    state<=m2;
	 cont<=cont+1;	
  end if;
   
	
WHEN m1 =>
 
   if cont>=9 then 
    state<=m0;
	 cont<="0000";
	else
    state<=m1;
	 cont<=cont+1;
  end if;
   

WHEN m0 =>
 
   if cont>=9 then 
    state<=sync;

	 cont<="0000";
	 min_unid<=min_unid+'1';
	 if min_unid>=9 then 
	   min_unid<="0000";
           min_dec<=min_dec+'1';
           if min_dec>=5 then
             min_dec<="000";
             hora_unid<=hora_unid+'1';
             if hora_unid>=3 and hora_dec>=2 then
               hora_unid<="0000";
               hora_dec<="000";
              elsif hora_unid>=9 then
                hora_dec<=hora_dec+'1';
					 hora_unid<="0000";
             end if;
            end if;
	 end if;



	else
    state<=m0;
    cont<=cont+1;
end if;
   
	
WHEN sync => 
   if cont>=9 then 
    state<=h6;
	 cont<="0000";
	else
    state<=sync;
	 cont<=cont+1;
  end if;
   

WHEN others =>
      state<=h6;
	 
end case;
end if;
	
end if;

end process;

process (clk,state,cont,hora_dec,hora_unid,min_dec,min_unid)

begin

salida<='0';

if state=sync then 
    salida <='1';
	 
 elsif state=h6 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_dec(2)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif 	state=h5 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_dec(1)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif state=h4 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_dec(0)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif state=h3 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_unid(3)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif state=h2 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_unid(2)='1' then salida<='0';
	   else salida<='1';
	end if;	
  elsif state=h1 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_unid(1)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif state=h0 then
   if cont=0 then salida<='0';
	 elsif cont=1 and hora_unid(0)='1' then salida<='0';
	   else salida<='1';
	end if;	
  elsif state=m6 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_dec(2)='1' then salida<='0';
	   else salida<='1';
	end if;
  elsif state=m5 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_dec(1)='1' then salida<='0';
	   else salida<='1';
	end if;
   elsif state=m4 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_dec(0)='1' then salida<='0';
	   else salida<='1';
	end if;
	elsif state=m3 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_unid(3)='1' then salida<='0';
	   else salida<='1';
	end if;
	elsif state=m2 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_unid(2)='1' then salida<='0';
	   else salida<='1';
	end if;
	elsif state=m1 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_unid(1)='1' then salida<='0';
	   else salida<='1';
	end if;
	elsif state=m0 then
   if cont=0 then salida<='0';
	 elsif cont=1 and min_unid(0)='1' then salida<='0';
	   else salida<='1';
	end if;

end if;
end process;

sal_dig <= salida;

end Behavioral;

