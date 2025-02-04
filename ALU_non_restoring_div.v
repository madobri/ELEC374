module ALU_non_restoring_div (M, Q, quotient, remainder); 

	input [32:0] M, Q; 
	output [31:0] quotient, remainder; 
	
	reg [32:0] A; //remainder register set to 0
	reg [31:0] count; //counter for number of cycles
	
	integer i; 
	
	always @(*)
	begin
		
		A = 32'b0; //set A = 0
		count = 32; //32 cycles
		
		for (i = 0; i < count; i = i+1)
		begin
			
			{A, quotient} = {A, quotient} << 1; //shift A and Q to the left by 1 bit 
			
			//Following steps based on leading bit of Q 
			if (A[32] == 0)
			begin
			
				A = A - M; //subtract M from A
				Q[0] = 1; 
				
			end 
			else if (A[32] == 1)
			begin 
			
				A = A + M; //Add M to A
				Q[0] = 0;  
			
			end
		end
	end
	
	quotient = Q; 
	remainder = A; 

		
endmodule
				
				
			
	
	
	