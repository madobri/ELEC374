`timescale 1ns / 1ps

module orALU_tb;

    reg [31:0] A;
    reg [31:0] B;


    wire [31:0] Result;

   
    orALU uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

  
    initial begin
       
        A = 32'h00000000;
        B = 32'h00000000;
        
        
        $monitor("Time=%0t | A=%h | B=%h | AND=%h", $time, A, B, Result);

       
        #10 A = 32'hFFFFFFFF; B = 32'h0000FFFF;
        #10 A = 32'hA5A5A5A5; B = 32'h5A5A5A5A;  
        #10 A = 32'h12345678; B = 32'hFFFF0000;  
        #10 A = 32'h87654321; B = 32'h0F0F0F0F; 
        #10 A = 32'hDEADBEEF; B = 32'hFFFFFFFF;  

       
        #10 $stop;
    end

endmodule

