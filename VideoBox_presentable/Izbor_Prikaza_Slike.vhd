-- Izbor_Prikaza_Slike.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Izbor_Prikaza_Slike is
	port (
		out_data              : out std_logic_vector(15 downto 0);                    --         out.data
		out_endofpacket       : out std_logic;                                        --            .endofpacket
		out_ready             : in  std_logic                     := '0';             --            .ready
		out_startofpacket     : out std_logic;                                        --            .startofpacket
		out_valid             : out std_logic;                                        --            .valid
		in1_valid             : in  std_logic                     := '0';             --         in1.valid
		in1_startofpacket     : in  std_logic                     := '0';             --            .startofpacket
		in1_ready             : out std_logic;                                        --            .ready
		in1_endofpacket       : in  std_logic                     := '0';             --            .endofpacket
		in1_data              : in  std_logic_vector(15 downto 0) := (others => '0'); --            .data
		in2_data              : in  std_logic_vector(15 downto 0) := (others => '0'); --         in2.data
		in2_ready             : out std_logic;                                        --            .ready
		in2_valid             : in  std_logic                     := '0';             --            .valid
		in2_startofpacket     : in  std_logic                     := '0';             --            .startofpacket
		in2_endofpacket       : in  std_logic                     := '0';             --            .endofpacket
		clock_clk             : in  std_logic                     := '0';             --       clock.clk
		reset_reset           : in  std_logic                     := '0';             --       reset.reset
		izbor_slike_address   : in  std_logic_vector(7 downto 0)  := (others => '0'); -- izbor_slike.address
		izbor_slike_write     : in  std_logic                     := '0';             --            .write
		izbor_slike_writedata : in  std_logic_vector(31 downto 0) := (others => '0'); --            .writedata
		izbor_slike_read      : in  std_logic                     := '0';             --            .read
		izbor_slike_readdata  : out std_logic_vector(31 downto 0);                    --            .readdata
		
		led_master_write      : out std_logic;                                        --  led_master.write
		led_master_writedata  : out std_logic_vector(7 downto 0);                      --            .writedata
		led_master_waitrequest : in  std_logic                     := '0' 
	);
end entity Izbor_Prikaza_Slike;

architecture rtl of Izbor_Prikaza_Slike is

signal parametar 			: std_logic_vector(31 downto 0) := (others => '0'); 

begin

	 -- Prihvatanje parametra koji definise koju sliku citamo, preko Avalon Memory Mapped interface-a!
	write_proc: process(clock_clk)
	begin
    if rising_edge(clock_clk) then
        
		  -- Prihvatanje parametra koji definise koju sliku cemo prikazati!
		  if izbor_slike_write = '1' then
            parametar <= izbor_slike_writedata;
				led_master_write <= '1';
				led_master_writedata <= parametar(7 downto 0);
			end if;
			
			-- Prikazivanje originalne slike iz 1. sektora SDRAM-a!
			if parametar(7 downto 0) = "00000001" then
				--Forward Avalon stream lines
				out_endofpacket <= in1_endofpacket;
				out_startofpacket <= in1_startofpacket;
				out_valid <= in1_valid; 				-- Dual Buffer zna da su prihvaceni podaci sa SOURCE-a, korektni!
				in1_ready <= out_ready;
				out_data <= in1_data;

			-- Prikazivanje transformisane slike iz 2. sektora SDRAM-a!
			else
				--Forward Avalon stream lines
				out_endofpacket <= in2_endofpacket;
				out_startofpacket <= in2_startofpacket;
				out_valid <= in2_valid; 				-- Dual Buffer zna da su prihvaceni podaci sa SOURCE-a, korektni!
				in2_ready <= out_ready;
				out_data <= in2_data;
			end if;
    end if;
	end process;



end architecture rtl; -- of Izbor_Prikaza_Slike
