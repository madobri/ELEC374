
module divisor (M, Q, Result);

	input signed [32:0] M;
	input signed [31:0] Q; 
	input clk, reset;
	output signed [63:0] Result;  
	
	reg [31:0] Q_reg;  //for quotient because we can't modify input Q
	reg [31:0] A;
	reg signed [32:0] M_neg;
	reg [32:0] M_Pos;

	integer count;
	
	 

	always @(posedge clk) begin
	
		if (~reset) begin
			
			A = 33'b0;
			Q_reg = Q;
			if (M[31] == 0) begin
				M_neg = 0 - M_neg;
			end 
			else if (M[31] == 1) begin
				M_neg = M;
				M_Pos = 0 - M;
			end
	
			count =0;
		end
		
		if(count<32 && count>0) begin 	
			{A,Q_reg} = {A,Q_reg} << 1;

			A = A + M_neg;
			
			end
			
			if(A[63] == 1)begin
				
				A = A + M_Pos;
				
				Q_reg[0] = 0;
			end else begin
				Q_reg[0] = 1;
				count = count +1;
			end 
			
		
			
	end
		
	assign Result = {A,Q_reg};
			 
	
	
	
endmodule
