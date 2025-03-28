`timescale 1ns / 1ps

module adder_tb;

    reg [31:0] A, B;
    
    wire [31:0] Result;
    
    adder uut (
        .A(A), 
        .B(B), 
        .Result(Result)
    );
    
    initial begin
        A = 32'd10; B = 32'd15; 
		  #10;  //10 + 15 = 25
        
        A = 32'd100; B = 32'd200; #10;  
		  //100 + 200 = 300
        
        A = 32'd 5000; B = 32'd1234; #10;  
		  //5000 + 1234 = 6234
        
        A = 32'd2147483647; B = 32'd1; #10;  
		  //Edge case: max int + 1
       
        
        A = 32'd0; B = 32'd0; #10;  
		  //0 + 0 = 0
        
        A = 32'd123456789; B = 32'd987654321; 
		  #10;//Large numbers
        
        $stop;
    end
    
endmodule
