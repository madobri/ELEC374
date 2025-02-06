`timescale 1ns/10ps
module ALU_restorative_div_tb(); 

	//Inputs
	reg [32:0] Q; 
	reg [32:0] M;  
	
	//Outputs
	wire [31:0] quotient; 
	wire [32:0] remainder; 

	//Instantiate the division module 
	ALU_restorative_div uut(
		.M(M), 
		.Q(Q), 
		.quotient(quotient),
		.remainder(remainder)
	); 
	
	//Test sequence
	initial begin 
		// Initializing variables
		Q = 33'h000000000; 
		M = 33'h000000000; 
		
		#10 Q = 33'h000000020; M = 33'h000000004; // 32/4
		#10 Q = 33'h0000000FF; M = 33'h00000000F; // 255/15
		#10 Q = 33'h000007FFF; M = 33'h000000002; // 32767/2
		#10 Q = 33'hFFFFFFFFF; M = 33'h000000003; // -1/3 (signed case)

		#10 $stop; 
	
	end

endmodule
