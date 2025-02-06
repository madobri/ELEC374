module rotateRight(

input [31:0] B,
input [4:0] rotate,
output [31:0] Result

);
	assign Result = (B>>rotate)|(B<<(32-rotate));
endmodule
