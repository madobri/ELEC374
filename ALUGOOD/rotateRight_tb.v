`timescale 1ns / 1ps

module rotateRight_tb;

    reg [31:0] B;
    reg [4:0] rotate;

  
    wire [31:0] Result;

	//UUT Port Unit Under Test
    rotateRight uut (
        .B(B),
        .rotate(rotate),
        .Result(Result)
    );

    initial begin
        
		  //32 bits in hex, set to 0
		B = 32'h00000000; 
		  //set rotate to zero
		rotate = 1;	
        
        //displays the time, B original value, # of bits to rotate, the result of the rotate
		$monitor("Time=%0t | B=%h | rotate=%d | Result=%h", $time, B, rotate, Result);

		  
		//#10 waits 10 time units
 
		#10 B = 32'hA5A5A5A5; rotate = 1; 
		#10 B = 32'hDEADBEEF; rotate = 2; 
		#10 B = 32'hA5A5A5A5; rotate = 4;  
		#10 B = 32'h12345678; rotate = 8; 
      #10 B = 32'h87654321; rotate = 16;
      #10 B = 32'h80000000; rotate = 31; 
         
        
        #10 $stop;
    end

endmodule

