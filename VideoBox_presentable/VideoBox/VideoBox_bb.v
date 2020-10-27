
module VideoBox (
	led_bus_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	ref_clock_clk,
	sdram_bus_addr,
	sdram_bus_ba,
	sdram_bus_cas_n,
	sdram_bus_cke,
	sdram_bus_cs_n,
	sdram_bus_dq,
	sdram_bus_dqm,
	sdram_bus_ras_n,
	sdram_bus_we_n,
	sdram_clock_clk,
	vga_bus_CLK,
	vga_bus_HS,
	vga_bus_VS,
	vga_bus_BLANK,
	vga_bus_SYNC,
	vga_bus_R,
	vga_bus_G,
	vga_bus_B);	

	output	[7:0]	led_bus_export;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		ref_clock_clk;
	output	[12:0]	sdram_bus_addr;
	output	[1:0]	sdram_bus_ba;
	output		sdram_bus_cas_n;
	output		sdram_bus_cke;
	output		sdram_bus_cs_n;
	inout	[15:0]	sdram_bus_dq;
	output	[1:0]	sdram_bus_dqm;
	output		sdram_bus_ras_n;
	output		sdram_bus_we_n;
	output		sdram_clock_clk;
	output		vga_bus_CLK;
	output		vga_bus_HS;
	output		vga_bus_VS;
	output		vga_bus_BLANK;
	output		vga_bus_SYNC;
	output	[7:0]	vga_bus_R;
	output	[7:0]	vga_bus_G;
	output	[7:0]	vga_bus_B;
endmodule
