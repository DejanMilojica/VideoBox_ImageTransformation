-- Transformacija_Slike.vhd

-- Generisanje pozicija piksela, na osnovu preslikavanja unazad!
-- Date pozicije se preko Avalon Stream-a prenose ka bloku 'Pozicioniranje_Piksela_u_SDRAM', putem koga se pikseli sa odgovarajucim preuzetim pozicijama, smjestaju u SDRAM!
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.conv_std_logic_vector;

entity Transformacija_Slike is
	port (
		clock_clk              : in  std_logic                     := '0';             --                  clock.clk
		reset_reset            : in  std_logic                     := '0';             --                  reset.reset
		
		out_data               : out std_logic_vector(31 downto 0);                    --                    out.data
		out_ready              : in  std_logic                     := '0';             --                       .ready
		out_startofpacket      : out std_logic;                                        --                       .startofpacket
		out_endofpacket        : out std_logic;                                        --                       .endofpacket
		out_valid              : out std_logic;                                        --                       .valid
		
		avalon_slave_write     : in  std_logic                     := '0';             -- avalon_slave_parametar.write
		avalon_slave_writedata : in  std_logic_vector(31 downto 0) := (others => '0'); --                       .writedata
		
		in_data                : in  std_logic_vector(63 downto 0) := (others => '0'); --                     in.data
		in_ready               : out std_logic;                                        --                       .ready
		in_startofpacket       : in  std_logic                     := '0';             --                       .startofpacket
		in_endofpacket         : in  std_logic                     := '0';             --                       .endofpacket
		in_valid               : in  std_logic                     := '0'              --                       .valid
	);
end entity Transformacija_Slike;

architecture rtl of Transformacija_Slike is

-- Parametar transformacije!
signal parametar 			: std_logic_vector(31 downto 0) := (others => '0');

-- Definisemo zavrsetak transformacije!
signal KRAJ	: std_logic              := '0';

 -- Dimenzije slike za prenos na VGA!
constant IMG_WIDTH : natural := 640;
constant IMG_HEIGH : natural := 480;

-- Horizontalni/Vertiklani pomjerac!
signal Xpos	: integer range 0 to 640 :=0;
signal Ypos	: integer range 0 to 480 :=0;

-- Vrijednosti polja afine matrice!
signal a : std_logic_vector(15 downto 0) := (others => '0');
signal b : std_logic_vector(15 downto 0) := (others => '0');
signal c : std_logic_vector(15 downto 0) := (others => '0');
signal d : std_logic_vector(15 downto 0) := (others => '0');

signal a_int,b_int,c_int,d_int : integer;  
signal x_pozicija, y_pozicija : integer;					


begin

	a_int <= to_integer(signed(a));  	  
	b_int <= to_integer(signed(b));
	c_int <= to_integer(signed(c));
	d_int <= to_integer(signed(d));
		

	proces_preslikavanje_unazad:process(clock_clk) is
	begin
		if falling_edge(clock_clk) then
			
			-- Prihvatanje parametra koji definise tip transformacije!
			if avalon_slave_write = '1' then
				parametar <= avalon_slave_writedata; -- Cuvanje prihvacenog parametra transformacije!
				in_ready <= '1';
				
				if in_valid = '1' then
					-- Prihvacanje elemenata transformacione matrice!
					a <= in_data(63 downto 48);
					b <= in_data(47 downto 32);
					c <= in_data(31 downto 16);
					d <= in_data(15 downto 0);
				end if;
				-- Resetovanje horizontalnog/vertikalnog pomjeraca!
				Xpos <= 0;
				Ypos <= 0;
				KRAJ <= '0';

			end if;  
			
			if( KRAJ = '0' and out_ready = '1') then
				out_valid <= '1';
				
				-- Odredjivanje pozicije piksela, na osnovu formule za preslikavanje unazad, definisane unutar izvjestaja!
				x_pozicija <= (d_int*Xpos-d_int*IMG_WIDTH/2-b_int*Ypos+b_int*IMG_HEIGH/2)/(a_int*d_int-b_int*c_int);
				y_pozicija <= (-c_int*Xpos+c_int*IMG_WIDTH/2+a_int*Ypos-a_int*IMG_HEIGH/2)/(a_int*d_int-b_int*c_int);
				out_data(31 downto 16) <= conv_std_logic_vector(x_pozicija, a'length);
				out_data(15 downto 0) <= conv_std_logic_vector(y_pozicija, a'length);

				--out_data(31 downto 16) <=  std_logic_vector(integer((Ypos-Xpos*integer((d)/(b))+integer(IMG_WIDTH/2)*integer((d)/(b))-integer(IMG_HEIGH/2))/((c)-((a)*integer(d/b))))); 	-- x pozicija!
				--out_data(15 downto 0) <=  std_logic_vector(integer((Ypos*integer((a)/((b)*(c)))-integer(Xpos/b)+integer(IMG_WIDTH/(2*b))-IMG_HEIGH*integer(a/(2*b*c)))/(integer((a*d/(b*c)-1))))); -- y pozicija!
			
				if(Xpos = IMG_WIDTH-1)then	
					Xpos<=0;
					if(Ypos = IMG_HEIGH-1)then
						Ypos<=0;
						KRAJ <= '1';
					else
						Ypos<=Ypos+1;
					end if;
					
				else	
					Xpos<=Xpos+1;
				end if;
			else
				out_valid <= '0';
			end if;
	
		end if;
	end process;
	
end architecture rtl; -- of Transformacija_Slike


	
	