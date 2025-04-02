module RAM #(
	parameter depth = 9,
	parameter width = 32
)(
	input clock, enable,
	input[depth - 1:0] index,
	input [width-1:0] w_data,
	output [width-1:0] r_data
);

reg [width-1:0] mem[0:2**depth-1];

initial $readmemh("ramFile.txt", mem);

assign r_data = mem[index];

always @(posedge clock) begin
	if(enable) begin
		mem[index] = w_data;
	end
end
endmodule	