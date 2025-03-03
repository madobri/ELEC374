`timescale 1ns/10ps
module divisor_tb(); 

	//inputs
	reg signed [31:0] Q; 
	reg signed [32:0] M;  
	
	//outputs
	wire signed [63:0] Result; 

	//instantiate the division module 
	divisor uut(
		.M(M), 
		.Q(Q), 
		.Result(Result),
		.clk(clk),
		.reset(reset)
	); 
	
	//test sequence
	initial begin 
		//initializing variables
		Q = 33'h000000000; 
		M = 33'h000000000; 
		
		#10 Q = 33'h000000020; M = 33'h000000004; //32/4
		#10 Q = 33'h0000000FF; M = 33'h00000000F; //255/15
		#10 Q = 33'h000007FFF; M = 33'h000000002; //32767/2
		#10 Q = 33'hFFFFFFFFF; M = 33'h000000003; //-1/3 (signed case)

		#10 $stop; 
	
	end

endmodule
