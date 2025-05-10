module MDR_register #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'b0)(
    input clear, clock, Rin, Rout, 
    input [DATA_WIDTH_IN-1:0] BusMuxOut,
    input [DATA_WIDTH_IN-1:0] Mdatain,
    input read,
    output wire [DATA_WIDTH_OUT-1:0] BusMuxIn
);

reg [DATA_WIDTH_IN-1:0] d;
initial d = INIT;

always @ (*) begin
    if (read) 
        d = Mdatain;
    else
        d = BusMuxOut; 
end

reg [DATA_WIDTH_IN-1:0] q;
initial q = INIT;

always @ (posedge clock) begin
    if (clear) begin
        q <= {DATA_WIDTH_IN{1'b0}};
    end else if (Rin) begin
        q <= d;
    end
end

assign BusMuxIn = (Rout) ? q[DATA_WIDTH_OUT-1:0] : {DATA_WIDTH_OUT{1'bz}};

endmodule
