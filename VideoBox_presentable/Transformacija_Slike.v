// Transformacija_Slike.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module Transformacija_Slike (
		input  wire        clock_clk,         // clock.clk
		input  wire        reset_reset,       // reset.reset
		input  wire [15:0] in_data,           //    in.data
		output wire        in_ready,          //      .ready
		input  wire        in_startofpacket,  //      .startofpacket
		input  wire        in_endofpacket,    //      .endofpacket
		input  wire        in_valid,          //      .valid
		output wire [15:0] out_data,          //   out.data
		input  wire        out_ready,         //      .ready
		output wire        out_startofpacket, //      .startofpacket
		output wire        out_endofpacket,   //      .endofpacket
		output wire        out_valid          //      .valid
	);

	// TODO: Auto-generated HDL template

	assign in_ready = 1'b0;

	assign out_valid = 1'b0;

	assign out_data = 16'b0000000000000000;

	assign out_startofpacket = 1'b0;

	assign out_endofpacket = 1'b0;

endmodule
