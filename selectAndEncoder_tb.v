`timescale 1ns/10ps
module selectAndEncoder_tb();

    // Inputs
    reg [31:0] IR;
    reg Gra, Grb, Grc, Rin, Rout, BAout;

    // Outputs
    wire [15:0] Result_in, Result_out;

    // Instantiate the SelectAndEncoder module
    SelectAndEncoder uut (
        .IR(IR), 
        .Gra(Gra), 
        .Grb(Grb), 
        .Grc(Grc), 
        .Rin(Rin), 
        .Rout(Rout), 
        .BAout(BAout),
        .Result_in(Result_in), 
        .Result_out(Result_out)
    );

    // Test sequence
    initial begin
        // Initialize
        IR = 32'h00000000;
        Gra = 0; Grb = 0; Grc = 0;
        Rin = 0; Rout = 0; BAout = 0;

        // Test Case 1: Selecting Ra (R3) and writing in
        #10 
        IR = 32'b11000000111000011001100000010101; // R3
        Gra = 1; Grb = 0; Grc = 0;
        Rin = 1; Rout = 0; BAout = 0;
       
        // Test Case 2: Selecting Rb (R7) and reading out
        #10 
        IR = 32'b11000000111000011001100000010101; // R7
        Gra = 0; Grb = 1; Grc = 0;
        Rin = 0; Rout = 1; BAout = 0;

        // Test Case 3: Selecting Rc (R10) for both read/write
        #10 
        IR = 32'b11000000111000011001100000010101; // R10
        Gra = 0; Grb = 0; Grc = 1;
        Rin = 1; Rout = 1; BAout = 0;

        // Test Case 4: BAout on R0
        #10 
        IR = 32'b11000000111000011001100000010101; // R0
        Gra = 1; Grb = 0; Grc = 0;
        Rin = 0; Rout = 1; BAout = 1;

        // Test Case 5: No selection (goes to default "invalid")
        #10
        IR = 32'b11000000111000011001100000010101; // R0 bits, but no Gra/Grb/Grc
        Gra = 0; Grb = 0; Grc = 0;
        Rin = 1; Rout = 1; BAout = 0;

        #10 $stop; // End simulation
    end

endmodule