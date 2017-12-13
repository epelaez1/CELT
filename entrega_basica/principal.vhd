--------------------------------------
--Principal
--
--Agrupa todos los submódulos 
--
--
--------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity principal is
    Port ( SIN : in STD_LOGIC; --entrada de datos
           CLK : in  STD_LOGIC; --entrada de reloj
           SAL : OUT STD_LOGIC_VECTOR (6 downto 0); --segmentos de displays
           ACT_SEG : OUT STD_LOGIC_VECTOR (3 downto 0) --control de displays
           );
end principal;

architecture a_principal of principal is

signal reg_to_sum  : STD_LOGIC_VECTOR (39 downto 0); --comunica el registro de desplazamiento40 con el sumador
signal CLK_M  : STD_LOGIC;
--signal audio  : STD_LOGIC;
signal sum_out : STD_LOGIC_VECTOR (5 downto 0); --salida del sumador que recibe el comparador
signal GTU1 : STD_LOGIC; --salida sumador mayor que umbral 1
signal LEU1 : STD_LOGIC; --salida sumador menor que umbral 1
signal LEU2 : STD_LOGIC; --salida sumador menor que umbral 2
signal SAND : STD_LOGIC; --salida del and
signal Dat_SIN : STD_LOGIC; --comunica Dato (autómata) con SIN del registro de desplazamiento
signal Capt_EN : STD_LOGIC; --comunica Captura (autómata) con EN del registro de desplazamiento
signal Val_EN : STD_LOGIC; --comunica Validar (autómata) con EN del registro de validación
signal reg_desp_val : STD_LOGIC_VECTOR (13 downto 0); --comunica el registro de desplazamiento con el r.validacion
signal val_visual : STD_LOGIC_VECTOR (13 downto 0); --comunica el registro de validacion con visualización

--component gen_signal 
--         Port ( clk : in  STD_LOGIC;
--           sal_dig : out  STD_LOGIC);
--    
--end component;


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

component comparador
        Port ( 
          P : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada P
          Q : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada Q
          PGTQ : out STD_LOGIC; -- Salida P>Q
          PLEQ : out STD_LOGIC
        ); -- Salida P≤Q
end component;
component AND_2
        Port ( 
            A : in STD_LOGIC; -- Entrada A
            B : in STD_LOGIC; -- Entrada B
            S : out STD_LOGIC
        ); 
end component;
component automata
        Port ( 
            CLK : in STD_LOGIC; -- Reloj del autómata
            C0 : in STD_LOGIC; -- Condición de decision para “0”
            C1 : in STD_LOGIC; -- Condición de decisión para “1”
            DATO : out STD_LOGIC; -- Datos a cargar
            CAPTUR : out STD_LOGIC; -- Enable del reg. de desplaz.
            VALID : out STD_LOGIC
        );
end component;
component reg_desp 
  Port (
    SIN : in STD_LOGIC; -- Datos de entrada serie
    CLK : in STD_LOGIC; -- Reloj
    EN : in STD_LOGIC; -- Enable
    Q : out STD_LOGIC_VECTOR (13 downto 0)
  ); -- Salida paralelo
end component;
component registro 
  Port (
    ENTRADA : in STD_LOGIC_VECTOR (13 downto 0); -- Entradas
    SALIDA : out STD_LOGIC_VECTOR (13 downto 0); -- Salidas
    EN : in STD_LOGIC; -- Enable
    CLK : in STD_LOGIC
  ); -- Reloj
end component;
component visualizacion 
   Port ( 
           CLK : in  STD_LOGIC;
           E0 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E0
           E1 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E1
           E2 : in   STD_LOGIC_VECTOR (3 downto 0);  -- entrada E2
           E3 : in   STD_LOGIC_VECTOR (3 downto 0);
           SEG7 : out  STD_LOGIC_VECTOR (6 downto 0);
           AN : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

begin
registro_desp40 : reg_desp40

            port map (
              SIN  =>  SIN,
              CLK  =>  CLK_M,
              Q    =>  reg_to_sum
            ); 


sumador : sumador40

            port map (
  					  ENT   =>  reg_to_sum,
  					  SAL   =>  sum_out
            );


clock40 : gen_reloj

            port map (
					    CLK   =>  CLK,
              CLK_M =>  CLK_M
               
            );

--generated_signal : gen_signal
--
--            port map (
--              CLK     =>  CLK,
--              sal_dig =>  audio
--            );
comparadorU1 : comparador 
            port map (
              P => sum_out, --entra al comparador la salida del sumador
              Q => "100010", --umbral 1, 34
              PGTQ => GTU1,
              PLEQ => LEU1
              );
comparadorU2 : comparador 
            port map (
              P => sum_out, --entra al comparador la salida del sumador
              Q => "100110", --umbral 2, 38
              PGTQ => open, 
              PLEQ => LEU2
              );
comparador_and_2 : AND_2
              port map (
                  A => GTU1, --entra cuando sal_sumador es mayor que umbral 1
                  B => LEU2, --entra cuando sal_sumador es menor que umbral 2
                  S => SAND
                );
automata_moore : automata
              port map (
                  CLK => CLK_M,
                  C0 => SAND,
                  C1 => LEU1,
                  DATO => Dat_SIN,
                  CAPTUR => Capt_EN,
                  VALID => Val_EN
                );
registro_desp : reg_desp
              port map (
                SIN => Dat_SIN,
                CLK => CLK_M,
                EN => Capt_EN,
                Q => reg_desp_val
                );
reg : registro
              port map (
                ENTRADA => reg_desp_val,
                SALIDA => val_visual,
                EN => Val_EN,
                CLK => CLK_M
                );
display : visualizacion
              port map (
                CLK => CLK,
                E3(2 downto 0)  => val_visual(13 downto 11),
                E3(3) => '0',
                E2  => val_visual(10 downto 7),
                E1(2 downto 0)  => val_visual(6 downto 4),
                E1(3) => '0',
                E0  => val_visual(3 downto 0),
                SEG7 => SAL, 
                AN  => ACT_SEG
                );
end a_principal;

-- Terminar visualizacion
