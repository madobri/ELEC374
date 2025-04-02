`timescale 1ns / 1ps

module testbench;
    reg clear;
    reg clock;
    reg Rin, Rout;
    reg [31:0] fromInPort;
    wire [31:0] BusMuxIn;

    // Clock generation
    always #5 clock = ~clock;  // 10ns period

    // Instantiate the register module
    register #(32, 32, 32'd0) InPort(
        .clear(clear),
        .clock(clock),
        .Rin(Rin),
        .Rout(Rout),
        .BusMuxOut(fromInPort),
        .BusMuxIn(BusMuxIn)
    );

    initial begin
        // Initialize signals
        clear = 1;
        clock = 0;
        Rin = 0;
        Rout = 0;
        fromInPort = 32'hDEADBEEF;

        // Reset
        #10 clear = 0;

        // Test: Load value into register
        Rin = 1;  // Enable Rin to load data
        Rout = 0; // Don't output yet
        #10 Rin = 0; // Disable Rin after one clock cycle

        // Test: Output value from register
        Rout = 1; // Enable Rout to output data
        #10;

        // Observe the output
        $display("BusMuxIn (Register Output): %h", BusMuxIn);
    end
endmodule
