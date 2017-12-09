library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cronometro is
    Port ( BOTON1_START : in STD_LOGIC;
           BOTON2_RESET : in  STD_LOGIC;
           CLK : in STD_LOGIC;
           tiempo : OUT STD_LOGIC_VECTOR (15 downto 0)
           );
end cronometro;

architecture a_cronometro of cronometro is

signal cuenta_tiempo  : STD_LOGIC_VECTOR (15 downto 0);

component contador_tiempo 
    Port ( reset : in STD_LOGIC;
           start : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           tiempo : out  STD_LOGIC_VECTOR (15 downto 0):=(others=>'0'));
end component;


component conversor 
    Port ( 
      cuenta_tiempo : in STD_LOGIC_VECTOR (15 downto 0); 
      minutos : out STD_LOGIC_VECTOR (7 downto 0);
      segundos : out STD_LOGIC_VECTOR(7 downto 0)
    ); 
end component;

begin
contador_de_tiempo : contador_tiempo

            port map (
              reset  =>  BOTON2_RESET,
              start  =>  BOTON1_START,
              CLK    =>  CLK,
              tiempo => cuenta_tiempo
            ); 


conversor_a_seg_min : conversor

            port map (
  					  cuenta_tiempo   =>  cuenta_tiempo,
  					  minutos   =>  tiempo(15 downto 8),
              segundos => tiempo(7 downto 0)
            );


end a_cronometro;

-- Terminar visualizacion
