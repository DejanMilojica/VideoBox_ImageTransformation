// Izbor_Prikaza_Slike.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module Izbor_Prikaza_Slike (
		output wire [15:0] out_data,              //         out.data
		output wire        out_endofpacket,       //            .endofpacket
		input  wire        out_ready,             //            .ready
		output wire        out_startofpacket,     //            .startofpacket
		output wire        out_valid,             //            .valid
		input  wire        in1_valid,             //         in1.valid
		input  wire        in1_startofpacket,     //            .startofpacket
		output wire        in1_ready,             //            .ready
		input  wire        in1_endofpacket,       //            .endofpacket
		input  wire [15:0] in1_data,              //            .data
		input  wire [15:0] in2_data,              //         in2.data
		output wire        in2_ready,             //            .ready
		input  wire        in2_valid,             //            .valid
		input  wire        in2_startofpacket,     //            .startofpacket
		input  wire        in2_endofpacket,       //            .endofpacket
		input  wire        clock_clk,             //       clock.clk
		input  wire        reset_reset,           //       reset.reset
		input  wire [7:0]  izbor_slike_address,   // izbor_slike.address
		input  wire        izbor_slike_write,     //            .write
		input  wire [31:0] izbor_slike_writedata, //            .writedata
		input  wire        izbor_slike_read,      //            .read
		output wire [31:0] izbor_slike_readdata   //            .readdata
	);

	// TODO: Auto-generated HDL template

	assign out_valid = 1'b0;

	assign out_data = 16'b0000000000000000;

	assign out_startofpacket = 1'b0;

	assign out_endofpacket = 1'b0;

	assign in1_ready = 1'b0;

	assign in2_ready = 1'b0;

	assign izbor_slike_readdata = 32'b00000000000000000000000000000000;

endmodule
