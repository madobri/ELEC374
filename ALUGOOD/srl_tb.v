`timescale 1ns / 1ps

module shiftRightLogical_tb;

    // Inputs
    reg [31:0] B;
    reg [4:0] shifts;

    // Output
    wire [31:0] Result;

    // Instantiate the shiftRight module
    shiftRightLogical uut (
        .B(B),
        .shifts(shifts),
        .Result(Result)
    );

    // Test sequence
    initial begin
        // Initialize signals
        B = 32'h00000000;
        shifts = 0;
        
        // Monitor values
        $monitor("Time=%0t | B=%h | shifts=%d | Result=%h", $time, B, shifts, Result);

        // Apply test cases
        #10 B = 32'hFFFFFFFF; shifts = 0;  // No shift
        #10 B = 32'hA5A5A5A5; shifts = 1;  // Shift by 1
        #10 B = 32'hB5A5A5A5; shifts = 4;  // Shift by 4
        #10 B = 32'h12345678; shifts = 8;  // Shift by 8
        #10 B = 32'h87654321; shifts = 16; // Shift by 16
        #10 B = 32'h80000000; shifts = 31; // Shift by 31
        #10 B = 32'hDEADBEEF; shifts = 3;  // Shift by 3

        // End simulation
        #10 $stop;
    end

endmodule

