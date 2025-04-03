module MDR_register(
	input [31:0] Mdatain,
	input [31:0] bus_mux_out,
	input wire clk, clear, mdr_in, mdr_read,
	output reg [31:0] mdr_data_out
);
	wire [31:0] D;
	
	mux_2to1 MDRmux(.I0(bus_mux_out), .I1(Mdatain), .signal(mdr_read), .MuxOut(D));

	always @(posedge clk or posedge clear) begin
		if(clear) 
			mdr_data_out <= 32'b0;
		else if (mdr_in)
			mdr_data_out <= D;
	end 
endmodule