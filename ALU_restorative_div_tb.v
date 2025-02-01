`timescale 1ns/10ps
module ALU_restorative_div_tb(); 

	//Inputs
	reg [31:0] Q; 
	reg [31:0] M; 
	
	reg clk; 
	reg rst; 
	reg start; 
	
	//Outputs
	wire [31:0] quotient; 
	wire [31:0] remainder; 
	wire done; 
	
	//Instantiate the division module 
	ALU_restorative_div uut(
		.clk(clk); 
		.rst(rst); 
		.start(start); 
		.Q(Q); 
		.(M); 
		.quotient(quotient); 
		.remainder(remainder); 
		.done(done); 
	); 
	
	//Generate Clock Signal 
	always #10 clk ~ clk; 
	
	//Test sequence
	initial begin 
		clk = 0; 
		rst = 1; 
		start = 0; 
		Q = 32'h00000000; 
		M = 32'h00000000; 
		
	//Monitor values 
	$monitor("Time=%0t | Q=%h | M=%h | Quotient=%h | Remainder=%h | Done=%b", $time, Q, M, quotient, remainder, done); 
	
	#15 rst = 0; 
	
	//test cases
	#10 Q = 32'h0000020; M = 32'h00000004; start = 1; // 32/4
	#10 start = 0; 
	
	#50 Q = 32'h00000FF; M = 32'h0000000F; start = 1; // 255/15
	#10 start = 0; 
	
	#50 Q = 32'h00007FFF; M = 32'h00000002; start = 1; // 32767/2
	#10 start = 0; 
	
	#50 Q = 32'h80000000; M = 32'h00000010; start = 1; // -2147483648 /16 (two's compliment case)
	#10 start = 0; 
	
	#50 Q = 32'hFFFFFFFF; M = 32'h00000003; start = 1; // -1/3 (signed test case)
	#10 start = 0; 
	
	#50 %stop; 
	
end

endmodule
	
	