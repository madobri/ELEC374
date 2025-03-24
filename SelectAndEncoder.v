module SelectAndEncoder (
    input [31:0] IR, 
    input Gra, Grb, Grc, Rin, Rout, BAout,
    output reg [15:0] Result_in, Result_out
);
    wire [3:0] Ra, Rb, Rc;
    reg [3:0] R_select; // The selected register field 
    wire [15:0] R_dec;  // Decoded output for the selected register
    wire enable_signal; // Enable signal
    wire valid_register; // Ensures valid register selection

    // Extract register fields from IR
    assign Ra = IR[26:23];
    assign Rb = IR[22:19];
    assign Rc = IR[18:15];

    // Selection Logic 
    always @(*) begin
        if (Gra && !Grb && !Grc) begin
            R_select = Ra;
        end else if (Grb && !Gra && !Grc) begin
            R_select = Rb;
        end else if (Grc && !Gra && !Grb) begin
            R_select = Rc;
        end else begin
            R_select = 4'b0000; // Default case
        end
    end

    // Ensure a valid register is selected
    assign valid_register = (R_select != 4'b0000);

    // Enable Logic
    assign enable_signal = (Gra && valid_register) | 
                           (Grb && valid_register) | 
                           (Grc && valid_register);

    // Decoder Instance
    decoder4to16 dec (
        .reg_select(R_select), 
        .enable(enable_signal),
        .reg_out(R_dec)
    );

    // Result logic
    always @(*) begin
        // Result_in Signal
        if (Rin) begin
            Result_in = R_dec;
        end else begin
            Result_in = 16'b0;
        end

        // Result_out Signal 
        if (Rout || BAout) begin
            if (BAout == 1'b1 && R_dec[0] == 1'b1) begin
                Result_out = 16'b0000000000000000; // Force zero when BAout is 1 and R0 is selected
            end else begin
                Result_out = R_dec; // Otherwise, pass through the decoded register output
            end
        end else begin
            Result_out = 16'b0; // Only 0 when Rout = 0 and BAout = 0
        end
    end

endmodule
