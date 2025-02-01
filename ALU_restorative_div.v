module ALU_restorative_div (M, Q, quotient, remainder); 

	input [32:0] M, Q; 
	output [31:0] quotient, remainder; 
	
	reg [32:0] A; //remainder register set to 0
	reg [31:0] count; //counter for number of cycles
	
	integer i; 
	
	always @(*)
	begin
		
		A = 32'b0; //set A = 0
		count = 32; //32 cycles
		
		for (i = 0; i < count; count = count+1)
		begin
			
			{A, quotient} = {A, quotient} << 1; //shift A and Q to the left by 1 bit 
			A = A - M; //subtract M from A
			
			//if leading bit is 1, add 0 to end of quotient, otherwise add 1 
			if (A[32] == 0)
			begin
			
				Q[0] = 1; 
				
			else if (A[32] == 1)
			begin 
			
				Q[0] = 0; 
				A = A + M; 
			
			end
		end
	end
	
	quotient = Q; 
	remainder = A; 

		
endmodule
				
				
			
	
	
	