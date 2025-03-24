module register_64 #(
    parameter DATA_WIDTH_IN = 64,  
    parameter DATA_WIDTH_OUT = 32, 
    parameter INIT = 64'b0
)(
    input clear, clock, Zin, Zhighout, Zlowout, 
    input [DATA_WIDTH_IN-1:0] BusMuxOut,
    output reg [DATA_WIDTH_OUT-1:0] BusMuxIn
);

    reg [DATA_WIDTH_IN-1:0] q;

    initial q = INIT;

    always @(posedge clock) begin
        if (clear) begin
            q <= {DATA_WIDTH_IN{1'b0}};
        end else if (Zin) begin
            q <= BusMuxOut;
        end
    end
    
    always @(*) begin
        if (Zhighout) 
            BusMuxIn = q[DATA_WIDTH_IN-1:DATA_WIDTH_OUT];
        else if (Zlowout) 
            BusMuxIn = q[DATA_WIDTH_OUT-1:0];
        else 
            BusMuxIn = {DATA_WIDTH_OUT{1'bz}};
    end
endmodule
