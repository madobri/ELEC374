module Mux_2to1(
	input [31:0] I0, I1,
	input signal,
	output reg [31:0] MuxOut
);

always @(*)begin 
	case (signal)
		1'b0: MuxOut = I0;
		1'b1: MuxOut = I1;
		default: MuxOut = 32'd0;
	endcase 
end

endmodule 