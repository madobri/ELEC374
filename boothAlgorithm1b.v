module boothAlgorithm1b(
	input signed [31:0] M,
	input signed [31:0] Q,
	
	output signed [63:0] Result
	

);

	reg signed [33:0] mult;

	reg signed[63:0] A;
	
	integer i;
	
	always @(*) begin
		
		A =0;
		
		mult = {Q,1'b0};
		
		
		
		for(i =0; i<32; i=i+1) begin
			case (mult[1:0])
				2'b00: A=A;
				2'b01: A= A+(M<<i);
				2'b10: A= A-(M<<i);
				2'b11: A=A;
			
			endcase 
			
			
		
			mult = $signed(mult)>>>1;
			
			
		
				
		end 
		
	end
		
	assign Result = A;
		
endmodule
				
				
				

