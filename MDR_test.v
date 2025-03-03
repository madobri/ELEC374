`timescale 1ns/1ps

module MDR_register_tb;

    reg clear, clock, Rin, Rout, read;
    reg [31:0] BusMuxOut, Mdatain;
    wire [31:0] BusMuxIn;

    // Instantiate the MDR_register module
    MDR_register uut (
        .clear(clear),
        .clock(clock),
        .Rin(Rin),
        .Rout(Rout),
        .BusMuxOut(BusMuxOut),
        .Mdatain(Mdatain),
        .read(read),
        .BusMuxIn(BusMuxIn)
    );

    // Clock generation (10ns period)
    always #5 clock = ~clock;

    initial begin
        // Initialize signals
        clock = 0; clear = 1; Rin = 0; Rout = 0; read = 0;
        BusMuxOut = 32'h00000000;
        Mdatain = 32'h00000000;
        
        #10 clear = 0; // Deassert clear
        
        // Load data from Mdatain using read
        #10 read = 1; Mdatain = 32'hA5A5A5A5;
        #10 Rin = 1; // Load Mdatain into MDR
        #10 Rin = 0; read = 0; // Stop loading

        // Output stored Mdatain value
        #10 Rout = 1;
        #10 Rout = 0;

        // Load data from BusMuxOut
        #10 BusMuxOut = 32'h5A5A5A5A; Rin = 1;
        #10 Rin = 0;

        // Output stored BusMuxOut value
        #10 Rout = 1;
        #10 Rout = 0;

        // Clear MDR register and check BusMuxIn
        #10 clear = 1;
        #10 clear = 0; Rout = 1;
        #10 Rout = 0;

        // End simulation
        #20 $finish;
    end
endmodule
