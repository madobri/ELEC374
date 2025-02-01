`timescale 1ns / 1ps

module shiftLeft_tb;

    
    reg [31:0] B;
    reg [4:0] shifts;

  
    wire [31:0] Result;

	//UUT Port Unit Under Test
    shiftLeft uut (
        .B(B),
        .shifts(shifts),
        .Result(Result)
    );

    initial begin
        
		  //32 bits in hex, set to 0
		B = 32'h00000000; 
		  //set shift to zero
		shifts = 0;
        
        //displays the time, B original value, # of bits to shift, the result of the shift
		$monitor("Time=%0t | B=%h | shifts=%d | Result=%h", $time, B, shifts, Result);

		  
		//#10 waits 10 time units
		#10 B = 32'hFFFFFFFF; shifts = 0;  
		#10 B = 32'hA5A5A5A5; shifts = 1; 
		#10 B = 32'hDEADBEEF; shifts = 2; 
		#10 B = 32'hA5A5A5A5; shifts = 4;  
		#10 B = 32'h12345678; shifts = 8; 
      #10 B = 32'h87654321; shifts = 16;
      #10 B = 32'h80000000; shifts = 31; 
         
        
        #10 $stop;
    end

endmodule

