`timescale 1ns / 1ps

module divisor_tb;
	reg clk, reset;
	reg [31:0] M, Q;
	reg [63:0] Result;
	
	divisor uut(
	 .clk(clk), .reset(reset), .M(M), .Q(Q), .Result(Result)
	);
	
	always #5 clk = ~clk;
	initial begin
		reset = 0;
		Result = 0;
		Q = 32'd25;
		M = 32'd5;
		#350;
		$stop;
	end
endmodule 