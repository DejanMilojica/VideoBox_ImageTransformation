

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Alpha_Blender is
	port (
		avs_s0_address         : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- address
		avs_s0_read            : in  std_logic                     := 'X';             -- read
		avs_s0_readdata        : out std_logic_vector(31 downto 0);                    -- readdata
		avs_s0_write           : in  std_logic                     := 'X';             -- write
		avs_s0_writedata       : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
		clock_clk              : in  std_logic                     := 'X';             -- clk
		reset_reset            : in  std_logic                     := 'X';             -- reset
		asi_in0_data           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- data
		asi_in0_ready          : out std_logic;                                        -- ready
		asi_in0_valid          : in  std_logic                     := 'X';             -- valid
		asi_in0_endofpacket    : in  std_logic                     := 'X';             -- endofpacket
		asi_in0_startofpacket  : in  std_logic                     := 'X';             -- startofpacket
		aso_out0_data          : out std_logic_vector(15 downto 0);                    -- data
		aso_out0_ready         : in  std_logic                     := 'X';             -- ready
		aso_out0_valid         : out std_logic;                                        -- valid
		aso_out0_endofpacket   : out std_logic;                                        -- endofpacket
		aso_out0_startofpacket : out std_logic                                         --         .valid
	);
end entity Alpha_Blender;

architecture rtl of Alpha_Blender is
signal r1, r2, r_out : std_logic_vector(4 downto 0);
signal g1, g2, g_out : std_logic_vector(5 downto 0);
signal b1, b2, b_out : std_logic_vector(4 downto 0);
signal alpha 			: std_logic_vector(31 downto 0);
begin

	--First image color extraction
	r1 <= asi_in0_data(15 downto 11);
	g1 <= asi_in0_data(10 downto 5);
	b1 <= asi_in0_data(4 downto 0);
	
	--Secon image color extraction
	r2 <= asi_in0_data(31 downto 27);
	g2 <= asi_in0_data(26 downto 21);
	b2 <= asi_in0_data(20 downto 16);
		
	--Forward Avalon stream lines
	aso_out0_endofpacket <= asi_in0_endofpacket;
	aso_out0_startofpacket <= asi_in0_startofpacket;
	aso_out0_valid <= asi_in0_valid;
	asi_in0_ready <= aso_out0_ready;
	
	--Blending operation
	r_out <= std_logic_vector(to_unsigned(((to_integer(unsigned(alpha))*to_integer(unsigned(r1)) + (1000-to_integer(unsigned(alpha)))*to_integer(unsigned(r2)))/1000), r_out'length));
	g_out <= std_logic_vector(to_unsigned(((to_integer(unsigned(alpha))*to_integer(unsigned(g1)) + (1000-to_integer(unsigned(alpha)))*to_integer(unsigned(g2)))/1000), g_out'length));
	b_out <= std_logic_vector(to_unsigned(((to_integer(unsigned(alpha))*to_integer(unsigned(b1)) + (1000-to_integer(unsigned(alpha)))*to_integer(unsigned(b2)))/1000), b_out'length));
	
	--Concatenate blended image components
	aso_out0_data <= r_out & g_out & b_out;
	
	--Receive alpha factor from Avalon Memory Mapped interface
	write_proc: process(clock_clk)
	begin
    if rising_edge(clock_clk) then
        if avs_s0_write = '1' then
            alpha <= avs_s0_writedata;
        end if;
    end if;
	end process;

	
end architecture rtl;
