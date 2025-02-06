`timescale 1ns / 1ps

module not_tb;

    // Inputs
    reg [31:0] A;

    // Output
    wire [31:0] Result;

    not uut (
        .A(A),
        .Result(Result)
    );

    // Test sequence
    initial begin
        // Initialize signals
        A = 32'h00000000;

        // Monitor values
        $monitor("Time=%0t | A=%h | Result=%h", $time, A, Result);

        // Apply test cases
        #10 A = 32'hFFFFFFFF; 
        #10 A = 32'hA5A5A5A5; 
        #10 A = 32'hB5A5A5A5; 
        #10 A = 32'h12345678; 
        #10 A = 32'h87654321; 
        #10 A = 32'h80000000; 
        #10 A = 32'hDEADBEEF;   

        // End simulation
        #10 $stop;
    end

endmodule

