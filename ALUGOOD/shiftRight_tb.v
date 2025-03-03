`timescale 1ns / 1ps
 
module shiftRight_tb;

   
    reg [31:0] B;
    reg [4:0] shifts;

  
    wire [31:0] Result;

    //instantiate the shiftRight module
    shiftRight uut (
        .B(B),
        .shifts(shifts),
        .Result(Result)
    );

    //test sequence
    initial begin
        //initialize signals
        B = 32'h00000000;
        shifts = 0;
        
        //apply test cases
        #10 B = 32'hFFFFFFFF; shifts = 0;  //no shift
        #10 B = 32'hA5A5A5A5; shifts = 1;  //shift by 1
        #10 B = 32'hA5A5A5A5; shifts = 4;  //shift by 4
        #10 B = 32'h12345678; shifts = 8;  //shift by 8
        #10 B = 32'h87654321; shifts = 16; //shift by 16
        #10 B = 32'h80000000; shifts = 31; //shift by 31
        #10 B = 32'hDEADBEEF; shifts = 3;  //shift by 3

        //end simulation
        #10 $stop;
    end

endmodule



