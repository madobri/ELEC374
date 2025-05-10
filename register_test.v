`timescale 1ns / 1ps

module register_tb;

    reg clear, clock, Rin, Rout;
    reg [31:0] BusMuxOut;
    wire [31:0] BusMuxIn;

    // Instantiate the register module
    register uut (
        .clear(clear),
        .clock(clock),
        .Rin(Rin),
        .Rout(Rout),
        .BusMuxOut(BusMuxOut),
        .BusMuxIn(BusMuxIn)
    );

    // Clock generation
    always #5 clock = ~clock;

    initial begin
        // Initialize inputs
        clock = 0;
        clear = 1;  // Start with clear active
        Rin = 0;
        Rout = 0;
        BusMuxOut = 32'h00000000;

        #10 clear = 0;  // Release clear

        // Test: Load a value into the register
        BusMuxOut = 32'hA5A5A5A5;
        Rin = 1; 
        #10 Rin = 0;  // Store value in register

        // Ensure register retains value
        #10;

        // Test: Read the value onto the bus
        Rout = 1;
        #10 Rout = 0;  // Output data should be visible during this time

        // Test: Load another value
        BusMuxOut = 32'h5A5A5A5A;
        Rin = 1;
        #10 Rin = 0;  // Store new value

        // Ensure register retains new value
        #10;

        // Test: Output the new value
        Rout = 1;
        #10 Rout = 0;  

        // Finish simulation
        #50;
        $finish;
    end

endmodule
