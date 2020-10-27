	component VideoBox is
		port (
			led_bus_export     : out   std_logic_vector(7 downto 0);                     -- export
			memory_mem_a       : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba      : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck      : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n    : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke     : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n    : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n   : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n   : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n    : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt     : out   std_logic;                                        -- mem_odt
			memory_mem_dm      : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin   : in    std_logic                     := 'X';             -- oct_rzqin
			ref_clock_clk      : in    std_logic                     := 'X';             -- clk
			sdram_bus_addr     : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_bus_ba       : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_bus_cas_n    : out   std_logic;                                        -- cas_n
			sdram_bus_cke      : out   std_logic;                                        -- cke
			sdram_bus_cs_n     : out   std_logic;                                        -- cs_n
			sdram_bus_dq       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_bus_dqm      : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_bus_ras_n    : out   std_logic;                                        -- ras_n
			sdram_bus_we_n     : out   std_logic;                                        -- we_n
			sdram_clock_clk    : out   std_logic;                                        -- clk
			vga_bus_CLK        : out   std_logic;                                        -- CLK
			vga_bus_HS         : out   std_logic;                                        -- HS
			vga_bus_VS         : out   std_logic;                                        -- VS
			vga_bus_BLANK      : out   std_logic;                                        -- BLANK
			vga_bus_SYNC       : out   std_logic;                                        -- SYNC
			vga_bus_R          : out   std_logic_vector(7 downto 0);                     -- R
			vga_bus_G          : out   std_logic_vector(7 downto 0);                     -- G
			vga_bus_B          : out   std_logic_vector(7 downto 0)                      -- B
		);
	end component VideoBox;

	u0 : component VideoBox
		port map (
			led_bus_export     => CONNECTED_TO_led_bus_export,     --     led_bus.export
			memory_mem_a       => CONNECTED_TO_memory_mem_a,       --      memory.mem_a
			memory_mem_ba      => CONNECTED_TO_memory_mem_ba,      --            .mem_ba
			memory_mem_ck      => CONNECTED_TO_memory_mem_ck,      --            .mem_ck
			memory_mem_ck_n    => CONNECTED_TO_memory_mem_ck_n,    --            .mem_ck_n
			memory_mem_cke     => CONNECTED_TO_memory_mem_cke,     --            .mem_cke
			memory_mem_cs_n    => CONNECTED_TO_memory_mem_cs_n,    --            .mem_cs_n
			memory_mem_ras_n   => CONNECTED_TO_memory_mem_ras_n,   --            .mem_ras_n
			memory_mem_cas_n   => CONNECTED_TO_memory_mem_cas_n,   --            .mem_cas_n
			memory_mem_we_n    => CONNECTED_TO_memory_mem_we_n,    --            .mem_we_n
			memory_mem_reset_n => CONNECTED_TO_memory_mem_reset_n, --            .mem_reset_n
			memory_mem_dq      => CONNECTED_TO_memory_mem_dq,      --            .mem_dq
			memory_mem_dqs     => CONNECTED_TO_memory_mem_dqs,     --            .mem_dqs
			memory_mem_dqs_n   => CONNECTED_TO_memory_mem_dqs_n,   --            .mem_dqs_n
			memory_mem_odt     => CONNECTED_TO_memory_mem_odt,     --            .mem_odt
			memory_mem_dm      => CONNECTED_TO_memory_mem_dm,      --            .mem_dm
			memory_oct_rzqin   => CONNECTED_TO_memory_oct_rzqin,   --            .oct_rzqin
			ref_clock_clk      => CONNECTED_TO_ref_clock_clk,      --   ref_clock.clk
			sdram_bus_addr     => CONNECTED_TO_sdram_bus_addr,     --   sdram_bus.addr
			sdram_bus_ba       => CONNECTED_TO_sdram_bus_ba,       --            .ba
			sdram_bus_cas_n    => CONNECTED_TO_sdram_bus_cas_n,    --            .cas_n
			sdram_bus_cke      => CONNECTED_TO_sdram_bus_cke,      --            .cke
			sdram_bus_cs_n     => CONNECTED_TO_sdram_bus_cs_n,     --            .cs_n
			sdram_bus_dq       => CONNECTED_TO_sdram_bus_dq,       --            .dq
			sdram_bus_dqm      => CONNECTED_TO_sdram_bus_dqm,      --            .dqm
			sdram_bus_ras_n    => CONNECTED_TO_sdram_bus_ras_n,    --            .ras_n
			sdram_bus_we_n     => CONNECTED_TO_sdram_bus_we_n,     --            .we_n
			sdram_clock_clk    => CONNECTED_TO_sdram_clock_clk,    -- sdram_clock.clk
			vga_bus_CLK        => CONNECTED_TO_vga_bus_CLK,        --     vga_bus.CLK
			vga_bus_HS         => CONNECTED_TO_vga_bus_HS,         --            .HS
			vga_bus_VS         => CONNECTED_TO_vga_bus_VS,         --            .VS
			vga_bus_BLANK      => CONNECTED_TO_vga_bus_BLANK,      --            .BLANK
			vga_bus_SYNC       => CONNECTED_TO_vga_bus_SYNC,       --            .SYNC
			vga_bus_R          => CONNECTED_TO_vga_bus_R,          --            .R
			vga_bus_G          => CONNECTED_TO_vga_bus_G,          --            .G
			vga_bus_B          => CONNECTED_TO_vga_bus_B           --            .B
		);

