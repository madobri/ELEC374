`timescale 1ns / 1ps

module boothAlgorithm_tb;

 
    reg signed[31:0] M, Q;
	
    
    wire [62:0] Result;

    boothAlgorithm uut (
        .M(M),
		  .Q(Q),
        .Result(Result)
    );

    initial begin
      
        M = 32'b11111111111111111111111111001011;
		  Q = 32'b11111111111111111111111111000010;
		  
		  #10;
		  
   
        $display("Time=%0t | M=%b | Q=%b| Result=%b", $time, M, Q, Result);

     
    end

endmodule


