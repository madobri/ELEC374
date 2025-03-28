`timescale 1ns / 1ps

module subtractor_tb;

    reg [31:0] A, B;
    
    wire [63:0] Result;
    
    subtractor uut (
        .A(A), 
        .B(B), 
        .Result(Result)
    );
    
    initial begin
        A = 32'd20; B = 32'd10; #10;
        
        A = 32'd100; B = 32'd50; #10;
        
        A = 32'd5000; B = 32'd1234; #10;
        
        A = 32'd0; B = 32'd1; #10;
        
        A = 32'd2147483647; B = 32'd123456789; #10;
        
        A = 32'd123456789; B = 32'd98765432; #10;
        
        $stop;
    end
    
endmodule


