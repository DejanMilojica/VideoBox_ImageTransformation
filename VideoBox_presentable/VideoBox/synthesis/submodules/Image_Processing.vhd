-- Image_Processing.vhd

-- Komponenta koja predefinise operacije transformacije slike, kao sto su:
-- Rotacija
-- Refleksija(Obrtanje) po pojedinacnim osama
-- Transformacija slike koja se baziran na probnoj integraciji bijelog pravougaonika na sredini slike!
-- Koja transformacija ce se izvrsavati, zavisi od primljene vrijednosti parametra, koju definise korisnik!

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Image_Processing is
	port (
		-- Avalon MM Slave, komunikacija sa HPS-om!
		avs_s0_address         : in  std_logic_vector(7 downto 0)  := (others => '0'); --    s0.address
		avs_s0_read            : in  std_logic                     := '0';             --      .read
		avs_s0_readdata        : out std_logic_vector(31 downto 0);                    --      .readdata
		avs_s0_write           : in  std_logic                     := '0';             --      .write
		avs_s0_writedata       : in  std_logic_vector(31 downto 0) := (others => '0'); --      .writedata
		
		-- Ulazni podaci, pixeli slike procitane iz SDRAM-a!
		asi_in0_data           : in  std_logic_vector(15 downto 0) := (others => '0'); --   in0.data
		asi_in0_ready          : out std_logic;                                        --      .ready
		asi_in0_valid          : in  std_logic                     := '0';             --      .valid
		asi_in0_endofpacket    : in  std_logic                     := '0';             --      .endofpacket
		asi_in0_startofpacket  : in  std_logic                     := '0';             --      .startofpacket

		-- Izlazni podaci, pixeli transformisane slike!		
		aso_out0_data          : out std_logic_vector(15 downto 0);                    --  out0.data
		aso_out0_ready         : in  std_logic                     := '0';             --      .ready
		aso_out0_valid         : out std_logic;                                        --      .valid
		aso_out0_endofpacket   : out std_logic;                                        --      .endofpacket
		aso_out0_startofpacket : out std_logic;                                        --      .startofpacket
		
		reset_reset            : in  std_logic                     := '0';             -- reset.reset
		clock_clk              : in  std_logic                     := '0'              -- clock.clk
	);
end entity Image_Processing;

architecture rtl of Image_Processing is

-- Parametar transformacije!
signal parametar 			: std_logic_vector(31 downto 0) := (others => '0');

 -- Dimenzije slike za prenos na VGA!
constant IMG_WIDTH : natural := 640;
constant IMG_HEIGH : natural := 480;

-- Horizontalni/Vertiklani pomjerac!
signal Xpos	: integer range 0 to 640 :=0;
signal Ypos	: integer range 0 to 480 :=0;

-- Pomocni Horizontalni/Vertiklani pomjerac/blokator!
signal Pom_Ypos	: integer range 0 to 480 :=479;
signal Pom_Xpos	: integer range 0 to 640 :=639;

-- Definisemo zavrsetak transformacije!
signal KRAJ	: std_logic              := '1';

-- Kontstantni Parametri koji definisu tip transformacije!
constant ROTACIJA_180 			: std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
constant VERTIKALNI_FLIP 		: std_logic_vector(31 downto 0) := "00000000000000000000000000000010";
constant HORIZONTALNI_FLIP 	: std_logic_vector(31 downto 0) := "00000000000000000000000000000011";
constant BIJELI_PRAVOUGAONIK 	: std_logic_vector(31 downto 0) := "00000000000000000000000000000100";

begin
		
	-- Proces kojim vrsimo transformaciju slike, na osnovu prihvacenog parametra transformacije sa HPS strane!
	proces_transformacija_slike:process(clock_clk) is
	begin


	    if rising_edge(clock_clk) then --falling_edge 
					 
			-- Prihvatanje parametra koji definise tip transformacije!
			if avs_s0_write = '1' then
				parametar <= avs_s0_writedata; -- Cuvanje prihvacenog parametra transformacije!
				-- Resetovanje horizontalnog/vertikalnog pomjeraca!
				Xpos <= 0;
				Ypos <= 0;
				
				-- Omogucavamo pocetak transformacije
				KRAJ <= '0';
				
				if parametar = VERTIKALNI_FLIP then
					Pom_Ypos	<= 0;
				else
					Pom_Ypos	<= IMG_HEIGH - 1;
				end if;
				
				Pom_Xpos	<= IMG_WIDTH - 1;
			end if; 
			
		  
			if(KRAJ = '0' and asi_in0_valid = '1' and aso_out0_ready = '1')then
				
				-- INTEGRACIJA BIJELOG PRAVOUGAONIKA!
				if parametar = BIJELI_PRAVOUGAONIK then 	
					--Spremni za prihvacanje podataka!
					aso_out0_valid <= '1';
					asi_in0_ready  <= '1';
					-- Algoritam za integraciju bijelog pravougaonika na sredini slike!
					if(Ypos>=200 and Ypos<=280 AND Xpos>=280 and Xpos<=360)then
						aso_out0_endofpacket <= asi_in0_endofpacket;
						aso_out0_startofpacket <= asi_in0_startofpacket;
						aso_out0_data <= (others => '1');
					else
						aso_out0_endofpacket <= asi_in0_endofpacket;
						aso_out0_startofpacket <= asi_in0_startofpacket;
						aso_out0_data <= asi_in0_data;
					end if;
					
					
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
						
					
				-- 3, OKRETANJE PO HORIZONTALNOJ LINIJI!
				elsif parametar = HORIZONTALNI_FLIP then 		
					if(Ypos = Pom_Ypos)then			
						-- Prosljedjivanje na izlaz!
					--Spremni za prihvacanje podataka!
						aso_out0_valid <= '1';
						asi_in0_ready  <= '1';
						aso_out0_endofpacket <= asi_in0_endofpacket;
						aso_out0_startofpacket <= asi_in0_startofpacket;
						aso_out0_data <= asi_in0_data;
					else
						asi_in0_ready <= '1';
						aso_out0_valid <= '0';
					end if;
					
					-- Blokiranje prihvacanja piksela iz SDRAM-a!
					--asi_in0_ready <= '0';
				
					if(Xpos = IMG_WIDTH-1)then	
						Xpos<=0;
						if Pom_Ypos>=0 then
							if(Ypos = Pom_Ypos)then			
								Pom_Ypos <= Pom_Ypos -1;
							end if;
						else 
							Pom_Ypos <= IMG_HEIGH-1;
							KRAJ <= '1';
						end if;

						if(Ypos = IMG_HEIGH-1)then
							Ypos<=0;
						else
							Ypos<=Ypos+1;
						end if;
										
					else	
						Xpos<=Xpos+1;
					end if;

			-- 2, OKRETANJE PO VERTIKALNOJ LINIJI!
				elsif parametar = VERTIKALNI_FLIP then 	
					if(Xpos = Pom_Xpos and Ypos = Pom_Ypos)THEN			
						--Forward Avalon stream lines
						aso_out0_endofpacket <= asi_in0_endofpacket;
						aso_out0_startofpacket <= asi_in0_startofpacket;
						--Spremni za prihvacanje podataka!
						aso_out0_valid <= '1';
						asi_in0_ready  <= '1';
						aso_out0_data <= asi_in0_data;
						
						if Pom_Xpos>0 then
							Pom_Xpos <= Pom_Xpos - 1;
						else 
							if Pom_Ypos = IMG_HEIGH-1 then
								KRAJ <= '1';
							else
								Pom_Xpos <= IMG_WIDTH-1;
								Pom_Ypos <= Pom_Ypos + 1;
							end if;
						end if;
						
					else
						asi_in0_ready <= '1';
						aso_out0_valid <= '0';
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
				

				-- 1, ROTACIJA SLIKE ZA 180 STEPENI!
				elsif parametar = ROTACIJA_180 then
					if(Xpos = Pom_Xpos and Ypos = Pom_Ypos)THEN			
						--Forward Avalon stream lines
						aso_out0_endofpacket <= asi_in0_endofpacket;
						aso_out0_startofpacket <= asi_in0_startofpacket;
						--Spremni za prihvacanje podataka!
						aso_out0_valid <= '1';
						asi_in0_ready  <= '1';
						aso_out0_data <= asi_in0_data;
						
						if Pom_Xpos>0 then
							Pom_Xpos <= Pom_Xpos - 1;
						else 
							if Pom_Ypos = 0 then
								KRAJ <= '1';
							else
								Pom_Xpos <= IMG_WIDTH - 1;
								Pom_Ypos <= Pom_Ypos - 1;
							end if;
						end if;
						
					else
						asi_in0_ready <= '1';
						aso_out0_valid <= '0';
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
				
				
				-- Ukoliko nije niti jedna poznata vrijednost, ne vrsimo transformaciju!
				else
					KRAJ <= '1';
				end if;
			else	 -- Onemogucen upis u sdram!
				aso_out0_valid <= '0';
				asi_in0_ready  <= '0';
			end if;
		end if;
	end process;


	

end architecture rtl;