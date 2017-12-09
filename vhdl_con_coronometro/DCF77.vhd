library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DCF77 is
    Port ( 
           CLK : in  STD_LOGIC;
           SAL : OUT STD_LOGIC_VECTOR (5 downto 0)
           );
end DCF77;

architecture a_dcf77 of DCF77 is

signal reg_to_sum  : STD_LOGIC_VECTOR (39 downto 0);
signal CLK_M  : STD_LOGIC;
signal audio  : STD_LOGIC;


component gen_signal 
         Port ( clk : in  STD_LOGIC;
           sal_dig : out  STD_LOGIC);
    
end component;


component reg_desp40 
     Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
            CLK : in STD_LOGIC; -- Reloj de muestreo
            Q :  out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
    
end component;

component sumador40 
    Port ( ENT : in  STD_LOGIC_VECTOR (39 downto 0);
           SAL : out  STD_LOGIC_VECTOR (5 downto 0));   
end component;

component gen_reloj
        Port ( CLK : in  STD_LOGIC;
           CLK_M : out  STD_LOGIC);
end component;




begin
reg_desp : reg_desp40

            port map (
              SIN  =>  audio,
              CLK  =>  CLK_M,
              Q    =>  reg_to_sum
            ); 


sumador : sumador40

            port map (
  					  ENT   =>  reg_to_sum,
  					  SAL   =>  SAL
            );


clock40 : gen_reloj

            port map (
					    CLK   =>  CLK,
              CLK_M =>  CLK_M
               
            );

generated_signal : gen_signal

            port map (
              CLK     =>  CLK,
              sal_dig =>  audio
            );

end a_dcf77;
