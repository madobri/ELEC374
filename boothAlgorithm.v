module boothAlgorithm(
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
		
		
		
		for(i =0; i<32; i=i+2) begin
			case (mult[2:0])
				3'b000: A=A;
				3'b001: A= A+(M<<i);
				3'b010: A= A+(M<<i);
				3'b011: A= A+(M<<(i+1));
				3'b100: A= A-(M<<(i+1));
				3'b101: A= A-(M<<i);
				3'b110: A= A-(M<<i);
				3'b111: A= A;
				
			endcase 
			
			mult = $signed(mult)>>>2;
	
				
		end 
	end
		
	assign Result = A;
		
endmodule
				
				
				

