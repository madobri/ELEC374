module register_R0 #(
    parameter DATA_WIDTH = 32
)(
    input clear, clock, R0in, Rout, BAout,
    input [DATA_WIDTH-1:0] BusMuxOut,
    output reg [DATA_WIDTH-1:0] BusMuxIn_R0
);

    reg [DATA_WIDTH-1:0] q;

    // Register storage logic
    always @(posedge clock) begin
        if (clear)
            q <= {DATA_WIDTH{1'b0}};
        else if (R0in)
            q <= BusMuxOut;
    end

    // Output logic controlled by Rout and BAout
    always @(*) begin
        if (Rout) begin
            if (BAout)
                BusMuxIn_R0 = 32'b0;  // Force output to 0 when BAout is high
            else
                BusMuxIn_R0 = q;  // Otherwise, output the stored value
        end else begin
            BusMuxIn_R0 = BusMuxOut;  // High-impedance when Rout is low
        end
    end

endmodule
