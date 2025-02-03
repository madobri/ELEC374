module boothAlgorithm1b(
	//input M and Q
	input signed [31:0] M,
	input signed [31:0] Q,
	
	//output
	output signed [63:0] Result
	

);
	
	//holds Q with sign extension
	reg signed [33:0] mult;
	
	//holds A, sum of each computation
	reg signed[63:0] A;
	
	//int i for loop
	integer i;
	
	always @(*) begin
		
		//set A =0 as base case
		A =0;
		
		//mult = Q with sign extension 0
		mult = {Q,1'b0};
		
		
		//loop through each bit of mult, comparing to the rght bit to determine computation
		for(i =0; i<32; i=i+1) begin
			//case 2 bits in mult
			case (mult[1:0])
				2'b00: A=A;
				2'b01: A= A+(M<<i);
				2'b10: A= A-(M<<i);
				2'b11: A=A;
			
			endcase 
			
			
			//logically shift right 1 bit
			mult = $signed(mult)>>>1;
			
			
		
				
		end 
		
	end
	
	//set result equal A	
	assign Result = A;
		
endmodule
				
				
				

