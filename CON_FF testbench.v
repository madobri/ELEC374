`timescale 1ns / 1ps

module CON_FF_tb;

    reg [31:0] bus;
    reg [1:0] ir;
    reg con_in;
    reg clock;
    wire [3:0] out;
    wire con_out;

    // Instantiate the module under test (MUT)
    CON_FF uut (
        .bus(bus),
        .ir(ir),
        .con_in(con_in),
        .clock(clock),
        .con_out(con_out),
        .out(out)
    );

    // Clock generation
    always #5 clock = ~clock; // Generate a clock with a period of 10 time units

    initial begin
        // Initialize inputs
        bus = 32'h00000000;
        ir = 2'b00;
        con_in = 0;
        clock = 0;

        // Apply stimulus
        #10 ir = 2'b00; bus = 32'hFFFFFFFF; con_in = 1;  // Test case 1: All 1s
        #10 con_in = 0;

        #10 ir = 2'b01; bus = 32'h00000000; con_in = 1;  // Test case 2: All 0s
        #10 con_in = 0;

        #10 ir = 2'b10; bus = 32'h7FFFFFFF; con_in = 1;  // Test case 3: MSB is 0
        #10 con_in = 0;

        #10 ir = 2'b11; bus = 32'h80000000; con_in = 1;  // Test case 4: MSB is 1
        #10 con_in = 0;

        #20 $stop; // End simulation
    end

endmodule
