-- Pozicioniranje_Piksela_u_SDRAM.vhd

-- Na osnovu dobijene pozicije piksela (x,y), preuzimamo dati piksel sa date pozicije iz SDRAM-a(Grapich Buffer), te ga smjestamo na sljedece dostupno mjesto u SDRAM(Video Buffer)
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Pozicioniranje_Piksela_u_SDRAM is
	port (
		reset_reset              : in  std_logic                     := '0';             --      reset.reset
		clock_clk                : in  std_logic                     := '0';             --      clock.clk
		
		-- Piksel za upis u memoriju!
		out_piksel_data          : out std_logic_vector(15 downto 0);                    -- out_piksel.data
		out_piksel_endofpacket   : out std_logic;                                        --           .endofpacket
		out_piksel_ready         : in  std_logic                     := '0';             --           .ready
		out_piksel_startofpacket : out std_logic;                                        --           .startofpacket
		out_piksel_valid         : out std_logic;                                        --           .valid
		
		-- Prihvaceni piksel!
		in_piksel_ready          : out std_logic;                                        --  in_piksel.ready
		in_piksel_valid          : in  std_logic                     := '0';             --           .valid
		in_piksel_endofpacket    : in  std_logic                     := '0';             --           .endofpacket
		in_piksel_data           : in  std_logic_vector(15 downto 0) := (others => '0'); --           .data
		in_piksel_startofpacket  : in  std_logic                     := '0';             --           .startofpacket
		
		-- Prihvacena pozicija za dati piksel!
		in_xy_valid              : in  std_logic                     := '0';             --      in_xy.valid
		in_xy_startofpacket      : in  std_logic                     := '0';             --           .startofpacket
		in_xy_endofpacket        : in  std_logic                     := '0';             --           .endofpacket
		in_xy_ready              : out std_logic;                                        --           .ready
		in_xy_data               : in  std_logic_vector(31 downto 0) := (others => '0')  --           .data
	);
end entity Pozicioniranje_Piksela_u_SDRAM;

architecture rtl of Pozicioniranje_Piksela_u_SDRAM is

 -- Dimenzije slike za prenos na VGA!
constant IMG_WIDTH : natural := 640;
constant IMG_HEIGH : natural := 480;

-- Horizontalni/Vertiklani pomjerac!
signal Xpos	: integer range 0 to 640 :=0;
signal Ypos	: integer range 0 to 480 :=0;

signal x_pozicija : integer range 0 to 640 :=0;
signal y_pozicija : integer range 0 to 480 :=0;

begin

	in_piksel_ready <= '1';  -- Spremni za prihvacanje piksela!
	in_xy_ready <= '1';		 -- Spremni za prihvacanje pozicije piksela!
	
	-- Uzimanje prihvacenih pozicija!
	x_pozicija <= to_integer(unsigned(in_xy_data(31 downto 16)));
	y_pozicija <= to_integer(unsigned(in_xy_data(15 downto 0)));
	
	proces_citanja_i_upisa_piksela_u_SDRAM:process(clock_clk) is
	begin
	   if falling_edge(clock_clk) then 
			if out_piksel_ready = '1' and in_xy_valid = '1' then -- Ako imamo poziciju, mozemo prihvatati piksele, te mozemo poslati piksel na izlaz
				if in_piksel_valid = '1' then
					if(Xpos = x_pozicija and Ypos = y_pozicija)then
						out_piksel_endofpacket <= in_piksel_endofpacket;
						out_piksel_startofpacket <= in_piksel_startofpacket;
						out_piksel_valid <= '1';
						out_piksel_data <= in_piksel_data;
					end if;
					
					if(Xpos = IMG_WIDTH-1)then	
						Xpos<=0;
						if(Ypos = IMG_HEIGH-1)then
							Ypos<=0;
						else
							Ypos<=Ypos+1;
						end if;
					else	
						Xpos<=Xpos+1;
					end if;
			
					
				end if;
			end if;
		
		end if;
	end process;
	
end architecture rtl; -- of Pozicioniranje_Piksela_u_SDRAM
