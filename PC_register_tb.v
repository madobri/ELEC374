`timescale 1ns / 1ps

module PC_register_tb;

    // Testbench signals
    reg clear, clock, Rin, Rout, Inc;
    reg [31:0] BusMuxOut; // Assuming DATA_WIDTH_IN is 32
    wire [31:0] BusMuxIn;  // Assuming DATA_WIDTH_OUT is 32

    // Instantiate the PC_register module
    PC_register uut (
        .clear(clear),
        .clock(clock),
        .Rin(Rin),
        .Rout(Rout),
        .Inc(Inc),
        .BusMuxOut(BusMuxOut),
        .BusMuxIn(BusMuxIn)
    );

    // Clock generation (period = 10ns)
    always #5 clock = ~clock;

    initial begin
        // Initialize signals
        clock = 0;
        clear = 0;
        Rin = 0;
        Rout = 0;
        Inc = 0;
        BusMuxOut = 32'd0;  // Initial value for BusMuxOut

        // Test 1: Reset the PC register with clear signal
        #10 clear = 1;
        #10 clear = 0;

        // Test 2: Load a value into the PC register with Rin signal
        #10 BusMuxOut = 32'd100;  // Set BusMuxOut to a test value
        Rin = 1;
        #10 Rin = 0;  // Disable Rin after loading value

        // Test 3: Increment the PC register
        #10 Inc = 1;  // Set Inc high to increment PC
        #10 Inc = 0;  // Disable Inc after one increment

        // Test 4: Read value from PC register with Rout signal
        #10 Rout = 1;  // Set Rout high to read value from the register
        #10 Rout = 0;  // Disable Rout

        // Test 5: Load a new value and increment again
        #10 BusMuxOut = 32'd200;  // Load a new value into the PC
        Rin = 1;
        #10 Rin = 0;
        #10 Inc = 1;  // Increment the PC
        #10 Inc = 0;

        // End the simulation
        #10 $stop;
    end

endmodule
