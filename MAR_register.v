module MAR_register #(
    parameter DATA_WIDTH_IN = 32, 
    parameter DATA_WIDTH_OUT = 32, 
    parameter INIT = 32'b0
)(
    input clear, clock, Rin, Rout, 
    input [DATA_WIDTH_IN-1:0] BusMuxOut,
    output wire [DATA_WIDTH_OUT-1:0] BusMuxIn,
	 output wire [8:0] address
);

    reg [DATA_WIDTH_IN-1:0] q;

    initial q = INIT;

    always @(posedge clock) begin
        if (clear) begin
            q <= {DATA_WIDTH_IN{1'b0}};
        end 
        else if (Rin) begin
            q <= BusMuxOut;
        end
    end
    assign BusMuxIn = Rout ? q[DATA_WIDTH_OUT-1:0] : {DATA_WIDTH_OUT{1'bz}};
	 assign address = BusMuxIn[8:0];
endmodule
