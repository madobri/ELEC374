`timescale 1ns/10ps
module ALU_tb();

    // Inputs
	 reg clk; 
    reg [4:0] signal;   
    reg [31:0] A, B;    

    //Outputs
    wire [63:0] Result;  

    // Instantiate the ALU module
    ALU uut (
		  .clk(clk),
        .signal(signal),
        .A(A),
        .B(B),
        .Result(Result)
    );
	 
	initial begin
		clk = 0; 
	end
	always #5 clk = ~clk; 

    // Test sequence
    initial begin
        // Initialize Inputs
        A = 32'h0000000a;
        B = 32'h00000000;
        signal = 5'b00000; // Default operation to set to 0

				A = 32'hFFFFFFFF; B = 32'h0F0F0F0F; signal = 5'b00000; // AND
        #10 A = 32'h00000000; B = 32'hF0F0F0F0; signal = 5'b00001; // OR
        #10 A = 32'h0000000F; B = 32'h00000000; signal = 5'b00010; // NOT
        #10 A = 32'h00000001; B = 32'h00000001; signal = 5'b00011; // ADD
        #10 A = 32'h00000005; B = 32'h00000002; signal = 5'b00100; // SUB
        #10 A = 32'h00000002; B = 32'h00000003; signal = 5'b00101; // MUL 
		  
	    // Division operation - Wait for 32 clock cycles (320ns)
        #10 A = -{32'd0000016}; B = 32'h000000010; signal = 5'b00110; // Start DIV
		  repeat (33) @(posedge clk);  // Wait for 32 clock cycles properly
		  #10;  
 
        #10 A = 32'h00000001; B = 32'h00000002; signal = 5'b00111; // SHL	  
        #10 A = 32'h00000001; B = 32'h80000000; signal = 5'b01000; // SHR
        #10 A = 32'h00000001; B = 32'h80000000; signal = 5'b01001; // SHRA
        #10 A = 32'h00000001; B = 32'h00000002; signal = 5'b01010; // ROL
        #10 A = 32'h80000000; B = 32'h00000002; signal = 5'b01011; // ROR
        #10 A = 32'h00000005; B = 32'h00000000; signal = 5'b01100; // NEG
        #10 $stop;
    end

endmodule
