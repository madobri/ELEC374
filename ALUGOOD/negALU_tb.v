`timescale 1ns / 1ps
module negALU_tb;

    // Inputs
    reg [31:0] A;

    // Output
    wire [31:0] Result;

    // Instantiate the NEG ALU module
    negALU uut (
        .A(A),
        .Result(Result)
    );

    // Test sequence
    initial begin
        // Initialize signals
        A = 32'h00000000;

        // Apply test cases
        #10 A = 32'h00000001;  // -1
        #10 A = 32'h00000005;  // -5
        #10 A = 32'h7FFFFFFF;  // -2147483647 (largest positive 32-bit)
        #10 A = 32'h80000000;  // -(-2147483648) (overflow case)
        #10 A = 32'hFFFFFFFF;  // -(-1) -> 1
        #10 A = 32'hA5A5A5A5; 
        #10 A = 32'h12345678;  
        #10 A = 32'hDEADBEEF;  // Negative number case

        // End simulation
        #10 $stop;
    end

endmodule
